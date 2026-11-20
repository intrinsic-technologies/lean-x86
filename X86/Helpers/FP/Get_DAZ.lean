-- Generated from data/definitions.xml.gz: FP::Get_DAZ; do not edit.
-- Source SHA256: b9d9f05eb6171f1c2d18cfff74cfd7b1c7742430957b1c1bb919f569773b0650
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AGet_DAZ)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Read_MXCSR_DAZ16.Binding σ]

def FP.Get_DAZ (size : Int) : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← (do if size == 16 then pure ((← Read_MXCSR_DAZ16 (← get).MXCSR) == 1) else pure ((← MXCSR.DAZ) == 1)))

end X86.Helpers
