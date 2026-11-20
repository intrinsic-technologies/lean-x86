import X86.Machine.Ram

namespace X86.UserProcess

open X86.Machine

abbrev CodeMap := List (BitVec 64 × UInt8)

def fetchByte : CodeMap → BitVec 64 → Option UInt8
  | [], _ => none
  | (stored, byte) :: rest, address =>
      if stored = address then some byte else fetchByte rest address

def fetchWindow (code : CodeMap) (rip : BitVec 64) : ByteArray :=
  let rec loop (remaining offset : Nat) (result : ByteArray) : ByteArray :=
    match remaining with
    | 0 => result
    | remaining + 1 =>
        match fetchByte code (rip + BitVec.ofNat 64 offset) with
        | none => result
        | some byte => loop remaining (offset + 1) (result.push byte)
  loop 15 0 ByteArray.empty

/-! Construct and install contiguous byte images. -/

/-- Map a byte list to consecutive 64-bit addresses. -/
def codeRange (base : BitVec 64) : List UInt8 → CodeMap
  | [] => []
  | byte :: bytes => (base, byte) :: codeRange (base + 1) bytes

/-- Map a byte array to consecutive 64-bit addresses. -/
def CodeMap.ofBytes (base : BitVec 64) (bytes : ByteArray) : CodeMap :=
  codeRange base bytes.data.toList

/-- Install an image in memory. Later entries overwrite earlier entries. -/
def CodeMap.install (memory : Ram) (code : CodeMap) : Ram :=
  code.foldl (fun memory (address, byte) => memory.insert address byte) memory

end X86.UserProcess
