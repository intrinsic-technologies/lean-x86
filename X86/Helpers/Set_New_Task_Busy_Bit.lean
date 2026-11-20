-- Generated from data/definitions.xml.gz: Set_New_Task_Busy_Bit; do not edit.
-- Source SHA256: 83353f23b987724372cf9ca91c1f0e827579a7fa1b7bd9b63010e93772a37b35
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Set_New_Task_Busy_Bit)
import X86.Runtime
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Store_Segment_Descriptor
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]

def Set_New_Task_Busy_Bit
    (selector : Segment_Selector) :
    Runtime.SpecM Exception (State σ) (Segment) := do
  -- todo: The read-modify-write action in this function should be atomic
  let mut task : Segment ← Load_Segment_Descriptor selector (← get).TR true
  if ((← Segment_Descriptor.R.partial task.descriptor) == 0) then
    task := { task with descriptor := (← Segment_Descriptor.setR.partial task.descriptor (1 : Runtime.Bit)) }
    Store_Segment_Descriptor task true
  return task

end X86.Helpers
