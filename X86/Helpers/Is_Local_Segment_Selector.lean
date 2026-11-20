-- Generated from data/definitions.xml.gz: Is_Local_Segment_Selector; do not edit.
-- Source SHA256: 4a9e1680a0281c09a44cd0e9f85aa58f362eb0ddfbec879e1a5ba6c9fc656151
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Local_Segment_Selector)
import X86.Runtime
import X86.Helpers.Segment_Selector
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Local_Segment_Selector
    (segment_selector : Segment_Selector) :
    Except (Runtime.Error Empty) (Bool) := do
  return Segment_Selector.TI segment_selector == 1

end X86.Helpers
