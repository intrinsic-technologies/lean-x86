-- Generated from data/definitions.xml.gz: FP::Unpack; do not edit.
-- Source SHA256: 950896d1c86a6a1da59ff4df2d364e424a4ac18e5e0435bfa072da7a6d777108
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AUnpack)
import X86.Runtime
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Unpack {size : Int}
    (x : Bits size) (e_size : Int) (denormals_are_zeros : Bool) :
    Runtime.SpecM Exception (State σ) (UFloat e_size size) := do
  Runtime.assert (size == 16 || size == 32 || size == 64)
  Runtime.assert (e_size in {2..(size - (2 : Int))})

  let ctx : RoundingContext e_size size ← IEEE754Context e_size size
  let px : PackedFloat e_size size ← PFloat (E := e_size) (N := size) x ctx
  let ux : UFloat e_size size ← PFloatUnpack (E := e_size) (N := size) px
  return (← (do if denormals_are_zeros and (← UFloatIsSubnormal (E := e_size) (N := size) ux) then pure (← ContextZero (E := e_size) (N := size) ctx ux.sign) else pure ux))

end X86.Helpers
