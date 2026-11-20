-- Generated from data/definitions.xml.gz: Check_TSS_Readability; do not edit.
-- Source SHA256: 684e1592d9f9b316b7c508052a52a10b39a29e63aa42701765edbb0780d09626
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_TSS_Readability)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Read_Permission
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Is_16Bit_Task
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Task_State_Segment
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Translate_Logical_To_Linear
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Check_TSS_Readability (task : Segment) : Runtime.SpecM Exception (State σ) Unit := do
  let offset : Bits 64 ← do
    if (← Is_16Bit_Task task) then
      pure TSS_IP_OFFSET
    else
      pure TSS_CR3_OFFSET
  let start_logical : Address_Translation ← Create_Logical_Address task offset 8
  let start_linear : Address_Translation ← Translate_Logical_To_Linear start_logical Memory_Alignment_Type.Normal_Alignment (← get).CS false
  let _ ← Translate_Linear_To_Physical.interpreted start_linear Memory_Access_Type.Memory_Read

  let last_byte_offset : Bits 64 ← do
    if (← Is_16Bit_Task task) then
      pure TSS_LIMIT_16
    else
      if (← CR4.CET) == 1 then
        Std.Bits.Add_int (n := 64) TSS_LIMIT 4
      else
        pure TSS_LIMIT

  let end_logical : Address_Translation ← Create_Logical_Address task last_byte_offset 8
  let end_linear : Address_Translation ← Translate_Logical_To_Linear end_logical Memory_Alignment_Type.Normal_Alignment (← get).CS false
  let _ ← Translate_Linear_To_Physical.interpreted end_linear Memory_Access_Type.Memory_Read

  Check_Read_Permission task

end X86.Helpers
