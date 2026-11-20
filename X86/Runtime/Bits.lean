import X86.Runtime.Control

namespace X86.Runtime

abbrev Bits (size : Int) := BitVec size.toNat
abbrev Bit := Bits 1

abbrev Unsigned {size : Nat} (x : BitVec size) : Int := x.toNat
abbrev Signed {size : Nat} (x : BitVec size) : Int := x.toInt

abbrev Is_Zero {size : Nat} (x : BitVec size) : Bool := x == 0
abbrev Is_Parity_Even {size : Nat} (x : BitVec size) : Bool :=
  x.cpop.toNat % 2 == 0

def slice {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Nat} (x : BitVec size) (lo width : Int) : m (Bits width) := do
  X86.Runtime.assert (0 ≤ lo && 0 ≤ width && lo + width ≤ size)
  return BitVec.extractLsb' lo.toNat width.toNat x

def intSlice {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (x lo width : Int) : m (Bits width) := do
  X86.Runtime.assert (0 ≤ lo && 0 ≤ width)
  return BitVec.ofInt width.toNat (x / 2 ^ lo.toNat)

-- Slice syntax shares the checked operations for integers and fixed-width bits.
class CheckedSlice (α : Type) where
  read {exception : Type} {m : Type → Type} [Monad m]
      [MonadExcept (Error exception) m] : α → (lo width : Int) → m (Bits width)

instance : CheckedSlice Int := ⟨intSlice⟩
instance {size : Nat} : CheckedSlice (BitVec size) := ⟨slice⟩

@[simp] def sliceInclusive {α : Type} [CheckedSlice α] {exception : Type}
    [Monad m] [MonadExcept (Error exception) m] (x : α) (hi lo : Int) :
    m (Bits (hi - lo + 1)) :=
  CheckedSlice.read x lo (hi - lo + 1)

def sliceHigh {α : Type} [CheckedSlice α] {exception : Type}
    [Monad m] [MonadExcept (Error exception) m] (x : α) (hi width : Int) :
    m (Bits width) :=
  CheckedSlice.read x (hi - width + 1) width

-- Intel evaluates an element's width before its index.
def sliceElement {α : Type} [CheckedSlice α] {exception : Type}
    [Monad m] [MonadExcept (Error exception) m] (x : α) (width index : Int) :
    m (Bits width) :=
  CheckedSlice.read x (index * width) width

/-- Replaces the `width` bits of `x` from bit `lo` on by `value`, dropping those at or above
`size`. Writing no bits returns `x` without computing `2 ^ lo`. -/
def setSlice {size : Nat} (x : BitVec size) (lo width : Nat)
    (value : BitVec width) : BitVec size :=
  if width = 0 then x
  else
    BitVec.ofNat size
      (x.toNat >>> (lo + width) <<< (lo + width) ||| x.toNat % 2 ^ lo ||| value.toNat <<< lo)

def zeroBits {exception : Type} [Monad m] [MonadExcept (Error exception) m] (size : Int) : m (Bits size) := do
  X86.Runtime.assert (0 ≤ size)
  return 0

def shiftLeftLogical {exception : Type} [Monad m] [MonadExcept (Error exception) m] {size : Nat} (x : BitVec size) (amount : Int) :
    m (BitVec size) := do
  X86.Runtime.assert (0 ≤ amount)
  return if amount ≥ size then 0 else x <<< amount.toNat

def shiftRightLogical {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Nat} (x : BitVec size) (amount : Int) : m (BitVec size) := do
  X86.Runtime.assert (0 ≤ amount)
  return if amount ≥ size then 0 else x >>> amount.toNat

-- The restricted builtin follows isa-tools' signed shift primitive. Negative
-- counts fail; sign filling also requires the count to be within the width.
def shiftRightArithmetic {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Nat} (x : BitVec size) (amount : Int) : m (BitVec size) := do
  if size == 0 || amount == 0 then return x
  X86.Runtime.assert (0 ≤ amount && (!x.msb || amount ≤ size))
  return x.sshiftRight amount.toNat

-- ISA Rotate_Left uses positive remainder followed by a slice of x ++ x.
-- Its remainder operation requires a positive width and nonnegative amount.
def Rotate_Left {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Nat} (x : BitVec size) (amount : Int) : m (BitVec size) := do
  X86.Runtime.assert (0 < size && 0 ≤ amount)
  return x.rotateLeft amount.toNat

def Zero_Extend {exception : Type} [Monad m] [MonadExcept (Error exception) m] {sourceSize : Nat}
    (x : BitVec sourceSize) (targetSize : Int) : m (Bits targetSize) := do
  X86.Runtime.assert (sourceSize ≤ targetSize)
  return BitVec.ofNat targetSize.toNat x.toNat

def Sign_Extend {exception : Type} [Monad m] [MonadExcept (Error exception) m] {sourceSize : Nat}
    (x : BitVec sourceSize) (targetSize : Int) : m (Bits targetSize) := do
  X86.Runtime.assert (0 < sourceSize && sourceSize ≤ targetSize)
  return BitVec.ofInt targetSize.toNat x.toInt

def From_Integer {exception : Type} [Monad m] [MonadExcept (Error exception) m] (value size : Int) : m (Bits size) := do
  X86.Runtime.assert (0 ≤ size)
  return BitVec.ofInt size.toNat value

def All_Ones {exception : Type} [Monad m] [MonadExcept (Error exception) m] (size : Int) : m (Bits size) := do
  X86.Runtime.assert (0 ≤ size)
  return BitVec.allOnes size.toNat

abbrev Is_All_Ones {size : Nat} (value : BitVec size) : Bool := value == BitVec.allOnes size

def addInt {exception : Type} [Monad m] [MonadExcept (Error exception) m] {size : Int} (left : Bits size) (right : Int) :
    m (Bits size) := do
  X86.Runtime.assert (0 ≤ size)
  return left + BitVec.ofInt size.toNat right

def subtractInt {exception : Type} [Monad m] [MonadExcept (Error exception) m] {size : Int} (left : Bits size) (right : Int) :
    m (Bits size) := do
  X86.Runtime.assert (0 ≤ size)
  return left - BitVec.ofInt size.toNat right

-- Preserve source Int widths rather than silently replacing them by Nat widths.
def concatBits {exception : Type} [Monad m] [MonadExcept (Error exception) m] {leftSize rightSize : Int}
    (left : Bits leftSize) (right : Bits rightSize) :
    m (Bits (leftSize + rightSize)) := do
  X86.Runtime.assert (0 ≤ leftSize && 0 ≤ rightSize)
  return BitVec.ofNat (leftSize + rightSize).toNat
    ((left.toNat <<< rightSize.toNat) + right.toNat)

/-- The primitive Std::Bits::Repeat concatenates count copies, including zero copies. -/
def repeatBits {exception : Type} [Monad m] [MonadExcept (Error exception) m] {size : Int}
    (value : Bits size) (count : Int) : m (Bits (size * count)) :=
  if valid : 0 ≤ size ∧ 0 ≤ count then
    pure ((value.replicate count.toNat).cast (Int.toNat_mul valid.1 valid.2).symm)
  else
    throw .assertionFailed

def setSliceChecked {exception : Type} [Monad m] [MonadExcept (Error exception) m] {size : Nat}
    (original : BitVec size) (offset width : Int) (value : Bits width) :
    m (BitVec size) := do
  X86.Runtime.assert (0 ≤ offset && 0 ≤ width && offset + width ≤ size)
  return setSlice original offset.toNat width.toNat value

end X86.Runtime
