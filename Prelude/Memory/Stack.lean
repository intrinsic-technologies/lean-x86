import Prelude.Memory.Region
import X86.Machine.State

namespace Prelude.Stack

variable {σ : Type}

/-- Stack alignment in bytes required before a call by the System V x86-64 ABI -/
def callAlignment : Nat := 16

/-- Size in bytes of the return address pushed by a 64-bit near call -/
def returnAddressBytes : Nat := 8

/-- The return-address slot `[RSP, RSP + returnAddressBytes)` -/
def returnSlot (s : X86.State σ) : MemoryRegion :=
  ⟨(s.regValue .rsp).toNat, returnAddressBytes⟩

/--
The region `[RSP - stackBytes, RSP + returnBytes)`, containing stack scratch space
below the entry RSP and a return slot at RSP
-/
def region (s : X86.State σ) (stackBytes : Nat)
    (returnBytes : Nat := returnAddressBytes) : MemoryRegion :=
  let pointer := (s.regValue .rsp).toNat
  let start := pointer - stackBytes
  ⟨start, pointer + returnBytes - start⟩

/-- RSP can be decreased by `stackBytes` without underflow -/
def NoUnderflow (s : X86.State σ) (stackBytes : Nat) : Prop :=
  stackBytes ≤ (s.regValue .rsp).toNat

/-- Available stack space and System V x86-64 alignment at function entry -/
def Valid (s : X86.Machine.RamState) (stackBytes : Nat) : Prop :=
  let region := Stack.region s stackBytes
  region.Bounded ∧
  region.Allocated s.external ∧
  NoUnderflow s stackBytes ∧
  (returnSlot s).Aligned callAlignment returnAddressBytes

end Prelude.Stack
