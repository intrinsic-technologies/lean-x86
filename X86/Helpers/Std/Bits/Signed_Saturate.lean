-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: bf2d1b812a3a482b566438ae347bab33a99b8e16dad06bcbfd9acdeadb318e2e
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Integer.Exp
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Signed_Saturate
    (x : Int) (size : Int) :
    Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (1 ≤ size)

  let r : Int ← do
    if decide (x ≥ (← (2 : Int) ** (size - 1))) then
      pure ((← (2 : Int) ** (size - 1)) - 1)
    else
      if decide (x < - (← (2 : Int) ** (size - 1))) then
        pure (- (← (2 : Int) ** (size - 1)))
      else
        pure x
  return (← r[0 +: size])

end X86.Helpers
