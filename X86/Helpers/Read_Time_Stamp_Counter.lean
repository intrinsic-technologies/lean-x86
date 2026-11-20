-- Generated from data/definitions.xml.gz: Read_Time_Stamp_Counter; do not edit.
-- Source SHA256: aec19eafe0e57629bf7fe80b12e1ff2e45bcaca61dfc1d456778af9b1cc69dac
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_Time_Stamp_Counter)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Read_Time_Stamp_Counter.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Read_Time_Stamp_Counter.Binding

variable {σ : Type}

variable
  [X86.Helpers.Read_Time_Stamp_Counter.Binding σ]

def Read_Time_Stamp_Counter  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (Read_Time_Stamp_Counter.Binding.call)

end X86.Helpers
