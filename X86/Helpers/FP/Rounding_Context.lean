-- Generated from data/definitions.xml.gz: FP::Rounding_Context; do not edit.
-- Source SHA256: 623ab36dbe420e0f5eb3fa11a5ba078d77642bdc5696119693bc6f83011417b6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3ARounding_Context)
import X86.Runtime
import X86.Helpers.Rounding_Mode
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Rounding_Context
    (E N : Int) (rm : Rounding_Mode) (flush_subnormals : Bool) :
    Runtime.SpecM Exception (State σ) (RoundingContext E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return { ({ (← IEEE754Context E N) with rm := some rm } : RoundingContext E N) with flush_subnormals := some flush_subnormals }

end X86.Helpers
