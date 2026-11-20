-- Generated from data/definitions.xml.gz: Cache::Flush_By_Address; do not edit.
-- Source SHA256: 6b4dcadba99a98c153e5e5707d4c2fe79915d8867660b2adcd9d830d909ece03
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Cache%3A%3AFlush_By_Address)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Cache.Flush_By_Address.Binding (σ : Type) where
  call (linear_address : Bits 64) (self_serialized : Bool) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Cache.Flush_By_Address.Binding

variable {σ : Type}

variable
  [X86.Helpers.Cache.Flush_By_Address.Binding σ]

def Cache.Flush_By_Address
    (linear_address : Bits 64) (self_serialized : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Cache.Flush_By_Address.Binding.call linear_address self_serialized)

end X86.Helpers
