-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: e6602dd2654b435358462c4233cd18cf3d064752828d8b525021f14a9440c5e9
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.Helpers.Std.End_Execution
import X86.Helpers.Std.Print.String
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

-- This procedure never returns normally; its result type is unrestricted.
def Std.Unreachable {α : Type} : Runtime.SpecM Exception (State σ) α := do
  Std.Print.String "Unreachable() function called.\n"
  Std.Print.String "This should be impossible - report a bug in the specification\n"
  Std.End_Execution false

end X86.Helpers
