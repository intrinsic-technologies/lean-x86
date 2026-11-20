-- Generated from data/definitions.xml.gz: CET::Shadow_Stack_Read; do not edit.
-- Source SHA256: 405d4fabc6b94cfa49885bc08bacf11a8cecc62fc653d8720f7196ce31c0fb9b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AShadow_Stack_Read)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class CET.Shadow_Stack_Read.Binding (σ : Type) where
  call (linear_address : Bits 64) (size_in_bits : Int) (acquire_lock is_implicit_supervisor_mode_access : Bool) :
    Runtime.SpecM Exception (State σ) (Bits size_in_bits)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CET.Shadow_Stack_Read.Binding

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]

def CET.Shadow_Stack_Read
    (linear_address : Bits 64) (size_in_bits : Int) (acquire_lock : Bool := false) (is_implicit_supervisor_mode_access : Bool := false) :
    Runtime.SpecM Exception (State σ) (Bits size_in_bits) := do
  Runtime.assert (0 ≤ size_in_bits)

  try
    CET.Shadow_Stack_Read.Binding.call linear_address size_in_bits acquire_lock is_implicit_supervisor_mode_access
  catch
    | .raised (.Exception_Info exception) =>
      Runtime.assert ((exception).vector in {0..255})
      throw (.raised (.Exception_Info exception))
    | error => throw error

end X86.Helpers
