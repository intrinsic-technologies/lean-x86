import X86.Runtime.Bits

namespace X86.Runtime

/--
Reading a local before its source initializer runs is a runtime error,
not an architectural exception or an unspecified-bit choice.
-/
def readInitialized {exception α : Type} [Monad m] [MonadExcept (Error exception) m]
    (value : Option α) : m α :=
  match value with
  | some value => pure value
  | none => throw .uninitializedRead

/--
Store bits with an initialization mask; some or all bits can remain unwritten.
Each set mask bit marks an unwritten payload bit. Reads of unwritten bits fail.
A fully written value has a zero mask, which is a small number at every width.
-/
structure InitializedBits (size : Int) where
  private payload : Bits size
  private unwritten : Bits size
  deriving Repr, DecidableEq

namespace InitializedBits

def empty (size : Int) : InitializedBits size := ⟨0, BitVec.allOnes size.toNat⟩

/-- The default has no bits written, as `empty`. A derived default would be a fully written zero. -/
instance {size : Int} : Inhabited (InitializedBits size) := ⟨empty size⟩

def ofValue {size : Int} (value : Bits size) : InitializedBits size := ⟨value, 0⟩

def readSlice {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Int} (value : InitializedBits size) (offset width : Int) : m (Bits width) := do
  X86.Runtime.assert (0 ≤ size)
  let unwritten ← slice value.unwritten offset width
  unless unwritten == 0 do throw .uninitializedRead
  slice value.payload offset width

def read {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Int} (value : InitializedBits size) : m (Bits size) :=
  value.readSlice 0 size

def writeSlice {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Int} (original : InitializedBits size) (offset width : Int)
    (value : Bits width) : m (InitializedBits size) := do
  X86.Runtime.assert (0 ≤ size)
  let payload ← setSliceChecked original.payload offset width value
  let unwritten ← setSliceChecked original.unwritten offset width 0
  return ⟨payload, unwritten⟩

end InitializedBits
end X86.Runtime
