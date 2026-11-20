-- Generated from data/definitions.xml.gz: Cache::Invalidate; do not edit.
-- Source SHA256: 4dbfc55afde3d9125b5a0196e89e29a9be64afa59c125e2aad6ecfa3387d6236
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Cache%3A%3AInvalidate)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Cache.Invalidate.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Cache.Invalidate.Binding

variable {σ : Type}

variable
  [X86.Helpers.Cache.Invalidate.Binding σ]

def Cache.Invalidate  : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Cache.Invalidate.Binding.call)

end X86.Helpers
