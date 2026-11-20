/-!
ELF64 records and the constants of the System V ABI's generic part (the gABI), which every ELF
file shares. Processor-, OS- and vendor-specific definitions are in their own modules:
`Elf.X86_64`, `Elf.Gnu` and `Elf.Android`.

Every field is a natural number. A signed field, such as a relocation's `r_addend`
(`Elf64_Sxword`), holds the unsigned value of its 64 bits: an addend of -4 is 2^64 - 4.

Each constant has the value its source defines: Linux 7.0's `include/uapi/linux/elf.h` where
Linux defines it, otherwise glibc's `elf/elf.h`.
-/

namespace Elf

/-- `e_type` of a position-dependent executable.

Linux: `ET_EXEC` in `include/uapi/linux/elf.h`. -/
def ET_EXEC : Nat := 2
/-- `e_type` of a shared object or position-independent executable.

Linux: `ET_DYN` in `include/uapi/linux/elf.h`. -/
def ET_DYN : Nat := 3

/-- `ELFMAG`, the bytes `0x7f`, `'E'` (0x45), `'L'` (0x4c) and `'F'` (0x46), as the one number
they spell little-endian.

Linux: `ELFMAG0` to `ELFMAG3` and `ELFMAG` in `include/uapi/linux/elf.h`. -/
def ELFMAG : Nat := 0x464c457f
/-- `e_ident[EI_CLASS]` of a file of ELF64 records.

Linux: `ELFCLASS64` in `include/uapi/linux/elf.h`. -/
def ELFCLASS64 : Nat := 2
/-- `e_ident[EI_DATA]` of a little-endian file.

Linux: `ELFDATA2LSB` in `include/uapi/linux/elf.h`. -/
def ELFDATA2LSB : Nat := 1

/-- `e_phnum` when the count is in section 0's `sh_info`, for files with 0xffff or more program
headers.

Linux: `PN_XNUM` in `include/uapi/linux/elf.h`. -/
def PN_XNUM : Nat := 0xffff

/-- `p_type` of a loadable segment.

Linux: `PT_LOAD` in `include/uapi/linux/elf.h`. -/
def PT_LOAD : Nat := 1
/-- `p_type` of the dynamic table (`_DYNAMIC`).

Linux: `PT_DYNAMIC` in `include/uapi/linux/elf.h`. -/
def PT_DYNAMIC : Nat := 2
/-- `p_type` of the path of the program interpreter.

Linux: `PT_INTERP` in `include/uapi/linux/elf.h`. -/
def PT_INTERP : Nat := 3
/-- `p_type` of the thread-local storage template.

Linux: `PT_TLS` in `include/uapi/linux/elf.h`. -/
def PT_TLS : Nat := 7

/-- `p_flags` bit: the segment is executable.

Linux: `PF_X` in `include/uapi/linux/elf.h`. -/
def PF_X : Nat := 1
/-- `p_flags` bit: the segment is writable.

Linux: `PF_W` in `include/uapi/linux/elf.h`. -/
def PF_W : Nat := 2
/-- `p_flags` bit: the segment is readable.

Linux: `PF_R` in `include/uapi/linux/elf.h`. -/
def PF_R : Nat := 4

/-- `sh_type` of a symbol table (`.symtab`).

Linux: `SHT_SYMTAB` in `include/uapi/linux/elf.h`. -/
def SHT_SYMTAB : Nat := 2
/-- `sh_type` of a string table.

Linux: `SHT_STRTAB` in `include/uapi/linux/elf.h`. -/
def SHT_STRTAB : Nat := 3
/-- `sh_type` of a relocation table with addends.

Linux: `SHT_RELA` in `include/uapi/linux/elf.h`. -/
def SHT_RELA : Nat := 4
/-- `sh_type` of a section that occupies no file bytes, such as `.bss`.

Linux: `SHT_NOBITS` in `include/uapi/linux/elf.h`. -/
def SHT_NOBITS : Nat := 8

/-- `sh_flags` bit: section contents begin with a compression header, followed by encoded data.

System V gABI: `SHF_COMPRESSED` in Section 3.7, Compressed Sections. -/
def SHF_COMPRESSED : Nat := 0x800

/-- The undefined section index: `e_shstrndx` of a file without section names.

