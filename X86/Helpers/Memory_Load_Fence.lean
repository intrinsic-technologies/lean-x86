-- Generated from data/definitions.xml.gz: Memory_Load_Fence; do not edit.
-- Source SHA256: 1a36a8f08a5dc1c7270976720c27e43a0b4c72a07ec923e6a58f9ac21de8628a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Memory_Load_Fence)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Memory_Load_Fence.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Memory_Load_Fence.Binding

variable {σ : Type}

variable
  [X86.Helpers.Memory_Load_Fence.Binding σ]

def Memory_Load_Fence  : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Memory_Load_Fence.Binding.call)

end X86.Helpers
