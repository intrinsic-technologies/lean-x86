-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 81631d90cc33a8510696d90589090670887b2e66e772ba8431e9cb59b3f4db94
import X86.Runtime
import X86.Helpers.Round_Square_Root
import X86.Helpers.Rounding_Mode
import X86.Helpers.Std.Bits.All_Ones
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

-- Missing IEEE binary32/binary64 square-root primitive. Intel FP::Sqrt keeps
-- DAZ and exception processing. A positive finite input has a normal finite root.
def UFloatIsQNaN {E : Int} {N : Int} (x : UFloat E N) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← UFloatIsNaN (E := E) (N := N) x) and not (← UFloatIsSNaN (E := E) (N := N) x)

def UFloatSqrt {E : Int} {N : Int}
    (x : UFloat E N) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  let fraction : Int := N - E - 1
  let original : Bits N := (BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) (← Bit x.sign) x.magnitude) : Bits N)
  if (← UFloatIsNaN (E := E) (N := N) x) then
    let quiet : Bits N := (BitVec.cast (by omega) (← concatBits (leftSize := (((1 : Int) + E) + (1 : Int))) (rightSize := (fraction - (1 : Int))) (← concatBits (leftSize := ((1 : Int) + E)) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := E) (0 : Runtime.Bit) (← Std.Bits.Zero E)) (1 : Runtime.Bit)) (← Std.Bits.Zero (fraction - 1))) : Bits N)
    return (← BinaryFloat_Produced E N (original or quiet) false false false false (← UFloatIsSNaN (E := E) (N := N) x))
  else
    if (← UFloatIsZero (E := E) (N := N) x) then
      return (← BinaryFloat_Produced E N original false false false false false)
    else
      if x.sign then
        return (← BinaryFloat_Produced E N (BitVec.cast (by omega) (← concatBits (leftSize := ((E + (1 : Int)) + (1 : Int))) (rightSize := (fraction - (1 : Int))) (← concatBits (leftSize := (E + (1 : Int))) (rightSize := 1) (← Std.Bits.All_Ones (E + 1)) (1 : Runtime.Bit)) (← Std.Bits.Zero (fraction - 1))) : Bits N) false false false false true)
      else
        if (← UFloatIsInfinite (E := E) (N := N) x) then
          return (← BinaryFloat_Produced E N original false false false false false)
  let bias : Int := (← (2 : Int) ** (E - 1)) - 1
  let xe : Int := Unsigned (← (do Runtime.assert (decide (fraction + E ≤ N - 1)); Runtime.assert (decide (0 ≤ fraction)); pure (← x.magnitude[fraction +: E])))
  let significand : Int := Unsigned (← (do Runtime.assert (decide (fraction ≤ N - 1)); Runtime.assert (decide (0 ≤ fraction)); pure (← x.magnitude[0 +: fraction]))) + (← (do if xe == 0 then pure (0 : Int) else pure (← (2 : Int) ** fraction)))
  let input_exponent : Int := (if xe == 0 then (1 : Int) else xe) - bias - fraction
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
  let (root, exponent, inexact, _increment) ← Round_Square_Root (width := (fraction + (1 : Int))) (← significand[0 +: fraction + 1]) input_exponent (fraction + 1) rc
  let encoded_exponent : Int := exponent + bias
  let bits : Bits N := (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + E)) (rightSize := fraction) (← concatBits (leftSize := 1) (rightSize := E) (0 : Runtime.Bit) (← encoded_exponent[0 +: E])) (← root[0 +: fraction])) : Bits N)
  return (← BinaryFloat_Produced E N bits false false inexact inexact false)

end X86.Helpers
