-- Generated from a local ISA specification; do not edit.
-- Source SHA256: cf51c7f9d6d2a26371d0fe8cc70601b0ef284dfa05fae4593127ff5fc510c0bd
import X86.Runtime
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Truncated_Divide
import X86.Helpers.Std.Integer.Truncated_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Temporary shared primitive for absent floating-point library operations.
-- Exact rational magnitude divided by 2**cut, rounded to an integer.
-- Requirements: magnitude is nonnegative; denominator is positive (checked below).
-- Intel SDM 4.8.4 supplies RC/ties rules; this helper is custom, not XML.
-- Replace this local body if the authoritative missing library becomes available.
def Emulate_Round_Rational
    (magnitude denominator cut : Int) (rc : Bits 2) (sign : Runtime.Bit) :
    Except (Runtime.Error Empty) (Int × Bool × Bool) := do
  Runtime.assert (decide (denominator > 0))
  -- Exact integer scaling needs neither a quotient nor a rounding decision.
  if (denominator == 1 and decide (cut ≤ 0)) then
    return (magnitude * (← (2 : Int) ** (- cut)), false, false)
  let dividend : Int ← do
    if decide (cut ≤ 0) then
      pure (magnitude * (← (2 : Int) ** (- cut)))
    else
      pure magnitude
  let divisor : Int ← do
    if decide (cut ≤ 0) then
      pure denominator
    else
      pure (denominator * (← (2 : Int) ** cut))
  let whole : Int ← Std.Integer.Truncated_Divide dividend divisor
  let remainder : Int ← Std.Integer.Truncated_Remainder dividend divisor
  let half : Int ← Std.Integer.Truncated_Divide divisor 2
  let even : Bool := (← Std.Integer.Truncated_Remainder divisor 2) == 0
  let inexact : Bool := remainder != 0
  let increment : Bool := inexact and (rc == 0 and (decide (remainder > half) or even and remainder == half and (← Std.Integer.Truncated_Remainder whole 2) == 1) or rc == 1 and sign == 1 or rc == 2 and sign == 0)
  return (if increment then whole + 1 else whole, increment, inexact)

end X86.Helpers
