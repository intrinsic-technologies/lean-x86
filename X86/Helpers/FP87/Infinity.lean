-- Generated from data/definitions.xml.gz: FP87::Infinity; do not edit.
-- Source SHA256: 4931fe40d78f92f5ebabcc3f53f8deccd39304601e292f14de65198f1357eba1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AInfinity)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Infinity (sign : Runtime.Bit) : Except (Runtime.Error Empty) (F80_Type) := do
  let infinity : F80_Type ← concatBits (leftSize := 1) (rightSize := 79) sign (← concatBits (leftSize := 15) (rightSize := 64) (← (32767 : Bits 16)[0 +: 15]) (9223372036854775808 : Bits 64))
  return infinity

end X86.Helpers
