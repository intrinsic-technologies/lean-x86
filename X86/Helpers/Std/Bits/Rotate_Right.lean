-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 0a5eaa4ad395e036ff2534296db4c093375e5e2398f543308cf7600074074cc4
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Rotate_Right {size : Int}
    (x : Bits size) (amount : Int) :
    Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (0 ≤ size)

  let distance : Int ← Std.Integer.Positive_Remainder amount size
  return (← (do Runtime.assert (decide (distance + size ≤ size + size)); Runtime.assert (decide (0 ≤ distance)); pure (← Runtime.CheckedSlice.read (← concatBits (leftSize := size) (rightSize := size) x x) distance size)))

end X86.Helpers
