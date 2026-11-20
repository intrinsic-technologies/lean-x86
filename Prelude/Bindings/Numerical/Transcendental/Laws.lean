import Prelude.Bindings.Numerical.Transcendental.Analytic
import X86.Helpers.F80_Type
import X86.Helpers.FP_Exception_Flags_Type
import Prelude.Bindings.Contract

set_option autoImplicit false

namespace Prelude.Bindings.Numerical.Transcendental

open X86

open Prelude.Bindings.Contract

open X86.Helpers

open Prelude.Float.Binary80

/-- Exact algebraic form of |x| ≤ 1−√2/2, without a rounded endpoint. -/
def log2p1Domain (x : Rat) : Prop :=
  let magnitude := Rat.abs x
  magnitude ≤ 1 ∧ (1 - magnitude) * (1 - magnitude) ≥ 1 / 2

def trigonometric (op : Operation) : Bool :=
  match op with
  | .sin | .cos | .sincos | .tan => true
  | _ => false

def binary (op : Operation) : Bool :=
  match op with
  | .atan2 | .mulLog2 | .mulLog2p1 => true
  | _ => false

/-- Supported finite operands in the operation's documented domain, where the result is defined. -/
def definedResult (op : Operation) (x y : Encoding) : Prop :=
  supportedFinite x ∧ (binary op = true → supportedFinite y) ∧
  match op with
  | .exp2m1 => Rat.abs (value x) ≤ 1
  | .sin | .cos | .sincos | .tan => Rat.abs (value x) < scale2 63
  | .atan2 => value x ≠ 0 ∧ value y ≠ 0
  | .mulLog2 => 0 < value x ∧ value y ≠ 0
  | .mulLog2p1 => log2p1Domain (value x) ∧ value x ≠ 0 ∧ value y ≠ 0

/-- Outside the trigonometric input range, wrappers preserve ST(0) and ignore numerical fields.
SDM 093 Vol. 1 Table 8-1 leaves C1 undefined for all four instructions when C2=1.
FSIN/FSINCOS/FPTAN forward roundedUp into C1; FCOS obtains C1 via UNSPECIFIED. -/
def OutOfRangeLaw (op : Operation) (x : Encoding) (r : Output) : Prop :=
  trigonometric op = true → supportedFinite x →
    (r.outOfRange = true ↔ scale2 63 ≤ Rat.abs (value x)) ∧
    (r.outOfRange = true → r.flags = 0)

/-- SDM 093 F2XM1 Table 1-12 gives an ordinary result range, not exact
endpoint encodings or precision flags. UE-clear outcomes exclude biased underflow. -/
def ExponentialRangeLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → op = .exp2m1 → FP_Exception_Flags_Type.UE r.flags = 0 →
    F80_Type.Sign r.first = F80_Type.Sign x ∧ -1 / 2 ≤ value r.first ∧ value r.first ≤ 1

/-- SDM 093 FYL2X Table 1-44 gives signed zero at x=1; Vol. 1, 4.9.1.4/5
exclude range exceptions for this exact zero, including the computed denormal-y path. -/
def ExactLogarithmLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  op = .mulLog2 → definedResult op x y → value x = 1 →
    r.first = F80_Type.setSign (0 : Encoding) (F80_Type.Sign y) ∧
    FP_Exception_Flags_Type.OE r.flags = 0 ∧ FP_Exception_Flags_Type.UE r.flags = 0

/-- The documented reduced-argument regions use mathematical π. -/
def accuracyRegion (op : Operation) (x : Rat) : Prop :=
  if op = .sin then LimitLT (constant (Rat.abs x)) (fun n => 3 * piSequence n / 4)
  else if trigonometric op then LimitLT (constant (Rat.abs x)) (fun n => 3 * piSequence n / 8)
  else True

/-- The 1.35 ulp multiplier applies to two-operand logarithms in nearest mode. -/
def errorBound (op : Operation) (rounding : X86.Helpers.Rounding_Mode) (y : Rat) : Rat :=
  if rounding = .Rounding_Mode_RNE then
    if (op = .mulLog2 ∨ op = .mulLog2p1) ∧ y ≠ 1 then 27 / 20 else 1
  else 3 / 2

