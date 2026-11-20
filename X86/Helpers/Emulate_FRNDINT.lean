-- Generated from a local ISA specification; do not edit.
-- Source SHA256: d3013b09e448540e94c10f40e18b1b2aea7eacaccbb62fcc62fc8c82cdce659e
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.One
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Length
import X86.Helpers.Std.Bits.Shift_Left_Logical
import X86.Helpers.Std.Bits.Shift_Right_Logical
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Missing XML primitive, implemented from Intel SDM 325462-089US FRNDINT,
-- Vol. 1 Sections 4.8.4 and 8.5.6, and IEEE 754-2019 Section 6.3.
-- This is a local body, not a recovered XML body.
--
-- Requirements: finite nonzero Normal or Denormal input, including pseudo-denormals.
-- Guarantees:
-- - Round to an integral F80 value using the explicit RC, retaining the sign of zero.
-- - Return whether the truncated magnitude was incremented and PE for an inexact result.
-- - Return no other flags; Round_To_Integer owns DE and special-value handling.
-- - Read or modify no architectural state and make no unspecified choices.
def Emulate_FRNDINT
    (x : F80_Type) (rc : Bits 2) :
    Except (Runtime.Error Empty) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  Runtime.assert (← (do
    let __check95 : FP87_Class_Type ← FP87.Classify x
    pure ((__check95 == FP87_Class_Type.FP87_Class_Normal) || (__check95 == FP87_Class_Type.FP87_Class_Denormal))))
  let one : F80_Type ← FP87.One 0
  let exponent : Int := Unsigned (F80_Type.Exponent x)
  let bias : Int := Unsigned (F80_Type.Exponent one)
  -- Keep the call's effects and prove the returned value.
  let ⟨mantissa_size, mantissa_size_result⟩ ← liftM (Runtime.remember (Std.Bits.Length (size := 64) (F80_Type.Mantissa x) : Except (Runtime.Error Empty) Int))
  have mantissa_size_value : mantissa_size = (64 : Int) := by
    simp_all [Std.Bits.Length, Runtime.assert, pure, Pure.pure, Except.pure, bind, Bind.bind, Except.bind]
    repeat (split at mantissa_size_result <;> simp_all)
  let unit : Bits 64 ← Std.Bits.Shift_Right_Logical (size := 64) (F80_Type.Mantissa one) (mantissa_size - 1)
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  let mut result : F80_Type := x
  let mut increment : Bool := false

  -- Every represented value with this exponent is already integral.
  if (decide (exponent ≥ bias + mantissa_size - 1)) then
    return (result, increment, exceptions)

  if (decide (exponent < bias)) then
    -- The magnitude is below one, so nearest-even resolves an exact half to zero.
    let above_half : Bool := exponent == bias - 1 and decide (Unsigned (F80_Type.Mantissa x) > Unsigned (F80_Type.Mantissa one))
    increment := rc == 0 and above_half or rc == 1 and F80_Type.Sign x == 1 or rc == 2 and F80_Type.Sign x == 0
    result := F80_Type.setExponent result (← (do if increment then pure (F80_Type.Exponent one) else pure (← Std.Bits.Zero 15)))
    result := F80_Type.setMantissa result (← (do if increment then pure (F80_Type.Mantissa one) else pure (← Std.Bits.Zero 64)))
    exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
  else
    let cut : Int := bias + mantissa_size - 1 - exponent
    let whole : Bits 64 ← Std.Bits.Shift_Right_Logical (size := 64) (F80_Type.Mantissa x) cut
    let discarded : Bits 64 := (BitVec.cast (by omega) (F80_Type.Mantissa x) : Bits 64) xor (← Std.Bits.Shift_Left_Logical (size := 64) whole cut)
    let half : Bits 64 ← Std.Bits.Shift_Left_Logical (size := 64) unit (cut - 1)
    let inexact : Bool := not (← Std.Bits.Is_Zero (size := 64) discarded)
    increment := rc == 0 and (decide (Unsigned discarded > Unsigned half) or discarded == half and (← whole[0 +: 1]) == 1) or rc == 1 and F80_Type.Sign x == 1 and inexact or rc == 2 and F80_Type.Sign x == 0 and inexact
    if (increment and whole == (← Std.Bits.Shift_Right_Logical (size := 64) (← Std.Bits.All_Ones 64) cut)) then
      result := F80_Type.setExponent result ((BitVec.cast (by omega) (F80_Type.Exponent x) : Bits 15) + (← Std.Bits.Zero_Extend (source_size := 1) 1 15))
      result := F80_Type.setMantissa result (F80_Type.Mantissa one)
    else
      let magnitude : Bits 64 := if increment then whole + unit else whole
      result := F80_Type.setMantissa result (← Std.Bits.Shift_Left_Logical (size := 64) magnitude cut)
    exceptions := FP_Exception_Flags_Type.setPE exceptions (if inexact then (1 : Runtime.Bit) else (0 : Runtime.Bit))
  return (result, increment, exceptions)

end X86.Helpers
