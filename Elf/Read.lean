import Elf.Basic
import Elf.Bytes
import Elf.Layout
import Elf.X86_64
import Elf.Android

/-!
Read an ELF64 file as the format lays it out: the header, the program headers, the section
headers and names, symbols, dynamic entries and relocations. Every query returns what the file
declares or an `Error`; the reader never substitutes a default for a field it cannot read.
Section-content queries require uncompressed tables: `SHF_COMPRESSED` contents need a
decompressor, so these queries return `invalidTable`. Section headers still read as declared.

The reader decides nothing about running the file, such as what Linux accepts and maps: callers
check the type, machine and segments they require.

Each table is read by structural recursion over its entry count, and each field is one
fixed-width read, so `decide +kernel` evaluates a query in time linear in the entries it
visits.
-/

namespace Elf

variable {α : Type} [ByteSource α]

/-- A field of the record at `base`, little-endian; the caller checks bounds -/
abbrev readField (file : α) (base : Nat) (field : Field) : Nat :=
  ByteSource.readLE file (base + field.offset) field.width

/--
The file header. The reader reads one layout, and these are its only requirements: at least the
64 bytes of an ELF64 header, the ELF magic number, ELFCLASS64 and ELFDATA2LSB, the ELF64 program
header size if there are program headers, and the program header table inside the file. It
returns `e_type` and `e_machine` without checking them. It does not check the section header
fields, which `sections` reads.
-/
def fileHeader (file : α) : Except Error FileHeader := do
  unless fileHeaderSize ≤ ByteSource.size file do throw .truncatedFileHeader
  unless readField file 0 EI_MAG == ELFMAG do throw .notElf
  unless readField file 0 EI_CLASS == ELFCLASS64 && readField file 0 EI_DATA == ELFDATA2LSB do
    throw .notElf64LittleEndian
  let count := readField file 0 e_phnum
  if count == PN_XNUM then throw .extendedNumbering
  let entrySize := readField file 0 e_phentsize
  unless count == 0 || entrySize == programHeaderSize do
    throw (.invalidProgramHeaderEntrySize entrySize)
  let offset := readField file 0 e_phoff
  unless inFile file offset (count * programHeaderSize) do throw .programHeadersOutsideFile
  return {
    type := readField file 0 e_type
    machine := readField file 0 e_machine
    entry := readField file 0 e_entry
    phoff := offset
    phnum := count
    shoff := readField file 0 e_shoff
    shentsize := readField file 0 e_shentsize
    shnum := readField file 0 e_shnum
    shstrndx := readField file 0 e_shstrndx }

/-- The program header at an offset; the caller checks it is inside the file -/
def programHeaderAt (file : α) (offset : Nat) : ProgramHeader where
  type := readField file offset p_type
  flags := readField file offset p_flags
  offset := readField file offset p_offset
  vaddr := readField file offset p_vaddr
  paddr := readField file offset p_paddr
  filesz := readField file offset p_filesz
  memsz := readField file offset p_memsz
  align := readField file offset p_align

/-- `count` program headers from an offset -/
def programHeadersFrom (file : α) : Nat → Nat → List ProgramHeader
  | 0, _ => []
  | count + 1, offset =>
      programHeaderAt file offset :: programHeadersFrom file count (offset + programHeaderSize)

/-- The program headers that a file header from `fileHeader` lists -/
def programHeadersOf (file : α) (header : FileHeader) : List ProgramHeader :=
  programHeadersFrom file header.phnum header.phoff

/-- The gABI's execution view: the file header and the program header table, as the file
declares them -/
structure Segments where
  fileHeader : FileHeader
  headers : List ProgramHeader
  deriving DecidableEq, Repr

/-- The `PT_LOAD` segments, in program header order -/
def Segments.loads (view : Segments) : List ProgramHeader :=
  view.headers.filter (·.type == PT_LOAD)

/-- The file header and program header table of a file -/
def segments (file : α) : Except Error Segments := do
  let header ← fileHeader file
  return ⟨header, programHeadersOf file header⟩

/-- The section header at an offset; the caller checks it is inside the file -/
def sectionHeaderAt (file : α) (offset : Nat) : SectionHeader where
  name := readField file offset sh_name
  type := readField file offset sh_type
  flags := readField file offset sh_flags
  addr := readField file offset sh_addr
  offset := readField file offset sh_offset
  size := readField file offset sh_size
  link := readField file offset sh_link
  info := readField file offset sh_info
  addralign := readField file offset sh_addralign
  entsize := readField file offset sh_entsize

