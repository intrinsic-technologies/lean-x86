-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: c090f198645556f22b16801dc460cf8a33e1cad17d3740250a4c7e8ecc06a04e
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

open scoped X86.Runtime.PartialSyntax in

def Std.Integer.Log2 (a : Int) : Runtime.PartialResult Empty (Int) := do
  Runtime.assert (1 ≤ a)

  Runtime.assert (decide (Nat.isPowerOfTwo (Int.toNat a)))
  let mut b : Int := a
  let mut r : Int := 0
  while decide (b > 1) do
    b := (← Std.Integer.Positive_Divide b 2)
    r := r + 1
  return r

end X86.Helpers
