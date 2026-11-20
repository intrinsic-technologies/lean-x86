-- Generated from data/definitions.xml.gz: Load_Segment_Descriptor_High; do not edit.
-- Source SHA256: 4b82c0b439f47c0ce66397c3e697e6e6b2fbe1249b95c0f5a603981906447255
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Load_Segment_Descriptor_High)
import X86.Runtime
import X86.Helpers.Calculate_And_Check_Descriptor_Linear_Address
import X86.Helpers.Descriptor_High
import X86.Helpers.Linear_Mem_Read
import X86.Helpers.Segment_Selector
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

def Load_Segment_Descriptor_High
    (segment_selector : Segment_Selector) :
    Runtime.SpecM Exception (State σ) (Descriptor_High) := do
  let descriptor_linear_address : Bits 64 ← Calculate_And_Check_Descriptor_Linear_Address segment_selector true false
  let descriptor_high : Descriptor_High ← Linear_Mem_Read descriptor_linear_address 64 true
  return descriptor_high

end X86.Helpers
