-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 66632afd51a9c3743882faa644fd9df19dc3146d187f3b0ef5390e5cad8e1b7c
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Rotate_Left {size : Int}
    (x : Bits size) (amount : Int) :
    Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (0 ≤ size)

  let distance : Int ← Std.Integer.Positive_Remainder amount size
  return (← (do Runtime.assert (decide (size - distance + size ≤ size + size)); Runtime.assert (decide (0 ≤ size - distance)); pure (← Runtime.CheckedSlice.read (← concatBits (leftSize := size) (rightSize := size) x x) (size - distance) size)))

end X86.Helpers
