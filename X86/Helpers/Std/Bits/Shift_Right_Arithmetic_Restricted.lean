-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 057d81e92ece109f6d59d7f00d36c01088baed04b3b2d989a4a94e36eecc63b6
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The source declares this builtin without an ISA body.
def Std.Bits.Shift_Right_Arithmetic_Restricted {exception : Type} {m : Type → Type}
    [Monad m] [MonadExcept (Runtime.Error exception) m] {size : Int}
    (x : Bits size) (amount : Int) : m (Bits size) := do
  Runtime.shiftRightArithmetic x amount

end X86.Helpers
