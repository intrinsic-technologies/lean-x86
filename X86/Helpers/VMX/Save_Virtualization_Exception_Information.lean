-- Generated from data/definitions.xml.gz: VMX::Save_Virtualization_Exception_Information; do not edit.
-- Source SHA256: f67608ac3b5bce9da719a3169d96b550cac22bdac1881ed8175432ed1aa4f3cc
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%3A%3ASave_Virtualization_Exception_Information)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Create_Physical_Address
import X86.Helpers.Memory_Type
import X86.Helpers.Physical_Mem_Write
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.All_Ones
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.EPTP_Index.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]

def VMX.Save_Virtualization_Exception_Information
    (exit_reason : Bits 32) (exit_qualification guest_linear_address guest_physical_address : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  let ve_address : Bits 64 ← Virtualization_Exception_Information_Address (← get).Current_VMCS_Pointer

  let physical_00 : Address_Translation ← Create_Physical_Address (← Std.Bits.Add_int (n := 64) ve_address 0) 32 Memory_Type.Memory_Type_Strong_Uncacheable
  Physical_Mem_Write physical_00 32 exit_reason

  let physical_04 : Address_Translation ← Create_Physical_Address (← Std.Bits.Add_int (n := 64) ve_address 4) 32 Memory_Type.Memory_Type_Strong_Uncacheable
  Physical_Mem_Write physical_04 32 (← Std.Bits.All_Ones 32)

  let physical_08 : Address_Translation ← Create_Physical_Address (← Std.Bits.Add_int (n := 64) ve_address 8) 64 Memory_Type.Memory_Type_Strong_Uncacheable
  Physical_Mem_Write physical_08 64 exit_qualification

  let physical_16 : Address_Translation ← Create_Physical_Address (← Std.Bits.Add_int (n := 64) ve_address 16) 64 Memory_Type.Memory_Type_Strong_Uncacheable
  Physical_Mem_Write physical_16 64 guest_linear_address

  let physical_24 : Address_Translation ← Create_Physical_Address (← Std.Bits.Add_int (n := 64) ve_address 24) 64 Memory_Type.Memory_Type_Strong_Uncacheable
  Physical_Mem_Write physical_24 64 guest_physical_address

  let eptp_index : Bits 16 ← EPTP_Index (← get).Current_VMCS_Pointer
  let physical_32 : Address_Translation ← Create_Physical_Address (← Std.Bits.Add_int (n := 64) ve_address 32) 16 Memory_Type.Memory_Type_Strong_Uncacheable
  Physical_Mem_Write physical_32 16 eptp_index

end X86.Helpers
