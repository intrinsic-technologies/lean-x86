import Prelude.Memory.Region
import X86.Machine.State

namespace Prelude

open X86

/-- Physical memory outside the allowed regions is unchanged between the two states -/
def MemoryWriteFrame (initial final : Machine.RamState)
    (regions : Vector MemoryRegion n) : Prop :=
  ∀ address : BitVec 64,
    (∀ region ∈ regions, ¬ region.Contains address.toNat) →
    final.external[address]? = initial.external[address]?

end Prelude
