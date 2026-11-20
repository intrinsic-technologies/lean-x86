//! A static PIE: `ET_DYN` without `PT_INTERP`. Linux maps it at a load bias, and its startup code
//! applies its own relocations before anything else runs.
use super::File;
use anyhow::{bail, ensure, Context, Result};
use object::{
    elf,
    read::elf::{FileHeader, ProgramHeader, SectionHeader},
    Object, ObjectSymbol,
};
use std::collections::BTreeMap;

// Relative-relocation tags, which `object` 0.36 does not name
const DT_RELRSZ: u32 = 35;
const DT_RELR: u32 = 36;
// Android's packed relocation tags
const DT_ANDROID_REL: u32 = 0x6000_000f;
const DT_ANDROID_RELSZ: u32 = 0x6000_0010;
const DT_ANDROID_RELA: u32 = 0x6000_0011;
const DT_ANDROID_RELASZ: u32 = 0x6000_0012;
const DT_ANDROID_RELR: u32 = 0x6fff_e000;
const DT_ANDROID_RELRSZ: u32 = 0x6fff_e001;

#[derive(Debug)]
pub struct StaticPie {
    /// The `R_X86_64_RELATIVE` slots and the link-time addresses startup stores there
    pub relocations: BTreeMap<u64, u64>,
}

impl StaticPie {
    /// Check the relocations startup applies and read them. Startup finds the dynamic table
    /// through `_DYNAMIC` and reads it, and the RELA table it names, from memory, so both are read
    /// here from the bytes the load segments map, not from file offsets or section headers.
    pub(super) fn read(
        file: &File<'_>,
        bytes: &[u8],
        writable_ranges: &[(u64, u64)],
    ) -> Result<Self> {
        let dynamic = Dynamic::read(file, bytes)?;
        let relocations = match dynamic.rela_table()? {
            None => BTreeMap::new(),
            Some((start, size)) => {
                let table = loaded(file, bytes, start, size).with_context(|| {
                    format!("DT_RELA {start:#x}+{size:#x} is not in a load segment's file bytes")
                })?;
                relocations(table, start..start + size, writable_ranges)?
            }
        };
        Ok(Self { relocations })
    }

    /// Only a relocated slot holds an address: startup stores its addend plus the load bias there.
    pub(super) fn pointer_at(&self, address: u64) -> Option<u64> {
        self.relocations.get(&address).copied()
    }

    /// The relocated slots, which may be in unselected writable sections such as `.data.rel.ro`
    pub(super) fn pointer_slots(&self) -> Vec<(u64, u64)> {
        self.relocations
            .iter()
            .map(|(&address, &target)| (address, target))
            .collect()
    }
}

/// The file bytes a load segment maps at the link-time addresses `address..address + size`
fn loaded<'data>(
    file: &File<'data>,
    bytes: &'data [u8],
    address: u64,
    size: u64,
) -> Option<&'data [u8]> {
    let endian = file.endian();
    file.elf_program_headers()
        .iter()
        .filter(|header| header.p_type(endian) == elf::PT_LOAD)
        .find_map(|header| {
            let offset = address.checked_sub(header.p_vaddr(endian))?;
            if offset.checked_add(size)? > header.p_filesz(endian) {
                return None;
            }
            let start = usize::try_from(header.p_offset(endian).checked_add(offset)?).ok()?;
            bytes.get(start..start.checked_add(usize::try_from(size).ok()?)?)
        })
}

/// The dynamic table startup reads, up to `DT_NULL`
struct Dynamic {
    entries: Vec<(u64, u64)>,
}

impl Dynamic {
    fn read(file: &File<'_>, bytes: &[u8]) -> Result<Self> {
        let (address, size) = dynamic_segment(file)?;
        let table = loaded(file, bytes, address, size)
            .context("PT_DYNAMIC is not in a load segment's file bytes")?;
        let mut entries = Vec::new();
        for entry in table.as_chunks::<16>().0 {
            let tag = u64::from_le_bytes(entry[..8].try_into().unwrap());
            if tag == u64::from(elf::DT_NULL) {
                return Ok(Self { entries });
            }
            entries.push((tag, u64::from_le_bytes(entry[8..].try_into().unwrap())));
        }
        bail!("PT_DYNAMIC has no DT_NULL")
    }

    /// The value of a tag. Startup keeps the last of repeated tags, which a check of the first
    /// would miss, so a repeated tag is rejected.
    fn value(&self, tag: u32) -> Result<Option<u64>> {
        let mut values = self
            .entries
            .iter()
            .filter(|&&(found, _)| found == u64::from(tag))
            .map(|&(_, value)| value);
        let value = values.next();
        ensure!(values.next().is_none(), "repeated dynamic tag {tag:#x}");
        Ok(value)
    }

