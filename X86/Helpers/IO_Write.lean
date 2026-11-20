-- Generated from data/definitions.xml.gz: IO_Write; do not edit.
-- Source SHA256: 21858e2ff49553e4e3f19d5c7603fe955e1d2c052709e4e1313cd74d150eea95
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=IO_Write)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class IO_Write.Binding (σ : Type) where
  call (port : Bits 32) (size : Int) (value : Bits size) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] IO_Write.Binding

variable {σ : Type}

variable
  [X86.Helpers.IO_Write.Binding σ]

def IO_Write
    (port : Bits 32) (size : Int) (value : Bits size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  Runtime.liftNoSourceException (IO_Write.Binding.call port size value)

end X86.Helpers
