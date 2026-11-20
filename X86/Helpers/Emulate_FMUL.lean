-- Generated from a local ISA specification; do not edit.
-- Source SHA256: c25f2615f3cc5899a2520a6e6bac4f36d9487ab9bb30a7c99cd894fe03736f06
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

-- Intel XML omits Emulate_FMUL's body. FP87::Multiply owns classification
-- and denormal flags; forms own writeback. Shared rounding is in round_result.isa.
-- Require finite nonzero operands and a defined PC setting. Read control only;
-- return the F80 result, magnitude-rounding direction and exception flags.
-- Retain checked width facts for dependent casts; their proofs are erased.
def Emulate_FMUL
    (x y : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let x_class : FP87_Class_Type ← FP87.Classify x
  let y_class : FP87_Class_Type ← FP87.Classify y
  Runtime.assert ((x_class == FP87_Class_Type.FP87_Class_Normal) || (x_class == FP87_Class_Type.FP87_Class_Denormal))
  Runtime.assert ((y_class == FP87_Class_Type.FP87_Class_Normal) || (y_class == FP87_Class_Type.FP87_Class_Denormal))
  Runtime.assert ((← FP87_Control.PC) != 1)

  let one : F80_Type ← FP87.One 0
  -- Keep the call's effects and prove the returned value.
  let ⟨mantissa_size, mantissa_size_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 64) (F80_Type.Mantissa one) : Except (Runtime.Error Exception) Int))
  have mantissa_size_value : mantissa_size = (64 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at mantissa_size_result <;> simp_all)
  let bias : Int := Unsigned (F80_Type.Exponent one)
  let infinity_exponent : Int := Unsigned (← Std.Bits.All_Ones (← Std.Bits.Length (size := 15) (F80_Type.Exponent one)))
  let _minimum_exponent : Int := 1 - bias
  let _maximum_exponent : Int := infinity_exponent - 1 - bias
  let _leading_unit : Int := Unsigned (F80_Type.Mantissa one)
  let precision : Int ← do
    if (← FP87_Control.PC) == 0 then
      pure 24
    else
      if (← FP87_Control.PC) == 2 then
        pure 53
      else
        pure 64
  let rc : Bits 2 ← FP87_Control.RC
  let sign : Runtime.Bit := F80_Type.Sign x xor F80_Type.Sign y
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
  let product : Int := Unsigned (F80_Type.Mantissa x) * Unsigned (F80_Type.Mantissa y)
  let product_bits : Bits 128 ← product[0 +: 128]
  let leading : Int := 2 * mantissa_size - 1 - (← Std.Bits.Count_Leading_Zero_Bits (size := 128) product_bits)
  let exponent : Int := x_exponent + y_exponent - 2 * bias - 2 * (mantissa_size - 1)
  return (← Emulate_FP87_Result product 1 exponent leading sign precision rc)

end X86.Helpers
