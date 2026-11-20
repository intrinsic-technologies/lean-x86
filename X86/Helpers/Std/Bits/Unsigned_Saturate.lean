-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: e1bb5de6d613145db6300bcf85da2c36b0b5e24a7a42450f931bfe6b0f2c3372
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Integer.Exp
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Unsigned_Saturate (x size : Int) : Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (0 ≤ size)

  let r : Int ← do
    if decide (x ≥ (← (2 : Int) ** size)) then
      pure ((← (2 : Int) ** size) - 1)
    else
      if decide (x < 0) then
        pure 0
      else
        pure x
  return (← r[0 +: size])

end X86.Helpers
