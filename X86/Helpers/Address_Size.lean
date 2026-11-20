-- Generated from data/definitions.xml.gz: Address_Size; do not edit.
-- Source SHA256: 26b1310b5bfb47bd7244c27a3a15de163f86e51c7bf636169d6d020f84fc5239
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Address_Size)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Address_Size (context : Instruction_Context) : Runtime.SpecM Exception (State σ) (Int) := do
  if context.is_mode64 then
    return if context.asz_prefix_present then 32 else 64
  else
    if ((← Segment_Descriptor.D.partial (← get).CS.descriptor) == 0) then
      return if context.asz_prefix_present then 32 else 16
    else
      return if context.asz_prefix_present then 16 else 32

end X86.Helpers
