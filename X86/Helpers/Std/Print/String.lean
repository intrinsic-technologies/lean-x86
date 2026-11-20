-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: ed4cf6372428a775645a2c90e2863f0096ef19c984f6742763aa9b7c49b03fb9
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

-- Source diagnostic output is retained separately from architectural state.
def Std.Print.String (x : String) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.print x

end X86.Helpers
