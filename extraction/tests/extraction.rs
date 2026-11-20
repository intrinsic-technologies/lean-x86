use object::{Object, ObjectSection, ObjectSymbol};
use std::{
    collections::BTreeMap,
    fs,
    path::Path,
    process::{Command, Output},
};
use x86_extract::{config::Config, elf};

fn command(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?}: {}{}",
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
    output
}

/// Run an executable that the test just wrote. A child that another test thread forks while the
/// file is open for writing holds that file descriptor until it execs, so `execve` can briefly
/// fail with ETXTBSY.
fn run_written(path: &Path) -> std::process::ExitStatus {
    for _ in 0..100 {
        match Command::new(path).status() {
            Err(error) if error.kind() == std::io::ErrorKind::ExecutableFileBusy => {
                std::thread::sleep(std::time::Duration::from_millis(10))
            }
            status => return status.unwrap(),
        }
    }
    panic!("{} stayed busy", path.display())
}

fn copy_fixture(directory: &Path, source: &str, target: &str) {
    let fixtures = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures");
    fs::copy(fixtures.join(source), directory.join(target)).unwrap();
}

/// Assemble `input.S` and link it as `input.elf` with `ld_arguments`.
fn assemble_and_link(directory: &Path, ld_arguments: &[&str]) {
    command(
        Command::new("as")
            .current_dir(directory)
            .args(["--64", "input.S", "-o", "input.o"]),
    );
    command(
        Command::new("ld")
            .current_dir(directory)
            .arg("--fatal-warnings")
            .args(ld_arguments)
            .args(["input.o", "-o", "input.elf"]),
    );
}

/// Link a fixture with `layout.ld`, and copy the default configuration.
fn fixture(directory: &Path, assembly: &str) {
    copy_fixture(directory, assembly, "input.S");
    copy_fixture(directory, "layout.ld", "layout.ld");
    copy_fixture(directory, "extraction.toml", "extraction.toml");
    assemble_and_link(directory, &["-T", "layout.ld"]);
}

/// The little-endian word at a file offset
fn read_word(bytes: &[u8], offset: usize) -> u64 {
    u64::from_le_bytes(bytes[offset..offset + 8].try_into().unwrap())
}

/// The little-endian half-word at a file offset
fn read_half(bytes: &[u8], offset: usize) -> u16 {
    u16::from_le_bytes(bytes[offset..offset + 2].try_into().unwrap())
}

/// Overwrite the little-endian word at a file offset.
fn write_word(file: &mut [u8], offset: usize, value: u64) {
    file[offset..offset + 8].copy_from_slice(&value.to_le_bytes());
}

/// The file range of a section
fn section_range(bytes: &[u8], name: &str) -> std::ops::Range<usize> {
    let object = object::File::parse(bytes).unwrap();
    let (offset, size) = object.section_by_name(name).unwrap().file_range().unwrap();
    offset as usize..(offset + size) as usize
}

/// The file offset of the first `.dynamic` entry with a tag
fn dynamic_entry(bytes: &[u8], tag: u64) -> usize {
    section_range(bytes, ".dynamic")
        .step_by(16)
        .find(|&offset| read_word(bytes, offset) == tag)
        .unwrap()
}

fn config() -> Config {
    toml::from_str(include_str!("fixtures/extraction.toml")).unwrap()
}

#[test]
fn config_rejects_ambiguities() {
    let mut c = config();
    c.validate().unwrap();
    assert_eq!(c.lean_namespace(), "Fixture.Extracted");
    // A single word may be a keyword, including syntax that generated modules import.
    for (namespace, expected) in [
        ("Keccak", "«Keccak»"),
        ("lean-keccak.Extracted", "«lean-keccak».Extracted"),
        ("Fixture.def", "Fixture.def"),
        ("def", "«def»"),
        ("include_chunked_bytes", "«include_chunked_bytes»"),
    ] {
        let mut named = config();
        named.namespace = namespace.into();
        named.output = namespace.replace('.', "/").into();
        named.validate().unwrap();
        assert_eq!(named.lean_namespace(), expected);
    }
    c.data_sections.push(".text".into());
    assert!(c.validate().is_err());
    let mut c = config();
    c.namespace = "A; import B".into();
    assert!(c.validate().is_err());
    let mut c = config();
    c.features = vec!["avx".into()];
    assert!(c.validate().is_err());
    let mut c = config();
    c.entries.insert("bad-alias".into(), "entry".into());
    assert!(c.validate().is_err());
    assert!(toml::from_str::<Config>(include_str!("fixtures/unknown-field.toml")).is_err());
    // Generated modules import each other by the namespace, so the output directory must end
    // with its components.
    let mut c = config();
    c.output = "Fixture/Other".into();
    assert!(c.validate().is_err());
    c.output = "work/Fixture/Extracted".into();
    c.validate().unwrap();
    c.output = "../work/Fixture/Extracted".into();
    c.validate().unwrap();
    // Generated modules import modules of these libraries, which a namespace must not shadow.
    for root in ["X86", "Prelude", "Elf", "Lean", "Init", "Std"] {
        let mut c = config();
        c.namespace = format!("{root}.Extracted");
        c.output = format!("{root}/Extracted").into();
        assert!(c.validate().is_err(), "{root}");
    }
    // `Path` drops a `.` component, which `create_dir` does not.
    for output in [
        "Fixture/Extracted/.",
        "Fixture/./Extracted",
        "a/../Fixture/Extracted",
    ] {
        c.output = output.into();
        assert!(c.validate().is_err(), "{output}");
    }
    // The whole file may be embedded.
    let mut c = config();
    c.include_file = true;
    c.validate().unwrap();
}

/// A loaded configuration's paths are joined to its directory, and the joined output passes
/// the checks `elf::read` repeats, with a leading `.` or `..`.
#[test]
fn loads_relative_outputs() {
    let tmp = tempfile::tempdir().unwrap();
    let work = tmp.path().join("work");
    fs::create_dir(&work).unwrap();
    fixture(&work, "basic.S");
    let bytes = fs::read(work.join("input.elf")).unwrap();
    // `load` joins to the canonical directory of the configuration.
    let root = tmp.path().canonicalize().unwrap();
    for (output, expected) in [
        ("./Fixture/Extracted", root.join("work/Fixture/Extracted")),
        ("../Fixture/Extracted", root.join("Fixture/Extracted")),
    ] {
        fs::write(
            work.join("extraction.toml"),
            include_str!("fixtures/extraction.toml").replace("Fixture/Extracted", output),
        )
        .unwrap();
        let c = Config::load(&work.join("extraction.toml")).unwrap();
        assert_eq!(c.output, expected, "{output}");
        elf::read(&bytes, &c).unwrap();
    }
}

