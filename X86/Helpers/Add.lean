-- Generated from data/definitions.xml.gz: Add; do not edit.
-- Source SHA256: 177d20d2076def6f2e198ddddf607209f2743c78aa1fb372d6b27875773c4b4b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Add)
import X86.Runtime
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Power2
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Add {size : Int}
    (x y : Bits size) (carry_in : Runtime.Bit := 0) :
    Except (Runtime.Error Empty) (Bits size × Runtime.Bit × Runtime.Bit × Runtime.Bit) := do
  Runtime.assert (0 ≤ size)

  let unsigned_sum : Int := Unsigned x + Unsigned y + Unsigned carry_in
  let signed_sum : Int := Signed x + Signed y + Unsigned carry_in
  let result : Bits size ← unsigned_sum[0 +: size]

  let carry_out : Runtime.Bit := if Unsigned result == unsigned_sum then 0 else 1
  let overflow : Runtime.Bit := if Signed result == signed_sum then 0 else 1

  -- Calculation of alternative_carry repeats the carry_out calculation for bits 3:0
  let unsigned_sum4 : Int := Unsigned (← x[3:0]) + Unsigned (← y[3:0]) + Unsigned carry_in
  let result4 : Bits 4 ← unsigned_sum[3:0]
  let alternative_carry : Runtime.Bit := if Unsigned result4 == unsigned_sum4 then 0 else 1

  return (result, carry_out, overflow, alternative_carry)

end X86.Helpers
