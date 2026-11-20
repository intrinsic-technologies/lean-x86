-- Generated from data/definitions.xml.gz: FP87::Zero; do not edit.
-- Source SHA256: 31b213597963bc7f8ca8b8278f5d559fe23ee23c09ddeb7d03e06d2cc3a5454a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AZero)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Zero (sign : Runtime.Bit) : Except (Runtime.Error Empty) (F80_Type) := do
  let mut zero : F80_Type ← Std.Bits.Zero 80
  zero := F80_Type.setSign zero sign
  return zero

end X86.Helpers
