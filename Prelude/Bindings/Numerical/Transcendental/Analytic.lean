import Std
import Prelude.Bindings.Numerical.Transcendental.Interface

set_option autoImplicit false

namespace Prelude.Bindings.Numerical.Transcendental

open Prelude.Float.Binary80

/-- Rational approximants, independent of the processor's numerical implementation. -/
abbrev Sequence := Nat → Rat

def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => factorial n * (n + 1)

def sumTerms (term : Nat → Rat) (n : Nat) : Rat :=
  (List.range n).foldl (fun acc k => acc + term k) 0

def alternating (n : Nat) : Rat := if n % 2 = 0 then 1 else -1

/-- The atan Taylor series is used only with arguments of magnitude at most one. -/
def atanSeries (x : Rat) (n : Nat) : Rat :=
  sumTerms (fun k => alternating k * x ^ (2 * k + 1) / (2 * k + 1 : Nat)) n

/-- Machin's identity fixes the mathematical constant independently of finite Pi. -/
def piSequence (n : Nat) : Rat := 16 * atanSeries (1 / 5) (n + 1) - 4 * atanSeries (1 / 239) (n + 1)

/-- Intel SDM Volume 1, 8.3.8: 0.C90FDAA22168C234C × 2². -/
def finitePi : Rat := (0xC90FDAA22168C234C : Nat) / (2 ^ 66 : Nat)

def sinSeries (x : Rat) (n : Nat) : Rat :=
  sumTerms (fun k => alternating k * x ^ (2 * k + 1) / factorial (2 * k + 1)) n

def cosSeries (x : Rat) (n : Nat) : Rat :=
  sumTerms (fun k => alternating k * x ^ (2 * k) / factorial (2 * k)) n

def expSeries (x : Rat) (n : Nat) : Rat :=
  sumTerms (fun k => x ^ k / factorial k) n

/-- For positive x, |(x−1)/(x+1)| < 1. -/
def lnSeries (x : Rat) (n : Nat) : Rat :=
  let z := (x - 1) / (x + 1)
  2 * sumTerms (fun k => z ^ (2 * k + 1) / (2 * k + 1 : Nat)) n

def atanSequence (x : Rat) (n : Nat) : Rat :=
  let a := Rat.abs x
  let value := if a ≤ 1 then atanSeries a (n + 1)
    else piSequence n / 2 - atanSeries (1 / a) (n + 1)
  if x < 0 then -value else value

/-- Quadrants follow atan2(y,x); signed-zero cases belong to Intel's wrapper. -/
def atan2Sequence (x y : Rat) (n : Nat) : Rat :=
  if x = 0 then if y < 0 then -piSequence n / 2 else piSequence n / 2
  else
    let a := atanSequence (y / x) n
    if x < 0 then if y < 0 then a - piSequence n else a + piSequence n else a

/-- Exact mathematical targets. The second sincos component is cosine. -/
def target (op : Operation) (x y : Rat) (second : Bool := false) : Sequence := fun n =>
  match op with
  | .exp2m1 => expSeries (x * lnSeries 2 (n + 1)) (n + 1) - 1
  | .sin => sinSeries x (n + 1)
  | .cos => cosSeries x (n + 1)
  | .sincos => if second then cosSeries x (n + 1) else sinSeries x (n + 1)
  | .tan => sinSeries x (n + 1) / cosSeries x (n + 1)
  | .atan2 => atan2Sequence x y n
  | .mulLog2 => y * lnSeries x (n + 1) / lnSeries 2 (n + 1)
  | .mulLog2p1 => y * lnSeries (1 + x) (n + 1) / lnSeries 2 (n + 1)

/-- The finite-Pi periodic target is distinct from the exact mathematical target. -/
def periodicTarget (op : Operation) (x : Rat) (second : Bool := false) : Sequence :=
  fun n => target op (x * piSequence n / finitePi) 1 second n

/-- Non-strict comparison of the limits, expressed using rational epsilon. -/
def LimitLE (a b : Sequence) : Prop :=
  ∀ ε : Rat, 0 < ε → ∃ start : Nat, ∀ n ≥ start, a n ≤ b n + ε

/-- A strict comparison needs a positive margin, not merely eventual inequality. -/
def LimitLT (a b : Sequence) : Prop :=
  ∃ margin : Rat, 0 < margin ∧ ∃ start : Nat, ∀ n ≥ start, a n + margin ≤ b n

def constant (x : Rat) : Sequence := fun _ => x

/-- The SDM ulp uses the binade of the exact target, not of the returned encoding. -/
def ErrorBelowUlps (a : Sequence) (result bound : Rat) : Prop :=
  ∃ exponent : Int,
    LimitLE (constant (scale2 exponent)) (fun n => Rat.abs (a n)) ∧
    LimitLT (fun n => Rat.abs (a n)) (constant (scale2 (exponent + 1))) ∧
    LimitLT (fun n => Rat.abs (a n - result))
      (constant (bound * scale2 (exponent - 63)))

/-- The two-operand logarithm bound is stated as within 1.35 ulps, inclusively. -/
def ErrorAtMostUlps (a : Sequence) (result bound : Rat) : Prop :=
  ∃ exponent : Int,
    LimitLE (constant (scale2 exponent)) (fun n => Rat.abs (a n)) ∧
    LimitLT (fun n => Rat.abs (a n)) (constant (scale2 (exponent + 1))) ∧
    LimitLE (fun n => Rat.abs (a n - result))
      (constant (bound * scale2 (exponent - 63)))

end Prelude.Bindings.Numerical.Transcendental