/-- `count` section headers from an offset -/
def sectionHeadersFrom (file : α) : Nat → Nat → List SectionHeader
  | 0, _ => []
  | count + 1, offset =>
      sectionHeaderAt file offset :: sectionHeadersFrom file count (offset + sectionHeaderSize)

/-- Whether section contents use a compression header and encoded bytes -/
def SectionHeader.isCompressed (section_ : SectionHeader) : Bool :=
  section_.flags &&& SHF_COMPRESSED != 0

/-- Whether a section is an uncompressed string table inside the file -/
def isStringTable (file : α) (table : SectionHeader) : Bool :=
  table.type == SHT_STRTAB && !table.isCompressed && inFile file table.offset table.size

/-- The gABI's linking view: the section headers and the section-name string table -/
structure Sections where
  headers : List SectionHeader
  /-- The section header string table (`.shstrtab`, at `e_shstrndx`) -/
  shstrtab : SectionHeader
  deriving DecidableEq, Repr

/-- The section headers of a file with this header; empty without a section header table -/
def sectionHeadersOf (file : α) (header : FileHeader) : Except Error (List SectionHeader) := do
  if header.shnum == 0 then
    -- No section header table, or `e_shnum` in section 0
    if header.shoff == 0 then return []
    else throw .extendedNumbering
  unless header.shentsize == sectionHeaderSize do
    throw (.invalidSectionHeaderEntrySize header.shentsize)
  -- Section headers at offset 0 would overlap the file header.
  if header.shoff == 0 then throw .sectionHeadersOutsideFile
  unless inFile file header.shoff (header.shnum * sectionHeaderSize) do
    throw .sectionHeadersOutsideFile
  return sectionHeadersFrom file header.shnum header.shoff

/-- The section headers, without their names -/
def sectionHeaders (file : α) : Except Error (List SectionHeader) := do
  sectionHeadersOf file (← fileHeader file)

/-- The section headers and section names -/
def sections (file : α) : Except Error Sections := do
  let header ← fileHeader file
  let headers ← sectionHeadersOf file header
  if header.shstrndx == SHN_UNDEF then throw .missingSectionNames
  if header.shstrndx == SHN_XINDEX then throw .extendedNumbering
  let some shstrtab := headers[header.shstrndx]? | throw .missingSectionNames
  unless isStringTable file shstrtab do throw (.invalidTable shstrtab)
  return ⟨headers, shstrtab⟩

/-- Whether the string at `offset` in an uncompressed string table inside the file is `name`.
In an empty table, offset 0 is the empty name, as the gABI allows. Invalid tables do not match. -/
def tableNamed (file : α) (table : SectionHeader) (offset : Nat) (name : List UInt8) : Bool :=
  isStringTable file table &&
    if table.size == 0 then offset == 0 && name.isEmpty
    else namedAt file (table.offset + table.size) (table.offset + offset) name

/-- The string at `offset` in an uncompressed string table inside the file. In an empty table,
offset 0 is the empty name, as the gABI allows. Invalid tables return `invalidTable`. -/
def tableString (file : α) (table : SectionHeader) (offset : Nat) : Except Error (List UInt8) := do
  unless isStringTable file table do throw (.invalidTable table)
  if table.size == 0 && offset == 0 then pure []
  else match cString? file (table.offset + table.size) table.size (table.offset + offset) with
    | some bytes => pure bytes
    | none => throw (.unterminatedName (table.offset + offset))

/-- A section's name -/
def Sections.name (file : α) (view : Sections) (section_ : SectionHeader) :
    Except Error (List UInt8) :=
  tableString file view.shstrtab section_.name

/-- The unique section with a name -/
def Sections.named (file : α) (view : Sections) (name : List UInt8) : Except Error SectionHeader := do
  unless isStringTable file view.shstrtab do throw (.invalidTable view.shstrtab)
  match view.headers.filter (tableNamed file view.shstrtab ·.name name) with
  | [section_] => pure section_
  | [] => throw (.missingSection name)
  | _ => throw (.duplicateSection name)

/-- The unique section with a name -/
def sectionNamed (file : α) (name : List UInt8) : Except Error SectionHeader := do
  (← sections file).named file name

/-- The symbol table and its string table -/
structure SymbolTable where
  /-- The `SHT_SYMTAB` section -/
  symtab : SectionHeader
  /-- The string table it links -/
  strtab : SectionHeader
  deriving DecidableEq, Repr

