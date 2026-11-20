-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 2fe960d2411cb1d35e34aa031ae3a882069a37cb71d49638a2f5b9eecf611135
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Bits.Align_Down {size : Int}
    (x : Bits size) (y : Int) :
    Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (0 ≤ size)

  Runtime.assert (decide (Nat.isPowerOfTwo (Int.toNat y)))
  return x and ~~~ (← (y - 1)[0 +: size])

end X86.Helpers
