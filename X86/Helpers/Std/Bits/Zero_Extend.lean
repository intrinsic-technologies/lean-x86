-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 131b4538ef74db7665ad0d5fa2e490a956be7840fe4acee79a00937f4ad4ebe9
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The source declares this builtin without an ISA body.
def Std.Bits.Zero_Extend {exception : Type} {m : Type → Type}
    [Monad m] [MonadExcept (Runtime.Error exception) m] {source_size : Int}
    (x : Bits source_size) (target_size : Int) : m (Bits target_size) := do
  Runtime.Zero_Extend x target_size

end X86.Helpers