#[test]
fn reads_exact_sections_and_symbols() {
    let tmp = tempfile::tempdir().unwrap();
    fixture(tmp.path(), "basic.S");
    let bytes = fs::read(tmp.path().join("input.elf")).unwrap();
    let image = elf::read(&bytes, &config()).unwrap();
    assert_eq!(
        image.sections[0].bytes,
        [0xb8, 42, 0, 0, 0, 0xc3, 0x31, 0xc0, 0xc3]
    );
    assert_eq!(image.sections[1].bytes, [1, 2, 3, 4]);
    assert_eq!(image.entries["entry"], 0x100000);
    assert_eq!(image.entries["second"], 0x100006);
    let mut c = config();
    c.data_sections.clear();
    assert!(elf::read(&bytes, &c)
        .unwrap_err()
        .to_string()
        .contains("not selected"));
    let mut c = config();
    c.entries.insert("missing".into(), "missing".into());
    assert!(elf::read(&bytes, &c)
        .unwrap_err()
        .to_string()
        .contains("missing or ambiguous"));
    let mut c = config();
    c.code_sections = vec![".rodata".into()];
    c.data_sections = vec![".text".into()];
    assert!(elf::read(&bytes, &c)
        .unwrap_err()
        .to_string()
        .contains("executable flag"));
    assert!(elf::read(&bytes[..40], &config()).is_err());
    let mut relocatable = bytes.clone();
    relocatable[16] = 1;
    assert!(elf::read(&relocatable, &config()).is_err());
    // ET_DYN is read as a static PIE, which needs PT_DYNAMIC.
    let mut pie = bytes.clone();
    pie[16] = 3;
    assert!(elf::read(&pie, &config())
        .unwrap_err()
        .to_string()
        .contains("without PT_DYNAMIC"));
    let mut wrong_machine = bytes.clone();
    wrong_machine[18] = 3;
    assert!(elf::read(&wrong_machine, &config()).is_err());
}

#[test]
fn rejects_invalid_load_segments_and_sections() {
    let tmp = tempfile::tempdir().unwrap();
    fixture(tmp.path(), "basic.S");
    let bytes = fs::read(tmp.path().join("input.elf")).unwrap();
    let word = |offset| u64::from_le_bytes(bytes[offset..offset + 8].try_into().unwrap()) as usize;
    let ph = word(32);
    let mut dynamic = bytes.clone();
    dynamic[ph..ph + 4].copy_from_slice(&2u32.to_le_bytes());
    assert!(elf::read(&dynamic, &config())
        .unwrap_err()
        .to_string()
        .contains("only supported in static PIEs"));
    let mut interpreted = bytes.clone();
    interpreted[ph..ph + 4].copy_from_slice(&3u32.to_le_bytes());
    interpreted[16] = 3;
    assert!(elf::read(&interpreted, &config())
        .unwrap_err()
        .to_string()
        .contains("dynamic linking"));
    let mut writable_code = bytes.clone();
    writable_code[ph + 4..ph + 8].copy_from_slice(&7u32.to_le_bytes());
    assert!(elf::read(&writable_code, &config())
        .unwrap_err()
        .to_string()
        .contains("writable and executable"));
    let mut short_memory = bytes.clone();
    short_memory[ph + 40..ph + 48].copy_from_slice(&0u64.to_le_bytes());
    assert!(elf::read(&short_memory, &config())
        .unwrap_err()
        .to_string()
        .contains("memory size"));
    let mut past_end = bytes.clone();
    past_end[ph + 8..ph + 16].copy_from_slice(&(bytes.len() as u64).to_le_bytes());
    assert!(elf::read(&past_end, &config())
        .unwrap_err()
        .to_string()
        .contains("past the ELF"));
    // Mapping must cover the exact bytes at the section's virtual address.
    for (offset, value) in [
        (ph + 16, word(ph + 16) as u64 + 1),
        (ph + 32, word(ph + 32) as u64 - 1),
        (ph + 8, word(ph + 8) as u64 + 1),
    ] {
        let mut unmapped = bytes.clone();
        unmapped[offset..offset + 8].copy_from_slice(&value.to_le_bytes());
        assert!(elf::read(&unmapped, &config())
            .unwrap_err()
            .to_string()
            .contains("compatible read-only load segment"));
    }
    let object = object::File::parse(bytes.as_slice()).unwrap();
    let index = object.section_by_name(".rodata").unwrap().index().0;
    let sh = word(40) + index * u16::from_le_bytes(bytes[58..60].try_into().unwrap()) as usize;
    let mut writable = bytes.clone();
    writable[sh + 8..sh + 16].copy_from_slice(&3u64.to_le_bytes());
    assert!(elf::read(&writable, &config())
        .unwrap_err()
        .to_string()
        .contains("read-only"));
    let mut bss = bytes.clone();
    bss[sh + 4..sh + 8].copy_from_slice(&8u32.to_le_bytes());
    assert!(elf::read(&bss, &config())
        .unwrap_err()
        .to_string()
        .contains("file-backed"));
    let mut reloc = bytes.clone();
    reloc[sh + 4..sh + 8].copy_from_slice(&4u32.to_le_bytes());
    assert!(elf::read(&reloc, &config()).is_err());
    let mut overlap = bytes.clone();
    overlap[sh + 16..sh + 24].copy_from_slice(&0x100000u64.to_le_bytes());
    assert!(elf::read(&overlap, &config())
        .unwrap_err()
        .to_string()
        .contains("overlapping"));
}

/// Startup and the loader ignore non-allocated relocation sections (`--emit-relocs`), but glibc's
/// static startup applies the IRELATIVE relocations from `__rela_iplt_start` to `__rela_iplt_end`.
#[test]
fn checks_the_relocations_static_startup_applies() {
    let link = |assembly: &str, extra: &[&str]| {
        let tmp = tempfile::tempdir().unwrap();
        copy_fixture(tmp.path(), assembly, "input.S");
        copy_fixture(tmp.path(), "layout.ld", "layout.ld");
        assemble_and_link(tmp.path(), &[&["-T", "layout.ld"], extra].concat());
        fs::read(tmp.path().join("input.elf")).unwrap()
    };
    let emitted = link("emit-relocs.S", &["--emit-relocs"]);
    let object = object::File::parse(emitted.as_slice()).unwrap();
    assert!(object.section_by_name(".rela.text").is_some());
    elf::read(&emitted, &config()).unwrap();
    assert!(elf::read(&link("iplt.S", &[]), &config())
        .unwrap_err()
        .to_string()
        .contains("__rela_iplt"));
}

