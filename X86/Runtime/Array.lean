import X86.Runtime.Control

namespace X86.Runtime

-- ISA integer-indexed arrays use indices 0 ≤ index < size. Keep the signed
-- source size in the type and check indices before converting them to Nat.
abbrev Array (size : Int) (α : Type) := Vector α size.toNat

namespace Array

def get {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Int} (values : X86.Runtime.Array size α) (index : Int) : m α := do
  if h : 0 ≤ index ∧ index < size then
    return values[index.toNat]'(by omega)
  else throw .assertionFailed

def set {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    {size : Int} (values : X86.Runtime.Array size α) (index : Int) (value : α) :
    m (X86.Runtime.Array size α) := do
  if h : 0 ≤ index ∧ index < size then
    return Vector.set values index.toNat value (by omega)
  else throw .assertionFailed

end Array
end X86.Runtime
