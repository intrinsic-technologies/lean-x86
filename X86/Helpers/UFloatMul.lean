-- Generated from a local ISA specification; do not edit.
-- Source SHA256: e57d6c7ae59ff57ddfde820efacde5489c33da1d6e1b250011aeb511ecc1618d
import X86.Runtime
import X86.Helpers.BinaryFloat_Multiply
import X86.Helpers.Rounding_Mode
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Is_All_Ones
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Temporary local body for a missing Intel library function; replace with
-- authoritative Intel source when available.
-- Finite binary32/binary64 arithmetic uses exact integers and rounds once at the target
-- precision. Intel XML retains classification, DAZ and exception processing.

def BinaryFloat_Produced
    (E N : Int) (bits : Bits N) (overflow underflow inexact inexact_significand invalid : Bool) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  let mut result_overflow : Option (Bool) := none
  let mut result_underflow : Option (Bool) := none
  let mut result_inexact : Option (Bool) := none
  let mut result_inexact_significand : Option (Bool) := none
  let mut result_invalid : Option (Bool) := none
  let result_sign : Bool := (← bits[N - 1 +: 1]) == 1
  let result_magnitude : Bits (N - (1 : Int)) ← bits[0 +: N - 1]
  result_overflow := some overflow
  result_underflow := some underflow
  result_inexact := some inexact
  result_inexact_significand := some inexact_significand
  result_invalid := some invalid
  let result_isnan : Bool := (← Std.Bits.Is_All_Ones (size := E) (← bits[N - E - 1 +: E])) and not (← Std.Bits.Is_Zero (size := ((N - E) - (1 : Int))) (← bits[0 +: N - E - 1]))
  let result_isinf : Bool := (← Std.Bits.Is_All_Ones (size := E) (← bits[N - E - 1 +: E])) and (← Std.Bits.Is_Zero (size := ((N - E) - (1 : Int))) (← bits[0 +: N - E - 1]))
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
  } : UFloat E N)

def UFloatMul {E : Int} {N : Int}
    (x y : UFloat E N) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  Runtime.assert (not (← UFloatIsNaN (E := E) (N := N) x) and not (← UFloatIsNaN (E := E) (N := N) y))
  let sign : Runtime.Bit ← Bit (x.sign != y.sign)
  if ((← UFloatIsInfinite (E := E) (N := N) x) or (← UFloatIsInfinite (E := E) (N := N) y)) then
    let invalid : Bool := (← UFloatIsZero (E := E) (N := N) x) or (← UFloatIsZero (E := E) (N := N) y)
    let bits : Bits N ← do
      if invalid then
        pure (BitVec.cast (by omega) (← concatBits (leftSize := ((E + (1 : Int)) + (1 : Int))) (rightSize := ((N - E) - (2 : Int))) (← concatBits (leftSize := (E + (1 : Int))) (rightSize := 1) (← Std.Bits.All_Ones (E + 1)) (1 : Runtime.Bit)) (← Std.Bits.Zero (N - E - 2))) : Bits N)
      else
        pure (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + E)) (rightSize := ((N - E) - (1 : Int))) (← concatBits (leftSize := 1) (rightSize := E) sign (← Std.Bits.All_Ones E)) (← Std.Bits.Zero (N - E - 1))) : Bits N)
    return (← BinaryFloat_Produced E N bits false false false false invalid)
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
  let xb : Bits ((1 : Int) + (N - (1 : Int))) ← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (← Bit x.sign) x.magnitude
  let yb : Bits ((1 : Int) + (N - (1 : Int))) ← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (← Bit y.sign) y.magnitude
  let (bits, overflow, underflow, inexact, significand) ← BinaryFloat_Multiply (E := E) (N := N) (← (do Runtime.assert (decide (N ≤ 1 + (N - 1))); pure (← xb[0 +: N]))) (← (do Runtime.assert (decide (N ≤ 1 + (N - 1))); pure (← yb[0 +: N]))) rc ctx
  return (← BinaryFloat_Produced E N bits overflow underflow inexact significand false)

