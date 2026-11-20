-- Generated from a local ISA specification; do not edit.
-- Source SHA256: a11d0d0bc9048fdc284ca7335352a20606b47abbb5d28d489068669d4e50c1d8
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_F2XM1.Binding (σ : Type) where
  call (x : F80_Type) :
    ReaderT (State σ) (Runtime.PartialResult Empty) ((F80_Type × Bool × FP_Exception_Flags_Type))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_F2XM1.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_FSIN.Binding (σ : Type) where
  call (x : F80_Type) :
    ReaderT (State σ) (Runtime.PartialResult Empty) ((F80_Type × Bool × Bool × FP_Exception_Flags_Type))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_FSIN.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_FCOS.Binding (σ : Type) where
  call (x : F80_Type) :
    ReaderT (State σ) (Runtime.PartialResult Empty) ((F80_Type × Bool × Bool × FP_Exception_Flags_Type))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_FCOS.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_FPTAN.Binding (σ : Type) where
  call (x : F80_Type) :
    ReaderT (State σ) (Runtime.PartialResult Empty) ((F80_Type × F80_Type × Bool × Bool × FP_Exception_Flags_Type))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_FPTAN.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_FSINCOS.Binding (σ : Type) where
  call (x : F80_Type) :
    ReaderT (State σ) (Runtime.PartialResult Empty) ((F80_Type × F80_Type × Bool × Bool × FP_Exception_Flags_Type))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_FSINCOS.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_FPATAN.Binding (σ : Type) where
  call (x y : F80_Type) :
    ReaderT (State σ) (Runtime.PartialResult Empty) ((F80_Type × Bool × FP_Exception_Flags_Type))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_FPATAN.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_FYL2X.Binding (σ : Type) where
  call (x y : F80_Type) :
    ReaderT (State σ) (Runtime.PartialResult Empty) ((F80_Type × Bool × FP_Exception_Flags_Type))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_FYL2X.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Emulate_FYL2XP1.Binding (σ : Type) where
  call (x y : F80_Type) :
    ReaderT (State σ) (Runtime.PartialResult Empty) ((F80_Type × Bool × FP_Exception_Flags_Type))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Emulate_FYL2XP1.Binding

variable {σ : Type}

variable
  [X86.Helpers.Emulate_F2XM1.Binding σ]
  [X86.Helpers.Emulate_FCOS.Binding σ]
  [X86.Helpers.Emulate_FPATAN.Binding σ]
  [X86.Helpers.Emulate_FPTAN.Binding σ]
  [X86.Helpers.Emulate_FSIN.Binding σ]
  [X86.Helpers.Emulate_FSINCOS.Binding σ]
  [X86.Helpers.Emulate_FYL2X.Binding σ]
  [X86.Helpers.Emulate_FYL2XP1.Binding σ]

-- Numerical results supplied by `Bindings.numerical`. Intel wrappers own
-- classification, stack effects and exception delivery; admissibility requires
-- separate accuracy, range, exception and valid-domain termination laws.
def Emulate_F2XM1
    (x : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  Runtime.liftPartialNoSourceException (liftM (Emulate_F2XM1.Binding.call x (← get)))

def Emulate_FSIN
    (x : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × Bool × FP_Exception_Flags_Type) := do
  Runtime.liftPartialNoSourceException (liftM (Emulate_FSIN.Binding.call x (← get)))

def Emulate_FCOS
    (x : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × Bool × FP_Exception_Flags_Type) := do
  Runtime.liftPartialNoSourceException (liftM (Emulate_FCOS.Binding.call x (← get)))

def Emulate_FPTAN
    (x : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × F80_Type × Bool × Bool × FP_Exception_Flags_Type) := do
  Runtime.liftPartialNoSourceException (liftM (Emulate_FPTAN.Binding.call x (← get)))

def Emulate_FSINCOS
    (x : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × F80_Type × Bool × Bool × FP_Exception_Flags_Type) := do
  Runtime.liftPartialNoSourceException (liftM (Emulate_FSINCOS.Binding.call x (← get)))

def Emulate_FPATAN
    (x y : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  Runtime.liftPartialNoSourceException (liftM (Emulate_FPATAN.Binding.call x y (← get)))

def Emulate_FYL2X
    (x y : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  Runtime.liftPartialNoSourceException (liftM (Emulate_FYL2X.Binding.call x y (← get)))

def Emulate_FYL2XP1
    (x y : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  Runtime.liftPartialNoSourceException (liftM (Emulate_FYL2XP1.Binding.call x y (← get)))

end X86.Helpers
