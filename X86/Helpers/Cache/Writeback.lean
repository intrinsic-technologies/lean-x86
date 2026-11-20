-- Generated from data/definitions.xml.gz: Cache::Writeback; do not edit.
-- Source SHA256: 597640478170cb3cf620bdfb3074447cc89e9568feaa67989a3ec658e04de1b6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Cache%3A%3AWriteback)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Cache.Writeback.Binding (σ : Type) where
  call (invalidate : Bool) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Cache.Writeback.Binding

variable {σ : Type}

variable
  [X86.Helpers.Cache.Writeback.Binding σ]

def Cache.Writeback (invalidate : Bool) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Cache.Writeback.Binding.call invalidate)

end X86.Helpers