/// Lean builds a section of up to 256 MiB; a larger one is rejected rather than written.
#[test]
fn rejects_sections_over_256_mib() {
    let tmp = tempfile::tempdir().unwrap();
    copy_fixture(tmp.path(), "layout.ld", "layout.ld");
    fs::write(
        tmp.path().join("input.S"),
        ".section .text\n.global entry\nentry:\n    ret\n.global second\nsecond:\n    ret\n\
         .section .rodata\n.zero 268435457\n",
    )
    .unwrap();
    assemble_and_link(tmp.path(), &["-T", "layout.ld"]);
    let bytes = fs::read(tmp.path().join("input.elf")).unwrap();
    assert!(elf::read(&bytes, &config())
        .unwrap_err()
        .to_string()
        .contains("256 MiB"));
}

/// The embedding limit applies to the whole file only when the file is embedded.
#[test]
fn rejects_files_over_256_mib_when_embedded() {
    let tmp = tempfile::tempdir().unwrap();
    fixture(tmp.path(), "basic.S");
    let input = tmp.path().join("input.elf");
    let mut bytes = fs::read(&input).unwrap();
    bytes.resize(256 << 20, 0);
    let mut c = config();
    c.include_file = true;
    elf::read(&bytes, &c).unwrap();
    bytes.push(0);
    assert!(elf::read(&bytes, &c)
        .unwrap_err()
        .to_string()
        .contains("ELF file is over 256 MiB"));
    c.include_file = false;
    elf::read(&bytes, &c).unwrap();
    drop(bytes);

    // Reject before starting the decoder or publishing an output directory.
    fs::OpenOptions::new()
        .write(true)
        .open(input)
        .unwrap()
        .set_len((256 << 20) + 1)
        .unwrap();
    let config_path = tmp.path().join("extraction.toml");
    fs::write(
        &config_path,
        include_str!("fixtures/extraction.toml")
            .replace("[entries]", "include_file = true\n\n[entries]"),
    )
    .unwrap();
    let error = x86_extract::run(&config_path, &tmp.path().join("missing-decoder")).unwrap_err();
    assert!(error.to_string().contains("ELF file is over 256 MiB"));
    assert!(!tmp.path().join("Fixture/Extracted").exists());
}

#[test]
fn rejects_overlapping_load_mappings() {
    let tmp = tempfile::tempdir().unwrap();
    fixture(tmp.path(), "exit.S");
    let input = tmp.path().join("input.elf");
    let bytes = fs::read(&input).unwrap();
    assert!(elf::read(&bytes, &config()).is_ok());
    #[cfg(all(target_os = "linux", target_arch = "x86_64"))]
    assert_eq!(run_written(&input).code(), Some(42));

    let word = |offset| u64::from_le_bytes(bytes[offset..offset + 8].try_into().unwrap()) as usize;
    let ph = word(32);
    let ph_size = u16::from_le_bytes(bytes[54..56].try_into().unwrap()) as usize;
    let ph_count = u16::from_le_bytes(bytes[56..58].try_into().unwrap());
    let headers = &bytes[ph..ph + ph_size * usize::from(ph_count)];
    let address = word(ph + 16) as u64;
    let text_size = word(ph + 32);
    let payload = bytes.len().next_multiple_of(4096);
    let mut base = bytes.clone();
    base.resize(payload + 4096, 0);
    base[payload..payload + text_size]
        .copy_from_slice(&bytes[word(ph + 8)..word(ph + 8) + text_size]);
    let exit_immediate = base[payload..payload + text_size]
        .windows(5)
        .position(|w| w == [0xbf, 42, 0, 0, 0])
        .unwrap()
        + 1;
    base[payload + exit_immediate] = 99;

    for (offset, filesz, memsz, flags, run) in [
        (0, text_size as u64, text_size as u64, 5u32, true),
        // The declared byte ranges are disjoint, but the later mapping replaces
        // the entire page, including the original entry point.
        (0x800, 1, 1, 5, true),
        (0, 0, 4096, 6, false), // zero-fill can overwrite the original image
        (0, text_size as u64, text_size as u64, 4, false), // removes execute permission
    ] {
        let mut overlapping = base.clone();
        let table = overlapping.len() as u64;
        overlapping.extend_from_slice(headers);
        let mut extra = headers[..ph_size].to_vec();
        extra[4..8].copy_from_slice(&flags.to_le_bytes());
        for (field, value) in [
            (8, payload as u64 + offset),
            (16, address + offset),
            (24, address + offset),
            (32, filesz),
            (40, memsz),
        ] {
            extra[field..field + 8].copy_from_slice(&value.to_le_bytes());
        }
        overlapping.extend_from_slice(&extra);
        overlapping[32..40].copy_from_slice(&table.to_le_bytes());
        overlapping[56..58].copy_from_slice(&(ph_count + 1).to_le_bytes());
        if run && cfg!(all(target_os = "linux", target_arch = "x86_64")) {
            fs::write(&input, &overlapping).unwrap();
            assert_eq!(run_written(&input).code(), Some(99));
        }
        assert!(elf::read(&overlapping, &config())
            .unwrap_err()
            .to_string()
            .contains("overlapping load mappings"));
    }
}

fn files(directory: &Path) -> BTreeMap<String, Vec<u8>> {
    fs::read_dir(directory)
        .unwrap()
        .map(|entry| {
            let entry = entry.unwrap();
            (
                entry.file_name().to_str().unwrap().to_owned(),
                fs::read(entry.path()).unwrap(),
            )
        })
        .collect()
}

fn invoke(directory: &Path) -> Output {
    Command::new(env!("CARGO_BIN_EXE_x86-extract"))
        .current_dir(directory)
        .arg("extraction.toml")
        .output()
        .unwrap()
}

fn success(output: Output) {
    assert!(
        output.status.success(),
        "{}{}",
        String::from_utf8_lossy(&output.stdout),
        String::from_utf8_lossy(&output.stderr)
    );
}

fn check_lean(workspace: &Path) {
    check_lean_at(workspace, &workspace.join("Fixture/Extracted"));
}