def ErrorLaw (op : Operation) (rounding : X86.Helpers.Rounding_Mode) (y : Rat)
    (a : Sequence) (result : Rat) : Prop :=
  if rounding = .Rounding_Mode_RNE ∧ (op = .mulLog2 ∨ op = .mulLog2p1) ∧ y ≠ 1 then
    ErrorAtMostUlps a result (errorBound op rounding y)
  else ErrorBelowUlps a result (errorBound op rounding y)

/-- Keep two ulps clear of the normal-range endpoints so an admitted approximation
cannot cross an overflow or underflow boundary. This domain ignores returned flags. -/
def safeNormalTarget (a : Sequence) : Prop :=
  let minimum := scale2 (-16382)
  let maximum := (2 ^ 64 - 1 : Nat) * scale2 16320
  LimitLE (constant (minimum + 2 * scale2 (-16445))) (fun n => Rat.abs (a n)) ∧
    LimitLE (fun n => Rat.abs (a n)) (constant (maximum - 2 * scale2 16320))

def AccuracyLaw (op : Operation) (rounding : X86.Helpers.Rounding_Mode) (x y : Encoding)
    (r : Output) : Prop :=
  definedResult op x y → accuracyRegion op (value x) →
    op = .sincos →
    let a := target op (value x) (value y) true
    safeNormalTarget a → finite r.first ∧
      ErrorLaw op rounding (value y) a (value r.first)

/-- The first component is always checked, independently of a cosine selector. -/
def PrimaryAccuracyLaw (op : Operation) (rounding : X86.Helpers.Rounding_Mode) (x y : Encoding)
    (r : Output) : Prop :=
  definedResult op x y → accuracyRegion op (value x) →
    let a := target op (value x) (value y) false
    safeNormalTarget a → finite (r.result op false) ∧
      ErrorLaw op rounding (value y) a (value (r.result op false))

/-- Shared exception flags are clear when every computed component is safely normal. -/
def safeNormalResults (op : Operation) (x y : Encoding) : Prop :=
  safeNormalTarget (target op (value x) (value y) false) ∧
    (op = .sincos → safeNormalTarget (target op (value x) (value y) true))

/-- A binding cannot claim a range exception to evade a safe-normal accuracy bound. -/
def NormalExceptionLaw (op : Operation) (x y : Encoding)
    (r : Output) : Prop :=
  definedResult op x y → accuracyRegion op (value x) →
    safeNormalResults op x y →
    (FP_Exception_Flags_Type.OE r.flags) = 0 ∧ (FP_Exception_Flags_Type.UE r.flags) = 0

/-- Helpers cannot introduce invalid-operation or divide-by-zero on their valid domain. -/
def FlagLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y →
    (FP_Exception_Flags_Type.IE r.flags) = 0 ∧ (FP_Exception_Flags_Type.ZE r.flags) = 0 ∧
    (op ≠ .mulLog2 ∧ op ≠ .mulLog2p1 → (FP_Exception_Flags_Type.OE r.flags) = 0) ∧
    (op = .atan2 → ((FP_Exception_Flags_Type.DE r.flags) = 1 ↔ (F80_Type.Exponent x).toNat = 0 ∨ (F80_Type.Exponent y).toNat = 0)) ∧
    ((FP_Exception_Flags_Type.PE r.flags) = 0 → r.roundedUp = false)

/-- SDM 093 Vol. 1, 8.5.2 restricts #D to denormal operands. Wrappers
add DE for denormal inputs; a binding cannot manufacture it for computed normal inputs. -/
def DenormalExceptionLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → (F80_Type.Exponent x).toNat ≠ 0 →
    (binary op = true → (F80_Type.Exponent y).toNat ≠ 0) →
    FP_Exception_Flags_Type.DE r.flags = 0

