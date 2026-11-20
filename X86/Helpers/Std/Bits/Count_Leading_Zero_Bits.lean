-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 324355d9432ae82353e6c75c130c88ce74b7140aa0b77eb600c4ab23438f12e6
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Bits.Count_Leading_Zero_Bits {size : Int}
    (x : Bits size) :
    Except (Runtime.Error Empty) (Int) := do
  Runtime.assert (0 ≤ size)

  for i in intRangeDown (size - 1) (0 : Int) do
    if ((← x[i +: 1]) == 1) then
      return size - i - 1
  return size

end X86.Helpers