fn check_lean_at(workspace: &Path, directory: &Path) {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap();
    let lean = command(
        Command::new("lake")
            .current_dir(root)
            .args(["env", "which", "lean"]),
    );
    let lean = String::from_utf8(lean.stdout).unwrap();
    let modules: Vec<_> = ["Sections", "Symbols", "Image", "File"]
        .into_iter()
        .filter(|name| directory.join(format!("{name}.lean")).exists())
        .collect();
    for name in &modules {
        let file = directory.join(format!("{name}.lean"));
        let result = command(
            Command::new(lean.trim())
                .current_dir(workspace)
                .env(
                    "LEAN_PATH",
                    std::env::join_paths([workspace.to_owned(), root.join(".lake/build/lib/lean")])
                        .unwrap(),
                )
                .arg("-o")
                .arg(file.with_extension("olean"))
                .arg(&file),
        );
        assert!(
            result.stdout.is_empty() && result.stderr.is_empty(),
            "unexpected diagnostics: {result:?}"
        );
    }
    // The modules hold definitions only. Build the check once per test process: test threads
    // would otherwise run `lake build` in one directory at once.
    static AUTHORED_PROOFS: std::sync::Once = std::sync::Once::new();
    AUTHORED_PROOFS.call_once(|| {
        command(
            Command::new("lake")
                .current_dir(root)
                .args(["build", "AuthoredProofs"]),
        );
    });
    let prefix = directory
        .strip_prefix(workspace)
        .unwrap()
        .iter()
        .map(|part| part.to_str().unwrap())
        .collect::<Vec<_>>()
        .join(".");
    command(
        Command::new(lean.trim())
            .current_dir(workspace)
            .env(
                "LEAN_PATH",
                std::env::join_paths([workspace.to_owned(), root.join(".lake/build/lib/lean")])
                    .unwrap(),
            )
            .arg("--run")
            .arg(root.join("tools/check_authored_proofs.lean"))
            .args(modules.iter().map(|name| format!("{prefix}.{name}"))),
    );
}

/// Run `lean` on a file in a workspace with the repository's and the workspace's modules.
fn lean_in(workspace: &Path, arguments: &[&std::ffi::OsStr]) -> Output {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap();
    let lean = command(
        Command::new("lake")
            .current_dir(root)
            .args(["env", "which", "lean"]),
    );
    command(
        Command::new(String::from_utf8(lean.stdout).unwrap().trim())
            .current_dir(workspace)
            .env(
                "LEAN_PATH",
                std::env::join_paths([workspace.to_owned(), root.join(".lake/build/lib/lean")])
                    .unwrap(),
            )
            .args(arguments),
    )
}

#[test]
#[ignore = "requires make -C extraction and lake build"]
fn dumps_reproducible_artifacts_that_lean_checks() {
    let tmp = tempfile::Builder::new()
        .prefix("x86 extraction ")
        .tempdir()
        .unwrap();
    fixture(tmp.path(), "basic.S");
    success(invoke(tmp.path()));
    let directory = tmp.path().join("Fixture/Extracted");
    let original = files(&directory);
    assert_eq!(
        original["text.bin"],
        elf::read(&fs::read(tmp.path().join("input.elf")).unwrap(), &config())
            .unwrap()
            .sections[0]
            .bytes
    );
    assert_eq!(original["rodata.bin"], [1, 2, 3, 4]);
    assert_eq!(
        original.keys().map(String::as_str).collect::<Vec<_>>(),
        [
            "Image.lean",
            "Sections.lean",
            "Symbols.lean",
            "rodata.bin",
            "text.bin"
        ]
    );
    let sections = String::from_utf8_lossy(&original["Sections.lean"]);
    assert!(sections.contains("import Prelude.Bytes.Include\n"));
    assert!(sections.contains("def textAddress") && sections.contains("def textBytes"));
    assert!(sections.contains("def rodataAddress") && sections.contains("def rodataBytes"));
    assert_eq!(sections.matches("namespace Fixture.Extracted\n").count(), 1);
    assert!(sections.contains("include_chunked_bytes \"text.bin\""));
    assert!(sections.contains("def textByteArray : ByteArray := textBytes.toByteArray"));
    assert!(sections.contains(
        "/-- The link-time address of the code section `.text` -/\ndef textAddress : BitVec 64 :="
    ));
    assert!(sections.contains(
        "/-- The bytes of the data section `.rodata`, from `rodata.bin` -/\ndef rodataBytes"
    ));
    assert!(!sections.contains("theorem") && !sections.contains("CodeMap"));
    let image = String::from_utf8_lossy(&original["Image.lean"]);
    assert!(image.contains("import Fixture.Extracted.Sections"));
    assert!(image.contains("[⟨textAddress, textBytes⟩,\n   ⟨rodataAddress, rodataBytes⟩]"));
    assert!(
        image.contains("def programImage : X86.UserProcess.CodeMap := programSections.toCodeMap")
    );
    assert!(!image.contains("theorem"));
    let symbols = String::from_utf8_lossy(&original["Symbols.lean"]);
    assert!(symbols.contains("def entryStackBytes : Option Nat := some 128"));
    assert!(!symbols.contains("panicAddresses"));
    assert!(!invoke(tmp.path()).status.success());
    assert_eq!(files(&directory), original);
    fs::remove_dir_all(&directory).unwrap();
    success(invoke(tmp.path()));
    assert_eq!(files(&directory), original);
    check_lean(tmp.path());
    // Escaped components must work in both module imports and declarations.
    fs::remove_dir_all(&directory).unwrap();
    copy_fixture(tmp.path(), "escaped.toml", "extraction.toml");
    success(invoke(tmp.path()));
    let escaped = tmp.path().join("Fixture/lean-keccak");
    check_lean_at(tmp.path(), &escaped);
    fs::remove_dir_all(&escaped).unwrap();
    // A namespace that is one word of syntax the generated modules use
    fs::write(
        tmp.path().join("extraction.toml"),
        include_str!("fixtures/extraction.toml")
            .replace("Fixture/Extracted", "include_chunked_bytes")
            .replace("'Fixture.Extracted'", "'include_chunked_bytes'"),
    )
    .unwrap();
    success(invoke(tmp.path()));
    let keyword = tmp.path().join("include_chunked_bytes");
    check_lean_at(tmp.path(), &keyword);
    fs::remove_dir_all(&keyword).unwrap();
    copy_fixture(tmp.path(), "extraction.toml", "extraction.toml");
    success(invoke(tmp.path()));

    // Unsupported instructions fail before an output directory is published.
    fs::remove_dir_all(&directory).unwrap();
    fixture(tmp.path(), "unsupported.S");
    assert!(!invoke(tmp.path()).status.success());
    assert!(!directory.exists());

    // Multiple code sections, including sections whose configured order differs
    // from their address order.
    fixture(tmp.path(), "multiple-sections.S");
    copy_fixture(tmp.path(), "multiple-sections.toml", "extraction.toml");
    success(invoke(tmp.path()));
    check_lean(tmp.path());
    assert_eq!(fs::read(directory.join("text_hot.bin")).unwrap(), [0xc3]);
    fs::remove_dir_all(&directory).unwrap();
    command(Command::new("objcopy").current_dir(tmp.path()).args([
        "--rename-section",
        ".text.hot=.TEXT",
        "input.elf",
        "renamed.elf",
    ]));
    fs::write(
        tmp.path().join("extraction.toml"),
        include_str!("fixtures/extraction.toml")
            .replace("input.elf", "renamed.elf")
            .replace("['.text']", "['.TEXT', '.text']"),
    )
    .unwrap();
    let result = invoke(tmp.path());
    assert!(!result.status.success());
    assert!(
        String::from_utf8_lossy(&result.stderr).contains("duplicate artifact name"),
        "{result:?}"
    );
    assert!(!directory.exists());
    copy_fixture(tmp.path(), "alias-conflict.toml", "extraction.toml");
    let result = invoke(tmp.path());
    assert!(!result.status.success());
    assert!(String::from_utf8_lossy(&result.stderr).contains("entry alias text conflicts"));
    assert!(!directory.exists());
}

