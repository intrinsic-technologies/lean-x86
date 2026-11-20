-- Generated from data/definitions.xml.gz: FP87::Is_Unmasked_Exception; do not edit.
-- Source SHA256: 0460786aebcf87d5ba011baf25358f07f24c8eebb78e4ab359885700d4711126
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AIs_Unmasked_Exception)
import X86.Runtime
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Is_Unmasked_Exception
    (exceptions : FP_Exception_Flags_Type) (mask : Bits 6) :
    Except (Runtime.Error Empty) (Bool) := do
  let unmasked_exceptions : Bits 6 := exceptions and ~~~ mask
  return not (← Std.Bits.Is_Zero (size := 6) unmasked_exceptions)

end X86.Helpers
