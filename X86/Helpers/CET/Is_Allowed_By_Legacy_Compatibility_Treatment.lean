-- Generated from data/definitions.xml.gz: CET::Is_Allowed_By_Legacy_Compatibility_Treatment; do not edit.
-- Source SHA256: 19b97d856129451a780effc1d9aae17a4aba6964f82ebb0a266234fda07e7c1e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AIs_Allowed_By_Legacy_Compatibility_Treatment)
import X86.Runtime
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.IA32_CET
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Linear_Mem_Read
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]

def CET.Is_Allowed_By_Legacy_Compatibility_Treatment
    (cpl : Int) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (cpl in {0..3})

  let cet_msr : IA32_U_CET_Type ← IA32_CET cpl

  if (cet_msr.LEG_IW_EN == 1) then
    let bitmap_base_address : Bits 64 ← concatBits (leftSize := 52) (rightSize := 12) cet_msr.EB_LEG_BITMAP_BASE (← Std.Bits.Zero 12)
    let linear_address : Bits 64 ← Compute_Linear_Address (← get).CS (← get).RIP (← get).CS

    -- todo: adjust for SGX elrange base when in an enclave

    let bitmap_linear_address : Bits 64 ← do
      if not (← In_64Bit_Mode) then
        pure (bitmap_base_address + (← Std.Bits.Zero_Extend (source_size := 17) (← linear_address[31:15]) 64))
      else
        if (← CR4.LA57) == 0 then
          pure (bitmap_base_address + (← Std.Bits.Zero_Extend (source_size := 33) (← sliceInclusive (← get).RIP 47 15) 64))
        else
          pure (bitmap_base_address + (← Std.Bits.Zero_Extend (source_size := 42) (← sliceInclusive (← get).RIP 56 15) 64))

    let bitmap_byte : Bits 8 ← Linear_Mem_Read bitmap_linear_address 8 true

    return (← Runtime.invalidOperands (result := Runtime.Bit) (bitmap_byte, (← linear_address[14:12]))) == 1

  return false

end X86.Helpers
