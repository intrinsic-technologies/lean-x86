import Std

/-!
# Compiled implementations of core `Nat` and `BitVec` operations

Lean computes `2 ^ n` and `x <<< n` with GMP, even when the result is small, and the core
`BitVec` operations were compiled with that `2 ^ n`. The executable semantics call them for each
bit slice of each instruction. The `@[csimp]` theorems below replace them, in compiled code only,
by equal definitions that read powers of two from a table, shift by multiplying and skip the
reduction when the value already fits.

Each fast path works only on values of at most `tableWidth` bits and otherwise does what Lean's
definition does. The theorems give equal results; this rule also keeps the time, memory and
panics of the compiled code within those of Lean's: no replacement computes a power of two that
Lean's definition would not.
-/

namespace X86.Runtime

/--
The largest exponent the tables below hold: the width of a ZMM register, the widest value that
the executable semantics slices. Wider operations fall back to Lean's definitions.
-/
def tableWidth : Nat := 512

/-- `2 ^ i` for `i ≤ tableWidth`. A constant, so it is computed once when the module is
initialized. -/
def twoPowTable : Array Nat := (Array.range (tableWidth + 1)).map (2 ^ ·)

/-- `2 ^ i - 1` for `i ≤ tableWidth`. -/
def allOnesTable : Array Nat := (Array.range (tableWidth + 1)).map (2 ^ · - 1)

end X86.Runtime

open X86.Runtime

namespace Nat

/-- `b ^ e`, from the table when `b` is 2 and the table holds `2 ^ e`. -/
def powImpl (b e : Nat) : Nat :=
  if h : b = 2 ∧ e < twoPowTable.size then twoPowTable[e] else b ^ e

@[csimp] theorem pow_eq_powImpl : @Nat.pow = @powImpl := by
  funext b e
  unfold powImpl
  split
  · next h => simp [twoPowTable, h.1]
  · rfl

/-- `instNatPowNat` with `powImpl`. Code that writes `b ^ e` reaches `Nat.pow` through it. -/
@[reducible] def instNatPowNatImpl : NatPow Nat := ⟨powImpl⟩

@[csimp] theorem instNatPowNat_eq_instNatPowNatImpl : @instNatPowNat = @instNatPowNatImpl := by
  simp only [instNatPowNat, instNatPowNatImpl, ← pow_eq_powImpl]

/--
`a <<< b` as `a` times `2 ^ b` from the table, which the runtime multiplies without GMP when the
result is small. Outside the table it is Lean's shift, which gives `0` for `a = 0` without
computing `2 ^ b`.
-/
def shiftLeftImpl (a b : Nat) : Nat :=
  if h : b < twoPowTable.size then a * twoPowTable[b] else a <<< b

@[csimp] theorem shiftLeft_eq_shiftLeftImpl : @Nat.shiftLeft = @shiftLeftImpl := by
  funext a b
  unfold shiftLeftImpl
  split
  · simp [twoPowTable, shiftLeft_eq]
  · rfl

/-- `Nat.instShiftLeft` with `shiftLeftImpl`. Code that writes `a <<< b` reaches `Nat.shiftLeft`
through it. -/
@[reducible] def instShiftLeftImpl : ShiftLeft Nat := ⟨shiftLeftImpl⟩

@[csimp] theorem instShiftLeft_eq_instShiftLeftImpl : @instShiftLeft = @instShiftLeftImpl := by
  simp only [instShiftLeft, instShiftLeftImpl, ← shiftLeft_eq_shiftLeftImpl]

end Nat

-- The definitions below are compiled after `pow_eq_powImpl`, so their `2 ^ n` uses `powImpl`.
namespace BitVec

/-- `BitVec.ofNat`, without the reduction when `x` already fits in `n` bits. -/
def ofNatImpl (n x : Nat) : BitVec n :=
  if h : x < 2 ^ n then .ofNatLT x h else .ofNatLT (x % 2 ^ n) (Nat.mod_lt _ (Nat.two_pow_pos n))

@[csimp] theorem ofNat_eq_ofNatImpl : @BitVec.ofNat = @ofNatImpl := by
  funext n x
  apply eq_of_toNat_eq
  unfold ofNatImpl
  split <;> simp [Nat.mod_eq_of_lt, *]

/-- `BitVec.instOfNat` with `ofNatImpl`. Numerals of type `BitVec n` reach `BitVec.ofNat` through
it. -/
@[reducible] def instOfNatImpl {n i : Nat} : OfNat (BitVec n) i := ⟨ofNatImpl n i⟩

@[csimp] theorem instOfNat_eq_instOfNatImpl : @instOfNat = @instOfNatImpl := by
  funext n i
  simp only [instOfNat, instOfNatImpl, ← ofNat_eq_ofNatImpl]

