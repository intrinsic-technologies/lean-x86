/-!
The bytes an ELF reader reads: a file's size and its fixed-width little-endian fields. The
reader checks that a field is inside the file before it reads it.
-/

namespace Elf

/-- A file's bytes. Compiled readers take the instance as an argument rather than a copy of the
reader specialized to each instance and file. -/
@[nospecialize] class ByteSource (α : Type) where
  size : α → Nat
  /-- The little-endian value of `width` bytes from `offset`; meaningful below `size` -/
  readLE : α → Nat → Nat → Nat

/-- The little-endian value of `width` bytes from `offset` -/
def readByteArrayLE (bytes : ByteArray) : Nat → Nat → Nat
  | _, 0 => 0
  | offset, width + 1 => (bytes.get! offset).toNat + 256 * readByteArrayLE bytes (offset + 1) width

instance : ByteSource ByteArray where
  size := ByteArray.size
  readLE bytes offset width := readByteArrayLE bytes offset width

variable {α : Type} [ByteSource α]

/-- Whether `width` bytes from `offset` are inside the file -/
def inFile (file : α) (offset width : Nat) : Bool :=
  offset + width ≤ ByteSource.size file

/-- The little-endian value of `width` bytes from `offset`, if they are inside the file -/
def read? (file : α) (offset width : Nat) : Option Nat :=
  if inFile file offset width then some (ByteSource.readLE file offset width) else none

/-- The byte at an offset, if it is inside the file -/
def byte? (file : α) (offset : Nat) : Option UInt8 :=
  (read? file offset 1).map UInt8.ofNat

/--
Whether the bytes from `offset` are `name` followed by a zero byte, all before `limit`. A
string-table lookup compares bytes and never decodes a string; a mismatch stops at its first
byte.
-/
def namedAt (file : α) (limit : Nat) : Nat → List UInt8 → Bool
  | offset, [] => offset < limit && read? file offset 1 == some 0
  | offset, byte :: rest =>
      byte != 0 && offset < limit && read? file offset 1 == some byte.toNat &&
        namedAt file limit (offset + 1) rest

/-- The bytes from `offset` before a zero byte, if the zero byte is within `count` bytes and
before `limit` -/
def cString? (file : α) (limit : Nat) : Nat → Nat → Option (List UInt8)
  | 0, _ => none
  | count + 1, offset =>
      if offset < limit then
        match read? file offset 1 with
        | some 0 => some []
        | some byte => (cString? file limit count (offset + 1)).map (UInt8.ofNat byte :: ·)
        | none => none
      else none

end Elf
