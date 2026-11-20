-- Generated from data/definitions.xml.gz: Logical_Mem_Write; do not edit.
-- Source SHA256: 46940ac17e24c9d33a92c65a6fcc9a4e4c1e72a60eeda95f3f57f4ea38eac8bd
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Logical_Mem_Write)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Data_Write_Breakpoint
import X86.Helpers.Check_Write_Permission
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Physical_Mem_Write
import X86.Helpers.Segment
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Translate_Logical_To_Linear
import X86.Helpers.Unimplemented_Feature
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Logical_Mem_Write {size : Int}
    (segment : Segment) (offset : Bits 64) (value : Bits size) (alignment_type : Memory_Alignment_Type := Memory_Alignment_Type.Normal_Alignment) (release_lock : Bool := false) (override_memory_type : Bool := false) (memory_type : Memory_Type := Memory_Type.Memory_Type_Unknown) (non_temporal_hint : Bool := false) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (size == 8 || size == 16 || size == 32 || size == 64 || size == 80 || size == 112 || size == 128 || size == 224 || size == 256 || size == 384 || size == 512 || size == 1024)

  Check_Write_Permission segment

  let logical : Address_Translation ← Create_Logical_Address segment offset size
  let linear : Address_Translation ← Translate_Logical_To_Linear logical alignment_type (← get).CS false
  Check_Data_Write_Breakpoint linear.linear_address (← Std.Integer.Positive_Divide size 8)
  let mut physical : Address_Translation ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Write

  if release_lock then
    Unimplemented_Feature "Logical_Mem_Write(release_lock=>True)" true false

  if override_memory_type then
    physical := { physical with translation1 := { physical.translation1 with memory_type := memory_type } }
  else
    if non_temporal_hint then
      -- The memory type of the region being written to can override the non-temporal hint,
      -- if the memory address specified for the non-temporal store is in uncacheable memory.
      -- Uncacheable as referred to here means that the region being written to has been
      -- mapped with either an uncacheable (UC) or write protected (WP) memory type.
      if (not ((physical.translation1.memory_type == Memory_Type.Memory_Type_Strong_Uncacheable) || (physical.translation1.memory_type == Memory_Type.Memory_Type_Write_Protected))) then
        physical := { physical with translation1 := { physical.translation1 with memory_type := Memory_Type.Memory_Type_Write_Combining } }

  Physical_Mem_Write physical size value

end X86.Helpers
