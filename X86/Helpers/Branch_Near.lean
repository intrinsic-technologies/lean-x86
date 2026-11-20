-- Generated from data/definitions.xml.gz: Branch_Near; do not edit.
-- Source SHA256: 9db338d68d8e8c246fb5cb15c4877dd0f1fd5e1cbfe3b32a14a838cf7aef8103
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Branch_Near)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def Branch_Near (new_rip : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  modify ({ · with RIP := new_rip })
  modify ({ · with Branch_Taken := true })

end X86.Helpers
