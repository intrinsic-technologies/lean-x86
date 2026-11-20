-- Generated from data/definitions.xml.gz: Is_End_Branch_Enabled_And_Not_Suppressed; do not edit.
-- Source SHA256: 15af9e9838493f9a8cf1cc7ae2e7c2d9d778fe64322ff01565657302ac59775c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_End_Branch_Enabled_And_Not_Suppressed)
import X86.Runtime
import X86.Helpers.IA32_CET
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Is_End_Branch_Enabled_And_Not_Suppressed
    (cpl : Int) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (cpl in {0..3})

  if ((← CR4.CET) == 1 and (← CR0.PE) == 1 and (← RFLAGS.VM) == 0) then
    return (← IA32_CET cpl).ENDBR_EN == 1 and (← IA32_CET cpl).SUPPRESS == 0
  else
    return false

end X86.Helpers
