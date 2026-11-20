-- Generated from data/definitions.xml.gz: Physical_Mem_Write; do not edit.
-- Source SHA256: 59d4d22d43624dd36359f2dc65ba2810a8efed56a7f4f2ce127ec53d3641d9b2
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Physical_Mem_Write)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Physical_Mem_Write.Binding (σ : Type) where
  call (physical : Address_Translation) (size : Int) (value : Bits size) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Physical_Mem_Write.Binding

variable {σ : Type}

variable
  [X86.Helpers.Physical_Mem_Write.Binding σ]

def Physical_Mem_Write
    (physical : Address_Translation) (size : Int) (value : Bits size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  Runtime.assert ((physical).translation_cpl in {0..3})
  Runtime.liftNoSourceException (Physical_Mem_Write.Binding.call physical size value)

end X86.Helpers
