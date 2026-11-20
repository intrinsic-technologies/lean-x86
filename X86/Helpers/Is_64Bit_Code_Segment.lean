-- Generated from data/definitions.xml.gz: Is_64Bit_Code_Segment; do not edit.
-- Source SHA256: 499a16cdb152c91acb49d307c17964bfd9e5f16449ccdb7a60cf1a1f96061ea1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_64Bit_Code_Segment)
import X86.Runtime
import X86.Helpers.Is_Code_Segment
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Is_64Bit_Code_Segment (segment : Segment) : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← get).IA32_EFER.LMA == 1 and (← Is_Code_Segment segment) and (← Segment_Descriptor.L.partial segment.descriptor) == 1 and (← Segment_Descriptor.D.partial segment.descriptor) == 0

end X86.Helpers
