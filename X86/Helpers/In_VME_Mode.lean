-- Generated from data/definitions.xml.gz: In_VME_Mode; do not edit.
-- Source SHA256: f330cc48b17426ba5fe8bfac99494e0f7a9589579fa7c723f2b577839f469aa5
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=In_VME_Mode)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def In_VME_Mode  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← CR0.PE) == 1 and (← RFLAGS.VM) == 1 and (← CR4.VME) == 1

end X86.Helpers
