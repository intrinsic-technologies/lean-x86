import Std.Data.ExtHashMap.Lemmas

namespace X86.Machine

/--
Physical RAM, as a map from physical address to byte. An address that is not in the map is not
backed by RAM.
-/
abbrev Ram := Std.ExtHashMap (BitVec 64) UInt8

/--
The interface between the processor and memory. Intel's code reaches memory only through its
`Physical_Mem_*` hooks, and `Bindings/PhysicalAccess.lean` implements those hooks with this class alone.

An access reaches this class at the end of address translation. Segmentation turns a logical
address into a linear address, and paging turns the linear address into a physical address.
Every address here is physical. At a physical address, the processor needs one of two things:

- a byte of RAM, for data and instruction fetch (`read` and `write`);
- a page-table entry, for the page walk (`entry` and `markEntry`).

Instances differ in where the page-table entries come from:

- `Ram` keeps the page tables as bytes in RAM. The walk reads them like data.
- Another instance can calculate the entries, for example from a model of an operating system's
  mappings. The tables are then not in RAM.

`write` and `markEntry` cannot fail. The hooks call them only after `read` or `entry` gives a
value. If they could fail, the old state would stay live during the change, and the change
would copy all of RAM.
-/
class PhysicalMemory (σ : Type) where
  /-- The byte at physical address `address`, or `none` if `address` is not backed by RAM. -/
  read : σ → BitVec 64 → Option UInt8
  /-- Writes a byte at a physical address where `read` gives a value. -/
  write : σ → BitVec 64 → UInt8 → σ
  /-- The page-table entry that the memory calculates at physical address `address`, if any. -/
  entry : σ → BitVec 64 → Option (BitVec 64) := fun _ _ => none
  /--
  Sets the accessed and dirty bits of `lowByte` in the calculated entry at physical address
  `address`. The page walk does this when it writes the low byte of the entry.
  -/
  markEntry : σ → BitVec 64 → UInt8 → σ := fun memory _ _ => memory

instance : PhysicalMemory Ram where
  read memory address := memory[address]?
  write memory address byte := memory.insert address byte

inductive Fault where
  | unmappedMemory (address : BitVec 64)
  deriving Repr, DecidableEq

def Ram.empty : Ram := {}

def fromNat (value : Nat) : BitVec 64 := BitVec.ofNat 64 value

def addAddress (address : BitVec 64) (offset : Nat) : BitVec 64 :=
  address + fromNat offset

/-- Little-endian memory access fails at the first unmapped byte. -/
def loadBytes (memory : Ram) (address : BitVec 64) (count : Nat) : Except Fault (BitVec 64) :=
  let rec loop (remaining current shift accumulator : Nat) : Except Fault (BitVec 64) :=
    match remaining with
    | 0 => .ok (fromNat accumulator)
    | remaining + 1 =>
        let location := addAddress address current
        match memory[location]? with
        | none => .error (.unmappedMemory location)
        | some byte =>
            loop remaining (current + 1) (shift + 8)
              (accumulator + byte.toNat * (2 ^ shift))
  loop count 0 0 0

def storeBytes
    (memory : Ram) (address value : BitVec 64) (count : Nat) : Except Fault Ram :=
  let rec loop (remaining current shifted : Nat) (result : Ram) : Except Fault Ram :=
    match remaining with
    | 0 => .ok result
    | remaining + 1 =>
        let location := addAddress address current
        match result[location]? with
        | none => .error (.unmappedMemory location)
        | some _ =>
            let byte := UInt8.ofNat (shifted % 256)
            loop remaining (current + 1) (shifted / 256) (result.insert location byte)
  loop count 0 value.toNat memory

-- Build fixture memory without performing architectural accesses.
def store64Image (memory : Ram) (address value : BitVec 64) : Ram :=
  let memory := memory.insert address (UInt8.ofNat (value.toNat % 256))
  let memory := memory.insert (address + 1) (UInt8.ofNat (value.toNat / 256 % 256))
  let memory := memory.insert (address + 2) (UInt8.ofNat (value.toNat / 256 / 256 % 256))
  let memory := memory.insert (address + 3) (UInt8.ofNat (value.toNat / 256 / 256 / 256 % 256))
  let memory := memory.insert (address + 4)
    (UInt8.ofNat (value.toNat / 256 / 256 / 256 / 256 % 256))
  let memory := memory.insert (address + 5)
    (UInt8.ofNat (value.toNat / 256 / 256 / 256 / 256 / 256 % 256))
  let memory := memory.insert (address + 6)
    (UInt8.ofNat (value.toNat / 256 / 256 / 256 / 256 / 256 / 256 % 256))
  memory.insert (address + 7)
    (UInt8.ofNat (value.toNat / 256 / 256 / 256 / 256 / 256 / 256 / 256 % 256))

def store8Image (memory : Ram) (address value : BitVec 64) : Ram :=
  memory.insert address (UInt8.ofNat (value.toNat % 256))

def store16Image (memory : Ram) (address value : BitVec 64) : Ram :=
  let memory := memory.insert address (UInt8.ofNat (value.toNat % 256))
  memory.insert (address + 1) (UInt8.ofNat (value.toNat / 256 % 256))

/-- The direct image of writing one already-byte-sized value. -/
def storeByteImage (memory : Ram) (address : BitVec 64) (value : UInt8) : Ram :=
  memory.insert address value

end X86.Machine
