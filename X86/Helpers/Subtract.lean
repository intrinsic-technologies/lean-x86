-- Generated from data/definitions.xml.gz: Subtract; do not edit.
-- Source SHA256: 36e4556d62aea678caedb4054631bb30c24b273702975520042d50e57d3beeda
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Subtract)
import X86.Runtime
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Power2
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Subtract {size : Int}
    (x y : Bits size) (borrow_in : Runtime.Bit := 0) :
    Except (Runtime.Error Empty) (Bits size × Runtime.Bit × Runtime.Bit × Runtime.Bit) := do
  Runtime.assert (0 ≤ size)

  let unsigned_diff : Int := Unsigned x - (Unsigned y + Unsigned borrow_in)
  let signed_diff : Int := Signed x - (Signed y + Unsigned borrow_in)
  let result : Bits size ← unsigned_diff[0 +: size]

  let carry_out : Runtime.Bit := if Unsigned result == unsigned_diff then 0 else 1
  let overflow : Runtime.Bit := if Signed result == signed_diff then 0 else 1

  -- Calculation of AF repeats the CF calculation for bits 3:0
  let unsigned_diff4 : Int := Unsigned (← x[3:0]) - (Unsigned (← y[3:0]) + Unsigned borrow_in)
  let result4 : Bits 4 ← unsigned_diff[3:0]
  let alternative_carry : Runtime.Bit := if Unsigned result4 == unsigned_diff4 then 0 else 1

  return (result, carry_out, overflow, alternative_carry)

end X86.Helpers
