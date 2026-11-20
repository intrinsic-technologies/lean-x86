//! Read the selected sections and symbols of a supported ELF. This module holds what every
//! supported ELF type shares; each type's own rules are in its module.
mod position_dependent;
mod static_pie;

use crate::config::Config;
use anyhow::{ensure, Context, Result};
use object::{
    elf,
    read::elf::{ElfFile64, FileHeader, ProgramHeader, SectionHeader},
    Architecture, Object, ObjectSection, ObjectSegment, ObjectSymbol,
};
use std::collections::{BTreeMap, BTreeSet};

pub use static_pie::StaticPie;

type File<'data> = ElfFile64<'data, object::Endianness>;

// Lean elaborates `include_chunked_bytes` within its default heartbeats up to about 300 MiB;
// 256 MiB is the largest tested embedding, whether it holds a section or the whole file.
const MAX_EMBEDDED_BYTES: usize = 256 << 20;

#[derive(Debug)]
pub struct Section {
    pub name: String,
    pub address: u64,
    pub code: bool,
    pub bytes: Vec<u8>,
    /// Where the bytes are in the file
    pub file_offset: u64,
}

#[derive(Debug)]
pub struct Image {
    pub sections: Vec<Section>,
    pub entries: BTreeMap<String, u64>,
    pub functions: BTreeSet<u64>,
    pub panics: BTreeSet<u64>,
    pub got: Option<u64>,
    pub kind: ExecutableKind,
}

/// The supported kinds of executable
#[derive(Debug)]
pub enum ExecutableKind {
    /// A position-dependent executable, `ET_EXEC`: Linux loads the link-time addresses unchanged.
    PositionDependent,
    /// `ET_DYN` without `PT_INTERP`: addresses are link-time, and Linux adds a load bias.
    StaticPie(StaticPie),
}

impl Image {
    /// The address that a pointer-sized slot holds when the program starts, if any
    pub fn pointer_at(&self, address: u64) -> Option<u64> {
        match &self.kind {
            ExecutableKind::PositionDependent => {
                position_dependent::pointer_at(&self.sections, address)
            }
            ExecutableKind::StaticPie(pie) => pie.pointer_at(address),
        }
    }

    /// The candidate pointer slots and the values they hold when the program starts, among the
    /// slots `pointer_at` reads: every data word of a position-dependent executable, and a
    /// static PIE's relocated slots. Callers keep the values that are function addresses.
    pub fn pointer_slots(&self) -> Vec<(u64, u64)> {
        match &self.kind {
            ExecutableKind::PositionDependent => position_dependent::data_words(&self.sections),
            ExecutableKind::StaticPie(pie) => pie.pointer_slots(),
        }
    }

    /// Whether an immediate operand can be an address; a static PIE's addresses depend on its
    /// load bias, so only RIP-relative ones are
    pub fn immediates_are_addresses(&self) -> bool {
        match self.kind {
            ExecutableKind::PositionDependent => true,
            ExecutableKind::StaticPie(_) => false,
        }
    }
}

fn rust_panic(name: &str) -> bool {
    let name = format!("{:#}", rustc_demangle::demangle(name));
    name.starts_with("core::panicking::panic")
        || (name.starts_with("core::slice::index::slice_") && name.contains("_fail"))
        || name.starts_with("std::panicking::begin_panic")
        || name == "rust_begin_unwind"
        || name == "__rustc::rust_begin_unwind"
}

