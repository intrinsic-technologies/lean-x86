-- Generated from data/definitions.xml.gz: FP::Prioritize_Operand_Exceptions; do not edit.
-- Source SHA256: ddea82d77b1ef6ed9d658fc81ba4780ef177ec8583de12efc50ecc9018b29b51
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3APrioritize_Operand_Exceptions)
import X86.Runtime
import X86.Helpers.FP_Exception_Flags_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP.Prioritize_Operand_Exceptions
    (exceptions : FP_Exception_Flags_Type) (mask : Bits 6) :
    Except (Runtime.Error Empty) (FP_Exception_Flags_Type) := do
  let unmasked_exceptions : FP_Exception_Flags_Type := exceptions and ~~~ mask
  if (FP_Exception_Flags_Type.IE exceptions == 1) then
    return 1
  else
    if (FP_Exception_Flags_Type.ZE exceptions == 1) then
      return 4
    else
      if (FP_Exception_Flags_Type.DE unmasked_exceptions == 1) then
        return 2
      else
        return exceptions

end X86.Helpers
