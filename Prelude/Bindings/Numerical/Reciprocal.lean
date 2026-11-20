import Prelude.Bindings.Numerical.Approximation
import X86.Helpers.Emulate_RCPSS
import X86.Helpers.FP.Reciprocal
import X86.Machine.Bindings

set_option autoImplicit false

namespace Prelude.Bindings.Numerical.Reciprocal

open X86

open Prelude.Bindings.Contract Prelude.Bindings.Numerical.Approximation

open X86.Runtime
open Prelude.Float.Binary32

/-- For positive magnitudes, this is exactly |y / (1/x) - 1| ≤ 3/8192. -/
def relativeAccuracy (x y : Bits 32) : Prop :=
  let product := magnitude x * magnitude y
  lowerFactor ≤ product ∧ product ≤ upperFactor

instance (x y : Bits 32) : Decidable (relativeAccuracy x y) :=
  inferInstanceAs (Decidable (_ ∧ _))

/-- The lower and upper printed magnitudes in SDM 093. The printed directions
of their guarantee inequalities conflict. -/
def lowerBoundary : Bits 32 := 0x7e7fe800

def upperBoundary : Bits 32 := 0x7e800c01

inductive InputRegion where
  | outsideNormalDomain
  | normalResult
  | tinyResult
  | unresolvedBoundary
  deriving DecidableEq, Repr

/-- Below the lower boundary, the accuracy bound prevents a tiny result.
Above the upper boundary, it prevents a normal result. Between them, the
contradictory printed guarantees are unresolved; this does not certify outputs. -/
def inputRegion (x : Bits 32) : InputRegion :=
  if !isNormal x then .outsideNormalDomain
  else
    let rawMagnitude := x.toNat % 2 ^ 31
    if rawMagnitude ≤ lowerBoundary.toNat then .normalResult
    else if upperBoundary.toNat ≤ rawMagnitude then .tinyResult
    else .unresolvedBoundary

/-- A pointwise contract for the certified domain. NaNs, infinities, zeros,
subnormal inputs, and the unresolved transition range have no certificate here.
The generated instruction wrappers retain the architectural special cases. -/
def certifiedResult (x y : Bits 32) : Prop :=
  sign y = sign x ∧
    match inputRegion x with
    | .normalResult => isNormal y = true ∧ relativeAccuracy x y
    | .tinyResult => isZero y = true
    | .outsideNormalDomain | .unresolvedBoundary => False

instance (x y : Bits 32) : Decidable (certifiedResult x y) := by
  unfold certifiedResult
  cases inputRegion x <;> infer_instance

/-- Necessary accuracy/flushing envelope without selecting the contradictory
printed transition cutoff. A zero requires that an accuracy-bounded positive
preflush estimate can lie strictly below minimumNormal:
(1-epsilon)/|x| < minimumNormal. -/
def numericalEnvelope (x y : Bits 32) : Prop :=
  isNormal x = true ∧ sign y = sign x ∧
    ((isNormal y = true ∧ relativeAccuracy x y) ∨
      (isZero y = true ∧ lowerFactor < magnitude x * minimumNormal))

instance (x y : Bits 32) : Decidable (numericalEnvelope x y) :=
  inferInstanceAs (Decidable (_ ∧ _))

/-- The SDM requirement for every normal input: the uncontested regions retain
their certificates and the unresolved transition uses the necessary envelope. -/
def result (x y : Bits 32) : Prop :=
  if inputRegion x = .unresolvedBoundary then numericalEnvelope x y
  else certifiedResult x y

instance (x y : Bits 32) : Decidable (result x y) := by
  unfold result
  infer_instance

/-- Binary32 FP wrapper result, including signed zero/subnormal/infinity and
payload-preserving NaN handling. Every normal input retains the numerical
requirement. Instruction decoding, memory faults and destination-lane
preservation are outside this relation. -/
def wrapperResult (x y : Bits 32) : Prop :=
  if isNaN x then y = quietNaN x
  else if exponent x = 0 then y = signedInfinity x
  else if isInfinite x then y = signedZero x
  else result x y

instance (x y : Bits 32) : Decidable (wrapperResult x y) := by
  unfold wrapperResult
  infer_instance

/-- Every normal helper input requires a successful numerical result. -/
def contract {σ : Type} : Contract (State σ) (Bits 32) (Bits 32) :=
  Contract.mk (fun _ x => Prelude.Float.Binary32.isNormal x = true) (fun _ x y => result x y)

def Satisfies {σ : Type} (implementation : Helpers.Emulate_RCPSS.Binding σ) : Prop :=
  contract.Satisfies (m := Id) implementation.call ∧ RoundingControlIndependent implementation.call

/-- The generated binary32 wrapper using the selected numerical binding. -/
def wrapper {σ : Type} (bindings : X86.Machine.Bindings) (input : Bits 32) :
    Runtime.SpecM Exception (State σ) (Bits 32) :=
  letI : X86.Machine.Bindings.Numerical σ := bindings.numerical
  Helpers.FP.Reciprocal input

/-- The complete binary32 FP wrapper, including its deterministic special cases. -/
def Wrapper.contract {σ : Type} : Contract (State σ) (Bits 32) (Bits 32) :=
  Contract.mk (fun _ _ => True) (fun _ x y => wrapperResult x y)

def Wrapper.Satisfies {σ ε : Type}
    (implementation : Bits 32 → Runtime.SpecM ε (State σ) (Bits 32)) : Prop :=
  (∀ input before, match (implementation input).run before with
    | (.ok output, after) => after = before ∧ Wrapper.contract.post before input output
    | (.error _, _) => False) ∧
    RoundingControlIndependent (fun input state => ((implementation input).run state).1)

end Prelude.Bindings.Numerical.Reciprocal