/// A section of over 16 MiB of random bytes, and thousands of panic functions: one literal of
/// either exceeded Lean's recursion depth, so the generated modules did not build.
#[test]
#[ignore = "requires make -C extraction and lake build"]
fn builds_large_sections_and_symbol_lists() {
    let tmp = tempfile::tempdir().unwrap();
    // Random bytes: Lean shares equal chunk literals, which hides the depth of uniform ones.
    let mut state = 0x9e37_79b9_7f4a_7c15u64;
    let data: Vec<u8> = (0..(20 << 20) + 5)
        .map(|_| {
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            state as u8
        })
        .collect();
    fs::write(tmp.path().join("data.bin"), &data).unwrap();
    let mut assembly = String::from(
        ".section .text\n.global entry\nentry:\n    ret\n.global second\nsecond:\n    ret\n",
    );
    for index in 0..2100 {
        assembly += &format!("_ZN4core9panicking5panic17h{index:016x}E:\n    ret\n");
    }
    assembly += ".section .rodata\n.incbin \"data.bin\"\n";
    // Thousands of sections: one list literal of them exceeded Lean's recursion depth.
    for index in 0..2100 {
        assembly += &format!(".section .r{index},\"a\"\n.byte {}\n", index % 256);
    }
    fs::write(tmp.path().join("input.S"), assembly).unwrap();
    copy_fixture(tmp.path(), "layout.ld", "layout.ld");
    assemble_and_link(tmp.path(), &["-T", "layout.ld"]);
    fs::write(
        tmp.path().join("extraction.toml"),
        include_str!("fixtures/extraction.toml")
            .replace(
                "data_sections = ['.rodata']",
                &format!(
                    "data_sections = ['.rodata', {}]",
                    (0..2100)
                        .map(|index| format!("'.r{index}'"))
                        .collect::<Vec<_>>()
                        .join(", ")
                ),
            )
            .replace("[entries]", "rust_panics = true\n\n[entries]"),
    )
    .unwrap();
    success(invoke(tmp.path()));
    let directory = tmp.path().join("Fixture/Extracted");
    assert_eq!(fs::read(directory.join("rodata.bin")).unwrap(), data);
    check_lean(tmp.path());

    // The file view's section-name list must also build with thousands of sections.
    fs::remove_dir_all(&directory).unwrap();
    let config_path = tmp.path().join("extraction.toml");
    let config = fs::read_to_string(&config_path).unwrap();
    fs::write(
        &config_path,
        config.replace("[entries]", "include_file = true\n\n[entries]"),
    )
    .unwrap();
    success(invoke(tmp.path()));
    assert_eq!(
        fs::read(directory.join("file.bin")).unwrap(),
        fs::read(tmp.path().join("input.elf")).unwrap()
    );
    check_lean(tmp.path());
}

#[test]
#[ignore = "requires make -C extraction and lake build"]
fn estimates_stack_and_discovers_opt_in_rust_panics() {
    let tmp = tempfile::tempdir().unwrap();
    fixture(tmp.path(), "stack.S");
    copy_fixture(tmp.path(), "stack.toml", "extraction.toml");
    let result = invoke(tmp.path());
    let diagnostics = String::from_utf8_lossy(&result.stderr);
    for reason in [
        "recursive call",
        "dynamic stack adjustment",
        "stack allocation in a loop",
        "unresolved call",
        "unreadable call slot",
        "unsupported stack adjustment",
        "unresolved fallthrough",
    ] {
        assert!(diagnostics.contains(reason), "{diagnostics}");
    }
    success(result);
    let directory = tmp.path().join("Fixture/Extracted");
    let symbols = fs::read_to_string(directory.join("Symbols.lean")).unwrap();
    // The entry and permutation reproduce Keccak's stack layout, including
    // direct, GOT-style and register calls, and the full 128-byte red zone.
    for (name, bytes) in [
        ("entry", 800),
        ("permutation", 272),
        ("second", 128),
        ("tail", 144),
        ("userPanic", 128),
        ("panicLoop", 128),
        ("panicCaller", 168),
        ("panicIndirect", 152),
        ("paddedBranch", 4256),
        ("fallthroughCall", 4256),
        ("fallthroughConditional", 4256),
        ("fallthroughFrame", 4256),
        ("sharedEntry", 4224),
        ("sharedTail", 4224),
        ("boundaryCall", 200),
        ("mixedPanicCall", 4232),
        ("panicBypass", 4232),
    ] {
        assert!(
            symbols.contains(&format!(
                "def {name}StackBytes : Option Nat := some {bytes}"
            )),
            "{symbols}"
        );
    }
    for name in [
        "recursive",
        "dynamic",
        "growingLoop",
        "unresolved",
        "unreadableSlot",
        "aligned",
        "fallthroughCycle",
        "fallthroughMissing",
    ] {
        assert!(
            symbols.contains(&format!("def {name}StackBytes : Option Nat := none")),
            "{symbols}"
        );
    }
    let c: Config = toml::from_str(include_str!("fixtures/stack.toml")).unwrap();
    let image = elf::read(&fs::read(tmp.path().join("input.elf")).unwrap(), &c).unwrap();
    assert_eq!(image.panics.len(), 2); // v0 and legacy aliases share one address
    let mut disabled = c;
    disabled.rust_panics = false;
    assert_eq!(
        elf::read(&fs::read(tmp.path().join("input.elf")).unwrap(), &disabled)
            .unwrap()
            .panics,
        image.panics
    );
    assert!(symbols.contains(&format!(
        "def panicAddresses : List (BitVec 64) := [{}]",
        image
            .panics
            .iter()
            .map(|a| format!("{a:#x}"))
            .collect::<Vec<_>>()
            .join(", ")
    )));
    // Generated definitions are documented, and an unknown budget gives its reason.
    assert!(symbols.contains(
        "/-- The link-time address of the symbol `entry` -/\ndef entryAddress : BitVec 64 :="
    ));
    assert!(symbols
        .contains("/-- No stack budget estimated for the symbol `recursive`: recursive call"));
    check_lean(tmp.path());
    let config_path = tmp.path().join("extraction.toml");
    fs::write(
        &config_path,
        fs::read_to_string(&config_path)
            .unwrap()
            .replace("rust_panics = true", "rust_panics = false")
            .replace("Fixture/Extracted", "WithoutPanics/Fixture/Extracted"),
    )
    .unwrap();
    success(invoke(tmp.path()));
    let disabled_symbols = fs::read_to_string(
        tmp.path()
            .join("WithoutPanics/Fixture/Extracted/Symbols.lean"),
    )
    .unwrap();
    assert!(!disabled_symbols.contains("panicAddresses"));
    let budgets = |text: &str| {
        text.lines()
            .filter(|line| line.contains("StackBytes"))
            .map(str::to_owned)
            .collect::<Vec<_>>()
    };
    assert_eq!(budgets(&symbols), budgets(&disabled_symbols));
}

