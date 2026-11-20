-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: b20c3f66bc90f3bbfa41649547afcba252d273c3fd0e0edbd15b2728b6d60063
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Bits.All_Ones
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Is_All_Ones {size : Int} (x : Bits size) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ size)

  return x == (← Std.Bits.All_Ones size)

end X86.Helpers
