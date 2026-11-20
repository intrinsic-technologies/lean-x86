-- Generated from data/definitions.xml.gz: CET::Shadow_Stack_Compare_Exchange; do not edit.
-- Source SHA256: 6e4c7a2d76f01940853c6bb686a7aa9ef6376f79ab966b1e0594b2489aa0e826
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AShadow_Stack_Compare_Exchange)
import X86.Runtime
import X86.Helpers.CET.Shadow_Stack_Read
import X86.Helpers.CET.Shadow_Stack_Write
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]

def CET.Shadow_Stack_Compare_Exchange
    (linear_address new_value expected_value : Bits 64) :
    Runtime.SpecM Exception (State σ) (SSP_Type) := do
  let old_value : Bits 64 ← CET.Shadow_Stack_Read linear_address 64 true true
  if (old_value == expected_value) then
    CET.Shadow_Stack_Write (size_in_bits := 64) linear_address new_value true true (← get).CPL
  else
    CET.Shadow_Stack_Write (size_in_bits := 64) linear_address old_value true true (← get).CPL
  return old_value

end X86.Helpers
