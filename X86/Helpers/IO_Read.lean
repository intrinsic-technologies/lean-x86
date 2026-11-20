-- Generated from data/definitions.xml.gz: IO_Read; do not edit.
-- Source SHA256: 6fdb0fde568bdea209ead5fdd6f84c3511c293ead5e0035cfb868111dfdd1cbd
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=IO_Read)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class IO_Read.Binding (σ : Type) where
  call (port : Bits 32) (size : Int) :
    Runtime.SpecM Empty (State σ) (Bits size)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] IO_Read.Binding

variable {σ : Type}

variable
  [X86.Helpers.IO_Read.Binding σ]

def IO_Read (port : Bits 32) (size : Int) : Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  Runtime.liftNoSourceException (IO_Read.Binding.call port size)

end X86.Helpers
