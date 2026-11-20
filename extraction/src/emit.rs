use crate::{
    config::Config,
    elf::{ExecutableKind, Image, Section},
};
use anyhow::{ensure, Context, Result};
use std::{collections::BTreeSet, fs, path::Path, process::Command};

const GENERATED_HEADER: &str =
    "/- Generated using lean-x86's extraction utility; do not modify this file directly. -/";

/// A Lean string literal with the given contents
fn lean_string(text: &str) -> String {
    let mut literal = String::from("\"");
    for c in text.chars() {
        match c {
            '"' | '\\' => {
                literal.push('\\');
                literal.push(c);
            }
            ' '..='~' => literal.push(c),
            // Lean reads `\xHH` and exactly four digits after `\u`, and rejects raw tabs.
            '\0'..='\x7f' => literal += &format!("\\x{:02x}", u32::from(c)),
            '\u{80}'..='\u{ffff}' => literal += &format!("\\u{:04x}", u32::from(c)),
            _ => literal.push(c),
        }
    }
    literal + "\""
}

fn section_stem(name: &str) -> Result<String> {
    let mut stem: String = name
        .trim_start_matches('.')
        .chars()
        .map(|c| {
            if c.is_ascii_alphanumeric() {
                c.to_ascii_lowercase()
            } else {
                '_'
            }
        })
        .collect();
    ensure!(!stem.is_empty(), "section {name:?} has no artifact name");
    if !stem.starts_with(|c: char| c.is_ascii_alphabetic()) {
        stem.insert_str(0, "section_");
    }
    Ok(stem)
}

/// A name quoted for a doc comment, if it is safe there. Lean block comments nest, so a name with
/// `/-` or `-/` would open or close one; such a name is left out.
fn quoted(name: &str) -> Option<String> {
    let safe = |c: char| c.is_ascii_alphanumeric() || "._$@-".contains(c);
    (!name.is_empty() && name.chars().all(safe)).then(|| format!("`{name}`"))
}

/// `text` with ` name` appended when the name is safe in a doc comment
fn named(text: &str, name: &str) -> String {
    match quoted(name) {
        Some(name) => format!("{text} {name}"),
        None => text.to_owned(),
    }
}

/// The value of a list definition `name : type`, and the definitions it needs first. Compiling
/// one list of a few thousand elements exceeds Lean's recursion depth, even as a concatenation of
/// literals, so a list of over 256 elements is joined from private parts.
fn list_value(name: &str, ty: &str, items: &[String], separator: &str) -> (String, String) {
    let literals: Vec<_> = items
        .chunks(256)
        .map(|part| format!("[{}]", part.join(separator)))
        .collect();
    if literals.len() <= 1 {
        let literal = literals
            .into_iter()
            .next()
            .unwrap_or_else(|| "[]".to_owned());
        return (String::new(), literal);
    }
    let mut parts = String::new();
    for (index, literal) in literals.iter().enumerate() {
        parts += &format!(
            "/-- Part {index} of `{name}` -/\nprivate def {name}Part{index} : {ty} :=\n  {literal}\n\n"
        );
    }
    let joined = (0..literals.len())
        .map(|index| format!("{name}Part{index}"))
        .collect::<Vec<_>>()
        .join(" ++\n    ");
    (parts, format!("\n  {joined}"))
}

pub fn generate(config: &Config, image: &Image, decoder: &Path, directory: &Path) -> Result<()> {
    let ns = config.lean_namespace();
    let (sections, program_sections, metadata) =
        sections_module(config, image, &ns, decoder, directory)?;
    let symbols = symbols_module(config, image, &ns, &metadata)?;
    let image_text = image_module(&ns, &program_sections);
    for (name, text) in [
        ("Sections", sections),
        ("Symbols", symbols),
        ("Image", image_text),
    ] {
        fs::write(directory.join(format!("{name}.lean")), text)?;
    }
    if config.include_file {
        fs::write(directory.join("File.lean"), file_module(config, image, &ns))?;
    }
    Ok(())
}

