-- Generated from data/definitions.xml.gz: Is_End_Branch_Enabled; do not edit.
-- Source SHA256: 3dec6f793c431b8b76762562c9230c76d3ffba6ec5be44059a2b3949d149da18
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_End_Branch_Enabled)
import X86.Runtime
import X86.Helpers.IA32_CET
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Is_End_Branch_Enabled (cpl : Int) : Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (cpl in {0..3})

  if ((← CR4.CET) == 1 and (← CR0.PE) == 1 and (← RFLAGS.VM) == 0) then
    return (← IA32_CET cpl).ENDBR_EN == 1
  else
    return false

end X86.Helpers
