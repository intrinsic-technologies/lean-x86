-- Generated from data/definitions.xml.gz: FP::Prioritize_Exceptions; do not edit.
-- Source SHA256: a4ed29ac90a8322026d3bf79f21938ede78ca2ef7f06bcd3ebc70849de907c2b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3APrioritize_Exceptions)
import X86.Runtime
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP.Prioritize_Exceptions
    (exceptions : FP_Exception_Flags_Type) (mask : Bits 6) :
    Except (Runtime.Error Empty) (FP_Exception_Flags_Type) := do
  let unmasked_pre_exceptions : Bool := not (← Std.Bits.Is_Zero (size := 3) ((← exceptions[2:0]) and ~~~ (← mask[2:0])))

  -- Only report post-computation exceptions if there are no unmasked pre-computation exceptions
  return (← (do if unmasked_pre_exceptions then pure (← concatBits (leftSize := 3) (rightSize := 3) (0 : Bits 3) (← exceptions[2:0])) else pure exceptions))

end X86.Helpers
