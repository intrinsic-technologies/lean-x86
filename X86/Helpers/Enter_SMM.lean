-- Generated from data/definitions.xml.gz: Enter_SMM; do not edit.
-- Source SHA256: 5dfdc058bc2deec868fbb2251e193bbf55703f4eba7d30c7bf8ead88fa328290
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Enter_SMM)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Enter_SMM.Binding (σ : Type) where
  call (is_psmi : Bool) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Enter_SMM.Binding

variable {σ : Type}

variable
  [X86.Helpers.Enter_SMM.Binding σ]

def Enter_SMM (is_psmi : Bool) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Enter_SMM.Binding.call is_psmi)

end X86.Helpers
