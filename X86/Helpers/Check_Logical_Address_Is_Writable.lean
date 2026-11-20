-- Generated from data/definitions.xml.gz: Check_Logical_Address_Is_Writable; do not edit.
-- Source SHA256: f6a22b56cf963704a10ef083ef1f835789ce981054e6b4e1a45b56358e757c22
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Logical_Address_Is_Writable)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Write_Permission
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Segment
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

def Check_Logical_Address_Is_Writable
    (segment : Segment) (offset : Bits 64) (size : Int) (alignment_type : Memory_Alignment_Type := Memory_Alignment_Type.Normal_Alignment) :
    Runtime.SpecM Exception (State σ) Unit := do
  Check_Write_Permission segment

  let logical : Address_Translation ← Create_Logical_Address segment offset size
  let linear : Address_Translation ← Translate_Logical_To_Linear logical alignment_type (← get).CS false
  let _ ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Write

end X86.Helpers
