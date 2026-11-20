//! A position-dependent executable, `ET_EXEC`: Linux maps the load segments at their link-time
//! addresses, and nothing changes the read-only image at startup.
use super::{File, Section};
use anyhow::{ensure, Result};
use object::{
    elf,
    read::elf::{ProgramHeader, SectionHeader},
    Object, ObjectSymbol,
};
use std::collections::BTreeSet;

/// Reject what only a static PIE uses.
pub(super) fn check(file: &File<'_>) -> Result<()> {
    let endian = file.endian();
    for header in file.elf_program_headers() {
        ensure!(
            header.p_type(endian) != elf::PT_DYNAMIC,
            "PT_DYNAMIC is only supported in static PIEs"
        );
    }
    // The loader and startup ignore relocation sections that are not allocated, such as the
    // output of `--emit-relocs`.
    for header in file.elf_section_table().iter() {
        ensure!(
            header.sh_size(endian) == 0
                || header.sh_flags(endian) & u64::from(elf::SHF_ALLOC) == 0
                || !matches!(
                    header.sh_type(endian),
                    elf::SHT_REL | elf::SHT_RELA | elf::SHT_RELR
                ),
            "allocated relocation sections are only supported in static PIEs"
        );
    }
    // glibc's static startup applies the IRELATIVE relocations from `__rela_iplt_start` to
    // `__rela_iplt_end`, whatever the section headers say.
    let bounds: BTreeSet<_> = file
        .symbols()
        .filter(|s| {
            !s.is_undefined()
                && s.name()
                    .is_ok_and(|n| matches!(n, "__rela_iplt_start" | "__rela_iplt_end"))
        })
        .map(|s| s.address())
        .collect();
    ensure!(
        bounds.len() <= 1,
        "IRELATIVE relocations from __rela_iplt_start to __rela_iplt_end are not supported"
    );
    Ok(())
}

/// The little-endian word at an address in the selected data sections
pub(super) fn pointer_at(sections: &[Section], address: u64) -> Option<u64> {
    sections.iter().filter(|s| !s.code).find_map(|s| {
        let offset = usize::try_from(address.checked_sub(s.address)?).ok()?;
        let bytes = s.bytes.get(offset..)?.get(..8)?;
        Some(u64::from_le_bytes(bytes.try_into().ok()?))
    })
}

/// Every word at an 8-byte offset in the selected data sections, and its address
pub(super) fn data_words(sections: &[Section]) -> Vec<(u64, u64)> {
    sections
        .iter()
        .filter(|s| !s.code)
        .flat_map(|section| {
            section
                .bytes
                .as_chunks::<8>()
                .0
                .iter()
                .enumerate()
                .map(move |(index, bytes)| {
                    (
                        section.address + index as u64 * 8,
                        u64::from_le_bytes(*bytes),
                    )
                })
        })
        .collect()
}
