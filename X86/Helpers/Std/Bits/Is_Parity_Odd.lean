-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 5aa94ce3e9f28be0b3573adf2386488f1e8b1f8c1b7a8dc4b714dc562cf268ec
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Bits.Is_Parity_Odd {size : Int} (x : Bits size) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ size)

  let mut r : Runtime.Bit := 0
  for i in intRange (0 : Int) (size - 1) do
    r := r xor (← x[i +: 1])
  return r == 1

end X86.Helpers
