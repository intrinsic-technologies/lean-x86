-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 29ccfa83c395cd8ee71c8d2b1fce1492a8aab32a0f6f208e85f6505c6df59f96
import X86.Runtime
import X86.Helpers.Emulate_Round_Rational
import X86.Helpers.F80_Type
import X86.Helpers.FP87.One
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Length
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Std.Integer.Truncated_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

-- Finite arithmetic local bodies: Intel XML omits Emulate_FADD/FSUB/FMUL/FDIV bodies.
-- Intel SDM 325462-089US, Vol. 1 Sections 4.8.4, 4.9.1.4–6,
-- 8.1.3.2, 8.1.5.2–3 and 8.5.4–6 specify rounding and range exceptions.
-- Source FP87::Add, Subtract and Multiply own classification and denormal flags;
-- instruction forms own status updates and writeback.

-- Round a positive exact rational value and encode the register result.
def Emulate_FP87_Result
    (magnitude denominator exponent leading : Int) (sign : Runtime.Bit) (precision : Int) (rc : Bits 2) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let one : F80_Type ← FP87.One 0
  -- Keep the call's effects and prove the returned value.
  let ⟨mantissa_size, mantissa_size_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 64) (F80_Type.Mantissa one) : Except (Runtime.Error Exception) Int))
  have mantissa_size_value : mantissa_size = (64 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at mantissa_size_result <;> simp_all)
  let bias : Int := Unsigned (F80_Type.Exponent one)
  -- Keep the call's effects and prove the returned value.
  let ⟨exponent_size, exponent_size_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 15) (F80_Type.Exponent one) : Except (Runtime.Error Exception) Int))
  have exponent_size_value : exponent_size = (15 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at exponent_size_result <;> simp_all)
  let infinity_exponent : Int := Unsigned (← Std.Bits.All_Ones exponent_size)
  let minimum_exponent : Int := 1 - bias
  let maximum_exponent : Int := infinity_exponent - 1 - bias
  let leading_unit : Int := Unsigned (F80_Type.Mantissa one)
  let mut (rounded, increment, inexact) ← Emulate_Round_Rational magnitude denominator (leading - precision + 1) rc sign
  let mut result_exponent : Int := exponent + leading
  if (rounded == (← (2 : Int) ** precision)) then
    rounded := (← Std.Integer.Truncated_Divide rounded 2)
    result_exponent := result_exponent + 1

  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  exceptions := FP_Exception_Flags_Type.setPE exceptions (if inexact then (1 : Runtime.Bit) else (0 : Runtime.Bit))
  let mut mantissa : Int := rounded * (← (2 : Int) ** (mantissa_size - precision))
  let mut encoded_exponent : Int := result_exponent + bias
  if (decide (result_exponent > maximum_exponent)) then
    exceptions := FP_Exception_Flags_Type.setOE exceptions (1 : Runtime.Bit)
    if ((← FP87_Control.OM) == 1) then
      let infinity : Bool := rc == 0 or rc == 1 and sign == 1 or rc == 2 and sign == 0
      mantissa := (← (do if infinity then pure leading_unit else pure (((← (2 : Int) ** precision) - 1) * (← (2 : Int) ** (mantissa_size - precision)))))
      encoded_exponent := if infinity then infinity_exponent else infinity_exponent - 1
      increment := infinity
      exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
    else
      encoded_exponent := encoded_exponent - 24576
  else
    if (decide (result_exponent < minimum_exponent)) then
      if ((← FP87_Control.UM) == 1) then
        -- Round the exact magnitude directly to the subnormal grid.
        let (rounded_1, increment_1, inexact_1) ← Emulate_Round_Rational magnitude denominator (minimum_exponent - precision + 1 - exponent) rc sign
        rounded := rounded_1
        increment := increment_1
        inexact := inexact_1
        mantissa := rounded * (← (2 : Int) ** (mantissa_size - precision))
        encoded_exponent := if mantissa == leading_unit then 1 else 0
        exceptions := FP_Exception_Flags_Type.setUE exceptions (if inexact then (1 : Runtime.Bit) else (0 : Runtime.Bit))
        exceptions := FP_Exception_Flags_Type.setPE exceptions (if inexact then (1 : Runtime.Bit) else (0 : Runtime.Bit))
      else
        exceptions := FP_Exception_Flags_Type.setUE exceptions (1 : Runtime.Bit)
        encoded_exponent := encoded_exponent + 24576

  let result : F80_Type := (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + exponent_size)) (rightSize := mantissa_size) (← concatBits (leftSize := 1) (rightSize := exponent_size) sign (← encoded_exponent[0 +: exponent_size])) (← mantissa[0 +: mantissa_size])) : Bits 80)
  return (result, increment, exceptions)

end X86.Helpers
