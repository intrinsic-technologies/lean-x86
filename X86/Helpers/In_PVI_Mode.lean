-- Generated from data/definitions.xml.gz: In_PVI_Mode; do not edit.
-- Source SHA256: fe611a79f3cfaa7b7b38f7c153d28b0150f539d2717aa0f9b866e856546f8583
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=In_PVI_Mode)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def In_PVI_Mode  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← CR0.PE) == 1 and (← RFLAGS.VM) == 0 and (← get).CPL == 3 and (← CR4.PVI) == 1

end X86.Helpers
