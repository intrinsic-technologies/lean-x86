import X86.Machine.Ram
import X86.Machine.State

namespace Prelude

open X86

open X86.Machine

/-- Exclusive address limit used by the fixed low-4-GiB memory predicates. -/
def userAddressLimit : Nat := 2^32

/-- A half-open address interval `[start, start + size)` -/
structure MemoryRegion where
  start : Nat
  size : Nat
  deriving DecidableEq, Repr

namespace MemoryRegion

/-- The region's start has the given remainder modulo `alignment` -/
def Aligned (region : MemoryRegion) (alignment : Nat) (offset : Nat := 0) : Prop :=
  region.start % alignment = offset

/-- The exclusive end of the region is strictly below `limit`, defaulting to 4 GiB -/
def Bounded (region : MemoryRegion) (limit : Nat := userAddressLimit) : Prop :=
  region.start + region.size < limit

/-- A supplied byte count matches the region's size -/
def HasLength (region : MemoryRegion) (length : Nat) : Prop :=
  length = region.size

/-- The bytes fill the region exactly -/
def HasBytes (region : MemoryRegion) (memory : Ram) (bytes : ByteArray) : Prop :=
  region.HasLength bytes.size ∧
  ∀ i : Fin bytes.size,
    memory[BitVec.ofNat 64 (region.start + i.val)]? = some bytes[i.val]

/-- Membership in the region's half-open interval -/
def Contains (region : MemoryRegion) (address : Nat) : Prop :=
  region.start ≤ address ∧ address < region.start + region.size

/-- The regions share no addresses, including when either region is empty -/
def Disjoint (region region' : MemoryRegion) : Prop :=
  ∀ address, region.Contains address → ¬ region'.Contains address

/-- Every pair of distinct positions contains disjoint regions -/
def PairwiseDisjoint (regions : Vector MemoryRegion n) : Prop :=
  ∀ i j : Fin n, i < j → (regions[i]).Disjoint regions[j]

/-- Every machine address in the region has a byte in physical memory -/
def Allocated (region : MemoryRegion) (memory : Ram) : Prop :=
  ∀ address : BitVec 64, region.Contains address.toNat →
    ∃ byte, memory[address]? = some byte

/-- No machine address in the region satisfies the forbidden-address predicate -/
def Avoids (region : MemoryRegion) (forbidden : BitVec 64 → Prop) : Prop :=
  ∀ address : BitVec 64, region.Contains address.toNat → ¬ forbidden address

/-- The region consists of an eight-byte little-endian word in physical memory -/
def Word64At (region : MemoryRegion) (memory : Ram) (value : BitVec 64) : Prop :=
  region.HasLength 8 ∧
  X86.Machine.loadBytes memory (BitVec.ofNat 64 region.start) 8 = .ok value

end MemoryRegion

/-- Region of `size` bytes at the address in a register -/
def registerRegion {σ : Type} (s : X86.State σ) (register : X86.Syntax.Reg)
    (size : Nat) : MemoryRegion :=
  ⟨(s.regValue register).toNat, size⟩

end Prelude
