-- Generated from data/definitions.xml.gz: FP87::Get_Tag_Word_Value; do not edit.
-- Source SHA256: 631b169f5dc0722040cdb38bae11f7f31cd740e785c9fbd25fae258248c9546f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AGet_Tag_Word_Value)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87_Class_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Get_Tag_Word_Value (value : F80_Type) : Except (Runtime.Error Empty) (Bits 2) := do
  match (← FP87.Classify value) with
  | FP87_Class_Type.FP87_Class_Normal => do
    return 0
  | FP87_Class_Type.FP87_Class_Zero => do
    return 1
  | _ => do
    return 2

end X86.Helpers
