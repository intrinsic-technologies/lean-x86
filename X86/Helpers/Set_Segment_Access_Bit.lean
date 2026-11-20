-- Generated from data/definitions.xml.gz: Set_Segment_Access_Bit; do not edit.
-- Source SHA256: 45f4000d913332033726fe50e77789fa7cdc8d101ba4b09b172b5239d0180cf1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Set_Segment_Access_Bit)
import X86.Runtime
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
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

def Set_Segment_Access_Bit
    (segment : Segment) (is_task_switch : Bool := false) :
    Runtime.SpecM Exception (State σ) (Segment) := do
  Runtime.assert ((← Segment_Descriptor.A.partial segment.descriptor) == 0)

  -- todo: this should be an atomic, read-modify-write operation
  let mut new_segment : Segment ← Load_Segment_Descriptor segment.selector segment is_task_switch
  new_segment := { new_segment with descriptor := (← Segment_Descriptor.setA.partial new_segment.descriptor (1 : Runtime.Bit)) }
  Store_Segment_Descriptor new_segment is_task_switch

  return new_segment

end X86.Helpers
