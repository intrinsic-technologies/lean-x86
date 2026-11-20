-- Generated from data/definitions.xml.gz: Is_Code_Segment; do not edit.
-- Source SHA256: 5752efdca5301b83b3c5f14e7e6848f3df61155d5a75e01657e01e84563cb23c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Code_Segment)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Code_Segment (segment : Segment) : Except (Runtime.Error Empty) (Bool) := do
  return (← Segment_Descriptor.S.partial segment.descriptor) == 1 and (← Segment_Descriptor.Code.partial segment.descriptor) == 1

end X86.Helpers
