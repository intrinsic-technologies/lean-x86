-- Generated from data/definitions.xml.gz: FP87::Negate; do not edit.
-- Source SHA256: 4ef42be169d464d5118d0693d5f1ca787468fbf3becbdda54aaa662c1bd13e8a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ANegate)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Negate (x : F80_Type) : Except (Runtime.Error Empty) (F80_Type) := do
  let mut r : F80_Type := x
  r := F80_Type.setSign r (~~~ (F80_Type.Sign x))
  return r

end X86.Helpers
