-- Generated from a local ISA specification; do not edit.
-- Source SHA256: a4a9130da16154125ee6ad42b444e96178ae98badca87c9d75835365bb3b1e58
import X86.Runtime
import X86.Helpers.Emulate_FP87_Result
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.One
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Length
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Power2
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

-- Intel XML omits Emulate_FADD and Emulate_FSUB bodies. Source FP87::Add and
-- FP87::Subtract own classification and denormal flags; forms own writeback.
-- Intel SDM Vol. 2 FADD/FSUB specifies exact-cancellation zero; round_result.isa
-- supplies the shared precision, rounding and range rules.
-- Exact signed dyadic coefficient and common power of two for finite F80 inputs.
-- This pure arithmetic has no precision, rounding or exception-mask choices.
def Emulate_FP87_ExactSum
    (x y : F80_Type) (subtract : Bool) :
    Except (Runtime.Error Empty) (Int × Int) := do
  let one : F80_Type ← FP87.One 0
  -- Keep the call's effects and prove the returned value.
  let ⟨mantissa_size, mantissa_size_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 64) (F80_Type.Mantissa one) : Except (Runtime.Error Empty) Int))
  have mantissa_size_value : mantissa_size = (64 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at mantissa_size_result <;> simp_all)
  let bias : Int := Unsigned (F80_Type.Exponent one)
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
  let base : Int := if decide (x_exponent < y_exponent) then x_exponent else y_exponent
  let x_magnitude : Int := Unsigned (F80_Type.Mantissa x) * (← (2 : Int) ** (x_exponent - base))
  let y_magnitude : Int := Unsigned (F80_Type.Mantissa y) * (← (2 : Int) ** (y_exponent - base))
  let y_sign : Runtime.Bit := if subtract then ~~~ (F80_Type.Sign y) else F80_Type.Sign y
  let exact : Int := (if F80_Type.Sign x == 1 then - x_magnitude else x_magnitude) + (if y_sign == 1 then - y_magnitude else y_magnitude)
  return (exact, base - bias - (mantissa_size - 1))

-- Exact signed addition precedes rounding. Source Add/Subtract own class handling.
-- Retain checked width facts for dependent casts; their proofs are erased.
def Emulate_FP87_Add
    (x y : F80_Type) (subtract : Bool) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let x_class : FP87_Class_Type ← FP87.Classify x
  let y_class : FP87_Class_Type ← FP87.Classify y
  Runtime.assert ((x_class == FP87_Class_Type.FP87_Class_Normal) || (x_class == FP87_Class_Type.FP87_Class_Denormal) || (x_class == FP87_Class_Type.FP87_Class_Zero))
  Runtime.assert ((y_class == FP87_Class_Type.FP87_Class_Normal) || (y_class == FP87_Class_Type.FP87_Class_Denormal) || (y_class == FP87_Class_Type.FP87_Class_Zero))
  Runtime.assert (x_class != FP87_Class_Type.FP87_Class_Zero or y_class != FP87_Class_Type.FP87_Class_Zero)
  Runtime.assert ((← FP87_Control.PC) != 1)
  let (exact, exponent) ← Emulate_FP87_ExactSum x y subtract
  if (exact == 0) then
    -- FADD/FSUB define exact cancellation as negative zero only under RTN.
    let sign : Runtime.Bit ← do
      if (← FP87_Control.RC) == 1 then
        pure 1
      else
        pure 0
    let result : F80_Type ← concatBits (leftSize := 1) (rightSize := 79) sign (← Std.Bits.Zero 79)
    return (result, false, (← Std.Bits.Zero 6))
  let sign : Runtime.Bit := if decide (exact < 0) then 1 else 0
  let magnitude : Int := if decide (exact < 0) then - exact else exact
  let one : F80_Type ← FP87.One 0
  -- Keep the call's effects and prove the returned value.
  let ⟨mantissa_size, mantissa_size_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 64) (F80_Type.Mantissa one) : Except (Runtime.Error Exception) Int))
  have mantissa_size_value : mantissa_size = (64 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at mantissa_size_result <;> simp_all)
  let infinity_exponent : Int := Unsigned (← Std.Bits.All_Ones (← Std.Bits.Length (size := 15) (F80_Type.Exponent one)))
  -- Bound the aligned significands plus a carry by the source exponent range.
  let width : Int := mantissa_size + infinity_exponent - 1
  let bits : Bits width ← magnitude[0 +: width]
  let leading : Int := width - 1 - (← Std.Bits.Count_Leading_Zero_Bits (size := width) bits)
  let precision : Int ← do
    if (← FP87_Control.PC) == 0 then
      pure 24
    else
      if (← FP87_Control.PC) == 2 then
        pure 53
      else
        pure 64
  let rc : Bits 2 ← FP87_Control.RC
  return (← Emulate_FP87_Result magnitude 1 exponent leading sign precision rc)

def Emulate_FADD
    (x y : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  return (← Emulate_FP87_Add x y false)

def Emulate_FSUB
    (x y : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  return (← Emulate_FP87_Add x y true)

end X86.Helpers
