-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: bc396ded3d0634e2dd6da8e1aad207c4331c4f436c17805bc2fa26bd10c59f00
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Infinity
import X86.Helpers.FP87.Is_Round_Up
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Shift_Left_Logical
import X86.Helpers.Std.Bits.Shift_Right_Logical
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Scale_Number
    (x y : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut result : F80_Type ← Std.Bits.Zero 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let min_normal_exponent : Int := 1
  let max_normal_exponent : Int := Unsigned (32766 : Bits 16)
  let f80_bias : Int := Unsigned (16383 : Bits 16)
  -- exponent of the least significant mantissa bit of a value whose exponent field holds zero
  let mantissa_lsb_exponent : Int := f80_bias + 63
  -- SDM volume 1, 8.5.4 and 8.5.5: unmasked register results are biased by 3 * 2^13
  let bias_adjustment : Int := 24576
  -- a larger scale magnitude cannot change the result for any representable operand exponent
  let max_scale : Int := Unsigned (65536 : Bits 20)

  -- Truncate `y` toward zero to an integral scale factor, saturating the magnitude so that
  -- the full 16 bit signed range (including -32768) survives without losing any bits.
  let mut scale_magnitude : Int := 0
  let y_exponent : Int := Unsigned (F80_Type.Exponent y)
  if (decide (y_exponent ≥ mantissa_lsb_exponent)) then
    scale_magnitude := max_scale
  else
    if (decide (mantissa_lsb_exponent - y_exponent < 64)) then
      let truncated : Bits 64 ← Std.Bits.Shift_Right_Logical (size := 64) (F80_Type.Mantissa y) (mantissa_lsb_exponent - y_exponent)
      scale_magnitude := Unsigned (← truncated[0 +: 17])
      if (not (← Std.Bits.Is_Zero (size := 47) (← truncated[63:17])) or decide (scale_magnitude > max_scale)) then
        scale_magnitude := max_scale
  let scale : Int := if F80_Type.Sign y == 1 then 0 - scale_magnitude else scale_magnitude

  -- Normalize `x` so that its value is `mantissa * 2 ^ (working_exponent - mantissa_lsb_exponent)`
  -- with the explicit integer bit of `mantissa` set.  Denormal operands store a zero exponent
  -- field but behave as though it held `min_normal_exponent`.  `working_exponent` is kept as an
  -- unbounded signed integer because normalizing a denormal or applying a large scale factor
  -- can leave it far outside the range of the 15 bit exponent field.
  let normalize_shift : Int ← Std.Bits.Count_Leading_Zero_Bits (size := 64) (F80_Type.Mantissa x)
  let mantissa : Bits 64 ← Std.Bits.Shift_Left_Logical (size := 64) (F80_Type.Mantissa x) normalize_shift
  let x_exponent : Int ← do
    if (← Std.Bits.Is_Zero (size := 15) (F80_Type.Exponent x)) then
      pure min_normal_exponent
    else
      pure (Unsigned (F80_Type.Exponent x))
  let working_exponent : Int := x_exponent + scale - normalize_shift

  result := F80_Type.setSign result (F80_Type.Sign x)

  -- An unmasked range exception normally stores the significand unchanged, so no precision
  -- exception is reported: scaling by a power of two never rounds the significand.  The
  -- massive fallbacks below are the exception, because there the significand is discarded and
  -- replaced by a zero or an infinity, which is inexact.
  if (decide (working_exponent > max_normal_exponent)) then
    exceptions := FP_Exception_Flags_Type.setOE exceptions (1 : Runtime.Bit)
    if ((← FP87_Control.OM) == 1) then
      -- masked overflow, SDM volume 1, Table 4-10
      rounded_up := (← FP87.Is_Round_Up (F80_Type.Sign x) 1 1 1)
      if rounded_up then
        result := (← FP87.Infinity (F80_Type.Sign x))
      else
        result := F80_Type.setExponent result (← max_normal_exponent[0 +: 15])
        result := F80_Type.setMantissa result (← Std.Bits.All_Ones 64)
      exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
    else
      if (decide (working_exponent - bias_adjustment > max_normal_exponent)) then
        -- massive overflow: still out of range once the bias adjustment is applied, so the
        -- significand is discarded and the magnitude is rounded up to an infinity
        result := (← FP87.Infinity (F80_Type.Sign x))
        rounded_up := true
        exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
      else
        result := F80_Type.setExponent result (← (working_exponent - bias_adjustment)[0 +: 15])
        result := F80_Type.setMantissa result mantissa
  else
    if (decide (working_exponent < min_normal_exponent)) then
      if ((← FP87_Control.UM) == 0) then
        -- unmasked underflow reports every tiny result, whether or not it is inexact
        exceptions := FP_Exception_Flags_Type.setUE exceptions (1 : Runtime.Bit)
        if (decide (working_exponent + bias_adjustment < min_normal_exponent)) then
          -- massive underflow: still out of range once the bias adjustment is applied, so
          -- the significand is discarded and the magnitude is rounded down to a zero
          result := (← FP87.Zero (F80_Type.Sign x))
          exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
        else
          result := F80_Type.setExponent result (← (working_exponent + bias_adjustment)[0 +: 15])
          result := F80_Type.setMantissa result mantissa
      else
        -- masked underflow: denormalize the result and round it to the destination precision
        let shift_count : Int := min_normal_exponent - working_exponent
        let mut L : Runtime.Bit := 0
        let mut R : Runtime.Bit := 0
        let mut S : Runtime.Bit := 0
        let mut denormalized : Bits 64 ← Std.Bits.Zero 64

        if (decide (shift_count < 64)) then
          denormalized := (← Std.Bits.Shift_Right_Logical (size := 64) mantissa shift_count)
          L := (← mantissa[shift_count +: 1])
          R := (← (do if decide (shift_count > 0) then pure (← mantissa[shift_count - 1 +: 1]) else pure 0))
          S := (← Bit (← (do if decide (shift_count > 1) then pure (not (← Std.Bits.Is_Zero (size := (shift_count + (-1 : Int))) (BitVec.cast (by omega) (← mantissa[shift_count - 2:0]) : Bits (shift_count + (-1 : Int))))) else pure false)))
        else
          if (shift_count == 64) then
            R := (← mantissa[63 +: 1])
            S := (← Bit (not (← Std.Bits.Is_Zero (size := 63) (← mantissa[62:0]))))
          else
            -- the whole significand is discarded, and it is never zero here
            S := 1

        rounded_up := (← FP87.Is_Round_Up (F80_Type.Sign x) L R S)
        if rounded_up then
          denormalized := denormalized + (1 : Bits 64)

        result := F80_Type.setMantissa result denormalized
        -- rounding up can carry into the explicit integer bit, giving the smallest normal
        result := F80_Type.setExponent result (← (do if (← denormalized[63 +: 1]) == 1 then pure (← min_normal_exponent[0 +: 15]) else pure (← Std.Bits.Zero 15)))

        if (R != 0 or S != 0) then
          -- masked underflow is reported only when the result is both tiny and inexact
          exceptions := FP_Exception_Flags_Type.setUE exceptions (1 : Runtime.Bit)
          exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
    else
      result := F80_Type.setExponent result (← working_exponent[0 +: 15])
      result := F80_Type.setMantissa result mantissa

  return (result, rounded_up, exceptions)

end X86.Helpers
