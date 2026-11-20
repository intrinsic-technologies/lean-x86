-- Generated from data/definitions.xml.gz: Current_Mode; do not edit.
-- Source SHA256: eae6d803ed5ecc0b84287ba0ad0f8f6650d4e854ae496cf38078898e7778f950
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Current_Mode)
import X86.Runtime
import X86.Helpers.Execution_Mode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Current_Mode  : Runtime.SpecM Exception (State σ) (Execution_Mode) := do
  if ((← CR0.PE) == 0) then
    return Execution_Mode.Real_Address_Mode
  else
    if ((← get).IA32_EFER.LMA == 1) then
      return Execution_Mode.IA32e_Mode
    else
      if ((← RFLAGS.VM) == 1) then
        return Execution_Mode.Virtual_8086_Mode
      else
        return Execution_Mode.Protected_Mode

end X86.Helpers
