-- Generated from data/definitions.xml.gz: Read_Mask; do not edit.
-- Source SHA256: 5eb4733bd70b84dfe5b3ee72df37e3b8c466440396e3ec822ea52938912b72f0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_Mask)
import X86.Runtime
import X86.Helpers.Std.Bits.All_Ones
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Read_Mask (rrr : Bits 3) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  -- K0 is implicit "no mask" when used as an opmask
  if (rrr == 0) then
    return (← Std.Bits.All_Ones 64)
  else
    return (← (do Runtime.assert (decide (Unsigned rrr < 8)); Runtime.assert (decide (0 ≤ Unsigned rrr)); pure (← K.get (Unsigned rrr))))

end X86.Helpers
