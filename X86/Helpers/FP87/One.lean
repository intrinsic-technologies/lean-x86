-- Generated from data/definitions.xml.gz: FP87::One; do not edit.
-- Source SHA256: df9c987d28795481afdcb313dd14665d9e9c1cfbda0dd38479d5031981e4fe4f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AOne)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.One (sign : Runtime.Bit) : Except (Runtime.Error Empty) (F80_Type) := do
  let one : F80_Type ← concatBits (leftSize := 1) (rightSize := 79) sign (← concatBits (leftSize := 15) (rightSize := 64) (← (16383 : Bits 16)[0 +: 15]) (9223372036854775808 : Bits 64))
  return one

end X86.Helpers
