-- Generated from data/definitions.xml.gz: Physical_Mem_Read; do not edit.
-- Source SHA256: 1f541dcc11d9d0240699f885a0bcc57f90102db9269fce256f323d5f25510241
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Physical_Mem_Read)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Physical_Mem_Read.Binding (σ : Type) where
  call (physical : Address_Translation) (size : Int) :
    Runtime.SpecM Empty (State σ) (Bits size)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Physical_Mem_Read.Binding

variable {σ : Type}

variable
  [X86.Helpers.Physical_Mem_Read.Binding σ]

def Physical_Mem_Read
    (physical : Address_Translation) (size : Int) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  Runtime.assert ((physical).translation_cpl in {0..3})
  Runtime.liftNoSourceException (Physical_Mem_Read.Binding.call physical size)

end X86.Helpers
