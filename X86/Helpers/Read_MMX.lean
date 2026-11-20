-- Generated from data/definitions.xml.gz: Read_MMX; do not edit.
-- Source SHA256: dd20edd3e7d5c47a6987c757c7378cd9cfebf5c59ef1cb5ad5a4fc9acb460059
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_MMX)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Read_MMX (rrr : Bits 3) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return F80_Type.Mantissa (← (do Runtime.assert (decide (Unsigned rrr < 8)); Runtime.assert (decide (0 ≤ Unsigned rrr)); pure (← FP87.get (Unsigned rrr))))

end X86.Helpers
