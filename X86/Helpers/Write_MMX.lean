-- Generated from data/definitions.xml.gz: Write_MMX; do not edit.
-- Source SHA256: ab0435145182cd14141ab1be5cfad1d037a6d99d653d215225b29289873124b8
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_MMX)
import X86.Runtime
import X86.Helpers.Std.Bits.All_Ones
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Write_MMX (rrr : Bits 3) (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (decide (Unsigned rrr < 8))
  Runtime.assert (decide (0 ≤ Unsigned rrr))
  FP87.set (Unsigned rrr) (← concatBits (leftSize := 16) (rightSize := 64) (← Std.Bits.All_Ones 16) value)

end X86.Helpers
