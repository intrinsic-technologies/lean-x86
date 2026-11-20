-- Generated from data/definitions.xml.gz: Is_Canonical_Wrt_Paging_Mode; do not edit.
-- Source SHA256: 4e5c51d89cdd3d094eb9ea0ddcaf82d15858a6488bdf63c5d2824ea4b38a8dfd
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Canonical_Wrt_Paging_Mode)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Is_Canonical_Wrt_Position
import X86.Helpers.Set_LAM_Canonical
import X86.Helpers.Std.Bits.Add_int
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
  [X86.Get_CPUID_Value.Binding σ]

def Is_Canonical_Wrt_Paging_Mode
    (address : Bits 64) (size : Int) (ignore_LAM : Bool := false) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert ((← CR0.PG) == 1 and (← CR4.PAE) == 1 and (← get).IA32_EFER.LME == 1)

  let temp_address : Bits 64 ← do
    if (← CPUID_LAM) and not ignore_LAM then
      Set_LAM_Canonical address
    else
      pure address

  let address_last : Bits 64 ← do
    if size == 0 then
      pure address
    else
      Std.Bits.Subtract_int (n := 64) (← Std.Bits.Add_int (n := 64) address (← Std.Integer.Positive_Divide size 8)) 1
  let temp_address_last : Bits 64 ← do
    if (← CPUID_LAM) and not ignore_LAM then
      Set_LAM_Canonical address_last
    else
      pure address_last

  if ((← CR4.LA57) == 0) then
    return (← Is_Canonical_Wrt_Position temp_address 48) and (← Is_Canonical_Wrt_Position temp_address_last 48)
  else
    return (← Is_Canonical_Wrt_Position temp_address 57) and (← Is_Canonical_Wrt_Position temp_address_last 57)

end X86.Helpers
