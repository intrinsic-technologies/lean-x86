import Prelude.Bindings.Numerical.Approximation
import X86.Machine.Bindings
import X86.Helpers.FP.Reciprocal_Sqrt

set_option autoImplicit false

namespace Prelude.Bindings.Numerical.ReciprocalSqrt

open X86 X86.Runtime
open Prelude.Bindings.Contract Prelude.Float.Binary32
open Prelude.Bindings.Numerical.Approximation

/-- For positive x,y, squaring this positive interval is equivalent to
|y / (1/sqrt(x)) - 1| ≤ 3/8192. No rounded intermediate square root is used. -/
def relativeAccuracy (x y : Bits 32) : Prop :=
  let squareProduct := magnitude x * magnitude y * magnitude y
  lowerFactor * lowerFactor ≤ squareProduct ∧
    squareProduct ≤ upperFactor * upperFactor

instance (x y : Bits 32) : Decidable (relativeAccuracy x y) :=
  inferInstanceAs (Decidable (_ ∧ _))

/-- Pointwise helper contract on finite normal inputs. Negative normal values
produce Intel's binary32 floating-point indefinite. Positive normal inputs
require a positive normal output satisfying the exact relative error bound.
All other input classes are handled by the generated architectural wrappers. -/
def result (x y : Bits 32) : Prop :=
  isNormal x = true ∧
    if sign x then y = indefinite
    else isNormal y = true ∧ sign y = false ∧ relativeAccuracy x y

instance (x y : Bits 32) : Decidable (result x y) :=
  inferInstanceAs (Decidable (_ ∧ _))

/-- RSQRT's denormal-as-signed-zero rule precedes its negative-value rule.
NaNs preserve their sign and payload while becoming quiet; negative normals
and negative infinity return the floating-point indefinite. -/
def wrapperResult (x y : Bits 32) : Prop :=
  if isNaN x then y = quietNaN x
  else if exponent x = 0 then y = signedInfinity x
  else if sign x then y = indefinite
  else if isInfinite x then y = 0
  else result x y

instance (x y : Bits 32) : Decidable (wrapperResult x y) := by
  unfold wrapperResult
  infer_instance

/-- The RSQRT helper's normal-input domain includes negative normals, whose
required result is the architectural floating-point indefinite. -/
def contract {σ : Type} : Contract (State σ) (Bits 32) (Bits 32) :=
  Contract.mk (fun _ x => Prelude.Float.Binary32.isNormal x = true) (fun _ x y => result x y)

def Satisfies {σ : Type} (implementation : Helpers.Emulate_RSQRTSS.Binding σ) : Prop :=
  contract.Satisfies (m := Id) implementation.call ∧ RoundingControlIndependent implementation.call

/-- The generated wrapper retains its deterministic special-case branches. -/
def wrapper {σ : Type} (bindings : X86.Machine.Bindings) (input : Bits 32) :
    Runtime.SpecM Exception (State σ) (Bits 32) :=
  letI : X86.Machine.Bindings.Numerical σ := bindings.numerical
  Helpers.FP.Reciprocal_Sqrt input

/-- The binary32 reciprocal-square-root FP wrapper admits every input encoding.
No SIMD floating-point exception or architectural state change is allowed. -/
def Wrapper.contract {σ : Type} : Contract (State σ) (Bits 32) (Bits 32) :=
  Contract.mk (fun _ _ => True) (fun _ x y => wrapperResult x y)

def Wrapper.Satisfies {σ ε : Type}
    (implementation : Bits 32 → Runtime.SpecM ε (State σ) (Bits 32)) : Prop :=
  (∀ input before, match (implementation input).run before with
    | (.ok output, after) => after = before ∧ Wrapper.contract.post before input output
    | (.error _, _) => False) ∧
    RoundingControlIndependent (fun input state => ((implementation input).run state).1)

end Prelude.Bindings.Numerical.ReciprocalSqrt
