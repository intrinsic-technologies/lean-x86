-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: cee8aecda93ee1dfd77fc39b3099057a18c4b16c71828a007cbc6135c68d4124
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The source declares this builtin without an ISA body.
def Std.Integer.Power2 {exception : Type} {m : Type → Type}
    [Monad m] [MonadExcept (Runtime.Error exception) m]
    (x : Int) : m (Int) := do
  Runtime.Power2 x

end X86.Helpers
