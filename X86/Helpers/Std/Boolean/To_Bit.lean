-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 784e3670bb2e03f55e3213e547c96e34e1368511c4e3cfa1f081d0c97ecaebaa
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Boolean.To_Bit (x : Bool) : Except (Runtime.Error Empty) (Runtime.Bit) := do
  return if x then 1 else 0

end X86.Helpers
