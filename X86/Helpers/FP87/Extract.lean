-- Generated from data/definitions.xml.gz: FP87::Extract; do not edit.
-- Source SHA256: 30f162ebf0e58d2166edfb85b5ab5820696181483eb57caea13f8122eac654c9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AExtract)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Convert_From_Integer
import X86.Helpers.FP87.Infinity
import X86.Helpers.FP87.Normalize
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Extract
    (x : F80_Type) :
    Runtime.PartialResult Empty (F80_Type × F80_Type × FP_Exception_Flags_Type) := do
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  let f80_bias : Bits 15 ← (16383 : Bits 16)[0 +: 15]

  let mut (result1, result2) : (F80_Type × F80_Type) ←
    match (← FP87.Classify x) with
    | FP87_Class_Type.FP87_Class_Unsupported => do
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      let result1 : F80_Type ← FP87.QNaN_Indefinite
      let result2 : F80_Type ← FP87.QNaN_Indefinite
      pure (result1, result2)

    | FP87_Class_Type.FP87_Class_QNaN => do
      let result1 : F80_Type := x
      let result2 : F80_Type := x
      pure (result1, result2)

    | FP87_Class_Type.FP87_Class_SNaN => do
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      let result1 : F80_Type ← FP87.Quietize_NaN x
      let result2 : F80_Type ← FP87.Quietize_NaN x
      pure (result1, result2)

    | FP87_Class_Type.FP87_Class_Infinity => do
      let result1 : F80_Type ← FP87.Infinity (F80_Type.Sign x)
      let result2 : F80_Type ← FP87.Infinity 0
      pure (result1, result2)

    | FP87_Class_Type.FP87_Class_Denormal => do
      -- calculate Mantissa
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
      let mut result1 : F80_Type ← FP87.Normalize x
      result1 := F80_Type.setExponent result1 f80_bias

      -- calculate Exponent
      let mut temp : F80_Type := x
      temp := F80_Type.setExponent temp (f80_bias + (← Std.Bits.Zero_Extend (source_size := 4) 1 15))
      temp := (← FP87.Normalize temp)
      let exp : Bits 15 := f80_bias - (BitVec.cast (by omega) (F80_Type.Exponent temp) : Bits 15) + f80_bias
      let mut result2 : F80_Type ← FP87.Convert_From_Integer (size := 64) (← Std.Bits.Zero_Extend (source_size := 15) exp 64)
      result2 := F80_Type.setSign result2 (1 : Runtime.Bit)
      pure (result1, result2)

    | FP87_Class_Type.FP87_Class_Zero => do
      exceptions := FP_Exception_Flags_Type.setZE exceptions (1 : Runtime.Bit)
      let result1 : F80_Type ← FP87.Zero (F80_Type.Sign x)
      let result2 : F80_Type ← FP87.Infinity 1
      pure (result1, result2)

    | FP87_Class_Type.FP87_Class_Normal => do
      -- copy Mantissa
      let mut result1 : F80_Type := x
      result1 := F80_Type.setExponent result1 f80_bias

      -- calculate Exponent
      let unbiased_exponent : Bits 15 := if decide (Unsigned (F80_Type.Exponent x) ≥ Unsigned f80_bias) then (BitVec.cast (by omega) (F80_Type.Exponent x) : Bits 15) - f80_bias else f80_bias - (BitVec.cast (by omega) (F80_Type.Exponent x) : Bits 15)

      let mut result2 : F80_Type ← FP87.Convert_From_Integer (size := 16) (← Std.Bits.Zero_Extend (source_size := 15) unbiased_exponent 16)

      if (decide (Unsigned (F80_Type.Exponent x) < Unsigned f80_bias)) then
        result2 := F80_Type.setSign result2 (1 : Runtime.Bit)
      pure (result1, result2)

  return (result1, result2, exceptions)

end X86.Helpers
