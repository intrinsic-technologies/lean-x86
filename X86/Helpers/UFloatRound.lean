-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 8ad5275178dd19b9896c438f413d22de3f7b1395a692d8856e189f16c3f64424
import X86.Runtime
import X86.Helpers.BinaryFloat_Multiply
import X86.Helpers.Rounding_Mode
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatMul
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Temporary local body for a missing Intel library function; replace with
-- authoritative Intel source when available.
-- Local widening, narrowing and NaN quieting for binary32/binary64.
-- Intel SDM Vol. 1 Table D-11 specifies sign/payload preservation and NaN quieting.
def UFloatRound {Ex : Int} {Nx : Int} {Er : Int} {Nr : Int}
    (x : UFloat Ex Nx) (ctx : RoundingContext Er Nr) :
    Except (Runtime.Error Empty) (UFloat Er Nr) := do
  Runtime.assert (0 ≤ Ex)
  Runtime.assert (0 ≤ Nx)
  Runtime.assert (0 ≤ Er)
  Runtime.assert (0 ≤ Nr)

  if (Ex == Er and Nx == Nr) then
    Runtime.assert (← UFloatIsNaN (E := Ex) (N := Nx) x)
    let quiet : Bits ((1 : Int) + (Nx - (1 : Int))) ← concatBits (leftSize := 1) (rightSize := (Nx - (1 : Int))) (← Bit x.sign) (x.magnitude or (BitVec.cast (by omega) (← concatBits (leftSize := (Ex + (1 : Int))) (rightSize := ((Nx - Ex) - (2 : Int))) (← concatBits (leftSize := Ex) (rightSize := 1) (← Std.Bits.Zero Ex) (1 : Runtime.Bit)) (← Std.Bits.Zero (Nx - Ex - 2))) : Bits (Nx - (1 : Int))))
    return (← BinaryFloat_Produced Er Nr (← (do Runtime.assert (decide (Nr ≤ 1 + (Nx - 1))); pure (← quiet[0 +: Nr]))) false false false false false)
  if (Ex == 11 and Nx == 64 and Er == 8 and Nr == 32) then
    if ((← UFloatIsNaN (E := Ex) (N := Nx) x) or (← UFloatIsInfinite (E := Ex) (N := Nx) x)) then
      let fraction : Bits 23 ← do
        Runtime.assert (decide (52 ≤ Nx - 1))
        pure (← x.magnitude[29 +: 23])
      let quiet_mask : Bits 23 ← concatBits (leftSize := 1) (rightSize := 22) (1 : Runtime.Bit) (← Std.Bits.Zero 22)
      let quiet_fraction : Bits 23 ← do
        if (← UFloatIsNaN (E := Ex) (N := Nx) x) then
          pure (fraction or quiet_mask)
        else
          pure fraction
      let bits : Bits 32 ← concatBits (leftSize := 9) (rightSize := 23) (← concatBits (leftSize := 1) (rightSize := 8) (← Bit x.sign) (← Std.Bits.All_Ones 8)) quiet_fraction
      return (← BinaryFloat_Produced Er Nr (← (do Runtime.assert (decide (Nr ≤ 1 + 8 + 23)); pure (← bits[0 +: Nr]))) false false false false false)
    let exponent : Int := Unsigned (← (do Runtime.assert (decide (63 ≤ Nx - 1)); pure (← x.magnitude[52 +: 11])))
    let significand : Int := Unsigned (← (do Runtime.assert (decide (52 ≤ Nx - 1)); pure (← x.magnitude[0 +: 52]))) + (← (do if exponent == 0 then pure (0 : Int) else pure (← (2 : Int) ** (52 : Int))))
    let power : Int := (if exponent == 0 then (1 : Int) else exponent) - 1023 - 52
    let rc : Bits 2 ← do
      if (← (do
  let operand := ctx.rm
  let operand_1 := some Rounding_Mode.Rounding_Mode_RNE
  let value ← Runtime.readInitialized operand
  let value_1 ← Runtime.readInitialized operand_1
  pure (value == value_1))) then
        pure 0
      else
        if (← (do
  let operand_2 := ctx.rm
  let operand_3 := some Rounding_Mode.Rounding_Mode_RTN
  let value_2 ← Runtime.readInitialized operand_2
  let value_3 ← Runtime.readInitialized operand_3
  pure (value_2 == value_3))) then
          pure 1
        else
          if (← (do
  let operand_4 := ctx.rm
  let operand_5 := some Rounding_Mode.Rounding_Mode_RTP
  let value_4 ← Runtime.readInitialized operand_4
  let value_5 ← Runtime.readInitialized operand_5
  pure (value_4 == value_5))) then
            pure 2
          else
            pure 3
    let (bits, overflow, underflow, inexact, precision_loss) ← BinaryFloat_Round (E := Er) (N := Nr) (width := 53) (← significand[0 +: 53]) (1 : Bits 53) power (← Bit x.sign) rc ctx
    let tiny : Bool := (← Std.Bits.Is_Zero (size := 8) (← (do Runtime.assert (decide (31 ≤ Nr)); pure (← bits[23 +: 8])))) and not (← Std.Bits.Is_Zero (size := 23) (← bits[0 +: 23]))
    let report_underflow : Bool := underflow or tiny and not ctx.mask_underflow
    let report_inexact : Bool := if overflow and not ctx.mask_overflow or report_underflow and not ctx.mask_underflow then precision_loss else inexact
    return (← BinaryFloat_Produced Er Nr bits overflow report_underflow report_inexact precision_loss false)
  Runtime.assert (Ex == 8 and Nx == 32 and Er == 11 and Nr == 64)
  let source_fraction_size : Int := Nx - Ex - 1
  let result_fraction_size : Int := Nr - Er - 1
  let source_bias : Int := (← (2 : Int) ** (Ex - 1)) - 1
  let result_bias : Int := (← (2 : Int) ** (Er - 1)) - 1
  let source_exponent : Int := Unsigned (← (do Runtime.assert (decide (source_fraction_size + Ex ≤ Nx - 1)); Runtime.assert (decide (0 ≤ source_fraction_size)); pure (← x.magnitude[source_fraction_size +: Ex])))
  let source_fraction : Bits source_fraction_size ← do
    Runtime.assert (decide (source_fraction_size ≤ Nx - 1))
    Runtime.assert (decide (0 ≤ source_fraction_size))
    pure (← x.magnitude[0 +: source_fraction_size])
  let (exponent, fraction) : (Int × Int) ← do
    if source_exponent == 0 then
      let (exponent, fraction) : (Int × Int) ← do
        if (← Std.Bits.Is_Zero (size := source_fraction_size) source_fraction) then
          let exponent : Int := 0
          let fraction : Int := 0
          pure (exponent, fraction)
        else
          let leading : Int := source_fraction_size - 1 - (← Std.Bits.Count_Leading_Zero_Bits (size := source_fraction_size) source_fraction)
          let exponent : Int := leading + 1 - source_bias - source_fraction_size + result_bias
          let fraction : Int := (Unsigned source_fraction - (← (2 : Int) ** leading)) * (← (2 : Int) ** (result_fraction_size - leading))
          pure (exponent, fraction)
      pure (exponent, fraction)
    else
      if source_exponent == (← (2 : Int) ** Ex) - 1 then
        let exponent : Int := (← (2 : Int) ** Er) - 1
        let mut fraction : Int := Unsigned source_fraction * (← (2 : Int) ** (result_fraction_size - source_fraction_size))
        if (not (← Std.Bits.Is_Zero (size := source_fraction_size) source_fraction) and (← (do Runtime.assert (decide (source_fraction_size - 1 < source_fraction_size)); Runtime.assert (decide (0 ≤ source_fraction_size - 1)); pure (← source_fraction[source_fraction_size - 1 +: 1]))) == 0) then
          fraction := fraction + (← (2 : Int) ** (result_fraction_size - 1))
        pure (exponent, fraction)
      else
        let exponent : Int := source_exponent - source_bias + result_bias
        let fraction : Int := Unsigned source_fraction * (← (2 : Int) ** (result_fraction_size - source_fraction_size))
        pure (exponent, fraction)
  let mut result_overflow : Option (Bool) := none
  let mut result_underflow : Option (Bool) := none
  let mut result_inexact : Option (Bool) := none
  let mut result_inexact_significand : Option (Bool) := none
  let mut result_invalid : Option (Bool) := none
  let result_sign : Bool := x.sign
  let result_magnitude : Bits (Nr - (1 : Int)) := (BitVec.cast (by omega) (← concatBits (leftSize := Er) (rightSize := result_fraction_size) (← exponent[0 +: Er]) (← fraction[0 +: result_fraction_size])) : Bits (Nr - (1 : Int)))
  -- Widening introduces no range loss or rounding loss, including NaN payloads.
  result_overflow := some false
  result_underflow := some false
  result_inexact := some false
  result_inexact_significand := some false
  let result_isnan : Bool := source_exponent == (← (2 : Int) ** Ex) - 1 and not (← Std.Bits.Is_Zero (size := source_fraction_size) source_fraction)
  let result_isinf : Bool := source_exponent == (← (2 : Int) ** Ex) - 1 and (← Std.Bits.Is_Zero (size := source_fraction_size) source_fraction)
  return ({
    sign := result_sign,
    magnitude := result_magnitude,
    overflow := result_overflow,
    underflow := result_underflow,
    inexact := result_inexact,
    inexact_significand := result_inexact_significand,
    invalid := result_invalid,
    isnan := result_isnan,
    isinf := result_isinf
  } : UFloat Er Nr)

def UFloatIsInexact {E : Int} {N : Int}
    (x : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  -- This local predicate, standing in for a missing Intel library function,
  -- observes producer-initialized status.
  if (← Runtime.readInitialized x.inexact) then
    return true
  else
    return false

end X86.Helpers