    /// The address and size of the RELA table, if any, after rejecting every other kind of
    /// relocation startup could apply
    fn rela_table(&self) -> Result<Option<(u64, u64)>> {
        for &(tag, _) in &self.entries {
            ensure!(
                !matches!(
                    u32::try_from(tag),
                    Ok(elf::DT_REL
                        | elf::DT_RELSZ
                        | elf::DT_TEXTREL
                        | DT_RELR
                        | DT_RELRSZ
                        | DT_ANDROID_REL
                        | DT_ANDROID_RELSZ
                        | DT_ANDROID_RELA
                        | DT_ANDROID_RELASZ
                        | DT_ANDROID_RELR
                        | DT_ANDROID_RELRSZ)
                ),
                "unsupported dynamic tag {tag:#x}: only RELA relocations are supported"
            );
        }
        ensure!(
            self.value(elf::DT_FLAGS)?.unwrap_or(0) & u64::from(elf::DF_TEXTREL) == 0,
            "text relocations are not supported"
        );
        ensure!(
            self.value(elf::DT_JMPREL)?.is_none()
                || self.value(elf::DT_PLTRELSZ)?.unwrap_or(0) == 0,
            "PLT relocations are not supported"
        );
        let (start, size) = match (self.value(elf::DT_RELA)?, self.value(elf::DT_RELASZ)?) {
            (None, None) => return Ok(None),
            (Some(start), Some(size)) => (start, size),
            _ => bail!("DT_RELA and DT_RELASZ must appear together"),
        };
        ensure!(
            self.value(elf::DT_RELAENT)?.is_none_or(|entry| entry == 24) && size % 24 == 0,
            "DT_RELA entries must be 24 bytes"
        );
        // glibc applies the first DT_RELACOUNT relocations as relative ones, even past DT_RELASZ.
        ensure!(
            self.value(elf::DT_RELACOUNT)?
                .is_none_or(|count| count <= size / 24),
            "DT_RELACOUNT exceeds the DT_RELASZ table"
        );
        Ok(Some((start, size)))
    }
}

/// The address and size of the dynamic table. Startup finds it through `_DYNAMIC`, not
/// PT_DYNAMIC, so `_DYNAMIC` and any `.dynamic` section must be at PT_DYNAMIC; and musl's startup
/// computes its load bias from AT_PHDR, which Linux takes from the PT_LOAD that maps the program
/// headers, so one must.
fn dynamic_segment(file: &File<'_>) -> Result<(u64, u64)> {
    let endian = file.endian();
    let mut headers = file
        .elf_program_headers()
        .iter()
        .filter(|header| header.p_type(endian) == elf::PT_DYNAMIC);
    let header = headers
        .next()
        .context("a static PIE without PT_DYNAMIC is not supported")?;
    ensure!(headers.next().is_none(), "more than one PT_DYNAMIC");
    let address = header.p_vaddr(endian);
    for section in file.elf_section_table().iter() {
        ensure!(
            section.sh_type(endian) != elf::SHT_DYNAMIC || section.sh_addr(endian) == address,
            "an SHT_DYNAMIC section at {:#x} is not PT_DYNAMIC {address:#x}",
            section.sh_addr(endian)
        );
    }
    for symbol in file.symbols().filter(|s| s.name() == Ok("_DYNAMIC")) {
        ensure!(
            symbol.address() == address,
            "_DYNAMIC {:#x} is not PT_DYNAMIC {address:#x}",
            symbol.address()
        );
    }
    let elf_header = file.elf_header();
    let headers_start = elf_header.e_phoff(endian);
    let headers_end = headers_start.saturating_add(
        u64::from(elf_header.e_phnum(endian)) * u64::from(elf_header.e_phentsize(endian)),
    );
    ensure!(
        file.elf_program_headers().iter().any(|h| {
            h.p_type(endian) == elf::PT_LOAD
                && h.p_offset(endian) <= headers_start
                && headers_end <= h.p_offset(endian).saturating_add(h.p_filesz(endian))
        }),
        "no PT_LOAD maps the program headers"
    );
    Ok((address, header.p_filesz(endian)))
}

/// The slots and addends of a RELA table at `table_range`. A static PIE's self-relocation may
/// only write writable load segments, so the read-only image is the file's bytes at every load
/// bias.
fn relocations(
    table: &[u8],
    table_range: std::ops::Range<u64>,
    writable_ranges: &[(u64, u64)],
) -> Result<BTreeMap<u64, u64>> {
    let mut relocations = BTreeMap::new();
    for relocation in table.as_chunks::<24>().0 {
        let field = |index: usize| {
            u64::from_le_bytes(relocation[8 * index..8 * index + 8].try_into().unwrap())
        };
        let (target, info, addend) = (field(0), field(1), field(2));
        ensure!(
            info == u64::from(elf::R_X86_64_RELATIVE),
            "unsupported relocation at {target:#x}: only R_X86_64_RELATIVE is supported"
        );
        let target_end = target
            .checked_add(8)
            .context("relocation address overflow")?;
        ensure!(
            writable_ranges
                .iter()
                .any(|&(low, high)| low <= target && target_end <= high),
            "relocation at {target:#x} is outside writable load segments"
        );
        // Startup would then apply the rewritten entries, not these.
        ensure!(
            target_end <= table_range.start || target >= table_range.end,
            "relocation at {target:#x} overwrites the RELA table"
        );
        relocations.insert(target, addend);
    }
    // Each relocation stores 8 bytes, in order. Stores to one slot leave the last, as the map
    // does, but a store that overlaps another slot changes that slot's pointer.
    let targets: Vec<_> = relocations.keys().collect();
    if let Some(pair) = targets.windows(2).find(|pair| pair[1] - pair[0] < 8) {
        bail!("relocations at {:#x} and {:#x} overlap", pair[0], pair[1]);
    }
    Ok(relocations)
}