/// `Sections.lean`, the stems of the selected sections, code sections first, and the decoder's
/// records of their instructions. Writes each section's `.bin` file.
fn sections_module(
    config: &Config,
    image: &Image,
    ns: &str,
    decoder: &Path,
    directory: &Path,
) -> Result<(String, Vec<String>, String)> {
    let mut text =
        format!("{GENERATED_HEADER}\n\nimport Prelude.Bytes.Include\n\nnamespace {ns}\n\n");
    text += match image.kind {
        ExecutableKind::PositionDependent => {
            "/-- Not position independent: Linux loads these addresses unchanged -/\n\
             def positionIndependent : Bool := false\n\n"
        }
        ExecutableKind::StaticPie(_) => {
            "/-- A static PIE: these are link-time addresses, and Linux adds a load bias -/\n\
             def positionIndependent : Bool := true\n\n"
        }
    };
    if config.include_file {
        text += "/-- The whole ELF file -/\n\
                 def fileBytes : Prelude.Bytes.Chunked := include_chunked_bytes \"file.bin\"\n\n";
    }
    let mut code_sections = Vec::new();
    let mut data_sections = Vec::new();
    let mut metadata = String::new();
    let mut names = BTreeSet::new();
    for section in &image.sections {
        let stem = section_stem(&section.name)?;
        ensure!(
            names.insert(stem.clone()),
            "section {} has a duplicate artifact name: {stem}",
            section.name
        );
        ensure!(
            !config.include_file || stem != "file",
            "section {} conflicts with the embedded file",
            section.name
        );
        ensure!(
            !config.entries.contains_key(&stem),
            "entry alias {stem} conflicts with section {}: choose another alias",
            section.name
        );
        let what = named(
            if section.code {
                "the code section"
            } else {
                "the data section"
            },
            &section.name,
        );
        text += &format!(
            "/-- The link-time address of {what} -/\n\
             def {stem}Address : BitVec 64 := {:#x}\n\n",
            section.address
        );
        // With the whole file embedded, a section's bytes are a slice of it, and the decoder
        // reads a temporary file of them.
        let temporary;
        let binary = if config.include_file {
            let (start, end) = (
                section.file_offset,
                section.file_offset + section.bytes.len() as u64,
            );
            text += &format!(
                "/-- The bytes of {what}: the file's bytes from {start:#x} to {end:#x} -/\n\
                 def {stem}Bytes : Prelude.Bytes.Chunked := fileBytes.extract {start:#x} {end:#x}\n\n"
            );
            temporary = tempfile::NamedTempFile::new_in(directory)?;
            temporary.path().to_owned()
        } else {
            text += &format!(
                "/-- The bytes of {what}, from `{stem}.bin` -/\n\
                 def {stem}Bytes : Prelude.Bytes.Chunked := include_chunked_bytes \"{stem}.bin\"\n\n"
            );
            directory.join(format!("{stem}.bin"))
        };
        fs::write(&binary, &section.bytes)?;
        text += &format!(
            "/-- The bytes of {what} as a byte array -/\n\
             def {stem}ByteArray : ByteArray := {stem}Bytes.toByteArray\n\n"
        );
        if section.code {
            metadata += &decode(config, decoder, &binary, section)?;
            code_sections.push(stem);
        } else {
            data_sections.push(stem);
        }
    }
    text += &format!("end {ns}\n");
    code_sections.append(&mut data_sections);
    Ok((text, code_sections, metadata))
}

/// The decoder's records of a code section's instructions, read from its `.bin` file
fn decode(config: &Config, decoder: &Path, binary: &Path, section: &Section) -> Result<String> {
    let output = Command::new(decoder)
        .arg(binary)
        .arg(section.address.to_string())
        .arg(section.bytes.len().to_string())
        .args(&config.features)
        .output()
        .with_context(|| {
            format!(
                "starting {}; run make -C extraction first",
                decoder.display()
            )
        })?;
    ensure!(
        output.status.success(),
        "decoding {}: {}",
        section.name,
        String::from_utf8_lossy(&output.stderr)
    );
    Ok(String::from_utf8(output.stdout)?)
}