/-- The unique `SHT_SYMTAB` section and the string table it links -/
def symbolTable (file : α) : Except Error SymbolTable := do
  let headers ← sectionHeaders file
  match headers.filter (·.type == SHT_SYMTAB) with
  | [] => throw .missingSymbolTable
  | [symtab] =>
      unless !symtab.isCompressed && symtab.entsize == symbolSize && symtab.size % symbolSize == 0 &&
          inFile file symtab.offset symtab.size do
        throw (.invalidTable symtab)
      let some strtab := headers[symtab.link]? | throw (.invalidTable symtab)
      unless isStringTable file strtab do throw (.invalidTable strtab)
      return ⟨symtab, strtab⟩
  | _ => throw .duplicateSymbolTable

/-- The symbol with an index at an offset; the caller checks it is inside the file -/
def symbolAt (file : α) (index offset : Nat) : Symbol :=
  let info := readField file offset st_info
  { index
    name := readField file offset st_name
    type := ELF64_ST_TYPE info
    binding := ELF64_ST_BIND info
    other := readField file offset st_other
    shndx := readField file offset st_shndx
    value := readField file offset st_value
    size := readField file offset st_size }

/-- `count` symbols from an index at an offset; the caller checks the uncompressed layout
and file bounds, as `symbolTable` does -/
def symbolsFrom (file : α) : Nat → Nat → Nat → List Symbol
  | 0, _, _ => []
  | count + 1, index, offset =>
      symbolAt file index offset :: symbolsFrom file count (index + 1) (offset + symbolSize)

/-- Every symbol in the symbol table, including the null symbol at index 0 -/
def symbols (file : α) : Except Error (List Symbol) := do
  let table ← symbolTable file
  return symbolsFrom file (table.symtab.size / symbolSize) 0 table.symtab.offset

/-- A symbol's name -/
def SymbolTable.name (file : α) (table : SymbolTable) (symbol : Symbol) : Except Error (List UInt8) :=
  tableString file table.strtab symbol.name

/-- Of `count` symbols from an index at an offset, those with a name. The caller checks the
uncompressed tables and file bounds, as `symbolTable` does. A symbol with another name costs
one name-offset read and a comparison that stops at the first differing byte. -/
def symbolsNamedFrom (file : α) (table : SymbolTable) (name : List UInt8) :
    Nat → Nat → Nat → List Symbol
  | 0, _, _ => []
  | count + 1, index, offset =>
      let rest := symbolsNamedFrom file table name count (index + 1) (offset + symbolSize)
      if tableNamed file table.strtab (readField file offset st_name) name then
        symbolAt file index offset :: rest
      else rest

/-- The symbols with a name -/
def symbolsNamed (file : α) (name : List UInt8) : Except Error (List Symbol) := do
  let table ← symbolTable file
  return symbolsNamedFrom file table name (table.symtab.size / symbolSize) 0 table.symtab.offset

/-- The unique symbol with a name -/
def symbolNamed (file : α) (name : List UInt8) : Except Error Symbol := do
  match ← symbolsNamed file name with
  | [symbol] => pure symbol
  | [] => throw (.missingSymbol name)
  | _ => throw (.duplicateSymbol name)

/-- The relocation at an offset; the caller checks it is inside the file -/
def relaAt (file : α) (offset : Nat) : Rela :=
  let info := readField file offset r_info
  { offset := readField file offset r_offset
    type := ELF64_R_TYPE info
    symbolIndex := ELF64_R_SYM info
    addend := readField file offset r_addend }

/-- `count` relocations from an offset; the caller checks the uncompressed ELF64 RELA layout
and file bounds -/
def relasFrom (file : α) : Nat → Nat → List Rela
  | 0, _ => []
  | count + 1, offset => relaAt file offset :: relasFrom file count (offset + relaSize)

/-- The entries of a relocation section with addends -/
def sectionRelocations (file : α) (table : SectionHeader) : Except Error (List Rela) := do
  unless table.type == SHT_RELA && !table.isCompressed && table.entsize == relaSize &&
      table.size % relaSize == 0 && inFile file table.offset table.size do
    throw (.invalidTable table)
  return relasFrom file (table.size / relaSize) table.offset

/-- `.rela.dyn` -/
def relaDynName : List UInt8 := ['.', 'r', 'e', 'l', 'a', '.', 'd', 'y', 'n'].map Char.toUInt8

