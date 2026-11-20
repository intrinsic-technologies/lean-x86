-- Generated from data/definitions.xml.gz: Task_Return; do not edit.
-- Source SHA256: a3f2867183730722f74c2f264e1f4bec5c3f7e5022db972d4a47041d8b3ff976
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Task_Return)
import X86.Runtime
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Is_Local_Segment_Selector
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Task_State_Segment
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

def Task_Return (return_ip : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  let previous_task_selector : Segment_Selector ← Logical_Mem_Read (← get).TR TSS_LINK_OFFSET 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false

  if ((← Is_Null_Segment_Selector previous_task_selector) or (← Is_Local_Segment_Selector previous_task_selector)) then
    liftM (Report_Invalid_TSS (← Get_Error_Code_From_Selector previous_task_selector))

  let new_task : Segment ← Load_Segment_Descriptor previous_task_selector (← get).TR true

  Task_Switch new_task Task_Switch_Initiator.Task_Switch_Iret (← get).RFLAGS return_ip false (← Std.Bits.Zero 32)

end X86.Helpers