/-- F2XM1 only leaves the result undefined outside [-1,1]; SDM 093 3-307
still limits #IA to unsupported/SNaN inputs and does not list #Z or #O. -/
def F2xm1ExceptionLaw (op : Operation) (x : Encoding) (r : Output) : Prop :=
  op = .exp2m1 → supportedFinite x →
    (FP_Exception_Flags_Type.IE r.flags) = 0 ∧
    (FP_Exception_Flags_Type.ZE r.flags) = 0 ∧
    (FP_Exception_Flags_Type.OE r.flags) = 0 ∧
    ((F80_Type.Exponent x).toNat ≠ 0 → (FP_Exception_Flags_Type.DE r.flags) = 0)

/-- SDM 093 4.9.1.5 preserves the F2XM1 source sign through underflow. -/
def UnderflowSignLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → FP_Exception_Flags_Type.UE r.flags = 1 →
    op = .exp2m1 → F80_Type.Sign (r.result op false) = F80_Type.Sign x

/-- SDM 093 4.9.1.5 requires correctly signed underflow; 8.5.5 biases
exponents by a positive factor. Reduced-region sine/tangent signs follow the input,
and cosine remains positive, including when the stored result is signed zero. -/
def TrigonometricUnderflowSignLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → accuracyRegion op (value x) →
    FP_Exception_Flags_Type.UE r.flags = 1 →
    match op with
    | .sin | .tan => F80_Type.Sign (r.result op false) = F80_Type.Sign x
    | .cos => F80_Type.Sign r.first = 0
    | .sincos => F80_Type.Sign r.second = F80_Type.Sign x ∧ F80_Type.Sign r.first = 0
    | _ => True

/-- FPATAN's result always has the sign of ST(1), including tiny values and zeros
(SDM 093 3-364); the requirement does not depend on returned range flags. -/
def AtanSignLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → op = .atan2 →
    F80_Type.Sign (r.result op false) = F80_Type.Sign y

/-- Without a precision exception, the numerical result equals the mathematical target. -/
def ExactNoPrecisionLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → accuracyRegion op (value x) →
    (FP_Exception_Flags_Type.PE r.flags) = 0 →
    (FP_Exception_Flags_Type.OE r.flags) = 0 →
    (FP_Exception_Flags_Type.UE r.flags) = 0 →
    let exactResult := fun cosine =>
      let a := target op (value x) (value y) cosine
      finite (r.result op cosine) ∧
        LimitLE a (constant (value (r.result op cosine))) ∧
        LimitLE (constant (value (r.result op cosine))) a
    exactResult false ∧ (op = .sincos → exactResult true)

