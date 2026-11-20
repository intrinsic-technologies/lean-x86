-- Generated from data/definitions.xml.gz: FP::Reciprocal; do not edit.
-- Source SHA256: 9f44e9ac605097d2c737a62e28b5d2750bc2e3173848b0a2d3370d6462e635a6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AReciprocal)
import X86.Runtime
import X86.Helpers.Emulate_RCPSS
import X86.Helpers.FP.Pack
import X86.Helpers.FP.Rounding_Context
import X86.Helpers.FP.Unpack
import X86.Helpers.Rounding_Mode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Unreachable
import X86.Helpers.UFloatClass
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatRound
import X86.Helpers.Unimplemented_Feature
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.Emulate_RCPSS.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]

def FP.Reciprocal {N : Int} (x : Bits N) : Runtime.SpecM Exception (State σ) (Bits N) := do
  Runtime.assert (N == 16 || N == 32)

  Runtime.assert ((N == (16 : Int)) || (N == (32 : Int)))
  let E : Int := if N == 16 then 5 else 8
  let ctx : RoundingContext E N ← FP.Rounding_Context E N Rounding_Mode.Rounding_Mode_RNE true
  let ux : UFloat E N ← FP.Unpack (size := N) x E true
  let mut ur : Option (UFloat E N) := none

  let x_class : UFloatClass_Type ← UFloatClass (E := E) (N := N) ux

  match x_class with
  | UFloatClass_Type.UFLOAT_CLASS_SIGNALING_NAN => do
    ur := some (← UFloatRound (Ex := E) (Nx := N) (Er := E) (Nr := N) ux ctx)

  | UFloatClass_Type.UFLOAT_CLASS_QUIET_NAN => do
    ur := some ux

  | UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_INFINITY | UFloatClass_Type.UFLOAT_CLASS_POSITIVE_INFINITY => do
    ur := some (← ContextZero (E := E) (N := N) ctx ux.sign)

  | UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_ZERO | UFloatClass_Type.UFLOAT_CLASS_POSITIVE_ZERO | UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_SUBNORMAL | UFloatClass_Type.UFLOAT_CLASS_POSITIVE_SUBNORMAL => do
    -- denormal inputs always treated as zero
    ur := some (← ContextInfinity (E := E) (N := N) ctx ux.sign)

  | UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_NORMAL | UFloatClass_Type.UFLOAT_CLASS_POSITIVE_NORMAL => do
    if (N == 32) then
      let r : Bits 32 ← Emulate_RCPSS (← x[0 +: 32])
      Runtime.assert (decide (N ≤ 32))
      return (← r[0 +: N])
    else
      Unimplemented_Feature "FP::Reciprocal 16-bit" false true
      return (← Std.Bits.Zero N)

  let r : Bits N ← FP.Pack (size := N) (e_size := E) (← Runtime.readInitialized ur)
  return r

end X86.Helpers
