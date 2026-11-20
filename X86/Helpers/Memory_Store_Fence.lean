-- Generated from data/definitions.xml.gz: Memory_Store_Fence; do not edit.
-- Source SHA256: a577b70e2cce40ffe8e51726868295ddb3553ceadc08fadf5604722b878c1785
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Memory_Store_Fence)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Memory_Store_Fence.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Memory_Store_Fence.Binding

variable {σ : Type}

variable
  [X86.Helpers.Memory_Store_Fence.Binding σ]

def Memory_Store_Fence  : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Memory_Store_Fence.Binding.call)

end X86.Helpers
