-- Generated from data/definitions.xml.gz: Cache::Prefetch_By_Address; do not edit.
-- Source SHA256: c1dbc39c644a27dbb1a015e9087a35a37b3436515e11c3fd2d431e0d594af673
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Cache%3A%3APrefetch_By_Address)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Cache.Prefetch_By_Address.Binding (σ : Type) where
  call (linear_address : Bits 64) (level : Int) (is_code is_vector exclusive : Bool) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Cache.Prefetch_By_Address.Binding

variable {σ : Type}

variable
  [X86.Helpers.Cache.Prefetch_By_Address.Binding σ]

def Cache.Prefetch_By_Address
    (linear_address : Bits 64) (level : Int) (is_code is_vector exclusive : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (level in {0..3})

  Runtime.liftNoSourceException (Cache.Prefetch_By_Address.Binding.call linear_address level is_code is_vector exclusive)

end X86.Helpers
