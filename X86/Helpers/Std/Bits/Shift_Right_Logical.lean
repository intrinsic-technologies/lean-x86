-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: e5bacc96460538fab567ab63faee4bd09ca10dd1216b50eaea31128394563b12
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Bits.Shift_Right_Logical_Restricted
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Shift_Right_Logical {size : Int}
    (x : Bits size) (amount : Int) :
    Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (0 ≤ size)

  if (decide (amount < size)) then
    return (← Std.Bits.Shift_Right_Logical_Restricted (size := size) x amount)
  else
    return (← Std.Bits.Zero size)

end X86.Helpers
