-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: c3b2faf87d43b85d9f3f518b25fefefc85d9e7f478e31e4951d9350754375fcd
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Integer.Power2
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Integer.Exp (left right : Int) : Except (Runtime.Error Empty) (Int) := do
  if (left == 2) then
    return (← Std.Integer.Power2 right)
  else
    Runtime.assert (decide (right ≥ 0))
    let mut result : Int := 1
    for _i in intRange (1 : Int) right do
      result := result * left
    return result

scoped infix:80 " ** " => Std.Integer.Exp

end X86.Helpers
