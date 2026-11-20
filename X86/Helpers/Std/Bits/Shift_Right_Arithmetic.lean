-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 66aec8f980e353fe6e414bbdfb61bf9090ceed715efe3847f0bb240fd0ce35fb
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Shift_Right_Arithmetic_Restricted
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Std.Bits.Shift_Right_Arithmetic {size : Int}
    (x : Bits size) (amount : Int) :
    Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (0 ≤ size)

  if (decide (amount < size)) then
    return (← Std.Bits.Shift_Right_Arithmetic_Restricted (size := size) x amount)
  else
    if ((← x[size - 1 +: 1]) == 0) then
      return (← Std.Bits.Zero size)
    else
      return (← Std.Bits.All_Ones size)

end X86.Helpers
