import X86.Runtime.Control

namespace X86.Runtime

def inRange (value lo hi : Int) : Bool := lo ≤ value && value ≤ hi

/-- ISA integer exponentiation by two requires a nonnegative exponent. -/
def Power2 {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (exponent : Int) : m Int := do
  X86.Runtime.assert (0 ≤ exponent)
  return Int.ofNat (2 ^ exponent.toNat)

-- Source for-loops include both bounds; reversed ranges are empty.
def intRange (lo hi : Int) : List Int :=
  (List.range (hi - lo + 1).toNat).map (fun (i : Nat) => lo + (i : Int))

def intRangeDown (hi lo : Int) : List Int :=
  (List.range (hi - lo + 1).toNat).map (fun (i : Nat) => hi - (i : Int))

def Positive_Divide {exception : Type} [Monad m] [MonadExcept (Error exception) m] (left right : Int) : m Int := do
  X86.Runtime.assert (0 ≤ left && 0 < right)
  return left / right

-- Successful division retains its exact quotient for dependent widths.
theorem positiveDivide_eq_of_ok {exception : Type} {left right value : Int}
    (result : (Positive_Divide left right : Except (Error exception) Int) = .ok value) :
    value = left / right := by
  simp only [Positive_Divide, assert] at result
  split at result
  · cases result
    rfl
  · cases result

def Positive_Remainder {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (left right : Int) : m Int := do
  X86.Runtime.assert (0 ≤ left && 0 < right)
  return left % right

/-- Intel's signed division truncates toward zero and requires a nonzero divisor. -/
def truncatedDivide {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (left right : Int) : m Int := do
  X86.Runtime.assert (right != 0)
  return Int.tdiv left right

-- ISA-tools aligns with truncating division, also for negative integers.
def alignDown {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (left right : Int) : m Int := do
  return right * (← truncatedDivide left right)

/-- The remainder has the dividend's sign, with the same nonzero-divisor check. -/
def truncatedRemainder {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (left right : Int) : m Int := do
  X86.Runtime.assert (right != 0)
  return Int.tmod left right

/-- ISA integer shifts require a nonnegative count. -/
def shiftIntegerLeft {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (value count : Int) : m Int := do
  X86.Runtime.assert (0 ≤ count)
  return value <<< count.toNat

/-- Like ISA-tools, right shift rounds negative values toward negative infinity. -/
def shiftIntegerRight {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (value count : Int) : m Int := do
  X86.Runtime.assert (0 ≤ count)
  return value >>> count.toNat

end X86.Runtime
