-- Generated from data/definitions.xml.gz: Set_LAM_Canonical; do not edit.
-- Source SHA256: eccb4aa0b179b1cc6d1d352a5ad71f0b4581f26554b910577e79b63f3044d390
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Set_LAM_Canonical)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Std.Bits.Sign_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

def Set_LAM_Canonical (address : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  let mut temp_address : Bits 64 := address
  if ((← temp_address[63 +: 1]) == 1) then
    -- Supervisor access
    if ((← CR4.LAM_SUP) == 1) then
      if ((← CPUID_LA57) and (← CR4.LA57) == 1 and (← get).IA32_EFER.LMA == 1) then
        temp_address := (← concatBits (leftSize := 1) (rightSize := 63) (1 : Runtime.Bit) (← Std.Bits.Sign_Extend (source_size := 57) (← temp_address[0 +: 57]) 63))
      else
        temp_address := (← concatBits (leftSize := 1) (rightSize := 63) (1 : Runtime.Bit) (← Std.Bits.Sign_Extend (source_size := 48) (← temp_address[0 +: 48]) 63))
  else
    -- User access
    if ((← CR3.LAM_U57) == 1) then
      temp_address := (← concatBits (leftSize := 1) (rightSize := 63) (0 : Runtime.Bit) (← Std.Bits.Sign_Extend (source_size := 57) (← temp_address[0 +: 57]) 63))
    else
      if ((← CR3.LAM_U48) == 1) then
        temp_address := (← concatBits (leftSize := 1) (rightSize := 63) (0 : Runtime.Bit) (← Std.Bits.Sign_Extend (source_size := 48) (← temp_address[0 +: 48]) 63))

  return temp_address

end X86.Helpers
