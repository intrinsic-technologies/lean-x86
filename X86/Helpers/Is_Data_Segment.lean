-- Generated from data/definitions.xml.gz: Is_Data_Segment; do not edit.
-- Source SHA256: f9436320e8b5fae9918a2eca2a1596bc62386ab9228f22a45fcbad48215b5c6b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Data_Segment)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Data_Segment (segment : Segment) : Except (Runtime.Error Empty) (Bool) := do
  return (← Segment_Descriptor.S.partial segment.descriptor) == 1 and (← Segment_Descriptor.Code.partial segment.descriptor) == 0

end X86.Helpers
