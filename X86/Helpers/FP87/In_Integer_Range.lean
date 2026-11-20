-- Generated from data/definitions.xml.gz: FP87::In_Integer_Range; do not edit.
-- Source SHA256: 5b05ac51565d81f85ab07587ff4c962376182660bee85edabefa3b36fff319df
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AIn_Integer_Range)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Round_To_Integer
import X86.Helpers.FP87_Class_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.In_Integer_Range
    (x : F80_Type) (rc : Bits 2) (N : Int) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)

  Runtime.assert (← (do
    let __check96 : FP87_Class_Type ← FP87.Classify x
    pure ((__check96 == FP87_Class_Type.FP87_Class_Denormal) || (__check96 == FP87_Class_Type.FP87_Class_Normal))))

  let f80_bias : Int := Unsigned (16383 : Bits 16)
  let max_exponent : Int := f80_bias + N - 1

  let (r, _, _) ← FP87.Round_To_Integer x rc
  let rounded_exponent : Int := Unsigned (F80_Type.Exponent r)

  if (decide (rounded_exponent > max_exponent) or rounded_exponent == max_exponent and F80_Type.Sign r == 0 or rounded_exponent == max_exponent and (← (F80_Type.Mantissa r)[63 +: 1]) == 1 and not (← Std.Bits.Is_Zero (size := 63) (← (F80_Type.Mantissa r)[62:0]))) then
    return false
  else
    return true

end X86.Helpers
