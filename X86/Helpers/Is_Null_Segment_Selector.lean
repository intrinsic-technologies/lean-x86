-- Generated from data/definitions.xml.gz: Is_Null_Segment_Selector; do not edit.
-- Source SHA256: f8c5e2a636ccd670990790bddc285fc6635baf8e6729eb4c5a62d2f492feab7c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Null_Segment_Selector)
import X86.Runtime
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Null_Segment_Selector
    (segment_selector : Segment_Selector) :
    Except (Runtime.Error Empty) (Bool) := do
  return (← Std.Bits.Is_Zero (size := 13) (Segment_Selector.Index segment_selector)) and (← Std.Bits.Is_Zero (size := 1) (Segment_Selector.TI segment_selector))

end X86.Helpers
