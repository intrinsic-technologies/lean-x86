-- Generated from data/definitions.xml.gz: Logical_Mem_Read; do not edit.
-- Source SHA256: d9226136c3c0f819c7561422d0bdc99bc177b2da361b7a3e34af4bc6a3221a71
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Logical_Mem_Read)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Bus_Lock_Trap
import X86.Helpers.Check_Data_Read_Breakpoint
import X86.Helpers.Check_Read_Permission
import X86.Helpers.Check_Split_Lock
import X86.Helpers.Check_UC_Lock
import X86.Helpers.Check_Write_Permission
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Is_Aligned
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Physical_Mem_Read
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Logical_Mem_Read
    (segment : Segment) (offset : Bits 64) (size : Int) (access_type : Memory_Access_Type := Memory_Access_Type.Memory_Read) (alignment_type : Memory_Alignment_Type := Memory_Alignment_Type.Normal_Alignment) (acquire_lock : Bool := false) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  Runtime.assert ((size == (8 : Int)) || (size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)) || (size == (80 : Int)) || (size == (112 : Int)) || (size == (128 : Int)) || (size == (224 : Int)) || (size == (256 : Int)) || (size == (384 : Int)) || (size == (512 : Int)) || (size == (1024 : Int)))
  Runtime.assert ((access_type == Memory_Access_Type.Memory_Read) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write))

  Check_Read_Permission segment

  if (access_type == Memory_Access_Type.Memory_Read_Modify_Write) then
    Check_Write_Permission segment

  let logical : Address_Translation ← Create_Logical_Address segment offset size
  let linear : Address_Translation ← Translate_Logical_To_Linear logical alignment_type (← get).CS false
  Check_Data_Read_Breakpoint linear.linear_address (← Std.Integer.Positive_Divide size 8)

  let physical : Address_Translation ← Translate_Linear_To_Physical.interpreted linear access_type

  if acquire_lock then
    Runtime.assert (access_type == Memory_Access_Type.Memory_Read_Modify_Write)

    -- todo: what about translation2?
    Check_UC_Lock physical.translation1.memory_type
    Check_Split_Lock physical.translation1.physical_address size
    Check_Bus_Lock_Trap physical.translation1.physical_address size physical.translation1.memory_type

    if (not (← Is_Aligned (n := 64) physical.translation1.physical_address (← Std.Integer.Positive_Divide size 8))) then
      -- can't handle locks split across pages at the moment
      Unimplemented_Feature "LockedMemRead" true false

    Unimplemented_Feature "Logical_Mem_Read(acquire_lock=>True)" true false

  let value : Bits size ← Physical_Mem_Read physical size
  return value

end X86.Helpers
