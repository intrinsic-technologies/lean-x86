-- Generated from data/definitions.xml.gz: VMX::Check_CR3_Target; do not edit.
-- Source SHA256: 90326df8602f0531f2cf088196fd784a6a6845ee327ebfbdef2bfd7f6efc678d
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%3A%3ACheck_CR3_Target)
import X86.Runtime
import X86.Helpers.VMX.Get_CR3_Target_Value
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.CR3_Target_Count.Binding σ]
  [X86.CR3_Target_Value0.Binding σ]
  [X86.CR3_Target_Value1.Binding σ]
  [X86.CR3_Target_Value2.Binding σ]
  [X86.CR3_Target_Value3.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]

def VMX.Check_CR3_Target (new_value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).CR3_Load_Exiting == 1) then
      let cr3_target_count : Int := Unsigned (← CR3_Target_Count (← get).Current_VMCS_Pointer)
      let mut is_allowed : Bool := false

      if (cr3_target_count != 0) then
        for i in intRange (0 : Int) (cr3_target_count - 1) do
          if (new_value == (← VMX.Get_CR3_Target_Value i)) then
            is_allowed := true

      if (not is_allowed) then
        VM_Exit VMX_EXIT_CR_ACCESS

end X86.Helpers