pub fn read(bytes: &[u8], config: &Config) -> Result<Image> {
    config.validate()?;
    ensure!(
        !config.include_file || bytes.len() <= MAX_EMBEDDED_BYTES,
        "ELF file is over 256 MiB, the largest embedded file the generated Lean is known to build"
    );
    let file = File::parse(bytes).context("reading ELF64")?;
    let endian = file.endian();
    let e_type = file.elf_header().e_type(endian);
    ensure!(
        file.architecture() == Architecture::X86_64
            && file.is_little_endian()
            && matches!(e_type, elf::ET_EXEC | elf::ET_DYN),
        "expected a little-endian x86-64 ET_EXEC or static-PIE ET_DYN ELF"
    );
    check_load_segments(&file, bytes)?;
    let writable_ranges = writable_ranges(&file);
    let kind = match e_type {
        elf::ET_EXEC => {
            position_dependent::check(&file)?;
            ExecutableKind::PositionDependent
        }
        // Without PT_INTERP, which `check_load_segments` rejects, ET_DYN is a static PIE.
        elf::ET_DYN => ExecutableKind::StaticPie(StaticPie::read(&file, bytes, &writable_ranges)?),
        _ => unreachable!("ELF type {e_type} was rejected above"),
    };
    let sections = sections(&file, config)?;
    let in_code = |address: u64| {
        sections
            .iter()
            .any(|s| s.code && address >= s.address && address - s.address < s.bytes.len() as u64)
    };
    let symbol_address = |name: &str| -> Result<u64> {
        let matches: BTreeSet<_> = file
            .symbols()
            .filter(|s| !s.is_undefined() && s.name() == Ok(name))
            .map(|s| s.address())
            .collect();
        ensure!(matches.len() == 1, "missing or ambiguous symbol {name}");
        let address = *matches.first().unwrap();
        ensure!(in_code(address), "entry {name} is outside selected code");
        Ok(address)
    };
    let mut entries = BTreeMap::new();
    for (alias, name) in &config.entries {
        let address = symbol_address(name)?;
        entries.insert(alias.clone(), address);
    }
    let panics = file
        .symbols()
        .filter(|s| !s.is_undefined() && in_code(s.address()) && s.name().is_ok_and(rust_panic))
        .map(|s| s.address())
        .collect();
    let mut functions: BTreeSet<_> = file
        .symbols()
        .filter(|s| {
            !s.is_undefined() && s.kind() == object::SymbolKind::Text && in_code(s.address())
        })
        .map(|s| s.address())
        .collect();
    functions.extend(entries.values());
    let got = file
        .symbols()
        .find(|s| s.name() == Ok("_GLOBAL_OFFSET_TABLE_"))
        .map(|s| s.address());
    Ok(Image {
        sections,
        entries,
        functions,
        panics,
        got,
        kind,
    })
}

/// Reject `PT_INTERP`, and check that each load segment is file-backed, not both writable and
/// executable, and on pages no other load segment maps.
fn check_load_segments(file: &File<'_>, bytes: &[u8]) -> Result<()> {
    let endian = file.endian();
    let mut load_ranges = Vec::new();
    for header in file.elf_program_headers() {
        ensure!(
            header.p_type(endian) != elf::PT_INTERP,
            "dynamic linking is not supported"
        );
        if header.p_type(endian) == elf::PT_LOAD {
            ensure!(
                header.p_filesz(endian) <= header.p_memsz(endian),
                "load segment file size exceeds memory size"
            );
            // Code in a writable segment could change at run time, so no image would describe it.
            ensure!(
                header.p_flags(endian) & (elf::PF_W | elf::PF_X) != elf::PF_W | elf::PF_X,
                "writable and executable load segments are not supported"
            );
            let end = header
                .p_vaddr(endian)
                .checked_add(header.p_memsz(endian))
                .context("load segment address overflow")?;
            ensure!(
                header
                    .p_offset(endian)
                    .checked_add(header.p_filesz(endian))
                    .is_some_and(|end| end <= bytes.len() as u64),
                "load segment extends past the ELF file"
            );
            // Loads map and zero-fill whole 4 KiB pages, including outside their byte ranges.
            let start = header.p_vaddr(endian) & !0xfff;
            let page_end = end
                .checked_add(0xfff)
                .context("load mapping address overflow")?
                & !0xfff;
            if start < page_end {
                load_ranges.push((start, page_end));
            }
        }
    }
    load_ranges.sort_unstable();
    ensure!(
        load_ranges.windows(2).all(|pair| pair[0].1 <= pair[1].0),
        "overlapping load mappings are not supported"
    );
    Ok(())
}