/// Assemble and link a static PIE as `input.elf`.
fn pie_fixture(directory: &Path, assembly: &str) {
    copy_fixture(directory, assembly, "input.S");
    assemble_and_link(
        directory,
        &[
            "-pie",
            "--no-dynamic-linker",
            "-z",
            "separate-code",
            "-e",
            "entry",
        ],
    );
}

const PIE_DATA_SECTIONS: [&str; 6] = [
    ".hash",
    ".gnu.hash",
    ".dynsym",
    ".dynstr",
    ".rela.dyn",
    ".rodata",
];

/// The configuration for `pie.S`: every read-only section, and its entry
fn pie_config() -> Config {
    let mut c = config();
    c.data_sections = PIE_DATA_SECTIONS.map(String::from).to_vec();
    c.entries = BTreeMap::from([("entry".into(), "entry".into())]);
    c
}

#[test]
fn reads_static_pies_without_writable_sections() {
    let tmp = tempfile::tempdir().unwrap();
    pie_fixture(tmp.path(), "pie.S");
    let bytes = fs::read(tmp.path().join("input.elf")).unwrap();
    let c = pie_config();
    let image = elf::read(&bytes, &c).unwrap();
    assert!(matches!(image.kind, elf::ExecutableKind::StaticPie(_)));
    assert_eq!(image.entries["entry"], 0x1000);
    let mut writable = pie_config();
    writable.data_sections.push(".data".into());
    assert!(elf::read(&bytes, &writable)
        .unwrap_err()
        .to_string()
        .contains("read-only"));
    let object = object::File::parse(bytes.as_slice()).unwrap();
    let rela = object
        .section_by_name(".rela.dyn")
        .unwrap()
        .file_range()
        .unwrap()
        .0 as usize;
    let mut into_rodata = bytes.clone();
    into_rodata[rela..rela + 8].copy_from_slice(&0x2000u64.to_le_bytes());
    assert!(elf::read(&into_rodata, &c)
        .unwrap_err()
        .to_string()
        .contains("outside writable"));
    let mut absolute = bytes.clone();
    absolute[rela + 8..rela + 16].copy_from_slice(&1u64.to_le_bytes());
    assert!(elf::read(&absolute, &c)
        .unwrap_err()
        .to_string()
        .contains("R_X86_64_RELATIVE"));
}

/// A Lean list literal
fn lean_list(items: impl IntoIterator<Item = String>) -> String {
    format!("[{}]", items.into_iter().collect::<Vec<_>>().join(",\n  "))
}

