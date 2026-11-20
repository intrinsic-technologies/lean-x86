-- Generated from data/definitions.xml.gz: FP87::Abs; do not edit.
-- Source SHA256: aa47659e91bf45f109e7aa4570b771f926bf4761e8af305c3e74cb9f3ae2cee5
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AAbs)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Abs (x : F80_Type) : Except (Runtime.Error Empty) (F80_Type) := do
  let mut r : F80_Type := x
  r := F80_Type.setSign r (0 : Runtime.Bit)
  return r

end X86.Helpers