/-- The entries of the section `.rela.dyn`. `dynamicRelocations` reads the table that
`PT_DYNAMIC` lists. -/
def relaDyn (file : α) : Except Error (List Rela) := do
  sectionRelocations file (← sectionNamed file relaDynName)

/-- At most `count` dynamic entries from an offset, through `DT_NULL` -/
def dynamicEntriesFrom (file : α) : Nat → Nat → Option (List (Nat × Nat))
  | 0, _ => none
  | count + 1, offset =>
      let tag := readField file offset d_tag
      let entry := (tag, readField file offset d_val)
      if tag == DT_NULL then some [entry]
      else (entry :: ·) <$> dynamicEntriesFrom file count (offset + dynamicEntrySize)

/-- The file offset of `size` bytes at a link-time address, if one `PT_LOAD` segment's file
bytes hold them -/
def Segments.fileOffset? (view : Segments) (address size : Nat) : Option Nat :=
  (view.loads.find? fun segment =>
      segment.vaddr ≤ address && address + size ≤ segment.vaddr + segment.filesz).map
    fun segment => segment.offset + (address - segment.vaddr)

/-- The `(d_tag, d_val)` entries of `PT_DYNAMIC`, read at its file offset through `DT_NULL`; empty
without `PT_DYNAMIC` -/
def dynamicEntries (file : α) (view : Segments) : Except Error (List (Nat × Nat)) :=
  match view.headers.filter (·.type == PT_DYNAMIC) with
  | [] => pure []
  | [segment] =>
      if inFile file segment.offset segment.filesz then
        match dynamicEntriesFrom file (segment.filesz / dynamicEntrySize) segment.offset with
        | some entries => pure entries
        | none => throw .invalidDynamic
      else throw .invalidDynamic
  | _ => throw .invalidDynamic

/-- The values of the dynamic entries with a tag, in table order -/
def dynamicValues (entries : List (Nat × Nat)) (tag : Nat) : List Nat :=
  (entries.filter (·.1 == tag)).map (·.2)

/-- The dynamic tags that locate a relocation table: the gABI's `DT_RELA`, `DT_REL` and `DT_RELR`,
the PLT's `DT_JMPREL`, and Android's packed tables -/
def relocationTableTags : List Nat :=
  [DT_RELA, DT_REL, DT_RELR, DT_JMPREL] ++ androidRelocationTableTags

/-- The tags among `relocationTableTags` that `PT_DYNAMIC` lists, in table order. A statement
that requires only a `DT_RELA` table checks this is `[DT_RELA]` or `[]`. -/
def dynamicRelocationTags (file : α) : Except Error (List Nat) := do
  let entries ← dynamicEntries file (← segments file)
  return (entries.map (·.1)).filter relocationTableTags.contains

/--
The `DT_RELA` table that `PT_DYNAMIC` lists, at the file offset of the `PT_LOAD` segment bytes
that hold its address; empty without `DT_RELA` and `DT_RELASZ`. A declared table must have
exactly one `DT_RELAENT`, specifying the ELF64 entry size. It reads only that table:
`dynamicRelocationTags` says which other relocation tables the file lists.
-/
def dynamicRelocations (file : α) : Except Error (List Rela) := do
  let view ← segments file
  let entries ← dynamicEntries file view
  match dynamicValues entries DT_RELA, dynamicValues entries DT_RELASZ with
  | [], [] => return []
  | [address], [size] =>
      unless dynamicValues entries DT_RELAENT == [relaSize] && size % relaSize == 0 do
        throw .invalidDynamic
      -- An empty table has no bytes to locate; GNU ld may give it any address, such as 0.
      if size == 0 then return []
      let some offset := view.fileOffset? address size | throw .invalidDynamic
      unless inFile file offset size do throw .invalidDynamic
      return relasFrom file (size / relaSize) offset
  | _, _ => throw .invalidDynamic

/-- The offset and addend of each relocation in `dynamicRelocations`, if each is
`R_X86_64_RELATIVE` without a symbol, or the index of the first that is not -/
def relativeRelocations (file : α) : Except Error (List (Nat × Nat)) := do
  relative 0 (← dynamicRelocations file)
where
  /-- The offset and addend of each relocation, numbering them from `index` -/
  relative : Nat → List Rela → Except Error (List (Nat × Nat))
    | _, [] => pure []
    | index, rela :: rest =>
        if rela.type == R_X86_64_RELATIVE && rela.symbolIndex == STN_UNDEF then
          ((rela.offset, rela.addend) :: ·) <$> relative (index + 1) rest
        else throw (.nonRelativeRelocation index)

end Elf
