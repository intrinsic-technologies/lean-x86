-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 350d6e2c82cfb49e12c6cabc6a0fe300c055810980d309c12f600371cbff3f21
import X86.Runtime
import X86.Helpers.Emulate_FADD
import X86.Helpers.Emulate_Round_Rational
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.One
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Class_Type
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Length
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Std.Integer.Truncated_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- TODO: Replace this local body with authoritative Intel source when available.
-- Intel XML omits Emulate_FSUB_For_Compare. FP87::Compare observes only whether
-- its result is zero and, otherwise, its sign. This local body implements that
-- numeric-order contract from the FCOMI/FUCOMI SDM description. The rounded
-- result encoding is an implementation choice, not a recovered XML definition.
-- Exact subtraction followed by nearest-even full-precision encoding preserves
-- these observations for every finite F80 pair. Arithmetic flags are not written.
def Emulate_FP87_CompareResult
    (exact exponent : Int) :
    Except (Runtime.Error Empty) (F80_Type) := do
  if (exact == 0) then
    return (← FP87.Zero 0)
  let sign : Runtime.Bit := if decide (exact < 0) then 1 else 0
  let magnitude : Int := if decide (exact < 0) then - exact else exact
  let one : F80_Type ← FP87.One 0
  -- Keep the call's effects and prove the returned value.
  let ⟨precision, precision_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 64) (F80_Type.Mantissa one) : Except (Runtime.Error Empty) Int))
  have precision_value : precision = (64 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at precision_result <;> simp_all)
  let bias : Int := Unsigned (F80_Type.Exponent one)
  -- Keep the call's effects and prove the returned value.
  let ⟨exponent_size, exponent_size_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 15) (F80_Type.Exponent one) : Except (Runtime.Error Empty) Int))
  have exponent_size_value : exponent_size = (15 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at exponent_size_result <;> simp_all)
  let infinity_exponent : Int := Unsigned (← Std.Bits.All_Ones exponent_size)
  let width : Int := precision + infinity_exponent - 1
  let bits : Bits width ← magnitude[0 +: width]
  let leading : Int := width - 1 - (← Std.Bits.Count_Leading_Zero_Bits (size := width) bits)
  let mut encoded_exponent : Int := exponent + leading + bias
  let mantissa : Int ← do
    if decide (encoded_exponent ≤ 0) then
      -- Finite inputs share the minimum-subnormal grid; this shift is exact.
      let mantissa : Int := magnitude * (← (2 : Int) ** (exponent + bias + precision - 2))
      encoded_exponent := 0
      pure mantissa
    else
      let (rounded, _, _) ← Emulate_Round_Rational magnitude 1 (leading - precision + 1) 0 sign
      let mut mantissa : Int := rounded
      if (mantissa == (← (2 : Int) ** precision)) then
        mantissa := (← Std.Integer.Truncated_Divide mantissa 2)
        encoded_exponent := encoded_exponent + 1
      if (decide (encoded_exponent ≥ infinity_exponent)) then
        mantissa := Unsigned (F80_Type.Mantissa one)
        encoded_exponent := infinity_exponent
      pure mantissa
  return (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + exponent_size)) (rightSize := precision) (← concatBits (leftSize := 1) (rightSize := exponent_size) sign (← encoded_exponent[0 +: exponent_size])) (← mantissa[0 +: precision])) : Bits 80)

def Emulate_FSUB_For_Compare (x y : F80_Type) : Except (Runtime.Error Empty) (F80_Type) := do
  Runtime.assert (← (do
    let __check133 : FP87_Class_Type ← FP87.Classify x
    pure ((__check133 == FP87_Class_Type.FP87_Class_Normal) || (__check133 == FP87_Class_Type.FP87_Class_Denormal) || (__check133 == FP87_Class_Type.FP87_Class_Zero))))
  Runtime.assert (← (do
    let __check134 : FP87_Class_Type ← FP87.Classify y
    pure ((__check134 == FP87_Class_Type.FP87_Class_Normal) || (__check134 == FP87_Class_Type.FP87_Class_Denormal) || (__check134 == FP87_Class_Type.FP87_Class_Zero))))
  let (exact, exponent) ← Emulate_FP87_ExactSum x y true
  return (← Emulate_FP87_CompareResult exact exponent)

end X86.Helpers