/// `Symbols.lean`: entry addresses, which must start instructions, stack estimates and, with
/// `rust_panics`, panic addresses
fn symbols_module(config: &Config, image: &Image, ns: &str, metadata: &str) -> Result<String> {
    let starts = metadata
        .lines()
        .map(|line| line.split_whitespace().next().unwrap_or_default().parse())
        .collect::<Result<BTreeSet<u64>, _>>()?;
    let panics = image.panics.iter().filter(|_| config.rust_panics);
    for address in image.entries.values().chain(panics) {
        ensure!(
            starts.contains(address),
            "{address:#x} is not an instruction boundary"
        );
    }
    let estimates = crate::stack::estimates(image, metadata)?;
    let mut text =
        format!("{GENERATED_HEADER}\n\nimport X86.UserProcess.CodeImage\n\nnamespace {ns}\n\n");
    for (alias, address) in &image.entries {
        let symbol = named("the symbol", &config.entries[alias]);
        text += &format!(
            "/-- The link-time address of {symbol} -/\n\
             def {alias}Address : BitVec 64 := {address:#x}\n\n"
        );
        let (doc, estimate) = match &estimates[address] {
            Ok(bytes) => (
                format!(
                    "An estimated stack budget for {symbol}: the bytes below its entry RSP that \
                     it and its callees use. A proof must check it."
                ),
                format!("some {bytes}"),
            ),
            Err(reason) => {
                eprintln!("Stack estimate for {alias}: unknown ({reason})");
                ensure!(
                    !reason.contains("/-") && !reason.contains("-/"),
                    "stack estimate reason {reason:?} cannot be in a doc comment"
                );
                (
                    format!("No stack budget estimated for {symbol}: {reason}"),
                    "none".to_owned(),
                )
            }
        };
        text += &format!("/-- {doc} -/\ndef {alias}StackBytes : Option Nat := {estimate}\n\n");
    }
    if config.rust_panics {
        let addresses: Vec<_> = image.panics.iter().map(|a| format!("{a:#x}")).collect();
        let (parts, value) = list_value("panicAddresses", "List (BitVec 64)", &addresses, ", ");
        text += &format!(
            "{parts}/-- The link-time addresses of the Rust panic and slice-index failure \
             functions -/\n\
             def panicAddresses : List (BitVec 64) := {value}\n\n"
        );
    }
    text += &format!("end {ns}\n");
    Ok(text)
}

/// `Image.lean`: the selected sections, code sections first, and their code map
fn image_module(ns: &str, program_sections: &[String]) -> String {
    let (parts, sections) = list_value(
        "programSections",
        "Prelude.ImageSections",
        &program_sections
            .iter()
            .map(|stem| format!("⟨{stem}Address, {stem}Bytes⟩"))
            .collect::<Vec<_>>(),
        ",\n   ",
    );
    format!(
        include_str!("../templates/image.lean"),
        generated_header = GENERATED_HEADER,
        ns = ns,
        parts = parts,
        sections = sections,
    )
}

/// `File.lean`: views of the embedded file, which the `Elf` library computes from `fileBytes`
fn file_module(config: &Config, image: &Image, ns: &str) -> String {
    // `programFileSlices` lists code sections before data sections, as `programSections` does.
    let names = image
        .sections
        .iter()
        .filter(|s| s.code)
        .chain(image.sections.iter().filter(|s| !s.code))
        .map(|s| format!("utf8_bytes {}", lean_string(&s.name)))
        .collect::<Vec<_>>();
    let (parts, names) = list_value(
        "programSectionNames",
        "List (List UInt8)",
        &names,
        ",\n    ",
    );
    format!(
        include_str!("../templates/file.lean"),
        generated_header = GENERATED_HEADER,
        ns = ns,
        relocations = match image.kind {
            ExecutableKind::PositionDependent => "",
            ExecutableKind::StaticPie(_) => {
                "/-- The offset and addend of each relocation in the `DT_RELA` table that \
                 `PT_DYNAMIC` lists, at link-time addresses, or the index of the first that is \
                 not `R_X86_64_RELATIVE` without a symbol -/\n\
                 def relativeRelocations : Except _root_.Elf.Error (List (Nat × Nat)) :=\n  \
                 _root_.Elf.relativeRelocations fileBytes\n\n"
            }
        },
        program_section_name_parts = parts,
        program_section_names = names,
        entry_symbols = config
            .entries
            .iter()
            .map(|(alias, name)| format!(
                "/-- {} in the symbol table -/\n\
                 def {alias}Symbol : Except _root_.Elf.Error _root_.Elf.Symbol :=\n  \
                 symbolNamed (utf8_bytes {})\n\n",
                named("The symbol", name),
                lean_string(name)
            ))
            .collect::<String>(),
    )
}

#[cfg(test)]
mod tests {
    use super::{lean_string, quoted};

    #[test]
    fn writes_lean_string_literals() {
        assert_eq!(lean_string(".text"), "\".text\"");
        assert_eq!(lean_string("a\"b\\c"), "\"a\\\"b\\\\c\"");
        assert_eq!(lean_string("\t\u{7f}"), "\"\\x09\\x7f\"");
        assert_eq!(lean_string("é€"), "\"\\u00e9\\u20ac\"");
        assert_eq!(lean_string("😀"), "\"😀\"");
    }

    #[test]
    fn quotes_only_names_safe_in_doc_comments() {
        assert_eq!(quoted(".text").as_deref(), Some("`.text`"));
        assert_eq!(
            quoted("_ZN4core9panicking5panic17h0123456789abcdefE").as_deref(),
            Some("`_ZN4core9panicking5panic17h0123456789abcdefE`")
        );
        for name in ["a-/b", "a/-b", "a`b", "a b", "a\nb", ""] {
            assert_eq!(quoted(name), None, "{name:?}");
        }
    }
}