/// The address ranges of the writable load segments, which `check_load_segments` has checked
fn writable_ranges(file: &File<'_>) -> Vec<(u64, u64)> {
    let endian = file.endian();
    file.elf_program_headers()
        .iter()
        .filter(|h| h.p_type(endian) == elf::PT_LOAD && h.p_flags(endian) & elf::PF_W != 0)
        .map(|h| (h.p_vaddr(endian), h.p_vaddr(endian) + h.p_memsz(endian)))
        .collect()
}

/// Check the selected sections and read their bytes.
fn sections(file: &File<'_>, config: &Config) -> Result<Vec<Section>> {
    let endian = file.endian();
    let mut selected: BTreeMap<_, _> = config.sections().map(|(name, _)| (name, None)).collect();
    for section in file.sections() {
        let name = section.name().context("invalid section name")?;
        let sh_flags = section.elf_section_header().sh_flags(endian);
        // Writable and TLS sections are not part of the immutable image and may be omitted.
        if section.size() != 0
            && sh_flags & u64::from(elf::SHF_ALLOC) != 0
            && sh_flags & u64::from(elf::SHF_WRITE | elf::SHF_TLS) == 0
        {
            ensure!(
                selected.contains_key(name),
                "allocated section {name} is not selected"
            );
        }
        ensure!(
            section.size() == 0
                || sh_flags & u64::from(elf::SHF_WRITE | elf::SHF_TLS) == 0
                || sh_flags & u64::from(elf::SHF_EXECINSTR) == 0,
            "writable or TLS section {name} is executable"
        );
        if let Some(found) = selected.get_mut(name) {
            ensure!(
                found.replace(section).is_none(),
                "duplicate ELF section {name}"
            );
        }
    }
    let mut sections: Vec<Section> = Vec::new();
    for (name, code) in config.sections() {
        let section = selected[name]
            .as_ref()
            .with_context(|| format!("missing section {name}"))?;
        let sh_flags = section.elf_section_header().sh_flags(endian);
        ensure!(
            sh_flags & u64::from(elf::SHF_ALLOC) != 0
                && sh_flags & u64::from(elf::SHF_WRITE | elf::SHF_TLS | elf::SHF_COMPRESSED) == 0,
            "{name} must be allocated, read-only, uncompressed and non-TLS"
        );
        ensure!(
            (sh_flags & u64::from(elf::SHF_EXECINSTR) != 0) == code,
            "wrong executable flag on {name}"
        );
        let data = section.data().with_context(|| format!("reading {name}"))?;
        ensure!(
            data.len() as u64 == section.size(),
            "{name} must be fully file-backed"
        );
        ensure!(!code || !data.is_empty(), "empty code section {name}");
        ensure!(
            data.len() <= MAX_EMBEDDED_BYTES,
            "{name} is over 256 MiB, the largest section the generated Lean is known to build"
        );
        let address = section.address();
        let end = address
            .checked_add(section.size())
            .context("section address overflow")?;
        for other in &sections {
            ensure!(
                data.is_empty()
                    || other.bytes.is_empty()
                    || end <= other.address
                    || address >= other.address + other.bytes.len() as u64,
                "overlapping sections {name} and {}",
                other.name
            );
        }
        let mapped = file.segments().any(|segment| {
            let p_flags = segment.elf_program_header().p_flags(endian);
            // PT_LOAD file sizes were checked against memory sizes above.
            let loaded = address
                .checked_sub(segment.address())
                .and_then(|offset| usize::try_from(offset).ok())
                .and_then(|offset| segment.data().ok()?.get(offset..)?.get(..data.len()));
            p_flags & elf::PF_R != 0
                && p_flags & elf::PF_W == 0
                && (!code || p_flags & elf::PF_X != 0)
                && loaded == Some(data)
        });
        ensure!(
            mapped,
            "{name} is not backed by a compatible read-only load segment"
        );
        sections.push(Section {
            name: name.to_owned(),
            address,
            code,
            bytes: data.to_vec(),
            file_offset: section.elf_section_header().sh_offset(endian),
        });
    }
    Ok(sections)
}
