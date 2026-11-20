-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 08fc55f45eed4feb33a61ac811ece254e9377a42b3eaacd3bb05663c4d7b55a1
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Bits.Count_Trailing_Zero_Bits {size : Int}
    (x : Bits size) :
    Except (Runtime.Error Empty) (Int) := do
  Runtime.assert (0 ≤ size)

  for i in intRange (0 : Int) (size - 1) do
    if ((← x[i +: 1]) == 1) then
      return i
  return size

end X86.Helpers
