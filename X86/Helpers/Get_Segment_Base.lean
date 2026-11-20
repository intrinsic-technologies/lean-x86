-- Generated from data/definitions.xml.gz: Get_Segment_Base; do not edit.
-- Source SHA256: 10286f1ef4e2e3d29fb734604e33c166dce02226ad1bf88365995b71b406a71b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Segment_Base)
import X86.Runtime
import X86.Helpers.Descriptor_High
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Get_Segment_Base (segment : Segment) : Except (Runtime.Error Empty) (Bits 64) := do
  return (← concatBits (leftSize := 32) (rightSize := 32) (← Descriptor_High.Base_High.partial segment.descriptor_high) (← Segment_Descriptor.Base.partial segment.descriptor))

end X86.Helpers
