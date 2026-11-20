-- Generated from data/definitions.xml.gz: ST; do not edit.
-- Source SHA256: d44abe726f198fd8af18ec481203bb796c491a863b46bb337627c8a5a9e6fb3b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=ST)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Get_Tag_Word_Value
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Std.Bits.Add_int
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def ST (i : Int) : Runtime.SpecM Exception (State σ) (F80_Type) := do
  Runtime.assert (decide (i < 8))
  let index : Bits 3 ← Std.Bits.Add_int (n := 3) (← FP87_Status.TOP) i
  let tag : Bits 2 ← do
    Runtime.assert (decide (Unsigned index * 2 ≤ 14))
    Runtime.assert (decide (0 ≤ Unsigned index))
    pure (← sliceElement (← get).FP87_Tag_Word 2 (Unsigned index))
  if (tag == 3) then
    FP87_Status.setSF 1
  return (← (do Runtime.assert (decide (Unsigned index < 8)); Runtime.assert (decide (0 ≤ Unsigned index)); pure (← FP87.get (Unsigned index))))

def ST_write (i : Int) (value : F80_Type) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (decide (i < 8))
  let index : Bits 3 ← Std.Bits.Add_int (n := 3) (← FP87_Status.TOP) i
  Runtime.assert (decide (Unsigned index * 2 ≤ 14))
  Runtime.assert (decide (0 ≤ Unsigned index))
  FP87_Tag_Word.setSlice ((Unsigned index) * (2 : Int)) 2 (← FP87.Get_Tag_Word_Value value)
  Runtime.assert (decide (Unsigned index < 8))
  Runtime.assert (decide (0 ≤ Unsigned index))
  FP87.set (Unsigned index) value

end X86.Helpers
