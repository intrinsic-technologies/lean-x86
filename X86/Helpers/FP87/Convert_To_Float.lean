-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 7e6f292e7da228670cc2b537e0d40af8818a7bf09ce042318fe35b5f1b5c2a56
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Is_Round_Up
import X86.Helpers.FP87.Is_Unmasked_Exception
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Is_All_Ones
import X86.Helpers.Std.Bits.Is_Zero
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

def FP87.Convert_To_Float
    (x : F80_Type) (N : Int) :
    Runtime.SpecM Exception (State σ) (Bits N × Bool × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 32 || N == 64)

  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  -- set when any bit of the source significand is discarded by the conversion
  let mut inexact : Bool := false

  let mut sign : Runtime.Bit := F80_Type.Sign x

  let E : Int := if N == 64 then 11 else 8

  let M : Int := N - E - 1
  let lsb_index : Int := 64 - M - 1
  let mut mantissa : Bits ((63 : Int) + (- lsb_index)) ← do
    Runtime.assert (decide (lsb_index ≤ 63))
    pure (BitVec.cast (by omega) (← (F80_Type.Mantissa x)[62:lsb_index]) : Bits ((63 : Int) + (- lsb_index)))

  let mut lsb : Runtime.Bit ← (F80_Type.Mantissa x)[lsb_index +: 1]
  let mut round_bit : Runtime.Bit ← (F80_Type.Mantissa x)[lsb_index - 1 +: 1]
  let mut sticky : Runtime.Bit ← Bit (not (← Std.Bits.Is_Zero (size := (lsb_index + (-1 : Int))) (BitVec.cast (by omega) (← (F80_Type.Mantissa x)[lsb_index - 2:0]) : Bits (lsb_index + (-1 : Int)))))

  let mut exponent : Bits E ←
    match (← FP87.Classify x) with
    | FP87_Class_Type.FP87_Class_Unsupported => do
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      -- set value to real indefinite (a QNaN)
      sign := 1
      let exponent : Bits E ← Std.Bits.All_Ones E
      mantissa := (BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (M - (1 : Int))) (1 : Runtime.Bit) (← Std.Bits.Zero (M - 1))) : Bits ((63 : Int) + (- lsb_index)))
      pure exponent

    | FP87_Class_Type.FP87_Class_SNaN => do
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      let exponent : Bits E ← Std.Bits.All_Ones E
      let __check138 : Int := M - 1
      Runtime.assert (decide (__check138 < 63 + - lsb_index))
      Runtime.assert (decide (0 ≤ __check138))
      mantissa := (← setSliceChecked mantissa __check138 1 1)
      pure exponent

    | FP87_Class_Type.FP87_Class_QNaN | FP87_Class_Type.FP87_Class_Infinity => do
      pure (← Std.Bits.All_Ones E)

    | FP87_Class_Type.FP87_Class_Zero => do
      pure (← Std.Bits.Zero E)

    | FP87_Class_Type.FP87_Class_Denormal => do
      exceptions := FP_Exception_Flags_Type.setUE exceptions (1 : Runtime.Bit)
      let exponent : Bits E ← Std.Bits.Zero E
      mantissa := (BitVec.cast (by omega) (← Std.Bits.Zero M) : Bits ((63 : Int) + (- lsb_index)))
      rounded_up := (← FP87.Is_Round_Up (F80_Type.Sign x) 0 0 1)
      if rounded_up then
        mantissa := mantissa + (BitVec.cast (by omega) (← (1 : Int)[0 +: M]) : Bits ((63 : Int) + (- lsb_index)))
      -- the whole significand is discarded when flushing to the target zero/min denormal
      inexact := not (← Std.Bits.Is_Zero (size := 64) (F80_Type.Mantissa x))
      if (not (← FP87.Is_Unmasked_Exception exceptions (← FP87_Control.Exception_Masks)) and inexact) then
        exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
      pure exponent

    | FP87_Class_Type.FP87_Class_Normal => do
      let f80_bias : Int := Unsigned (16383 : Bits 16)
      let float_bias : Int := if N == 64 then Unsigned (1023 : Bits 12) else Unsigned (127 : Bits 8)
      let unbiased_exponent : Int := Unsigned (F80_Type.Exponent x) - f80_bias
      let min_normal_exp : Int := 0 - float_bias + 1

      let exponent : Bits E ← do
        if decide (unbiased_exponent > float_bias) then
          -- overflow to infinity
          exceptions := FP_Exception_Flags_Type.setOE exceptions (1 : Runtime.Bit)
          if ((← FP87_Control.OM) == 1) then
            rounded_up := (← FP87.Is_Round_Up (F80_Type.Sign x) 1 1 1)
          let exponent : Bits E ← do
            if rounded_up then
              let exponent : Bits E ← Std.Bits.All_Ones E
              mantissa := (BitVec.cast (by omega) (← Std.Bits.Zero M) : Bits ((63 : Int) + (- lsb_index)))
              pure exponent
            else
              let exponent : Bits E := (← Std.Bits.All_Ones E) - (← (1 : Int)[0 +: E])
              mantissa := (BitVec.cast (by omega) (← Std.Bits.All_Ones M) : Bits ((63 : Int) + (- lsb_index)))
              pure exponent
          -- the overflow response never represents the source value exactly
          inexact := true
          pure exponent
        else
          if decide (unbiased_exponent < min_normal_exp) then
            let mut exponent : Bits E ← Std.Bits.Zero E
            let tiny : Bool := decide (unbiased_exponent < min_normal_exp - 1) or not ((← Std.Bits.Is_All_Ones (size := ((63 : Int) + (- lsb_index))) mantissa) and (← FP87.Is_Round_Up (F80_Type.Sign x) lsb round_bit sticky))
            let shift_count : Int := lsb_index + 1 - float_bias - unbiased_exponent
            if (decide (shift_count < 64)) then
              let temp : Bits 64 ← Std.Bits.Shift_Right_Logical (size := 64) (F80_Type.Mantissa x) shift_count
              mantissa := (BitVec.cast (by omega) (← temp[0 +: M]) : Bits ((63 : Int) + (- lsb_index)))
              lsb := (← (do Runtime.assert (decide (0 < 63 + - lsb_index)); pure (← mantissa[0 +: 1])))
              round_bit := (← (F80_Type.Mantissa x)[shift_count - 1 +: 1])
              sticky := if not (← Std.Bits.Is_Zero (size := (shift_count + (-1 : Int))) (BitVec.cast (by omega) (← (F80_Type.Mantissa x)[shift_count - 2:0]) : Bits (shift_count + (-1 : Int)))) then 1 else 0
            else
              mantissa := (BitVec.cast (by omega) (← Std.Bits.Zero M) : Bits ((63 : Int) + (- lsb_index)))
              lsb := 0
              round_bit := (← (do if shift_count == 64 then pure (← (F80_Type.Mantissa x)[63 +: 1]) else pure 0))
              sticky := (← (do if shift_count == 64 then pure (if not (← Std.Bits.Is_Zero (size := 63) (← (F80_Type.Mantissa x)[62:0])) then 1 else 0) else pure 1))
            rounded_up := (← FP87.Is_Round_Up (F80_Type.Sign x) lsb round_bit sticky)
            if rounded_up then
              if (← Std.Bits.Is_All_Ones (size := ((63 : Int) + (- lsb_index))) mantissa) then
                exponent := (← (1 : Int)[0 +: E])
                mantissa := (BitVec.cast (by omega) (← Std.Bits.Zero M) : Bits ((63 : Int) + (- lsb_index)))
              else
                mantissa := mantissa + (BitVec.cast (by omega) (← (1 : Int)[0 +: M]) : Bits ((63 : Int) + (- lsb_index)))
            inexact := round_bit == 1 or sticky == 1
            if (tiny and ((← FP87_Control.UM) == 0 or round_bit == 1 or sticky == 1)) then
              exceptions := FP_Exception_Flags_Type.setUE exceptions (1 : Runtime.Bit)
            pure exponent
          else
            let mut exponent : Bits E := (← unbiased_exponent[0 +: E]) + (← float_bias[0 +: E])
            rounded_up := (← FP87.Is_Round_Up (F80_Type.Sign x) lsb round_bit sticky)
            if rounded_up then
              if (← Std.Bits.Is_All_Ones (size := ((63 : Int) + (- lsb_index))) mantissa) then
                exponent := exponent + (← (1 : Int)[0 +: E])
                mantissa := (BitVec.cast (by omega) (← Std.Bits.Zero M) : Bits ((63 : Int) + (- lsb_index)))
                -- Check if the incremented exponent overflowed to all-ones (infinity)
                if (← Std.Bits.Is_All_Ones (size := E) exponent) then
                  exceptions := FP_Exception_Flags_Type.setOE exceptions (1 : Runtime.Bit)
              else
                mantissa := mantissa + (BitVec.cast (by omega) (← (1 : Int)[0 +: M]) : Bits ((63 : Int) + (- lsb_index)))
            -- the result is inexact if any discarded bit is set, even on an
            -- exact tie that rounds to even (round_bit set, sticky clear)
            inexact := round_bit == 1 or sticky == 1
            pure exponent

      if (not (← FP87.Is_Unmasked_Exception exceptions (← FP87_Control.Exception_Masks)) and inexact) then
        exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
      pure exponent

  let result : Bits N := (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + E)) (rightSize := ((63 : Int) + (- lsb_index))) (← concatBits (leftSize := 1) (rightSize := E) sign exponent) mantissa) : Bits N)
  return (result, rounded_up, exceptions)

end X86.Helpers
