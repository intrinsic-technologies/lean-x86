-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 4aedf8a3e6076674b2696cce5275b58307765ae6cb5f86418f4ec487a9767e4a
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.One
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Round_Square_Root
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Length
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Exp
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

-- Intel XML omits Emulate_FSQRT. This local body implements the finite positive
-- case using exact integer comparisons and SDM Vol. 1 Section 4.8.4 rounding.
-- FP87::Sqrt owns zero, negative, special-value and denormal-input handling.
-- A finite extended80 square root is in the normal extended80 exponent range.
-- Read precision/rounding control only; return the value, rounding direction and PE.
def Emulate_FSQRT
    (x : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  Runtime.assert (← (do
    let __check147 : FP87_Class_Type ← FP87.Classify x
    pure ((__check147 == FP87_Class_Type.FP87_Class_Normal) || (__check147 == FP87_Class_Type.FP87_Class_Denormal))))
  Runtime.assert (F80_Type.Sign x == 0)
  Runtime.assert ((← FP87_Control.PC) != 1)
  let one : F80_Type ← FP87.One 0
  -- Keep the call's effects and prove the returned value.
  let ⟨width, width_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 64) (F80_Type.Mantissa x) : Except (Runtime.Error Exception) Int))
  have width_value : width = (64 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at width_result <;> simp_all)
  let bias : Int := Unsigned (F80_Type.Exponent one)
  let input_exponent : Int := (if (← Std.Bits.Is_Zero (size := 15) (F80_Type.Exponent x)) then (1 : Int) else Unsigned (F80_Type.Exponent x)) - bias - (width - 1)
  let precision : Int ← do
    if (← FP87_Control.PC) == 0 then
      pure 24
    else
      if (← FP87_Control.PC) == 2 then
        pure 53
      else
        pure 64
  let (root, exponent, inexact, increment) ← Round_Square_Root (width := 64) (F80_Type.Mantissa x) input_exponent precision (← FP87_Control.RC)
  let encoded_exponent : Int := exponent + bias
  let mantissa : Int := root * (← (2 : Int) ** (width - precision))
  let result : F80_Type := (BitVec.cast (by omega) (← concatBits (leftSize := 16) (rightSize := width) (← concatBits (leftSize := 1) (rightSize := 15) (0 : Runtime.Bit) (← encoded_exponent[0 +: 15])) (← mantissa[0 +: width])) : Bits 80)
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  exceptions := FP_Exception_Flags_Type.setPE exceptions (if inexact then (1 : Runtime.Bit) else (0 : Runtime.Bit))
  return (result, increment, exceptions)

end X86.Helpers
