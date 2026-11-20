-- Generated from data/definitions.xml.gz: FP87::Classify; do not edit.
-- Source SHA256: e2474d9f7843731a6dffc4c7e66327a014a697958995938c179be7901dc6d0b1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AClassify)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87_Class_Type
import X86.Helpers.Std.Bits.Is_All_Ones
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Classify (x : F80_Type) : Except (Runtime.Error Empty) (FP87_Class_Type) := do
  let j : Runtime.Bit ← (F80_Type.Mantissa x)[63 +: 1]
  let fraction : Bits 63 ← (F80_Type.Mantissa x)[62:0]

  if (← Std.Bits.Is_All_Ones (size := 15) (F80_Type.Exponent x)) then
    if (j == 1) then
      if (← Std.Bits.Is_Zero (size := 63) fraction) then
        return FP87_Class_Type.FP87_Class_Infinity
      else
        if ((← fraction[62 +: 1]) == 1) then
          return FP87_Class_Type.FP87_Class_QNaN
        else
          return FP87_Class_Type.FP87_Class_SNaN
  else
    if (← Std.Bits.Is_Zero (size := 15) (F80_Type.Exponent x)) then
      if (j == 0) then
        if (← Std.Bits.Is_Zero (size := 63) fraction) then
          return FP87_Class_Type.FP87_Class_Zero
        else
          return FP87_Class_Type.FP87_Class_Denormal
      else
        return FP87_Class_Type.FP87_Class_Denormal
    else
      if (j == 1) then
        return FP87_Class_Type.FP87_Class_Normal

  return FP87_Class_Type.FP87_Class_Unsupported

end X86.Helpers
