-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 3966d2283453d41cb6be408760d2e0e45b8e401d70060060a23ec95b51f56e94
import X86.Runtime
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Floating-point ordering predicates share the local comparison helper.
-- Intel retains DAZ, NaN exception rules and MIN/MAX's second-source selection.
def UFloatOrdered {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return not (← UFloatIsNaN (E := E) (N := N) x) and not (← UFloatIsNaN (E := E) (N := N) y)

def UFloatEqual {E : Int} {N : Int} (x y : UFloat E N) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← (do
    let __check127 : FloatCompare ← UFloatCompare (E := E) (N := N) x y
    pure ((__check127 == FloatCompare.FPCompare_EQUAL) || (__check127 == FloatCompare.FPCompare_ZERO_GREATER) || (__check127 == FloatCompare.FPCompare_ZERO_LESS))))

def UFloatNotEqual {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return not (← UFloatEqual (E := E) (N := N) x y)

def UFloatLessThan {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← UFloatCompare (E := E) (N := N) x y) == FloatCompare.FPCompare_LESS

def UFloatGreaterThan {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← UFloatCompare (E := E) (N := N) x y) == FloatCompare.FPCompare_GREATER

def UFloatLessEqual {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← UFloatLessThan (E := E) (N := N) x y) or (← UFloatEqual (E := E) (N := N) x y)

def UFloatGreaterEqual {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← UFloatGreaterThan (E := E) (N := N) x y) or (← UFloatEqual (E := E) (N := N) x y)

-- The supplied FP::Min_Max body handles NaNs before these calls.
def UFloatMin {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (← UFloatOrdered (E := E) (N := N) x y)
  return if (← UFloatLessThan (E := E) (N := N) x y) then x else y

def UFloatMax {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (← UFloatOrdered (E := E) (N := N) x y)
  return if (← UFloatGreaterThan (E := E) (N := N) x y) then x else y

end X86.Helpers
