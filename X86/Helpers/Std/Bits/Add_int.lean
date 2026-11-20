-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 1be7b7af94350bbcf7698d770cabb961826a88f4cfa8285900f95de0e58b0b48
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Bits.From_Integer
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Add_int {n : Int}
    (left : Bits n) (right : Int) :
    Except (Runtime.Error Empty) (Bits n) := do
  Runtime.assert (0 ≤ n)

  return left + (← Std.Bits.From_Integer right n)

end X86.Helpers
