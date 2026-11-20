-- Generated from data/definitions.xml.gz: FP87::Convert_To_Integer; do not edit.
-- Source SHA256: 6a5ed0ff66309220667fe9a3c7bb43337aa2c8d1c44f92c046db85a27717d028
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AConvert_To_Integer)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.In_Integer_Range
import X86.Helpers.FP87.Round_To_Integer
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Shift_Right_Logical
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Subtract
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Convert_To_Integer
    (x : F80_Type) (rc : Bits 2) (N : Int) (is_signed : Bool := true) :
    Except (Runtime.Error Empty) (Bits N × Bool × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)

  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let mut result : Bits N ←
    match (← FP87.Classify x) with
    | FP87_Class_Type.FP87_Class_Unsupported | FP87_Class_Type.FP87_Class_QNaN | FP87_Class_Type.FP87_Class_SNaN | FP87_Class_Type.FP87_Class_Infinity => do
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      pure (BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (1 : Runtime.Bit) (← Std.Bits.Zero (N - 1))) : Bits N)

    | FP87_Class_Type.FP87_Class_Zero => do
      pure (← Std.Bits.Zero N)

    | FP87_Class_Type.FP87_Class_Denormal | FP87_Class_Type.FP87_Class_Normal => do
      let f80_bias : Int := Unsigned (16383 : Bits 16)
      let _max_exponent : Int := f80_bias + N - 1

      let (r, rounded_up_1, exceptions_1) ← FP87.Round_To_Integer x rc
      rounded_up := rounded_up_1
      exceptions := exceptions_1
      let _rounded_exponent : Int := Unsigned (F80_Type.Exponent r)

      let result : Bits N ← do
        if not (← FP87.In_Integer_Range x rc N) then
          exceptions := (← Std.Bits.Zero 6)
          exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
          rounded_up := false
          let result : Bits N := (BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (1 : Runtime.Bit) (← Std.Bits.Zero (N - 1))) : Bits N)
          pure result
        else
          let exponent : Int := Unsigned (F80_Type.Exponent x)

          let shifted_mantissa : Bits 64 ← Std.Bits.Shift_Right_Logical (size := 64) (F80_Type.Mantissa x) (64 - N)
          let mut result : Bits N ← shifted_mantissa[0 +: N]
          let shift_count : Int := if decide (exponent < f80_bias) then f80_bias + N - exponent else f80_bias + N - exponent - 1

          result := (← Std.Bits.Shift_Right_Logical (size := N) result shift_count)

          if rounded_up then
            result := result + (← (1 : Int)[0 +: N])

          if (is_signed and F80_Type.Sign x == 1) then
            -- perform two's complement on negative
            let (result_1, _, _, _) ← Subtract (size := N) (← Std.Bits.Zero N) result
            result := result_1
          pure result
      pure result

  return (result, rounded_up, exceptions)

end X86.Helpers