Linux: `SHN_UNDEF` in `include/uapi/linux/elf.h`. -/
def SHN_UNDEF : Nat := 0
/-- `e_shstrndx` when the index is in section 0's `sh_link`. Linux's `elf.h` does not define it.

glibc: `SHN_XINDEX` in `elf/elf.h`. -/
def SHN_XINDEX : Nat := 0xffff

/-- `ELF64_ST_TYPE` of a data object, such as a variable.

Linux: `STT_OBJECT` in `include/uapi/linux/elf.h`. -/
def STT_OBJECT : Nat := 1
/-- `ELF64_ST_TYPE` of a function.

Linux: `STT_FUNC` in `include/uapi/linux/elf.h`. -/
def STT_FUNC : Nat := 2

/-- The undefined symbol index: `ELF64_R_SYM` of a relocation without a symbol.

Linux: `STN_UNDEF` in `include/uapi/linux/elf.h`. -/
def STN_UNDEF : Nat := 0

/-- `d_tag` of the entry that ends the dynamic table.

Linux: `DT_NULL` in `include/uapi/linux/elf.h`. -/
def DT_NULL : Nat := 0
/-- `d_tag` of the size in bytes of the PLT relocations (`DT_JMPREL`).

Linux: `DT_PLTRELSZ` in `include/uapi/linux/elf.h`. -/
def DT_PLTRELSZ : Nat := 2
/-- `d_tag` of the address of the relocation table with addends.

Linux: `DT_RELA` in `include/uapi/linux/elf.h`. -/
def DT_RELA : Nat := 7
/-- `d_tag` of the size in bytes of the `DT_RELA` table.

Linux: `DT_RELASZ` in `include/uapi/linux/elf.h`. -/
def DT_RELASZ : Nat := 8
/-- `d_tag` of the size of one `DT_RELA` entry.

Linux: `DT_RELAENT` in `include/uapi/linux/elf.h`. -/
def DT_RELAENT : Nat := 9
/-- `d_tag` of the address of the relocation table without addends.

Linux: `DT_REL` in `include/uapi/linux/elf.h`. -/
def DT_REL : Nat := 17
/-- `d_tag` of the size in bytes of the `DT_REL` table.

Linux: `DT_RELSZ` in `include/uapi/linux/elf.h`. -/
def DT_RELSZ : Nat := 18
/-- `d_tag` present when relocations may write to read-only segments.

Linux: `DT_TEXTREL` in `include/uapi/linux/elf.h`. -/
def DT_TEXTREL : Nat := 22
/-- `d_tag` of the address of the PLT relocations.

Linux: `DT_JMPREL` in `include/uapi/linux/elf.h`. -/
def DT_JMPREL : Nat := 23
/-- `d_tag` of the object's flags, such as `DF_TEXTREL`. Linux's `elf.h` does not define it.

glibc: `DT_FLAGS` in `elf/elf.h`. -/
def DT_FLAGS : Nat := 30
/-- `d_tag` of the size in bytes of the `DT_RELR` table. Linux's `elf.h` does not define it.

glibc: `DT_RELRSZ` in `elf/elf.h`. -/
def DT_RELRSZ : Nat := 35
/-- `d_tag` of the address of the packed relative relocations (`SHT_RELR`). Linux's `elf.h`
does not define it.

glibc: `DT_RELR` in `elf/elf.h`. -/
def DT_RELR : Nat := 36
/-- `DT_FLAGS` bit for text relocations, the flag form of `DT_TEXTREL`.

glibc: `DF_TEXTREL` in `elf/elf.h`. -/
def DF_TEXTREL : Nat := 4

/-- The file header fields the reader returns -/
structure FileHeader where
  type : Nat
  machine : Nat
  entry : Nat
  phoff : Nat
  phnum : Nat
  shoff : Nat
  shentsize : Nat
  shnum : Nat
  shstrndx : Nat
  deriving DecidableEq, Repr

structure ProgramHeader where
  type : Nat
  flags : Nat
  offset : Nat
  vaddr : Nat
  paddr : Nat
  filesz : Nat
  memsz : Nat
  align : Nat
  deriving DecidableEq, Repr

