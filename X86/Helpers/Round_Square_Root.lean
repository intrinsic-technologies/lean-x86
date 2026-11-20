-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 250a2c5930e70d39bf8af0acdbfd5cf998cbaf9764641bc4fea8058e47d65097
import X86.Runtime
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Truncated_Divide
import X86.Helpers.Std.Integer.Truncated_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Exact positive square-root rounding shared by binary and x87 formats.
-- The value is magnitude * 2^input_exponent. Integer comparisons select each
-- significand bit, then round once under SDM Vol. 1 Section 4.8.4.
def Round_Square_Root {width : Int}
    (magnitude : Bits width) (input_exponent : Int) (precision : Int) (rc : Bits 2) :
    Except (Runtime.Error Empty) (Int × Int × Bool × Bool) := do
  Runtime.assert (0 ≤ width)
  Runtime.assert (precision in {1..64})

  Runtime.assert (not (← Std.Bits.Is_Zero (size := width) magnitude))
  let leading : Int := width - 1 - (← Std.Bits.Count_Leading_Zero_Bits (size := width) magnitude)
  let value_exponent : Int := input_exponent + leading
  -- Floor division by two, including negative odd exponents.
  let mut exponent : Int ← do
    if decide (value_exponent ≥ 0) then
      Std.Integer.Truncated_Divide value_exponent 2
    else
      pure (- (← Std.Integer.Truncated_Divide (1 - value_exponent) 2))
  let target : Int := exponent - (precision - 1)
  let shift : Int := input_exponent - 2 * target
  let numerator : Int := Unsigned magnitude * (← (do if decide (shift ≥ 0) then pure (← (2 : Int) ** shift) else pure (1 : Int)))
  let denominator : Int ← do
    if decide (shift ≥ 0) then
      pure 1
    else
      (2 : Int) ** (- shift)
  let mut root : Int := 0
  -- Select each result bit. The loop takes at most 64 iterations.
  for bit in intRangeDown (precision - 1) (0 : Int) do
    let candidate : Int := root + (← (2 : Int) ** bit)
    if (decide (candidate * candidate * denominator ≤ numerator)) then
      root := candidate
  let inexact : Bool := root * root * denominator != numerator
  let midpoint : Int := (2 * root + 1) * (2 * root + 1) * denominator
  let increment : Bool := rc == 0 and (decide (4 * numerator > midpoint) or 4 * numerator == midpoint and (← Std.Integer.Truncated_Remainder root 2) == 1) or rc == 2 and inexact
  if increment then
    root := root + 1
  if (root == (← (2 : Int) ** precision)) then
    root := (← Std.Integer.Truncated_Divide root 2)
    exponent := exponent + 1
  return (root, exponent, inexact, increment)

end X86.Helpers
