-- Generated from data/definitions.xml.gz: Store_Segment_Descriptor; do not edit.
-- Source SHA256: 88f70633abf65327f60918963217140c34c033e615a9f843d578515b36e887ef
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Store_Segment_Descriptor)
import X86.Runtime
import X86.Helpers.Calculate_And_Check_Descriptor_Linear_Address
import X86.Helpers.Linear_Mem_Write
import X86.Helpers.Segment
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]

def Store_Segment_Descriptor
    (segment : Segment) (is_task_switch : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  let descriptor_linear_address : Bits 64 ← Calculate_And_Check_Descriptor_Linear_Address segment.selector false is_task_switch
  Linear_Mem_Write descriptor_linear_address 64 (← Runtime.InitializedBits.read segment.descriptor) true

end X86.Helpers
