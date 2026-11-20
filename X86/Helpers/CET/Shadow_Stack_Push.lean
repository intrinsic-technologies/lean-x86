-- Generated from data/definitions.xml.gz: CET::Shadow_Stack_Push; do not edit.
-- Source SHA256: bddd88b4c32b176ea07bf6b92f2a039879f50c4b563084c1ed0a170ec3baa79c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AShadow_Stack_Push)
import X86.Runtime
import X86.Helpers.CET.Shadow_Stack_Write
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]

def CET.Shadow_Stack_Push {size_in_bits : Int}
    (ssp : SSP_Type) (value : Bits size_in_bits) :
    Runtime.SpecM Exception (State σ) (SSP_Type) := do
  Runtime.assert (0 ≤ size_in_bits)

  let linear_address : Bits 64 ← Std.Bits.Subtract_int (n := 64) ssp (← Std.Integer.Positive_Divide size_in_bits 8)
  CET.Shadow_Stack_Write (size_in_bits := size_in_bits) linear_address value false false (← get).CPL
  return (← Std.Bits.Subtract_int (n := 64) ssp (← Std.Integer.Positive_Divide size_in_bits 8))

end X86.Helpers
