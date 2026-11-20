-- Generated from data/definitions.xml.gz: FP87::Read_STi; do not edit.
-- Source SHA256: 7c7bd6ba2038b26bdc7ae97fb756563b092935ada830846953dd3ee52eb12509
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ARead_STi)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Get_Stack_Index
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Read_STi (i : Int) : Runtime.SpecM Exception (State σ) (F80_Type) := do
  Runtime.assert (decide (i < 8))
  return (← (do
    let __check71 : Int ← FP87.Get_Stack_Index i
    Runtime.assert (decide (__check71 < 8))
    Runtime.assert (decide (0 ≤ __check71))
    pure (← FP87.get __check71)))

end X86.Helpers