#[test]
#[ignore = "requires make -C extraction and lake build"]
fn file_views_match_the_elf() {
    use object::read::elf::{FileHeader, ProgramHeader, Rela, SectionHeader};
    let tmp = tempfile::tempdir().unwrap();
    pie_fixture(tmp.path(), "pie.S");
    let mut c = config();
    c.data_sections = PIE_DATA_SECTIONS.map(String::from).to_vec();
    let sections = c
        .code_sections
        .iter()
        .chain(&c.data_sections)
        .map(|name| format!("'{name}'"))
        .collect::<Vec<_>>()
        .join(", ");
    fs::write(
        tmp.path().join("extraction.toml"),
        format!(
            "elf = 'input.elf'\noutput = 'Fixture/Extracted'\nnamespace = 'Fixture.Extracted'\n\
             code_sections = ['.text']\ndata_sections = [{}]\ninclude_file = true\n\n\
             [entries]\nentry = 'entry'\n",
            sections.trim_start_matches("'.text', ")
        ),
    )
    .unwrap();
    success(invoke(tmp.path()));
    let directory = tmp.path().join("Fixture/Extracted");
    assert_eq!(
        files(&directory).into_keys().collect::<Vec<_>>(),
        [
            "File.lean",
            "Image.lean",
            "Sections.lean",
            "Symbols.lean",
            "file.bin"
        ]
    );
    check_lean(tmp.path());

    // Expected values from the `object` crate's reader.
    let bytes = fs::read(tmp.path().join("input.elf")).unwrap();
    let elf = object::read::elf::ElfFile64::<object::Endianness>::parse(bytes.as_slice()).unwrap();
    let endian = elf.endian();
    let headers = lean_list(elf.elf_program_headers().iter().map(|h| {
        format!(
            "{{ type := {}, flags := {}, offset := {}, vaddr := {}, paddr := {}, filesz := {}, \
             memsz := {}, align := {} }}",
            h.p_type(endian),
            h.p_flags(endian),
            h.p_offset(endian),
            h.p_vaddr(endian),
            h.p_paddr(endian),
            h.p_filesz(endian),
            h.p_memsz(endian),
            h.p_align(endian)
        )
    }));
    let entry = elf.elf_header().e_entry(endian);
    let symbol = elf
        .symbols()
        .find(|symbol| symbol.name() == Ok("entry"))
        .unwrap();
    let rela = elf.section_by_name(".rela.dyn").unwrap();
    let relocations = lean_list(
        rela.elf_section_header()
            .data_as_array::<object::elf::Rela64<object::Endianness>, _>(endian, bytes.as_slice())
            .unwrap()
            .iter()
            .map(|r| format!("({}, {})", r.r_offset(endian), r.r_addend(endian) as u64)),
    );
    assert!(relocations.contains(','), "the fixture has relocations");
    let slices = lean_list(c.code_sections.iter().chain(&c.data_sections).map(|name| {
        let section = elf.section_by_name(name).unwrap();
        format!(
            "{{ address := {}, offset := {}, size := {} }}",
            section.address(),
            section.file_range().unwrap().0,
            section.size()
        )
    }));
    fs::write(
        tmp.path().join("Check.lean"),
        format!(
            "import Fixture.Extracted.File\n\
             import Fixture.Extracted.Image\n\
             open Fixture.Extracted\n\n\
             example : (·.headers) <$> segments = .ok\n  {headers} := by decide +kernel\n\n\
             example : (fun s => (s.value, s.size)) <$> entrySymbol = .ok ({}, {}) := by decide +kernel\n\n\
             example : (·.value) <$> symbolNamed (utf8_bytes \"missing\") =\n    \
             .error (.missingSymbol (utf8_bytes \"missing\")) := by decide +kernel\n\n\
             example : relativeRelocations = .ok\n  {relocations} := by decide +kernel\n\n\
             example : programFileSlices = .ok\n  {slices} := by decide +kernel\n\n\
             example : programFileFetchByte {entry} = .ok (some {}) := by decide +kernel\n\n\
             -- The sections' bytes are the file's.\n\
             example : programSections.fetchByte {entry} = some {} := by decide +kernel\n",
            symbol.address(),
            symbol.size(),
            bytes[entry as usize],
            bytes[entry as usize],
        ),
    )
    .unwrap();
    let result = lean_in(tmp.path(), &[tmp.path().join("Check.lean").as_os_str()]);
    assert!(result.stdout.is_empty(), "{result:?}");

    // The views name the reader as `_root_.Elf`, so a namespace ending in `Elf` works.
    let config_path = tmp.path().join("extraction.toml");
    let text = fs::read_to_string(&config_path).unwrap();
    fs::write(
        &config_path,
        text.replace("Fixture/Extracted", "Fixture/Elf")
            .replace("Fixture.Extracted", "Fixture.Elf"),
    )
    .unwrap();
    success(invoke(tmp.path()));
    check_lean_at(tmp.path(), &tmp.path().join("Fixture/Elf"));
    fs::write(&config_path, text).unwrap();
}

#[test]
fn checks_the_relocations_startup_applies() {
    let tmp = tempfile::tempdir().unwrap();
    pie_fixture(tmp.path(), "pie.S");
    let bytes = fs::read(tmp.path().join("input.elf")).unwrap();
    let c = pie_config();
    elf::read(&bytes, &c).unwrap();
    // Startup would apply relative relocations that no checked section describes.
    let mut relr = bytes.clone();
    write_word(&mut relr, dynamic_entry(&bytes, 9), 36);
    assert!(elf::read(&relr, &c)
        .unwrap_err()
        .to_string()
        .contains("unsupported dynamic tag 0x24"));
    // Startup would read relocations past the bytes the load segment maps.
    let mut longer = bytes.clone();
    let size = dynamic_entry(&bytes, 8) + 8;
    write_word(&mut longer, size, read_word(&bytes, size) + 24);
    assert!(elf::read(&longer, &c)
        .unwrap_err()
        .to_string()
        .contains("is not in a load segment's file bytes"));
}