/-- C1 records a significand increment; directed modes constrain its direction.
For sincos the SDM does not identify which computed component supplies C1. -/
def RoundingDirectionLaw (op : Operation) (rounding : X86.Helpers.Rounding_Mode)
    (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → r.roundedUp = true →
    let hasSign := fun sign =>
      (F80_Type.Sign (r.result op false)).toNat = sign ∨
        (op = .sincos ∧ (F80_Type.Sign r.first).toNat = sign)
    rounding ≠ .Rounding_Mode_RTZ ∧
    (rounding = .Rounding_Mode_RTP → hasSign 0) ∧
    (rounding = .Rounding_Mode_RTN → hasSign 1)

/-- A significand increment cannot produce zero (SDM 093 8.5.4–6).
FSINCOS shares C1, so a zero in only one component does not force it clear.
Out-of-range trigonometric numerical fields are ignored and C1 is undefined. -/
def ZeroRoundingLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → value (r.result op false) = 0 →
    (op = .sincos → value r.first = 0) → r.roundedUp = false

/-- Defined computed results are finite without overflow; only masked logarithm overflow
can produce infinity. The tangent helper also returns the architectural constant to push. -/
def ResultShapeLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y →
    (trigonometric op = true → r.outOfRange = false) ∧
    (op = .tan → r.first = one) ∧
    (FP_Exception_Flags_Type.OE r.flags = 0 → finite (r.result op false)) ∧
    (op = .sincos → finite r.first)

/-- SDM 093 Tables 3-25, 3-37 and 3-38 bound computed sine/cosine by one.
UE-clear outcomes exclude the exponent-scaled underflow results of Vol. 1, 8.5.5. -/
def SineCosineRangeLaw (op : Operation) (x y : Encoding) (r : Output) : Prop :=
  definedResult op x y → FP_Exception_Flags_Type.UE r.flags = 0 →
    (op = .sin ∨ op = .cos ∨ op = .sincos → Rat.abs (value (r.result op false)) ≤ 1) ∧
    (op = .sincos → Rat.abs (value r.first) ≤ 1)

/-- Finite-Pi targets describe periodic monotonic branches outside the accuracy region. -/
def architecturalTarget (op : Operation) (x y : Rat) (cosine : Bool) : Sequence :=
  if trigonometric op then periodicTarget op x cosine else target op x y cosine

/-- The whole segment must be monotone; comparisons cannot cross a pole or branch cut. -/
def MonotoneSegment (op : Operation) (x₁ y₁ x₂ y₂ : Rat) (cosine : Bool) : Prop :=
  (x₁ = x₂ ∨ y₁ = y₂) ∧
    ∀ s t : Rat, 0 ≤ s → s ≤ t → t ≤ 1 →
      let x := fun u => x₁ + u * (x₂ - x₁)
      let y := fun u => y₁ + u * (y₂ - y₁)
      LimitLE (architecturalTarget op (x s) (y s) cosine)
        (architecturalTarget op (x t) (y t) cosine)

/-- Pointwise necessary SDM conditions, without claiming complete conformance. -/
structure OutcomeLaws (op : Operation) (rounding : X86.Helpers.Rounding_Mode)
    (x y : Encoding) (r : Output) : Prop where
  outOfRange : OutOfRangeLaw op x r
  exponentialRange : ExponentialRangeLaw op x y r
  exactLogarithm : ExactLogarithmLaw op x y r
  accuracy : PrimaryAccuracyLaw op rounding x y r
  cosineAccuracy : AccuracyLaw op rounding x y r
  flags : FlagLaw op x y r
  normalExceptions : NormalExceptionLaw op x y r
  exactNoPrecision : ExactNoPrecisionLaw op x y r
  roundingDirection : RoundingDirectionLaw op rounding x y r
  zeroRounding : ZeroRoundingLaw op x y r
  resultShape : ResultShapeLaw op x y r
  exponentialExceptions : F2xm1ExceptionLaw op x r
  denormalExceptions : DenormalExceptionLaw op x y r
  sineCosineRange : SineCosineRangeLaw op x y r
  underflowSign : UnderflowSignLaw op x y r
  trigUnderflowSign : TrigonometricUnderflowSignLaw op x y r
  atanSign : AtanSignLaw op x y r

/-- The finite operands for which the generated Intel x87 wrappers call the binding.
Cosine handles denormals locally; exponential calls them only when DM is set. -/
def computedFinite (denormalMasked : Bool) (input : Input) : Prop :=
  supportedFinite input.x ∧ value input.x ≠ 0 ∧
    match input.operation with
    | .exp2m1 => (F80_Type.Exponent input.x).toNat ≠ 0 ∨ denormalMasked = true
    | .cos => (F80_Type.Exponent input.x).toNat ≠ 0
    | .sin | .sincos | .tan => True
    | .atan2 | .mulLog2p1 => supportedFinite input.y ∧ value input.y ≠ 0
    | .mulLog2 => supportedFinite input.y ∧ value input.y ≠ 0 ∧
        (F80_Type.Sign input.x) = 0 ∧
        (input.x ≠ one ∨ (F80_Type.Exponent input.y).toNat = 0)

/-- `computedFinite` with DM read from the control word. -/
def computedFiniteIn {σ : Type} (state : X86.State σ) (input : Input) : Prop :=
  computedFinite ((FP87_Control_Type.DM state.FP87_Control) == 1) input

/-- Supported PC settings only: SDM 093 Table 8-2 reserves 01.
This predicate does not validate other control-word fields or change `computedFiniteIn`. -/
def supportedPrecisionControl {σ : Type} (state : X86.State σ) : Prop :=
  FP87_Control_Type.PC state.FP87_Control ≠ 1

/-- Finite operands with undefined numerical results still finish.
Only FYL2XP1 explicitly permits implementation-dependent exceptions. -/
def undefinedResult (input : Input) : Prop :=
  supportedFinite input.x ∧
    match input.operation with
    | .exp2m1 => 1 < Rat.abs (value input.x)
    | .mulLog2p1 => supportedFinite input.y ∧ value input.y ≠ 0 ∧
        ¬ log2p1Domain (value input.x)
    | _ => False

/-- Required successful cases include finite undefined-result operands and the
documented trigonometric out-of-range branch; wrappers own zero and special cases. -/
def mustComplete (input : Input) : Prop :=
  definedResult input.operation input.x input.y ∨
    (trigonometric input.operation = true ∧ supportedFinite input.x ∧
      scale2 63 ≤ Rat.abs (value input.x)) ∨ undefinedResult input

/-- Completion is required for computed finite operands that must complete,
including under reserved PC. -/
def precondition {σ : Type} (state : X86.State σ) (input : Input) : Prop :=
  computedFiniteIn state input ∧ mustComplete input

/-- `precondition` under a supported PC; reserved PC carries no documented numerical
or status guarantee. -/
def supportedPrecondition {σ : Type} (state : X86.State σ) (input : Input) : Prop :=
  supportedPrecisionControl state ∧ precondition state input

/-- Unmasked denormal operands stop a defined operation before result storage.
The generated wrapper still invokes its binding, whose numerical fields are discarded. -/
def discardedDenormal {σ : Type} (before : X86.State σ) (input : Input) : Prop :=
  definedResult input.operation input.x input.y ∧
    FP87_Control_Type.DM before.FP87_Control = 0 ∧
    ((F80_Type.Exponent input.x).toNat = 0 ∨
      (binary input.operation = true ∧ (F80_Type.Exponent input.y).toNat = 0))

/-- Retain fields observed before an unmasked denormal abort. Atan's wrapper
replaces its initial flags, so its binding must supply DE; other wrappers add DE. -/
def DiscardedDenormalLaw (input : Input) (output : Output) : Prop :=
  FP_Exception_Flags_Type.IE output.flags = 0 ∧
    FP_Exception_Flags_Type.ZE output.flags = 0 ∧
    (input.operation = .atan2 → FP_Exception_Flags_Type.DE output.flags = 1) ∧
    (trigonometric input.operation = true → output.outOfRange = false)

/-- Unmasked range exceptions exponent-bias stored register-stack values.
Raw-value monotonic comparisons apply only when neither bias can occur. -/
def unscaledOutput {σ : Type} (before : X86.State σ) (output : Output) : Prop :=
  (FP_Exception_Flags_Type.OE output.flags = 0 ∨ FP87_Control_Type.OM before.FP87_Control = 1) ∧
    (FP_Exception_Flags_Type.UE output.flags = 0 ∨ FP87_Control_Type.UM before.FP87_Control = 1)

/-- Table 4-11 saturation for a masked overflow in double extended precision. -/
def maskedOverflowResult (rounding : X86.Helpers.Rounding_Mode) (negative : Bool) : Encoding :=
  let infinity := rounding = .Rounding_Mode_RNE ∨
    (rounding = .Rounding_Mode_RTN ∧ negative = true) ∨ (rounding = .Rounding_Mode_RTP ∧ negative = false)
  F80_Type.setSign (if infinity then 0x7fff8000000000000000 else 0x7ffeffffffffffffffff)
    (if negative then 1 else 0)

/-- A shared sincos flag may originate in either computed component. -/
def someComputedComponent (input : Input) (output : Output)
    (predicate : Encoding → Prop) : Prop :=
  predicate (output.result input.operation false) ∨
    (input.operation = .sincos ∧ predicate output.first)

def everyComputedComponent (input : Input) (output : Output)
    (predicate : Encoding → Prop) : Prop :=
  predicate (output.result input.operation false) ∧
    (input.operation = .sincos → predicate output.first)

/-- Logarithms have a source-derived sign, including signed underflow zeros. -/
def logarithmNegative (input : Input) : Bool :=
  decide (if input.operation = .mulLog2 then value input.x < 1 else value input.x < 0) !=
    decide (value input.y < 0)

/-- The no-range result tables (SDM 093 3-422/424) and range sign preservation
(4.9.1.4/5) agree. Valid logarithms retain this sign for every range-flag outcome;
FYL2X at x=1 retains the multiplier's sign, with range flags specified separately. -/
def LogarithmSignLaw (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y →
    (input.operation = .mulLog2 ∨ input.operation = .mulLog2p1) →
    F80_Type.Sign (output.result input.operation false) =
      if logarithmNegative input then 1 else 0

/-- SDM 093 4.9.1.4/5 and 8.5.4/5 bound saturated or exponent-biased outputs.
Only masked range exceptions force inexactness here; unmasked exact significands remain possible. -/
def RangeExceptionLaw {σ : Type} (before : X86.State σ)
    (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y →
    (FP_Exception_Flags_Type.OE output.flags = 1 →
      FP_Exception_Flags_Type.UE output.flags = 0 ∧
      (FP87_Control_Type.OM before.FP87_Control = 1 →
        output.result input.operation false =
          maskedOverflowResult (roundingOfState before) (logarithmNegative input) ∧
        FP_Exception_Flags_Type.PE output.flags = 1) ∧
      (FP87_Control_Type.OM before.FP87_Control = 0 →
        finite (output.result input.operation false) ∧
        scale2 (-8192) ≤ Rat.abs (value (output.result input.operation false)))) ∧
    (FP_Exception_Flags_Type.UE output.flags = 1 →
      FP_Exception_Flags_Type.OE output.flags = 0 ∧
      everyComputedComponent input output finite ∧
      (FP87_Control_Type.UM before.FP87_Control = 1 →
        FP_Exception_Flags_Type.PE output.flags = 1 ∧
        someComputedComponent input output (fun result => Rat.abs (value result) ≤ scale2 (-16382))) ∧
      (FP87_Control_Type.UM before.FP87_Control = 0 →
        someComputedComponent input output
          (fun result => 0 < Rat.abs (value result) ∧ Rat.abs (value result) < scale2 8194)))

/-- SDM 093 8.5.5 reports unmasked underflow for every nonzero tiny result,
including exact ones. An unscaled register result cannot be nonzero subnormal. -/
def UnmaskedTinyResultLaw {σ : Type} (before : X86.State σ)
    (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y →
    FP87_Control_Type.UM before.FP87_Control = 0 →
    FP_Exception_Flags_Type.OE output.flags = 0 →
    FP_Exception_Flags_Type.UE output.flags = 0 →
    everyComputedComponent input output (fun result =>
      value result = 0 ∨ scale2 (-16382) ≤ Rat.abs (value result))

/-- SDM 093 4.9.1.5 and 8.5.6 require masked underflow when a single
computed result is both tiny and inexact. FSINCOS has shared flags: precision
loss in one component does not make an exact tiny second component inexact. -/
def MaskedTinyResultLaw {σ : Type} (before : X86.State σ)
    (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y → input.operation ≠ .sincos →
    FP87_Control_Type.UM before.FP87_Control = 1 →
    FP_Exception_Flags_Type.OE output.flags = 0 →
    FP_Exception_Flags_Type.PE output.flags = 1 →
    let result := output.result input.operation false
    finite result → value result ≠ 0 → Rat.abs (value result) < scale2 (-16382) →
    FP_Exception_Flags_Type.UE output.flags = 1

/-- Masked underflow does not exponent-bias the sine/cosine outputs. -/
def MaskedSineCosineRangeLaw {σ : Type} (before : X86.State σ)
    (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y → FP87_Control_Type.UM before.FP87_Control = 1 →
    (input.operation = .sin ∨ input.operation = .cos ∨ input.operation = .sincos →
      Rat.abs (value (output.result input.operation false)) ≤ 1) ∧
    (input.operation = .sincos → Rat.abs (value output.first) ≤ 1)

/-- Undo the prescribed register-stack exponent bias, not an approximation's error. -/
def biasCorrectedValue (output : Output) (result : Encoding) : Rat :=
  if FP_Exception_Flags_Type.OE output.flags = 1 then value result * scale2 24576
  else value result / scale2 24576

/-- The selected exponent bias has a range cause; unaffected components remain
normal or zero. Sine and cosine retain their ordinary range after undoing bias. -/
def BiasedComponentRangeLaw (input : Input) (output : Output)
    (cosine biased : Bool) : Prop :=
  let result := output.result input.operation cosine
  let numerical := if biased then biasCorrectedValue output result else value result
  finite result ∧
    (if biased then
      (FP_Exception_Flags_Type.OE output.flags = 1 → scale2 16384 ≤ Rat.abs numerical) ∧
      (FP_Exception_Flags_Type.UE output.flags = 1 →
        0 < Rat.abs numerical ∧ Rat.abs numerical < scale2 (-16382))
    else numerical = 0 ∨ scale2 (-16382) ≤ Rat.abs numerical) ∧
    ((input.operation = .sin ∨ input.operation = .cos ∨ input.operation = .sincos) →
      Rat.abs numerical ≤ 1)

/-- Range, accuracy and PE-clear exactness use the same selected component value. -/
def BiasedComponentLaw {σ : Type} (before : X86.State σ)
    (input : Input) (output : Output) (cosine biased : Bool) : Prop :=
  let result := output.result input.operation cosine
  let numerical := if biased then biasCorrectedValue output result else value result
  let a := target input.operation (value input.x) (value input.y) cosine
  BiasedComponentRangeLaw input output cosine biased ∧
    (accuracyRegion input.operation (value input.x) →
      ((input.operation ≠ .mulLog2 ∨ value input.x ≠ 1) →
        ErrorLaw input.operation (roundingOfState before) (value input.y) a numerical) ∧
      (FP_Exception_Flags_Type.PE output.flags = 0 →
        LimitLE a (constant numerical) ∧ LimitLE (constant numerical) a))

/-- SDM 093 8.5.4–6 ties each selected exponent bias to its range condition.
A shared sincos flag admits either component or both, using one coherent selection
for the range, approximation and PE-clear exactness obligations. -/
def BiasedResultLaw {σ : Type} (before : X86.State σ)
    (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y →
    ((FP_Exception_Flags_Type.OE output.flags = 1 ∧ FP87_Control_Type.OM before.FP87_Control = 0) ∨
      (FP_Exception_Flags_Type.UE output.flags = 1 ∧ FP87_Control_Type.UM before.FP87_Control = 0)) →
    match input.operation with
    | .sincos =>
      (BiasedComponentLaw before input output false true ∧
        BiasedComponentLaw before input output true false) ∨
      (BiasedComponentLaw before input output false false ∧
        BiasedComponentLaw before input output true true) ∨
      (BiasedComponentLaw before input output false true ∧
        BiasedComponentLaw before input output true true)
    | _ => BiasedComponentLaw before input output false true

/-- An unscaled target needs no gradual-underflow error bound when it is at least
normal-sized, or when underflow is unmasked and no biased output was reported. -/
def unscaledAccuracyTarget {σ : Type} (before : X86.State σ) (a : Sequence) : Prop :=
  LimitLE (constant (scale2 (-16382))) (fun n => Rat.abs (a n)) ∨
    (FP87_Control_Type.UM before.FP87_Control = 0 ∧
      LimitLT (constant 0) (fun n => Rat.abs (a n)))

/-- SDM 093 8.3.10 and 8.5.4–6 bound unscaled results when no overflow was reported.
The target has no upper cutoff: an above-range target must report overflow when
no finite approximation can satisfy the bound. Unmasked nonzero tiny targets
likewise cannot hide underflow by returning zero. Masked tiny targets remain
outside this law. -/
def UnscaledAccuracyLaw {σ : Type} (before : X86.State σ)
    (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y →
    accuracyRegion input.operation (value input.x) →
    FP_Exception_Flags_Type.OE output.flags = 0 →
    (FP_Exception_Flags_Type.UE output.flags = 0 ∨ FP87_Control_Type.UM before.FP87_Control = 1) →
    let bounded := fun cosine =>
      let a := target input.operation (value input.x) (value input.y) cosine
      unscaledAccuracyTarget before a → finite (output.result input.operation cosine) ∧
        ErrorLaw input.operation (roundingOfState before) (value input.y) a
          (value (output.result input.operation cosine))
    bounded false ∧ (input.operation = .sincos → bounded true)

/-- The existing two-ulp upper safety margin needs no lower range restriction. -/
def overflowSafeTarget (a : Sequence) : Prop :=
  let maximum := (2 ^ 64 - 1 : Nat) * scale2 16320
  LimitLE (fun n => Rat.abs (a n)) (constant (maximum - 2 * scale2 16320))

/-- The existing two-ulp lower safety margin needs no upper range restriction. -/
def underflowSafeTarget (a : Sequence) : Prop :=
  LimitLE (constant (scale2 (-16382) + 2 * scale2 (-16445)))
    (fun n => Rat.abs (a n))

/-- A safely bounded target cannot manufacture overflow to evade its numerical bounds. -/
def NoOverflowBelowRangeLaw (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y →
    accuracyRegion input.operation (value input.x) →
    overflowSafeTarget (target input.operation (value input.x) (value input.y) false) →
    (input.operation = .sincos →
      overflowSafeTarget (target input.operation (value input.x) (value input.y) true)) →
    FP_Exception_Flags_Type.OE output.flags = 0

/-- Shared flags are clear only when every computed target is safely above underflow. -/
def NoUnderflowAboveRangeLaw (input : Input) (output : Output) : Prop :=
  definedResult input.operation input.x input.y →
    accuracyRegion input.operation (value input.x) →
    underflowSafeTarget (target input.operation (value input.x) (value input.y) false) →
    (input.operation = .sincos →
      underflowSafeTarget (target input.operation (value input.x) (value input.y) true)) →
    FP_Exception_Flags_Type.UE output.flags = 0

structure ComputedOutcomeLaws {σ : Type} (before : X86.State σ)
    (input : Input) (output : Output) : Prop where
  pointwise : OutcomeLaws input.operation (roundingOfState before) input.x input.y output
  rangeExceptions : RangeExceptionLaw before input output
  maskedSineCosineRange : MaskedSineCosineRangeLaw before input output
  biasedResult : BiasedResultLaw before input output
  unscaledAccuracy : UnscaledAccuracyLaw before input output
  unmaskedTinyResult : UnmaskedTinyResultLaw before input output
  maskedTinyResult : MaskedTinyResultLaw before input output
  logarithmSign : LogarithmSignLaw input output
  noOverflowBelowRange : NoOverflowBelowRangeLaw input output
  noUnderflowAboveRange : NoUnderflowAboveRangeLaw input output

/-- Necessary conditions with successful evaluation.
This base contract does not assert a gradual-underflow error bound, finite-Pi
error outside the reduced accuracy regions, or an exact calibration of internal
approximation and PE/UE/OE/C1. Exact-zero logarithms cannot report new range exceptions;
their precision status is not prescribed by this base contract. -/
def contract (σ : Type) : Prelude.Bindings.Contract (X86.State σ) Input Output :=
  Prelude.Bindings.Contract.mk
    precondition
    (fun before input output =>
      supportedPrecisionControl before →
      (discardedDenormal before input → DiscardedDenormalLaw input output) ∧
      (¬ discardedDenormal before input →
        ComputedOutcomeLaws before input output))

end Prelude.Bindings.Numerical.Transcendental
