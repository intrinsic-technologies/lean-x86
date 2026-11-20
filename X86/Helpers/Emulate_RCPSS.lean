-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 95da417f922d8823d19e1459c7bde6ec9f38b048ce76a75205495892690dbc38
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_RCPSS.Binding (σ : Type) where
  call (x : Bits 32) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bits 32)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_RCPSS.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_RSQRTSS.Binding (σ : Type) where
  call (x : Bits 32) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bits 32)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_RSQRTSS.Binding

variable {σ : Type}

variable
  [X86.Helpers.Emulate_RCPSS.Binding σ]
  [X86.Helpers.Emulate_RSQRTSS.Binding σ]

-- Numerical results supplied by `Bindings.numerical`. Intel wrappers own
-- classification and instruction behavior; admissibility requires separate laws.
def Emulate_RCPSS (x : Bits 32) : Runtime.SpecM Exception (State σ) (Bits 32) := do
  Runtime.liftNoSourceException (liftM (Emulate_RCPSS.Binding.call x (← get)))

def Emulate_RSQRTSS (x : Bits 32) : Runtime.SpecM Exception (State σ) (Bits 32) := do
  Runtime.liftNoSourceException (liftM (Emulate_RSQRTSS.Binding.call x (← get)))

end X86.Helpers
