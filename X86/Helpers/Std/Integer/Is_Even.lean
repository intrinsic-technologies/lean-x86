-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: c1c20e10286b4dcd7aacbef1b7dd251e39baf2d9e4e432bf8ea9aada7d4004e9
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Integer.Is_Even (x : Int) : Except (Runtime.Error Empty) (Bool) := do
  return (← x[0 +: 1]) == 0

end X86.Helpers
