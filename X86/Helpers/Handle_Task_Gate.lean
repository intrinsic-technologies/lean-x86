-- Generated from data/definitions.xml.gz: Handle_Task_Gate; do not edit.
-- Source SHA256: 54d6f8ff84e70e841258cb0dbda6a381d2ee23f8af8a5d57d51e2c247f59c0f4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Handle_Task_Gate)
import X86.Runtime
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Is_Local_Segment_Selector
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Segment_Not_Present
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Segment_Type
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

def Handle_Task_Gate (gate : Segment) : Runtime.SpecM Exception (State σ) (Segment) := do

  Runtime.assert ((← Get_Segment_Type gate) == Segment_Type.System_Task_Gate)

  if ((← Segment_Descriptor.P.partial gate.descriptor) == 0) then
    liftM (Report_Segment_Not_Present (← Get_Error_Code_From_Selector gate.selector))

  let new_task_selector : Segment_Selector ← Segment_Descriptor.Selector.partial gate.descriptor

  if ((← Is_Null_Segment_Selector new_task_selector) or (← Is_Local_Segment_Selector new_task_selector)) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_task_selector))

  let new_task : Segment ← Load_Segment_Descriptor new_task_selector (← get).TR true

  return new_task

end X86.Helpers