/// Startup reads the dynamic table and the RELA table from memory, up to `DT_NULL`, so the checks
/// read the bytes the load segments map there, not copies that headers point to.
#[test]
fn checks_the_tables_startup_reads() {
    let tmp = tempfile::tempdir().unwrap();
    pie_fixture(tmp.path(), "pie.S");
    let bytes = fs::read(tmp.path().join("input.elf")).unwrap();
    let c = pie_config();
    elf::read(&bytes, &c).unwrap();
    let error = |file: &[u8]| elf::read(file, &c).unwrap_err().to_string();
    let word = |offset| read_word(&bytes, offset);
    let half = |offset| read_half(&bytes, offset);
    let set = write_word;
    let object = object::File::parse(bytes.as_slice()).unwrap();
    let range = |name| section_range(&bytes, name);
    let dynamic = range(".dynamic");
    let rela = range(".rela.dyn");
    let entry = |tag| dynamic_entry(&bytes, tag);
    let program_headers = (0..usize::from(half(56)))
        .map(|index| word(32) as usize + index * usize::from(half(54)))
        .collect::<Vec<_>>();
    let program_header = |p_type: u32| {
        *program_headers
            .iter()
            .find(|&&h| u32::from_le_bytes(bytes[h..h + 4].try_into().unwrap()) == p_type)
            .unwrap()
    };
    let section_header = |name| {
        word(40) as usize + object.section_by_name(name).unwrap().index().0 * usize::from(half(58))
    };
    const DT_DEBUG: u64 = 21;
    const DT_RELR: u64 = 36;

    // PT_DYNAMIC's file offset names a copy of the table, while the loaded table lists DT_RELR.
    let mut copied_dynamic = bytes.clone();
    copied_dynamic.extend_from_slice(&bytes[dynamic.clone()]);
    set(
        &mut copied_dynamic,
        program_header(2) + 8,
        bytes.len() as u64,
    );
    set(&mut copied_dynamic, entry(DT_DEBUG), DT_RELR);
    assert!(error(&copied_dynamic).contains("unsupported dynamic tag 0x24"));

    // `.rela.dyn`'s section header names a copy of the table, while the loaded table relocates
    // `.rodata`.
    let mut copied_rela = bytes.clone();
    copied_rela.extend_from_slice(&bytes[rela.clone()]);
    set(
        &mut copied_rela,
        section_header(".rela.dyn") + 24,
        bytes.len() as u64,
    );
    set(&mut copied_rela, rela.start, 0x2000);
    assert!(error(&copied_rela).contains("outside writable"));

    // Startup stops at DT_NULL, so a tag in the padding after it does not count.
    let mut padded = bytes.clone();
    set(&mut padded, entry(0) + 16, DT_RELR);
    elf::read(&padded, &c).unwrap();
    // Without DT_NULL, startup would read past the table.
    let mut unterminated = bytes.clone();
    for offset in dynamic.clone().step_by(16).filter(|&o| word(o) == 0) {
        set(&mut unterminated, offset, DT_DEBUG);
    }
    assert!(error(&unterminated).contains("no DT_NULL"));

    // Startup takes the last of repeated tags; the checks take none.
    let mut repeated = bytes.clone();
    set(&mut repeated, entry(DT_DEBUG), 7);
    set(&mut repeated, entry(DT_DEBUG) + 8, 0x1e0);
    assert!(error(&repeated).contains("repeated dynamic tag 0x7"));

    // Startup finds the table through `_DYNAMIC`, not PT_DYNAMIC, so without PT_DYNAMIC it
    // still applies the relocations.
    let mut hidden = bytes.clone();
    hidden[program_header(2)..program_header(2) + 4].copy_from_slice(&0u32.to_le_bytes());
    assert!(error(&hidden).contains("without PT_DYNAMIC"));
    // A `.dynamic` section elsewhere would be the table `_DYNAMIC` names.
    let mut elsewhere = bytes.clone();
    let address = word(section_header(".dynamic") + 16);
    set(
        &mut elsewhere,
        section_header(".dynamic") + 16,
        address + 16,
    );
    assert!(error(&elsewhere).contains("SHT_DYNAMIC"));

    // musl's startup finds its load bias through AT_PHDR, which Linux computes from the PT_LOAD
    // that maps the program headers.
    let mut unmapped_headers = bytes.clone();
    let table =
        word(32) as usize..word(32) as usize + program_headers.len() * usize::from(half(54));
    unmapped_headers.extend_from_slice(&bytes[table]);
    set(&mut unmapped_headers, 32, bytes.len() as u64);
    assert!(error(&unmapped_headers).contains("program headers"));

    // Startup finds the table through `_DYNAMIC`.
    let mut moved = bytes.clone();
    let symbol = object.symbol_by_name("_DYNAMIC").unwrap().index().0;
    set(&mut moved, range(".symtab").start + symbol * 24 + 8, 0x3f00);
    assert!(error(&moved).contains("_DYNAMIC"));

    // A relocation that rewrote the RELA table would change what startup applies after it.
    let mut overwriting = bytes.clone();
    let first_load = program_header(1);
    overwriting[first_load + 4..first_load + 8].copy_from_slice(&6u32.to_le_bytes());
    set(
        &mut overwriting,
        rela.start,
        word(section_header(".rela.dyn") + 16),
    );
    assert!(error(&overwriting).contains("overwrites the RELA table"));
}

/// What startup's relocations write: glibc applies `DT_RELACOUNT` relocations even past
/// `DT_RELASZ`, and each relocation stores 8 bytes, so overlapping ones leave other values.
#[test]
fn checks_what_relocations_write() {
    let tmp = tempfile::tempdir().unwrap();
    pie_fixture(tmp.path(), "pie-pointers.S");
    let bytes = fs::read(tmp.path().join("input.elf")).unwrap();
    let c = pie_config();
    let image = elf::read(&bytes, &c).unwrap();
    let word = |offset| read_word(&bytes, offset);
    let set = write_word;
    let error = |file: &[u8]| elf::read(file, &c).unwrap_err().to_string();
    let rela = section_range(&bytes, ".rela.dyn");
    let entry = |tag| dynamic_entry(&bytes, tag);
    const DT_RELASZ: u64 = 8;
    const DT_RELACOUNT: u64 = 0x6fff_fff9;
    let (first, second) = (word(rela.start), word(rela.start + 24));
    assert_eq!(second, first + 8);
    assert_eq!(image.pointer_at(first), Some(word(rela.start + 16)));

    // glibc would apply a third relocation, past the checked table.
    let mut counted = bytes.clone();
    set(&mut counted, entry(DT_RELACOUNT) + 8, 3);
    assert!(error(&counted).contains("DT_RELACOUNT"));
    // A shorter DT_RELASZ hides the second relocation, which glibc still applies.
    let mut shorter = bytes.clone();
    set(&mut shorter, entry(DT_RELASZ) + 8, 24);
    assert!(error(&shorter).contains("DT_RELACOUNT"));

    // The second relocation's store would replace the upper half of the first pointer.
    let mut overlapping = bytes.clone();
    set(&mut overlapping, rela.start + 24, first + 4);
    assert!(error(&overlapping).contains("overlap"));
    // Two stores to one slot leave the second, as startup applies them in order.
    let mut repeated = bytes.clone();
    set(&mut repeated, rela.start + 24, first);
    let image = elf::read(&repeated, &c).unwrap();
    assert_eq!(image.pointer_at(first), Some(word(rela.start + 24 + 16)));
}

#[test]
#[ignore = "requires make -C extraction and lake build"]
fn extracts_static_pies_and_code_only_programs_that_lean_checks() {
    let tmp = tempfile::tempdir().unwrap();
    let directory = tmp.path().join("Fixture/Extracted");
    // A static PIE: one code section and six data sections.
    pie_fixture(tmp.path(), "pie.S");
    fs::write(
        tmp.path().join("extraction.toml"),
        format!(
            "elf = 'input.elf'\noutput = 'Fixture/Extracted'\nnamespace = 'Fixture.Extracted'\n\
             code_sections = ['.text']\ndata_sections = [{}]\n\n\
             [entries]\nentry = 'entry'\n",
            PIE_DATA_SECTIONS.map(|name| format!("'{name}'")).join(", ")
        ),
    )
    .unwrap();
    success(invoke(tmp.path()));
    assert!(fs::read_to_string(directory.join("Sections.lean"))
        .unwrap()
        .contains("def positionIndependent : Bool := true"));
    check_lean(tmp.path());
    fs::remove_dir_all(&directory).unwrap();
    // A program without data sections.
    fixture(tmp.path(), "code-only.S");
    fs::write(
        tmp.path().join("extraction.toml"),
        include_str!("fixtures/extraction.toml")
            .replace("data_sections = ['.rodata']", "data_sections = []")
            .replace("second = 'second'\n", ""),
    )
    .unwrap();
    success(invoke(tmp.path()));
    assert!(fs::read_to_string(directory.join("Sections.lean"))
        .unwrap()
        .contains("def positionIndependent : Bool := false"));
    check_lean(tmp.path());
}
