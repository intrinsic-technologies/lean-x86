-- Generated from data/definitions.xml.gz: FP87::Is_STi_Empty; do not edit.
-- Source SHA256: 58ac90e5bbb3539cf8edd5ef3f2f189c03d787bb876a975a39f6eee04b354d4c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AIs_STi_Empty)
import X86.Runtime
import X86.Helpers.FP87.Get_Stack_Index
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Is_STi_Empty (i : Int) : Runtime.SpecM Exception (State σ) (Bool) := do
  let stack_index : Int ← FP87.Get_Stack_Index i
  return (← (do Runtime.assert (decide (stack_index * 2 ≤ 14)); Runtime.assert (decide (0 ≤ stack_index)); pure (← sliceElement (← get).FP87_Tag_Word 2 stack_index))) == 3

end X86.Helpers
