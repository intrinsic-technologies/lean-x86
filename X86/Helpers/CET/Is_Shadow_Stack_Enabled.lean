-- Generated from data/definitions.xml.gz: CET::Is_Shadow_Stack_Enabled; do not edit.
-- Source SHA256: d0e9b5826e117f089b962249159cddbacb8cfba069f328b990bb2af2eaaf7802
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AIs_Shadow_Stack_Enabled)
import X86.Runtime
import X86.Helpers.IA32_CET
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def CET.Is_Shadow_Stack_Enabled (cpl : Int) : Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (cpl in {0..3})

  if ((← CR4.CET) == 1 and (← CR0.PE) == 1 and (← RFLAGS.VM) == 0) then
    return (← IA32_CET cpl).SH_STK_EN == 1
  else
    return false

end X86.Helpers
