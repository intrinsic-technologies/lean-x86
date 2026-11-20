-- Generated from data/definitions.xml.gz: FP87::Process_Exceptions; do not edit.
-- Source SHA256: c2dddcc9c7b01cd8178a0ad5037660b053c426017e9d3d4893d5f55541b22e3c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AProcess_Exceptions)
import X86.Runtime
import X86.Helpers.FP.Prioritize_Exceptions
import X86.Helpers.FP87.Is_Unmasked_Exception
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP87_Status_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Process_Exceptions
    (exceptions : FP_Exception_Flags_Type) :
    Runtime.SpecM Exception (State σ) Unit := do
  FP87_Status.setException_Flags ((BitVec.cast (by omega) (← FP87_Status.Exception_Flags) : Bits 6) or (← FP.Prioritize_Exceptions exceptions (← FP87_Control.Exception_Masks)))

  if (← FP87.Is_Unmasked_Exception exceptions (← FP87_Control.Exception_Masks)) then
    FP87_Status.setES 1
    FP87_Status.setB 1

end X86.Helpers
