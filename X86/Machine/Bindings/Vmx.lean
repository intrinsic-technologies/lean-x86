import X86.Helpers.Physical_Mem_Read_EPT
import X86.Helpers.EPT.Get_Exit_Qualification
import X86.Helpers.VM_Exit

namespace X86.Machine.Bindings.Vmx

open X86.Helpers

variable {σ : Type}

-- These bindings read the VMCS or leave VMX operation. This machine does not model VMX.
-- The page walk in `PhysicalAccess` also rejects nested paging through this helper.
def unsupported {exception α : Type} (operation : String) :
    X86.Runtime.SpecM exception (X86.State σ) α :=
  throw (.externalFailure s!"unsupported VMX operation: {operation}")

-- Address translation reads these controls; every VMX feature they select is off.
instance : X86.VM_Exec_Controls2.Binding σ where
  call := pure {
    Unrestricted_Guest := 0
    Descriptor_Table_Exiting := 0
    WBINVD_Exiting := 0
    EPT_Violation_VE := 0
    Enable_EPT := 0
    Mode_Based_Execute_Control_For_EPT := 0 }

instance : X86.VM_Exec_Controls3.Binding σ where
  call := pure { EPT_Paging_Write_Control := 0, Enable_HLAT := 0 }

instance : X86.EPTP_Index.Binding σ where
  call _ := unsupported "EPTP_Index"

instance : X86.HLAT_PLR_Prefix_Size.Binding σ where
  call _ := unsupported "HLAT_PLR_Prefix_Size"

instance : X86.Virtualization_Exception_Information_Address.Binding σ where
  call _ := unsupported "Virtualization_Exception_Information_Address"

instance : Physical_Mem_Read_EPT.Binding σ where
  call _ _ _ _ _ := unsupported "Physical_Mem_Read_EPT"

instance : EPT.Get_Exit_Qualification.Binding σ where
  call _ _ _ _ := unsupported "EPT.Get_Exit_Qualification"

instance : VM_Exit.Binding σ where
  call _ := unsupported "VM_Exit"

-- Port-access interception.
instance : X86.VM_Exec_Controls1.Binding σ where
  call := unsupported "VM_Exec_Controls1"

instance : X86.Address_Of_IO_Bitmap_A.Binding σ where
  call _ := unsupported "Address_Of_IO_Bitmap_A"

instance : X86.Address_Of_IO_Bitmap_B.Binding σ where
  call _ := unsupported "Address_Of_IO_Bitmap_B"

-- Control-register interception.
instance : X86.CR0_Guest_Host_Mask.Binding σ where
  call _ := unsupported "CR0_Guest_Host_Mask"

instance : X86.CR0_Read_Shadow.Binding σ where
  call _ := unsupported "CR0_Read_Shadow"

instance : X86.CR4_Guest_Host_Mask.Binding σ where
  call _ := unsupported "CR4_Guest_Host_Mask"

instance : X86.CR4_Read_Shadow.Binding σ where
  call _ := unsupported "CR4_Read_Shadow"

instance : X86.CR3_Target_Count.Binding σ where
  call _ := unsupported "CR3_Target_Count"

instance : X86.CR3_Target_Value0.Binding σ where
  call _ := unsupported "CR3_Target_Value0"

instance : X86.CR3_Target_Value1.Binding σ where
  call _ := unsupported "CR3_Target_Value1"

instance : X86.CR3_Target_Value2.Binding σ where
  call _ := unsupported "CR3_Target_Value2"

instance : X86.CR3_Target_Value3.Binding σ where
  call _ := unsupported "CR3_Target_Value3"

-- Exception and page-fault filtering for VM exits.
instance : X86.Exception_Bitmap.Binding σ where
  call _ := unsupported "Exception_Bitmap"

instance : X86.Page_Fault_Error_Code_Mask.Binding σ where
  call _ := unsupported "Page_Fault_Error_Code_Mask"

instance : X86.Page_Fault_Error_Code_Match.Binding σ where
  call _ := unsupported "Page_Fault_Error_Code_Match"

end X86.Machine.Bindings.Vmx
