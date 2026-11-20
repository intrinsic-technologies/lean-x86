-- Generated from data/definitions.xml.gz: FP::Reciprocal_Sqrt; do not edit.
-- Source SHA256: 194de5bee6337cbe2931f75c51696ff75f11bb2f67e06a79d7d6c60b34b2c118
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AReciprocal_Sqrt)
import X86.Runtime
import X86.Helpers.Emulate_RCPSS
import X86.Helpers.FP.Pack
import X86.Helpers.FP.QNaN_Indefinite
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
  [X86.Helpers.Emulate_RSQRTSS.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]

def FP.Reciprocal_Sqrt {N : Int} (x : Bits N) : Runtime.SpecM Exception (State σ) (Bits N) := do
  Runtime.assert (N == 16 || N == 32)

  Runtime.assert ((N == (16 : Int)) || (N == (32 : Int)))
  let E : Int := if N == 16 then 5 else 8
  let ctx : RoundingContext E N ← FP.Rounding_Context E N Rounding_Mode.Rounding_Mode_RNE true
  -- denormals will be handled separately below, due the special behavior
  -- for half-precision (N=16) negative denormals
  let ux : UFloat E N ← FP.Unpack (size := N) x E false
  let mut ur : Option (UFloat E N) := none

  let x_class : UFloatClass_Type ← UFloatClass (E := E) (N := N) ux

  match x_class with
  | UFloatClass_Type.UFLOAT_CLASS_SIGNALING_NAN => do
    ur := some (← UFloatRound (Ex := E) (Nx := N) (Er := E) (Nr := N) ux ctx)

  | UFloatClass_Type.UFLOAT_CLASS_QUIET_NAN => do
    ur := some ux

  | UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_INFINITY => do
    return (← FP.QNaN_Indefinite E N)

  | UFloatClass_Type.UFLOAT_CLASS_POSITIVE_INFINITY => do
    ur := some (← ContextZero (E := E) (N := N) ctx ux.sign)

  | UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_ZERO | UFloatClass_Type.UFLOAT_CLASS_POSITIVE_ZERO => do
    -- denormal input treated as zero
    ur := some (← ContextInfinity (E := E) (N := N) ctx ux.sign)

  | UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_SUBNORMAL => do
    if (N == 16) then
      return (← FP.QNaN_Indefinite E N)
    else
      ur := some (← ContextInfinity (E := E) (N := N) ctx ux.sign)

  | UFloatClass_Type.UFLOAT_CLASS_POSITIVE_SUBNORMAL => do
    if (N == 32) then
      ur := some (← ContextInfinity (E := E) (N := N) ctx ux.sign)
    else
      Unimplemented_Feature "FP::Reciprocal_Sqrt 16-bit subnormal" false true
      return (← Std.Bits.Zero N)

  | UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_NORMAL | UFloatClass_Type.UFLOAT_CLASS_POSITIVE_NORMAL => do
    if (N == 32) then
      let r : Bits 32 ← Emulate_RSQRTSS (← x[0 +: 32])
      Runtime.assert (decide (N ≤ 32))
      return (← r[0 +: N])
    else
      Unimplemented_Feature "FP::Reciprocal_Sqrt 16-bit" false true
      return (← Std.Bits.Zero N)

  let r : Bits N ← FP.Pack (size := N) (e_size := E) (← Runtime.readInitialized ur)
  return r

end X86.Helpers
