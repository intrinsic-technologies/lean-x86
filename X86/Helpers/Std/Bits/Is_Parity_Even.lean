-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: d7f6bc0772a5d720c045f74d7419053dd73250e216721f3a96f251ec2f5cce88
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Bits.Is_Parity_Even {size : Int}
    (x : Bits size) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ size)

  let mut r : Runtime.Bit := 0
  for i in intRange (0 : Int) (size - 1) do
    r := r xor (← x[i +: 1])
  return r == 0

end X86.Helpers
