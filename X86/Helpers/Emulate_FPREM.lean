-- Generated from a local ISA specification; do not edit.
-- Source SHA256: e56cc63f8c7e15594b14796d664ee0e1fb574b33ed916209c97671f77d964b1d
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.One
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Length
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Truncated_Divide
import X86.Helpers.Std.Integer.Truncated_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Select_FP87_Remainder_Reduction.Binding (σ : Type) where
  call (x y : F80_Type) (nearest : Bool) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bits 5)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_FP87_Remainder_Reduction.Binding

variable {σ : Type}

variable
  [X86.Helpers.Select_FP87_Remainder_Reduction.Binding σ]

-- Intel XML omits Emulate_FPREM and Emulate_FPREM1. This local body follows the
-- FPREM/FPREM1 operation descriptions in Intel SDM Vol. 2.
-- SDM 325462-093 Vol. 1 Sections 4.9.1.5 and 8.5.5 specify exact-tiny
-- unmasked underflow and the register-result exponent adjustment.
-- FP87::Remainder owns special values and denormal-input flags.
-- The result is exact; RC and PC do not affect remainder calculation.

def Select_FP87_Remainder_Reduction
    (x y : F80_Type) (nearest : Bool) :
    Runtime.SpecM Exception (State σ) (Bits 5) := do
  Runtime.liftNoSourceException (liftM (Select_FP87_Remainder_Reduction.Binding.call x y nearest (← get)))

