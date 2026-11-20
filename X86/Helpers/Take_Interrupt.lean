-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: df90a99802d45ce3c4f1dbe3947562361505ef6b433686093fd3053a986fe873
import X86.Runtime
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Handle_Vectored_Event
import X86.Helpers.Handle_Virtual_8086_Mode_Interrupt_Redirection_Bitmap
import X86.Helpers.UFloatCompare
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Handle_Vectored_Event.Semantics σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Take_Interrupt
    (interrupt_type : Vectored_Event_Type) (vector : Int) (return_ip : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (vector in {0..255})

  Runtime.assert (interrupt_type != Vectored_Event_Type.Hardware_Exception)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if (interrupt_type == Vectored_Event_Type.Non_Maskable_Interrupt) then
      if ((← get).«VMCS::Pin_Based_VM_Exec_Controls».NMI_Exiting == 1) then
        VM_Exit VMX_EXIT_EXCEPTION_NMI
    else
      if (interrupt_type == Vectored_Event_Type.External_Interrupt) then
        if ((← get).«VMCS::Pin_Based_VM_Exec_Controls».External_Interrupt_Exiting == 1) then
          VM_Exit VMX_EXIT_EXTERNAL_INTERRUPT

  if (not (← Handle_Virtual_8086_Mode_Interrupt_Redirection_Bitmap interrupt_type vector return_ip)) then
    Default_Error_Code.setEXT (← Bit (interrupt_type == Vectored_Event_Type.External_Interrupt))
    try
      Handle_Vectored_Event.interpreted interrupt_type vector (← get).Default_Error_Code return_ip
    catch exception =>
      match exception with
      | .raised (.Exception_Info e) =>
        -- Only INT n, INT3 and INTO deliver nested faults without EXT.
        if (interrupt_type != Vectored_Event_Type.Software_Interrupt_INTn and interrupt_type != Vectored_Event_Type.Software_Exception_INT3_Or_INTO and (← (do let subject := e.vector; pure ((subject == TS_Exception) || (subject == NP_Exception) || (subject == SS_Exception) || (subject == GP_Exception) || (subject == AC_Exception))))) then
          throw (.raised (↑({
            vector := e.vector,
            linear_address := e.linear_address,
            error_code := (← concatBits (leftSize := 31) (rightSize := 1) (← e.error_code[31:1]) (1 : Runtime.Bit))
          } : Exception_Info) : Exception))
        throw (.raised (↑e : Exception))
      | _ => throw exception

end X86.Helpers
