-- Generated from data/definitions.xml.gz: Set_Segment_Base; do not edit.
-- Source SHA256: dc3c98bb9d860a15d8632ed6e282c772ef56b85e2ee2a2d7c56efabee475e21f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Set_Segment_Base)
import X86.Runtime
import X86.Helpers.Segment
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Set_Segment_Base
    (value : Bits 64) (segment : Segment) :
    Except (Runtime.Error Empty) (Segment) := do
  let mut new_segment : Segment := segment
  new_segment := { new_segment with descriptor := (← Segment_Descriptor.setBase.partial new_segment.descriptor (← value[31:0])) }
  new_segment := { new_segment with descriptor_high := (← Descriptor_High.setBase_High.partial new_segment.descriptor_high (← value[63:32])) }
  return new_segment

end X86.Helpers
