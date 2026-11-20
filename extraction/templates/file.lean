{generated_header}

import {ns}.Sections
import Prelude.Bytes.Utf8
import Elf

/-!
Views of the embedded ELF file, computed from `fileBytes` by the `Elf` library, so they agree
with the file by construction. Each is an `Except _root_.Elf.Error`: the value, or what the
reader cannot read. They describe the file, not what Linux maps; addresses are link-time. `_root_.Elf` names the library even inside a namespace that ends in `Elf`.
-/

namespace {ns}

/-- The ELF header and program headers: the file's segments -/
def segments : Except _root_.Elf.Error _root_.Elf.Segments :=
  _root_.Elf.segments fileBytes

{relocations}/-- The section headers and section names -/
def sections : Except _root_.Elf.Error _root_.Elf.Sections :=
  _root_.Elf.sections fileBytes

{program_section_name_parts}/-- The selected sections as slices of the file, code sections first -/
def programFileSlices : Except _root_.Elf.Error _root_.Elf.FileSlices := do
  let view ← sections
  ({program_section_names}).mapM (view.slice fileBytes)

/-- The byte at a link-time address in the selected sections, found through the file's section
headers. It agrees with `programSections.fetchByte`, which reads the sections' own bytes, at
`address.toNat`. -/
def programFileFetchByte (address : Nat) : Except _root_.Elf.Error (Option UInt8) := do
  return (← programFileSlices).fetchByte? fileBytes address

/-- The symbol table -/
def symbols : Except _root_.Elf.Error (List _root_.Elf.Symbol) :=
  _root_.Elf.symbols fileBytes

/-- The unique symbol with a name, written `utf8_bytes "name"` -/
def symbolNamed (name : List UInt8) : Except _root_.Elf.Error _root_.Elf.Symbol :=
  _root_.Elf.symbolNamed fileBytes name

{entry_symbols}end {ns}
