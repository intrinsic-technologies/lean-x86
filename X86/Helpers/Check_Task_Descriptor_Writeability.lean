-- Generated from data/definitions.xml.gz: Check_Task_Descriptor_Writeability; do not edit.
-- Source SHA256: 209d9f642e71f5137ae75384b9dfbe4d4fcba7c585c1e39235127ffc112c8398
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Task_Descriptor_Writeability)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Calculate_And_Check_Descriptor_Linear_Address
import X86.Helpers.Create_Linear_Address
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Segment
import X86.Helpers.Translate_Linear_To_Physical
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

def Check_Task_Descriptor_Writeability
    (task : Segment) :
    Runtime.SpecM Exception (State σ) Unit := do
  let linear_address : Bits 64 ← Calculate_And_Check_Descriptor_Linear_Address task.selector false true
  let mut linear : Address_Translation ← Create_Linear_Address linear_address 8
  linear := { linear with is_implicit_supervisor_mode_access := true }
  let _ ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Write

end X86.Helpers
