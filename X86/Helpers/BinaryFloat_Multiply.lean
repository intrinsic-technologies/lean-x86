-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 713e7b1cfb71f6238694b6403777518005a416f04013d244057464b0fff70bb7
import X86.Runtime
import X86.Helpers.Emulate_Round_Rational
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Std.Integer.Truncated_Divide
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

def BinaryFloat_Round {E : Int} {N : Int} {width : Int}
    (numerator denominator : Bits width) (exponent : Int) (sign : Runtime.Bit) (rc : Bits 2) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (Bits N × Bool × Bool × Bool × Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)
  Runtime.assert (0 ≤ width)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  let fraction_size : Int := N - E - 1
  let bias : Int := (← (2 : Int) ** (E - 1)) - 1
  Runtime.assert (decide (width > 0) and not (← Std.Bits.Is_Zero (size := width) denominator))
  if (← Std.Bits.Is_Zero (size := width) numerator) then
    return ((BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) sign (← Std.Bits.Zero (N - 1))) : Bits N), false, false, false, false)
  let n : Int := Unsigned numerator
  let d : Int := Unsigned denominator
  let mut leading : Int := (← Std.Bits.Count_Leading_Zero_Bits (size := width) denominator) - (← Std.Bits.Count_Leading_Zero_Bits (size := width) numerator)
  if (← (do if decide (leading ≥ 0) then pure (decide (n < d * (← (2 : Int) ** leading))) else pure (decide (n * (← (2 : Int) ** (- leading)) < d)))) then
    leading := leading - 1
  let exact_exponent : Int := leading + exponent
  let (initial, _, precision_loss) ← Emulate_Round_Rational n d (exact_exponent - fraction_size - exponent) rc sign
  let mut normal : Int := initial
  let mut rounded_exponent : Int := exact_exponent
  if (normal == (← (2 : Int) ** (fraction_size + 1))) then
    normal := (← Std.Integer.Truncated_Divide normal 2)
    rounded_exponent := rounded_exponent + 1
  if (decide (rounded_exponent > bias)) then
    let infinity : Bool := rc == 0 or rc == 1 and sign == 1 or rc == 2 and sign == 0
    let magnitude : Int ← do
      if infinity then
        pure (((← (2 : Int) ** E) - 1) * (← (2 : Int) ** fraction_size))
      else
        pure (((← (2 : Int) ** E) - 1) * (← (2 : Int) ** fraction_size) - 1)
    return ((BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) sign (← magnitude[0 +: N - 1])) : Bits N), true, false, true, precision_loss)
  else
    if (decide (rounded_exponent < - (bias - 1))) then
      if (← Runtime.readInitialized ctx.flush_subnormals) then
        return ((BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) sign (← Std.Bits.Zero (N - 1))) : Bits N), false, true, true, precision_loss)
      let (subnormal, _, inexact) ← Emulate_Round_Rational n d (- (bias - 1 + fraction_size) - exponent) rc sign
      return ((BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) sign (← subnormal[0 +: N - 1])) : Bits N), false, inexact, inexact, precision_loss)
    else
      let encoded : Int := (rounded_exponent + bias) * (← (2 : Int) ** fraction_size) + normal - (← (2 : Int) ** fraction_size)
      return ((BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (N - (1 : Int))) sign (← encoded[0 +: N - 1])) : Bits N), false, false, precision_loss, precision_loss)

