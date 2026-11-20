import Elf.Read

/-!
Sections as slices of the file: where a section's bytes are in the file, and the byte at a
link-time address in a list of such slices.
-/

namespace Elf

variable {α : Type} [ByteSource α]

/-- A section's bytes as a slice of the file: `size` bytes from file offset `offset`, at
link-time address `address` -/
structure FileSlice where
  address : Nat
  offset : Nat
  size : Nat
  deriving DecidableEq, Repr

/-- Slices of a file, in order -/
abbrev FileSlices := List FileSlice

/-- The bytes of the unique section with a name in section headers already read, as a slice of
the file -/
def Sections.slice (file : α) (view : Sections) (name : List UInt8) :
    Except Error FileSlice := do
  let section_ ← view.named file name
  unless section_.type != SHT_NOBITS && inFile file section_.offset section_.size do
    throw (.sectionOutsideFile section_)
  return ⟨section_.addr, section_.offset, section_.size⟩

/-- The bytes of the unique section with a name, as a slice of the file, reading the section
headers first -/
def sectionSlice (file : α) (name : List UInt8) : Except Error FileSlice := do
  (← sections file).slice file name

/-- The byte at a link-time address in the first slice that holds it, as
`Prelude.ImageSections.fetchByte` finds it in sections -/
def FileSlices.fetchByte? (file : α) : FileSlices → Nat → Option UInt8
  | [], _ => none
  | slice :: rest, address =>
      if slice.address ≤ address && address < slice.address + slice.size then
        byte? file (slice.offset + (address - slice.address))
      else FileSlices.fetchByte? file rest address

end Elf
