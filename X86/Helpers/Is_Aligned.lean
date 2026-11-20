-- Generated from data/definitions.xml.gz: Is_Aligned; do not edit.
-- Source SHA256: d6895dee3bf8622ef5a63130dc62b973d24a2e5d5b170d7c098dda5bdab2e1d6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Aligned)
import X86.Runtime
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Aligned {n : Int} (x : Bits n) (size : Int) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ n)
  Runtime.assert (0 ≤ size)

  return (← Std.Integer.Positive_Remainder (Unsigned x) size) == 0

end X86.Helpers
