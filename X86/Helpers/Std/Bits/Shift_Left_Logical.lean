-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 4582a507189a00449d13460c4a0698570e200fdda7ad48d1524faf8bac11e867
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Bits.Shift_Left_Logical_Restricted
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Shift_Left_Logical {size : Int}
    (x : Bits size) (amount : Int) :
    Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (0 ≤ size)
  Runtime.assert (0 ≤ amount)

  if (decide (amount < size)) then
    return (← Std.Bits.Shift_Left_Logical_Restricted (size := size) x amount)
  else
    return (← Std.Bits.Zero size)

end X86.Helpers
