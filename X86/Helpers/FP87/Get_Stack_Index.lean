-- Generated from data/definitions.xml.gz: FP87::Get_Stack_Index; do not edit.
-- Source SHA256: d9d31b7bafc5914f6bf09efa3e9abeb6a9e710c7b595e888f00d8600e32d7c61
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AGet_Stack_Index)
import X86.Runtime
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Get_Stack_Index (i : Int) : Runtime.SpecM Exception (State σ) (Int) := do
  let stack_index : Int ← (do
    let __check70 : Int := i + Unsigned (← FP87_Status.TOP)
    pure (← Std.Integer.Positive_Remainder __check70 8))
  return stack_index

end X86.Helpers
