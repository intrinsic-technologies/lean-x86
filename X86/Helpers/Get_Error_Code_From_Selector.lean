-- Generated from data/definitions.xml.gz: Get_Error_Code_From_Selector; do not edit.
-- Source SHA256: 58d34c4d9fae63250a1335e8a55d5ff82dfb01e07733cef2fb0ef7540d21eae3
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Error_Code_From_Selector)
import X86.Runtime
import X86.Helpers.Segment_Selector
import X86.Helpers.Selector_Error_Code
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Get_Error_Code_From_Selector
    (selector : Segment_Selector) :
    Except (Runtime.Error Empty) (Selector_Error_Code) := do
  let error_code : Bits 32 ← concatBits (leftSize := 30) (rightSize := 2) (← concatBits (leftSize := 16) (rightSize := 14) (← Std.Bits.Zero 16) (← selector[15:2])) (0 : Bits 2)
  return error_code

end X86.Helpers
