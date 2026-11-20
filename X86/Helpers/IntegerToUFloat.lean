-- Generated from a local ISA specification; do not edit.
-- Source SHA256: cd4042d3c4c6383ce650098f27072182af37d76e1704ad985c98df33943efc04
import X86.Runtime
import X86.Helpers.BinaryFloat_Multiply
import X86.Helpers.Rounding_Mode
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatMul
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Intel declares SignedToUFloat and UnsignedToUFloat without bodies.
-- Convert exact integers through the shared binary32/binary64 rounding operation.
-- Intel's instruction bodies retain exception handling and destination writes.
def IntegerToUFloat {E : Int} {N : Int} {width : Int}
    (ctx : RoundingContext E N) (x : Bits width) (is_signed : Bool) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)
  Runtime.assert (0 ≤ width)

  Runtime.assert (width == 16 or width == 32 or width == 64)
  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  let value : Int := if is_signed then Signed x else Unsigned x
  let sign : Bool := decide (value < 0)
  let magnitude : Int := if sign then - value else value
  let rc : Bits 2 ← do
    if (← (do
  let operand := ctx.rm
  let operand_1 := some Rounding_Mode.Rounding_Mode_RNE
  let value_1 ← Runtime.readInitialized operand
  let value_2 ← Runtime.readInitialized operand_1
  pure (value_1 == value_2))) then
      pure 0
    else
      if (← (do
  let operand_2 := ctx.rm
  let operand_3 := some Rounding_Mode.Rounding_Mode_RTN
  let value_3 ← Runtime.readInitialized operand_2
  let value_4 ← Runtime.readInitialized operand_3
  pure (value_3 == value_4))) then
        pure 1
      else
        if (← (do
  let operand_4 := ctx.rm
  let operand_5 := some Rounding_Mode.Rounding_Mode_RTP
  let value_5 ← Runtime.readInitialized operand_4
  let value_6 ← Runtime.readInitialized operand_5
  pure (value_5 == value_6))) then
          pure 2
        else
          pure 3
  let (bits, overflow, underflow, inexact, precision_loss) ← BinaryFloat_Round (E := E) (N := N) (width := width) (← magnitude[0 +: width]) (← (1 : Int)[0 +: width]) 0 (← Bit sign) rc ctx
  return (← BinaryFloat_Produced E N bits overflow underflow inexact precision_loss false)

def SignedToUFloat {E : Int} {N : Int} {width : Int}
    (ctx : RoundingContext E N) (x : Bits width) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)
  Runtime.assert (0 ≤ width)

  return (← IntegerToUFloat (E := E) (N := N) (width := width) ctx x true)

def UnsignedToUFloat {E : Int} {N : Int} {width : Int}
    (ctx : RoundingContext E N) (x : Bits width) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)
  Runtime.assert (0 ≤ width)

  return (← IntegerToUFloat (E := E) (N := N) (width := width) ctx x false)

end X86.Helpers
