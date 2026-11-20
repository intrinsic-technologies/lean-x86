-- Generated from data/definitions.xml.gz: Handle_Task; do not edit.
-- Source SHA256: 731e37e2f25b9207a6aad1183ac664be63fe1f049d7dd0115e7ef31517f98e23
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Handle_Task)
import X86.Runtime
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Handle_Task_Gate
import X86.Helpers.Is_Local_Segment_Selector
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Is_System_Segment
import X86.Helpers.Is_Task_Segment
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Segment_Type
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Task_Switch
import X86.Helpers.Task_Switch_Initiator
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]
  [X86.Helpers.Check_New_TSS.Binding σ]
  [X86.Helpers.Load_New_TSS.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Handle_Task
    (new_cs : Segment) (initiator : Task_Switch_Initiator) (return_ip : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (← Is_Task_Segment new_cs)

  if ((← get).IA32_EFER.LMA == 1 or not (← Is_System_Segment new_cs) or decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < (← get).CPL) or decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < Unsigned (Segment_Selector.RPL new_cs.selector))) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

  let mut new_task : Segment := new_cs

  if ((← Get_Segment_Type new_cs) == Segment_Type.System_Task_Gate) then
    new_task := (← Handle_Task_Gate new_cs)

  if ((← Is_Null_Segment_Selector new_task.selector) or (← Is_Local_Segment_Selector new_task.selector)) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_task.selector))

  Task_Switch new_task initiator (← get).RFLAGS return_ip false (← Std.Bits.Zero 32)

end X86.Helpers
