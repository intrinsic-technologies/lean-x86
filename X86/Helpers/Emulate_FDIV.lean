-- Generated from a local ISA specification; do not edit.
-- Source SHA256: d0aa44bdb0f5dde6df2bbebe1d91311e6425a4297f29e03e8150a766093f2d7a
import X86.Runtime
import X86.Helpers.Emulate_FP87_Result
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Integer.Exp
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

-- Intel XML declares Emulate_FDIV but supplies no body. This local body
-- uses exact integer division and the shared SDM rounding/range rules in
-- round_result.isa. FP87::Divide owns special values and denormal-input flags.
-- Require finite nonzero operands and a defined precision-control setting.
-- Read control only; return the value, magnitude-rounding direction and flags.
def Emulate_FDIV
    (x y : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  Runtime.assert (← (do
    let __check145 : FP87_Class_Type ← FP87.Classify x
    pure ((__check145 == FP87_Class_Type.FP87_Class_Normal) || (__check145 == FP87_Class_Type.FP87_Class_Denormal))))
  Runtime.assert (← (do
    let __check146 : FP87_Class_Type ← FP87.Classify y
    pure ((__check146 == FP87_Class_Type.FP87_Class_Normal) || (__check146 == FP87_Class_Type.FP87_Class_Denormal))))
  Runtime.assert ((← FP87_Control.PC) != 1)

  let numerator : Int := Unsigned (F80_Type.Mantissa x)
  let denominator : Int := Unsigned (F80_Type.Mantissa y)
  let x_exponent : Int ← do
    if (← Std.Bits.Is_Zero (size := 15) (F80_Type.Exponent x)) then
      pure 1
    else
      pure (Unsigned (F80_Type.Exponent x))
  let y_exponent : Int ← do
    if (← Std.Bits.Is_Zero (size := 15) (F80_Type.Exponent y)) then
      pure 1
    else
      pure (Unsigned (F80_Type.Exponent y))
  let precision : Int ← do
    if (← FP87_Control.PC) == 0 then
      pure 24
    else
      if (← FP87_Control.PC) == 2 then
        pure 53
      else
        pure 64

  -- The difference in bit lengths is the quotient's leading-bit position,
  -- or one greater. Compare scaled integers to choose without rounding.
  let mut leading : Int := (← Std.Bits.Count_Leading_Zero_Bits (size := 64) (F80_Type.Mantissa y)) - (← Std.Bits.Count_Leading_Zero_Bits (size := 64) (F80_Type.Mantissa x))
  let below : Bool ← do
    if decide (leading ≥ 0) then
      pure (decide (numerator < denominator * (← (2 : Int) ** leading)))
    else
      pure (decide (numerator * (← (2 : Int) ** (- leading)) < denominator))
  if below then
    leading := leading - 1
  return (← Emulate_FP87_Result numerator denominator (x_exponent - y_exponent) leading (F80_Type.Sign x xor F80_Type.Sign y) precision (← FP87_Control.RC))

end X86.Helpers
