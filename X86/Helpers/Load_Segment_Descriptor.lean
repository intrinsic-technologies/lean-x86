-- Generated from data/definitions.xml.gz: Load_Segment_Descriptor; do not edit.
-- Source SHA256: f36c7ad9342ee4b3e68cec8b2b93a7efd5734846cceb1ba8f5b4352ea70361d6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Load_Segment_Descriptor)
import X86.Runtime
import X86.Helpers.Calculate_And_Check_Descriptor_Linear_Address
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Linear_Mem_Read
import X86.Helpers.Null_Segment
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Zero
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

def Load_Segment_Descriptor
    (segment_selector : Segment_Selector) (segment : Segment) (is_task_switch : Bool := false) :
    Runtime.SpecM Exception (State σ) (Segment) := do
  if (← Is_Null_Segment_Selector segment_selector) then
    return (← Null_Segment segment)
  else
    let descriptor_linear_address : Bits 64 ← Calculate_And_Check_Descriptor_Linear_Address segment_selector false is_task_switch
    let mut new_segment : Segment := segment
    new_segment := { new_segment with selector := segment_selector }
    new_segment := { new_segment with descriptor := Runtime.InitializedBits.ofValue (← Linear_Mem_Read descriptor_linear_address 64 true) }
    new_segment := { new_segment with descriptor_high := Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64) }
    new_segment := { new_segment with descriptor_valid := some true }
    return new_segment

end X86.Helpers
