import X86.UserProcess.CodeImage
import Prelude.Bytes.Chunked

/-!
A program's image as its sections, each a run of bytes at consecutive addresses.
`ImageSections.fetchByte` finds a byte by its offset in a section, so its kernel cost depends on
the number of sections, not on the number of bytes before the address. `ImageSections.toCodeMap`
is the same image as the `CodeMap` the user-process model installs, where `fetchByte` finds the
same bytes.
-/

namespace Prelude

open X86.UserProcess

/-- A section of a program's image: its bytes at consecutive addresses from `address` -/
structure ImageSection where
  address : BitVec 64
  bytes : Bytes.Chunked

/-- A program's image as sections, in order -/
abbrev ImageSections := List ImageSection

namespace ImageSection

/-- Each byte of the section at its address -/
def toCodeMap (s : ImageSection) : CodeMap :=
  codeRange s.address s.bytes.toList

/-- The byte at an address in the section -/
def fetchByte (s : ImageSection) (address : BitVec 64) : Option UInt8 :=
  s.bytes.get? (address - s.address).toNat

end ImageSection

namespace ImageSections

/-- The sections' bytes in order, each at its address -/
def toCodeMap (sections : ImageSections) : CodeMap :=
  sections.flatMap ImageSection.toCodeMap

/-- The byte at an address in the first section that holds it -/
def fetchByte : ImageSections → BitVec 64 → Option UInt8
  | [], _ => none
  | s :: rest, address => (s.fetchByte address).or (fetchByte rest address)

/-- The sections at run time, loaded at `bias`: each address plus the bias -/
def addBias (bias : BitVec 64) (sections : ImageSections) : ImageSections :=
  sections.map fun s => { s with address := bias + s.address }

end ImageSections

end Prelude
