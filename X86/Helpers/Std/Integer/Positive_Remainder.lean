-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 956f8174c7f9b596b2f77662be5366951da4b9cd8310198a89616702e5d40338
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The source declares this builtin without an ISA body.
def Std.Integer.Positive_Remainder {exception : Type} {m : Type → Type}
    [Monad m] [MonadExcept (Runtime.Error exception) m]
    (left right : Int) : m (Int) := do
  Runtime.Positive_Remainder left right

end X86.Helpers
