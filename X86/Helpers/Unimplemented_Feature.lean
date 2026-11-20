-- Generated from data/definitions.xml.gz: Unimplemented_Feature; do not edit.
-- Source SHA256: 0fbb2d7b5d9c012bc29326689ed69227315ca006c4d115869ce11d7f6ce97b5b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Unimplemented_Feature)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Unimplemented_Feature.Binding (σ : Type) where
  call (name : String) (continue_with_step fuzz_result : Bool) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Unimplemented_Feature.Binding

variable {σ : Type}

variable
  [X86.Helpers.Unimplemented_Feature.Binding σ]

def Unimplemented_Feature
    (name : String) (continue_with_step : Bool := false) (fuzz_result : Bool := true) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Unimplemented_Feature.Binding.call name continue_with_step fuzz_result)

end X86.Helpers
