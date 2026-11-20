-- Generated from data/definitions.xml.gz: CET::Shadow_Stack_Write; do not edit.
-- Source SHA256: d248c934acabae14ecf6d24a4b078674e09dc02f82d2e911a24b22ec81cb056b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AShadow_Stack_Write)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class CET.Shadow_Stack_Write.Binding (σ : Type) where
  call {size_in_bits : Int} (linear_address : Bits 64) (value : Bits size_in_bits) (is_implicit_supervisor_mode_access release_lock : Bool) (translation_cpl : Int) :
    Runtime.SpecM Exception (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CET.Shadow_Stack_Write.Binding

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]

def CET.Shadow_Stack_Write {size_in_bits : Int}
    (linear_address : Bits 64) (value : Bits size_in_bits) (is_implicit_supervisor_mode_access : Bool := false) (release_lock : Bool := false) (translation_cpl : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size_in_bits)
  Runtime.assert (translation_cpl in {0..3})

  try
    CET.Shadow_Stack_Write.Binding.call (size_in_bits := size_in_bits) linear_address value is_implicit_supervisor_mode_access release_lock translation_cpl
  catch
    | .raised (.Exception_Info exception) =>
      Runtime.assert ((exception).vector in {0..255})
      throw (.raised (.Exception_Info exception))
    | error => throw error

end X86.Helpers
