-- Generated from data/definitions.xml.gz: In_64Bit_Mode; do not edit.
-- Source SHA256: 775bb0bcede4e42858fae96b6ca55e6f4fbe575467930e489cf98faac9564ac5
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=In_64Bit_Mode)
import X86.Runtime
import X86.Helpers.Is_64Bit_Code_Segment
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def In_64Bit_Mode  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Is_64Bit_Code_Segment (← get).CS)

end X86.Helpers