-- Finite inputs include signed zero and subnormals. DAZ belongs to XML Unpack.
def BinaryFloat_Multiply {E : Int} {N : Int}
    (x y : Bits N) (rc : Bits 2) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (Bits N × Bool × Bool × Bool × Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  let fraction_size : Int := N - E - 1
  let bias : Int := (← (2 : Int) ** (E - 1)) - 1
  let xe : Int := Unsigned (← x[fraction_size +: E])
  let ye : Int := Unsigned (← y[fraction_size +: E])
  Runtime.assert (xe != (← (2 : Int) ** E) - 1 and ye != (← (2 : Int) ** E) - 1)
  let xm : Int := Unsigned (← x[0 +: fraction_size]) + (← (do if xe == 0 then pure (0 : Int) else pure (← (2 : Int) ** fraction_size)))
  let ym : Int := Unsigned (← y[0 +: fraction_size]) + (← (do if ye == 0 then pure (0 : Int) else pure (← (2 : Int) ** fraction_size)))
  let exponent : Int := (if xe == 0 then (1 : Int) else xe) + (if ye == 0 then (1 : Int) else ye) - 2 * (bias + fraction_size)
  let product : Int := xm * ym
  let product_width : Int := 2 * (fraction_size + 1)
  let one : Bits product_width ← (1 : Int)[0 +: product_width]
  return (← BinaryFloat_Round (E := E) (N := N) (width := product_width) (← product[0 +: product_width]) one exponent ((← x[N - 1 +: 1]) xor (← y[N - 1 +: 1])) rc ctx)

def BinaryFloat_Add {E : Int} {N : Int}
    (x y : Bits N) (subtract : Bool) (rc : Bits 2) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (Bits N × Bool × Bool × Bool × Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  let fraction_size : Int := N - E - 1
  let bias : Int := (← (2 : Int) ** (E - 1)) - 1
  let xe : Int := Unsigned (← x[fraction_size +: E])
  let ye : Int := Unsigned (← y[fraction_size +: E])
  Runtime.assert (xe != (← (2 : Int) ** E) - 1 and ye != (← (2 : Int) ** E) - 1)
  let xm : Int := Unsigned (← x[0 +: fraction_size]) + (← (do if xe == 0 then pure (0 : Int) else pure (← (2 : Int) ** fraction_size)))
  let ym : Int := Unsigned (← y[0 +: fraction_size]) + (← (do if ye == 0 then pure (0 : Int) else pure (← (2 : Int) ** fraction_size)))
  let ex : Int := if xe == 0 then 1 else xe
  let ey : Int := if ye == 0 then 1 else ye
  let base : Int := if decide (ex < ey) then ex else ey
  let sx : Runtime.Bit ← x[N - 1 +: 1]
  let sy : Runtime.Bit ← do
    if subtract then
      pure (~~~ (← y[N - 1 +: 1]))
    else
      y[N - 1 +: 1]
  let a : Int := xm * (← (2 : Int) ** (ex - base))
  let b : Int := ym * (← (2 : Int) ** (ey - base))
  let exact : Int := (if sx == 1 then - a else a) + (if sy == 1 then - b else b)
  let sign : Runtime.Bit := if exact == 0 then if sx == sy then sx else if rc == 1 then 1 else 0 else if decide (exact < 0) then 1 else 0
  let magnitude : Int := if decide (exact < 0) then - exact else exact
  -- Maximum finite exponent separation plus significand and carry.
  let width : Int := (← (2 : Int) ** E) - 3 + fraction_size + 2
  let one : Bits width ← (1 : Int)[0 +: width]
  return (← BinaryFloat_Round (E := E) (N := N) (width := width) (← magnitude[0 +: width]) one (base - bias - fraction_size) sign rc ctx)

def BinaryFloat_Divide {E : Int} {N : Int}
    (x y : Bits N) (rc : Bits 2) (ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (Bits N × Bool × Bool × Bool × Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  let fraction_size : Int := N - E - 1
  let xe : Int := Unsigned (← x[fraction_size +: E])
  let ye : Int := Unsigned (← y[fraction_size +: E])
  Runtime.assert (xe != (← (2 : Int) ** E) - 1 and ye != (← (2 : Int) ** E) - 1)
  let xm : Int := Unsigned (← x[0 +: fraction_size]) + (← (do if xe == 0 then pure (0 : Int) else pure (← (2 : Int) ** fraction_size)))
  let ym : Int := Unsigned (← y[0 +: fraction_size]) + (← (do if ye == 0 then pure (0 : Int) else pure (← (2 : Int) ** fraction_size)))
  Runtime.assert (ym != 0)
  let exponent : Int := (if xe == 0 then (1 : Int) else xe) - (if ye == 0 then (1 : Int) else ye)
  return (← BinaryFloat_Round (E := E) (N := N) (width := (fraction_size + (1 : Int))) (← xm[0 +: fraction_size + 1]) (← ym[0 +: fraction_size + 1]) exponent ((← x[N - 1 +: 1]) xor (← y[N - 1 +: 1])) rc ctx)

end X86.Helpers
