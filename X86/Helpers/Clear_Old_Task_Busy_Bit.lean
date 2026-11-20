-- Generated from data/definitions.xml.gz: Clear_Old_Task_Busy_Bit; do not edit.
-- Source SHA256: 128151ca32c2e2e64616171156e00ecd2eeafd4f5d02032982fa026bb3a41e98
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Clear_Old_Task_Busy_Bit)
import X86.Runtime
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Segment
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

def Clear_Old_Task_Busy_Bit
    (selector : Segment_Selector) :
    Runtime.SpecM Exception (State σ) Unit := do
  -- todo: The read-modify-write action in this function should be atomic
  let mut task : Segment ← Load_Segment_Descriptor selector (← get).TR true
  task := { task with descriptor := (← Segment_Descriptor.setR.partial task.descriptor (0 : Runtime.Bit)) }
  Store_Segment_Descriptor task true

end X86.Helpers