structure SectionHeader where
  /-- The offset of the name in the section-name string table -/
  name : Nat
  type : Nat
  flags : Nat
  addr : Nat
  offset : Nat
  size : Nat
  link : Nat
  info : Nat
  addralign : Nat
  entsize : Nat
  deriving DecidableEq, Repr

structure Symbol where
  /-- The index in the symbol table -/
  index : Nat
  /-- The offset of the name in the symbol table's string table -/
  name : Nat
  /-- `ELF64_ST_TYPE` of `st_info` -/
  type : Nat
  /-- `ELF64_ST_BIND` of `st_info` -/
  binding : Nat
  other : Nat
  shndx : Nat
  value : Nat
  size : Nat
  deriving DecidableEq, Repr

/-- A relocation with addend -/
structure Rela where
  offset : Nat
  /-- `ELF64_R_TYPE` of `r_info` -/
  type : Nat
  /-- `ELF64_R_SYM` of `r_info` -/
  symbolIndex : Nat
  /-- `r_addend` as its 64-bit two's-complement pattern -/
  addend : Nat
  deriving DecidableEq, Repr

/-- What the reader cannot read: a file outside the one layout it reads, a table outside the file,
or a name or entry a query looks for and does not find -/
inductive Error where
  /-- The file is shorter than the ELF64 file header. -/
  | truncatedFileHeader
  /-- The file does not start with the ELF magic number. -/
  | notElf
  /-- The file is not ELFCLASS64 and ELFDATA2LSB, the only layout the reader reads. -/
  | notElf64LittleEndian
  /-- `e_phentsize` of a non-empty program header table is not the ELF64 program header size. -/
  | invalidProgramHeaderEntrySize (size : Nat)
  /-- The program header table is not inside the file. -/
  | programHeadersOutsideFile
  /-- `e_shentsize` of a non-empty section header table is not the ELF64 section header size. -/
  | invalidSectionHeaderEntrySize (size : Nat)
  /-- `e_phnum`, `e_shnum` or `e_shstrndx` is in section 0, which the reader does not read. -/
  | extendedNumbering
  /-- The section header table is not inside the file. -/
  | sectionHeadersOutsideFile
  /-- A section that has no bytes in the file (`SHT_NOBITS`), or whose bytes extend past its end -/
  | sectionOutsideFile (section_ : SectionHeader)
  /-- The file has no section header string table. -/
  | missingSectionNames
  /-- A string table, symbol table or relocation table that is not an uncompressed table of
  the expected layout inside the file -/
  | invalidTable (table : SectionHeader)
  /-- A string with no terminating zero byte inside its table -/
  | unterminatedName (offset : Nat)
  /-- No section has this name. -/
  | missingSection (name : List UInt8)
  /-- More than one section has this name. -/
  | duplicateSection (name : List UInt8)
  /-- The file has no `SHT_SYMTAB` section. -/
  | missingSymbolTable
  /-- The file has more than one `SHT_SYMTAB` section. -/
  | duplicateSymbolTable
  /-- No symbol has this name. -/
  | missingSymbol (name : List UInt8)
  /-- More than one symbol has this name. -/
  | duplicateSymbol (name : List UInt8)
  /-- The relocation with this index is not `R_X86_64_RELATIVE` without a symbol, the only kind
  `relativeRelocations` reads. -/
  | nonRelativeRelocation (index : Nat)
  /-- More than one `PT_DYNAMIC`; a `PT_DYNAMIC` whose bytes are outside the file or have no
  `DT_NULL`; or a `DT_RELA` table the reader cannot locate in the file: `DT_RELA`, `DT_RELASZ`
  or `DT_RELAENT` missing or repeated, `DT_RELAENT` other than the ELF64 size, or the table
  outside one `PT_LOAD` segment's file bytes -/
  | invalidDynamic
  deriving DecidableEq, Repr

/-- Decide equality of query results, so that `decide +kernel` checks a query's value or error -/
instance {α : Type} [DecidableEq α] : DecidableEq (Except Error α) := fun
  | .ok a, .ok b => if h : a = b then isTrue (h ▸ rfl) else isFalse (by intro e; cases e; exact h rfl)
  | .error a, .error b =>
      if h : a = b then isTrue (h ▸ rfl) else isFalse (by intro e; cases e; exact h rfl)
  | .ok _, .error _ => isFalse nofun
  | .error _, .ok _ => isFalse nofun

end Elf