def Emulate_FP87_Remainder
    (x y : F80_Type) (nearest : Bool) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bits 4 × FP_Exception_Flags_Type) := do
  Runtime.assert (← (do
    let __check148 : FP87_Class_Type ← FP87.Classify x
    pure ((__check148 == FP87_Class_Type.FP87_Class_Normal) || (__check148 == FP87_Class_Type.FP87_Class_Denormal))))
  Runtime.assert (← (do
    let __check149 : FP87_Class_Type ← FP87.Classify y
    pure ((__check149 == FP87_Class_Type.FP87_Class_Normal) || (__check149 == FP87_Class_Type.FP87_Class_Denormal))))
  let one : F80_Type ← FP87.One 0
  -- Keep the call's effects and prove the returned value.
  let ⟨width, width_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 64) (F80_Type.Mantissa one) : Except (Runtime.Error Exception) Int))
  have width_value : width = (64 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at width_result <;> simp_all)
  let bias : Int := Unsigned (F80_Type.Exponent one)
  let x_exp : Int := (if (← Std.Bits.Is_Zero (size := 15) (F80_Type.Exponent x)) then (1 : Int) else Unsigned (F80_Type.Exponent x)) - bias - (width - 1)
  let y_exp : Int := (if (← Std.Bits.Is_Zero (size := 15) (F80_Type.Exponent y)) then (1 : Int) else Unsigned (F80_Type.Exponent y)) - bias - (width - 1)
  let difference : Int := x_exp - y_exp + (← Std.Bits.Count_Leading_Zero_Bits (size := 64) (F80_Type.Mantissa y)) - (← Std.Bits.Count_Leading_Zero_Bits (size := 64) (F80_Type.Mantissa x))
  let incomplete : Bool := decide (difference ≥ 64)
  let shift : Int ← do
    if incomplete then
      pure (difference - (32 + Unsigned (← Select_FP87_Remainder_Reduction x y nearest)))
    else
      pure 0
  let quotient_exp : Int := x_exp - y_exp - shift
  let numerator : Int := Unsigned (F80_Type.Mantissa x) * (← (do if decide (quotient_exp ≥ 0) then pure (← (2 : Int) ** quotient_exp) else pure (1 : Int)))
  let denominator : Int := Unsigned (F80_Type.Mantissa y) * (← (do if decide (quotient_exp ≥ 0) then pure (1 : Int) else pure (← (2 : Int) ** (- quotient_exp))))
  let mut quotient : Int ← Std.Integer.Truncated_Divide numerator denominator
  if (nearest and not incomplete) then
    let remainder : Int ← Std.Integer.Truncated_Remainder numerator denominator
    if (decide (2 * remainder > denominator) or 2 * remainder == denominator and (← Std.Integer.Truncated_Remainder quotient 2) == 1) then
      quotient := quotient + 1
  let exponent : Int := if decide (x_exp < y_exp + shift) then x_exp else y_exp + shift
  let left : Int := Unsigned (F80_Type.Mantissa x) * (← (2 : Int) ** (x_exp - exponent))
  let right : Int := Unsigned (F80_Type.Mantissa y) * quotient * (← (2 : Int) ** (y_exp + shift - exponent))
  let negative : Bool := decide (left < right)
  let magnitude : Int := if negative then right - left else left - right
  let sign : Runtime.Bit := F80_Type.Sign x xor (if negative then 1 else 0)
  let mut result : F80_Type ← FP87.Zero sign
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  if (magnitude != 0) then
    -- The exact remainder fits in the original 64-bit precision.
    Runtime.assert (decide (magnitude < (← (2 : Int) ** width)))
    let bits : Bits 64 := (BitVec.cast (by omega) (← magnitude[0 +: width]) : Bits 64)
    let leading : Int := width - 1 - (← Std.Bits.Count_Leading_Zero_Bits (size := 64) bits)
    let unbiased : Int := exponent + leading
    if (decide (unbiased ≥ 1 - bias)) then
      let encoded_exponent : Int := unbiased + bias
      let mantissa : Int := magnitude * (← (2 : Int) ** (width - 1 - leading))
      result := (BitVec.cast (by omega) (← concatBits (leftSize := 16) (rightSize := width) (← concatBits (leftSize := 1) (rightSize := 15) sign (← encoded_exponent[0 +: 15])) (← mantissa[0 +: width])) : Bits 80)
    else
      if ((← FP87_Control.UM) == 0) then
        let encoded_exponent : Int := unbiased + bias + 24576
        let mantissa : Int := magnitude * (← (2 : Int) ** (width - 1 - leading))
        result := (BitVec.cast (by omega) (← concatBits (leftSize := 16) (rightSize := width) (← concatBits (leftSize := 1) (rightSize := 15) sign (← encoded_exponent[0 +: 15])) (← mantissa[0 +: width])) : Bits 80)
        exceptions := FP_Exception_Flags_Type.setUE exceptions (1 : Runtime.Bit)
      else
        let mantissa : Int := magnitude * (← (2 : Int) ** (exponent - (1 - bias - (width - 1))))
        result := (BitVec.cast (by omega) (← concatBits (leftSize := 16) (rightSize := width) (← concatBits (leftSize := 1) (rightSize := 15) sign (← Std.Bits.Zero 15)) (← mantissa[0 +: width])) : Bits 80)
  let conditions : Bits 4 ← do
    if incomplete then
      -- Only C2 is defined after an incomplete step.
      let conditions : Bits 4 ← concatBits (leftSize := 2) (rightSize := 2) (← concatBits (leftSize := 1) (rightSize := 1) (← UNSPECIFIED (size := 1)) (1 : Runtime.Bit)) (← UNSPECIFIED (size := 2))
      pure conditions
    else
      let low : Bits 3 ← quotient[0 +: 3]
      let conditions : Bits 4 ← concatBits (leftSize := 3) (rightSize := 1) (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (← low[1 +: 1]) (0 : Runtime.Bit)) (← low[0 +: 1])) (← low[2 +: 1])
      pure conditions
  return (result, conditions, exceptions)

def Emulate_FPREM
    (x y : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bits 4 × FP_Exception_Flags_Type) := do
  return (← Emulate_FP87_Remainder x y false)

def Emulate_FPREM1
    (x y : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bits 4 × FP_Exception_Flags_Type) := do
  return (← Emulate_FP87_Remainder x y true)

end X86.Helpers