/-- `BitVec.allOnes`, from the table when it holds `2 ^ n - 1`. -/
def allOnesImpl (n : Nat) : BitVec n :=
  if h : n < allOnesTable.size then
    .ofNatLT allOnesTable[n]
      (by simpa [allOnesTable] using Nat.sub_lt (Nat.two_pow_pos n) Nat.one_pos)
  else allOnes n

@[csimp] theorem allOnes_eq_allOnesImpl : @allOnes = @allOnesImpl := by
  funext n
  unfold allOnesImpl
  split
  · apply eq_of_toNat_eq
    simp [allOnesTable]
  · rfl

def extractLsb'Impl {n : Nat} (start len : Nat) (x : BitVec n) : BitVec len :=
  ofNatImpl len (x.toNat >>> start)

@[csimp] theorem extractLsb'_eq_extractLsb'Impl : @extractLsb' = @extractLsb'Impl := by
  funext n start len x
  simp [extractLsb'Impl, ← ofNat_eq_ofNatImpl, extractLsb']

def addImpl {n : Nat} (x y : BitVec n) : BitVec n := ofNatImpl n (x.toNat + y.toNat)

@[csimp] theorem add_eq_addImpl : @BitVec.add = @addImpl := by
  funext n x y
  apply eq_of_toNat_eq
  simp [addImpl, ← ofNat_eq_ofNatImpl, toNat_add]

def subImpl {n : Nat} (x y : BitVec n) : BitVec n :=
  if h : y.toNat ≤ x.toNat then .ofNatLT (x.toNat - y.toNat) (by have := x.isLt; omega)
  else ofNatImpl n (x.toNat + (2 ^ n - y.toNat))

@[csimp] theorem sub_eq_subImpl : @BitVec.sub = @subImpl := by
  funext n x y
  unfold subImpl
  apply eq_of_toNat_eq
  have hx := x.isLt
  have hy := y.isLt
  change (x - y).toNat = _
  split
  · rw [toNat_sub]
    simp only [toNat_ofNatLT]
    rw [show 2 ^ n - y.toNat + x.toNat = (x.toNat - y.toNat) + 2 ^ n by omega, Nat.add_mod_right,
      Nat.mod_eq_of_lt (by omega)]
  · rw [toNat_sub, ← ofNat_eq_ofNatImpl, toNat_ofNat]
    congr 1
    omega

def notImpl {n : Nat} (x : BitVec n) : BitVec n := allOnesImpl n ^^^ x

@[csimp] theorem not_eq_notImpl : @BitVec.not = @notImpl := by
  funext n x
  simp [notImpl, ← allOnes_eq_allOnesImpl]

def ofIntImpl (n : Nat) (i : Int) : BitVec n :=
  match i with
  | .ofNat x => ofNatImpl n x
  | .negSucc x => notImpl (ofNatImpl n x)

@[csimp] theorem ofInt_eq_ofIntImpl : @BitVec.ofInt = @ofIntImpl := by
  funext n i
  cases i with
  | ofNat x => simp [ofIntImpl, ← ofNat_eq_ofNatImpl]
  | negSucc x =>
    simp [ofIntImpl, ← ofNat_eq_ofNatImpl, ← not_eq_notImpl, ofInt_negSucc_eq_not_ofNat]

/-- `BitVec.toInt`, compiled here so that its `2 ^ n` uses `powImpl`. -/
def toIntImpl {n : Nat} (x : BitVec n) : Int :=
  if 2 * x.toNat < 2 ^ n then x.toNat else (x.toNat : Int) - (2 ^ n : Nat)

@[csimp] theorem toInt_eq_toIntImpl : @BitVec.toInt = @toIntImpl := rfl

-- Code that writes `x + y`, `x - y` or `~~~x` reaches the operations through these instances.

@[reducible] def instAddImpl {n : Nat} : Add (BitVec n) := ⟨addImpl⟩

@[csimp] theorem instAdd_eq_instAddImpl : @instAdd = @instAddImpl := by
  funext n
  simp only [instAdd, instAddImpl, ← add_eq_addImpl]

@[reducible] def instSubImpl {n : Nat} : Sub (BitVec n) := ⟨subImpl⟩

@[csimp] theorem instSub_eq_instSubImpl : @instSub = @instSubImpl := by
  funext n
  simp only [instSub, instSubImpl, ← sub_eq_subImpl]

@[reducible] def instComplementImpl {n : Nat} : Complement (BitVec n) := ⟨notImpl⟩

@[csimp] theorem instComplement_eq_instComplementImpl :
    @instComplement = @instComplementImpl := by
  funext n
  simp only [instComplement, instComplementImpl, ← not_eq_notImpl]

end BitVec
