-- Generated from data/definitions.xml.gz: Is_Linear_Access_Split_Across4KB_Pages; do not edit.
-- Source SHA256: c39b363ab01c46a1bc649901b5357d4baff9dc68ba19e1a7d52b69441c11a288
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Linear_Access_Split_Across4KB_Pages)
import X86.Runtime
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Is_Linear_Access_Split_Across4KB_Pages
    (linear_address : Bits 64) (size_in_bytes : Int) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  if ((← CR0.PG) == 0) then
    return false

  let Page_Size_4KB : Int := 4096
  let start_address : Int := Unsigned linear_address
  let end_address : Int := start_address + size_in_bytes - 1
  return (← Std.Integer.Positive_Divide start_address Page_Size_4KB) != (← Std.Integer.Positive_Divide end_address Page_Size_4KB)

end X86.Helpers
