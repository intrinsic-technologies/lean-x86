-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: 770c5cffc4dcaea5251fc546a8a185d5c81c1d5fc201ed13bb61388b4f6b3d21
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The source declares this builtin without an ISA body.
def Std.Bits.Repeat {exception : Type} {monad : Type → Type}
    [Monad monad] [MonadExcept (Runtime.Error exception) monad] {m : Int}
    (x : Bits m) (n : Int) : monad (Bits (m * n)) := do
  Runtime.repeatBits x n

end X86.Helpers