def UFloatAddSub {E : Int} {N : Int}
    (x y : UFloat E N) (ctx : RoundingContext E N) (subtract : Bool) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  Runtime.assert (not (← UFloatIsNaN (E := E) (N := N) x) and not (← UFloatIsNaN (E := E) (N := N) y))
  let ysign : Bool := if subtract then not y.sign else y.sign
  if ((← UFloatIsInfinite (E := E) (N := N) x) or (← UFloatIsInfinite (E := E) (N := N) y)) then
    let invalid : Bool := (← UFloatIsInfinite (E := E) (N := N) x) and (← UFloatIsInfinite (E := E) (N := N) y) and x.sign != ysign
    let sign : Bool ← do
      if (← UFloatIsInfinite (E := E) (N := N) x) then
        pure x.sign
      else
        pure ysign
    let bits : Bits N ← do
      if invalid then
        pure (BitVec.cast (by omega) (← concatBits (leftSize := ((E + (1 : Int)) + (1 : Int))) (rightSize := ((N - E) - (2 : Int))) (← concatBits (leftSize := (E + (1 : Int))) (rightSize := 1) (← Std.Bits.All_Ones (E + 1)) (1 : Runtime.Bit)) (← Std.Bits.Zero (N - E - 2))) : Bits N)
      else
        pure (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + E)) (rightSize := ((N - E) - (1 : Int))) (← concatBits (leftSize := 1) (rightSize := E) (← Bit sign) (← Std.Bits.All_Ones E)) (← Std.Bits.Zero (N - E - 1))) : Bits N)
    return (← BinaryFloat_Produced E N bits false false false false invalid)
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
  let xb : Bits ((1 : Int) + (N - (1 : Int))) ← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (← Bit x.sign) x.magnitude
  let yb : Bits ((1 : Int) + (N - (1 : Int))) ← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (← Bit y.sign) y.magnitude
  let (bits, overflow, underflow, inexact, significand) ← BinaryFloat_Add (E := E) (N := N) (← (do Runtime.assert (decide (N ≤ 1 + (N - 1))); pure (← xb[0 +: N]))) (← (do Runtime.assert (decide (N ≤ 1 + (N - 1))); pure (← yb[0 +: N]))) subtract rc ctx
  return (← BinaryFloat_Produced E N bits overflow underflow inexact significand false)

def UFloatAdd {E : Int} {N : Int}
    (x y : UFloat E N) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← UFloatAddSub (E := E) (N := N) x y ctx false)

def UFloatSub {E : Int} {N : Int}
    (x y : UFloat E N) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← UFloatAddSub (E := E) (N := N) x y ctx true)

def UFloatDiv {E : Int} {N : Int}
    (x y : UFloat E N) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  Runtime.assert (not (← UFloatIsNaN (E := E) (N := N) x) and not (← UFloatIsNaN (E := E) (N := N) y))
  let sign : Runtime.Bit ← Bit (x.sign != y.sign)
  let invalid : Bool := (← UFloatIsZero (E := E) (N := N) x) and (← UFloatIsZero (E := E) (N := N) y) or (← UFloatIsInfinite (E := E) (N := N) x) and (← UFloatIsInfinite (E := E) (N := N) y)
  if invalid then
    return (← BinaryFloat_Produced E N (BitVec.cast (by omega) (← concatBits (leftSize := ((E + (1 : Int)) + (1 : Int))) (rightSize := ((N - E) - (2 : Int))) (← concatBits (leftSize := (E + (1 : Int))) (rightSize := 1) (← Std.Bits.All_Ones (E + 1)) (1 : Runtime.Bit)) (← Std.Bits.Zero (N - E - 2))) : Bits N) false false false false true)
  else
    if ((← UFloatIsInfinite (E := E) (N := N) x) or (← UFloatIsZero (E := E) (N := N) y)) then
      return (← BinaryFloat_Produced E N (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + E)) (rightSize := ((N - E) - (1 : Int))) (← concatBits (leftSize := 1) (rightSize := E) sign (← Std.Bits.All_Ones E)) (← Std.Bits.Zero (N - E - 1))) : Bits N) false false false false false)
    else
      if (← UFloatIsInfinite (E := E) (N := N) y) then
        return (← BinaryFloat_Produced E N (BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) sign (← Std.Bits.Zero (N - 1))) : Bits N) false false false false false)
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
  let xb : Bits ((1 : Int) + (N - (1 : Int))) ← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (← Bit x.sign) x.magnitude
  let yb : Bits ((1 : Int) + (N - (1 : Int))) ← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (← Bit y.sign) y.magnitude
  let (bits, overflow, underflow, inexact, significand) ← BinaryFloat_Divide (E := E) (N := N) (← (do Runtime.assert (decide (N ≤ 1 + (N - 1))); pure (← xb[0 +: N]))) (← (do Runtime.assert (decide (N ≤ 1 + (N - 1))); pure (← yb[0 +: N]))) rc ctx
  return (← BinaryFloat_Produced E N bits overflow underflow inexact significand false)

end X86.Helpers
