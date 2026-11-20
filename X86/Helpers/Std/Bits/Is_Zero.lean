-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: a2fdb9e810a6a22e3cb72112595e12e9ece8f0d54c859a39a77e8e58998eabd3
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Is_Zero {size : Int} (x : Bits size) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ size)

  return x == (← Std.Bits.Zero size)

end X86.Helpers
