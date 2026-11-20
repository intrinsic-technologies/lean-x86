-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 0ae7272f9e993d88a0126c7c7687e4b62e9fc6c205a20313df3adf9a37408c26
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Integer.Min (left right : Int) : Int :=
  if decide (left ≤ right) then left else right

end X86.Helpers
