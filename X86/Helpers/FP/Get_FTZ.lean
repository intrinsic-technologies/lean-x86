-- Generated from data/definitions.xml.gz: FP::Get_FTZ; do not edit.
-- Source SHA256: 1917642ba33603b22a032b14b947c86782f7b63b4784086f1978d94460075bf5
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AGet_FTZ)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Read_MXCSR_FTZ16.Binding σ]

def FP.Get_FTZ (size : Int) : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← (do if size == 16 then pure ((← Read_MXCSR_FTZ16 (← get).MXCSR) == 1) else pure ((← MXCSR.FTZ) == 1)))

end X86.Helpers
