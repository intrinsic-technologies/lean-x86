-- Generated from data/definitions.xml.gz: FP87::Is_Unmasked_Pre_Computation_Exception; do not edit.
-- Source SHA256: 5341cccbbe283b97c50f19afed28387fda0036e2336a9ce323f2d198bfcd82e0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AIs_Unmasked_Pre_Computation_Exception)
import X86.Runtime
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Is_Unmasked_Pre_Computation_Exception
    (exceptions : FP_Exception_Flags_Type) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  let unmasked_exceptions : Bits 3 := (← exceptions[2:0]) and ~~~ (← sliceInclusive (← FP87_Control.Exception_Masks) 2 0)
  return not (← Std.Bits.Is_Zero (size := 3) unmasked_exceptions)

end X86.Helpers
