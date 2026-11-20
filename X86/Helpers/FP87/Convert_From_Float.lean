-- Generated from data/definitions.xml.gz: FP87::Convert_From_Float; do not edit.
-- Source SHA256: 4c285cbf21e6777e709fb92e5aa0c747b3cebf28b277ccead235c20828308009
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AConvert_From_Float)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Normalize
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Convert_From_Float {size : Int}
    (x : Bits size) :
    Runtime.PartialResult Empty (F80_Type × Bool) := do
  Runtime.assert (size == 32 || size == 64)

  let mut is_denormal : Bool := false

  let exponent_size : Int := if size == 32 then 8 else 11
  let mantissa_size : Int := size - exponent_size - 1

  let sign : Runtime.Bit ← x[size - 1 +: 1]
  let exponent : Bits exponent_size ← x[mantissa_size +: exponent_size]
  let mantissa : Bits mantissa_size ← x[0 +: mantissa_size]
  let result_bits_63_0 : Bits 64 := (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + mantissa_size)) (rightSize := (((64 : Int) - mantissa_size) - (1 : Int))) (← concatBits (leftSize := 1) (rightSize := mantissa_size) (1 : Runtime.Bit) mantissa) (← Std.Bits.Zero (64 - mantissa_size - 1))) : Bits 64)

  let f80_bias : Bits 15 ← (16383 : Bits 16)[0 +: 15]
  let bias : Bits 15 ← do
    if size == 32 then
      pure (← Std.Bits.Zero_Extend (source_size := 8) 127 15)
    else
      pure (← Std.Bits.Zero_Extend (source_size := 12) 1023 15)

  let result : F80_Type ← do
    if exponent == (← Std.Bits.All_Ones exponent_size) then
      let result_bits_78_64_1 : Bits 15 ← Std.Bits.All_Ones 15
      let result : F80_Type ← concatBits (leftSize := 1) (rightSize := 79) sign (← concatBits (leftSize := 15) (rightSize := 64) result_bits_78_64_1 result_bits_63_0)
      pure result
    else
      if (← Std.Bits.Is_Zero (size := exponent_size) exponent) then
        let mut result : F80_Type ← concatBits (leftSize := 1) (rightSize := 79) sign (← concatBits (leftSize := 15) (rightSize := 64) (← Std.Bits.Zero 15) result_bits_63_0)
        if (← Std.Bits.Is_Zero (size := mantissa_size) mantissa) then
          result := F80_Type.setMantissa result (← Std.Bits.Zero 64)
        else
          result := F80_Type.setExponent result (f80_bias - bias + (← Std.Bits.Zero_Extend (source_size := 4) 1 15))
          if (not (← Std.Bits.Is_Zero (size := 64) (F80_Type.Mantissa result))) then
            result := (← setSliceChecked result 63 1 0)
            result := (← FP87.Normalize result)
          is_denormal := true
        pure result
      else
        let result_bits_78_64 : Bits 15 := (← Std.Bits.Zero_Extend (source_size := exponent_size) exponent 15) + (f80_bias - bias)
        let result : F80_Type ← concatBits (leftSize := 1) (rightSize := 79) sign (← concatBits (leftSize := 15) (rightSize := 64) result_bits_78_64 result_bits_63_0)
        pure result

  return (result, is_denormal)

end X86.Helpers
