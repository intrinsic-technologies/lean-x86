-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: d35af6d6d7e4516c748ff677ee5f110e8888e667cbd9b0c3c2c3bc109a621d52
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The source declares this builtin without an ISA body.
def Std.Integer.Positive_Divide {exception : Type} {m : Type → Type}
    [Monad m] [MonadExcept (Runtime.Error exception) m]
    (left right : Int) : m (Int) := do
  Runtime.Positive_Divide left right

end X86.Helpers
