-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 0d2dcf7015029a84e2fe7988dcacc7e20a9fc8dff11a31c59bb0627d1e48b23d
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The source declares this builtin without an ISA body.
def Std.Bits.Shift_Right_Logical_Restricted {exception : Type} {m : Type → Type}
    [Monad m] [MonadExcept (Runtime.Error exception) m] {size : Int}
    (x : Bits size) (amount : Int) : m (Bits size) := do
  Runtime.shiftRightLogical x amount

end X86.Helpers
