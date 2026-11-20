-- Generated from data/definitions.xml.gz: CET::Shadow_Stack_Pop; do not edit.
-- Source SHA256: b4eb8debdb3672033e75a7ad9e02c9d3a58e782284f2848a88236e400643e9ad
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AShadow_Stack_Pop)
import X86.Runtime
import X86.Helpers.CET.Shadow_Stack_Read
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]

def CET.Shadow_Stack_Pop
    (ssp : SSP_Type) (size_in_bits : Int) :
    Runtime.SpecM Exception (State σ) (Bits size_in_bits × SSP_Type) := do
  Runtime.assert (0 ≤ size_in_bits)

  let value : Bits size_in_bits ← CET.Shadow_Stack_Read ssp size_in_bits false false
  return (value, (← Std.Bits.Add_int (n := 64) ssp (← Std.Integer.Positive_Divide size_in_bits 8)))

end X86.Helpers
