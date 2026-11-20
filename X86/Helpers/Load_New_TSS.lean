-- Generated from data/definitions.xml.gz: Load_New_TSS; do not edit.
-- Source SHA256: 3869c75f0a39d08ec248101cb2da40caf5c55fca28051aba9ef872fcb438f90e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Load_New_TSS)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Task_Switch_Initiator
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Load_New_TSS.Binding (σ : Type) where
  call (new_task : Segment) (initiator : Task_Switch_Initiator) :
    Runtime.SpecM Exception (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Load_New_TSS.Binding

variable {σ : Type}

variable
  [X86.Helpers.Load_New_TSS.Binding σ]

def Load_New_TSS
    (new_task : Segment) (initiator : Task_Switch_Initiator) :
    Runtime.SpecM Exception (State σ) Unit := do
  try
    Load_New_TSS.Binding.call new_task initiator
  catch
    | .raised (.Exception_Info exception) =>
      Runtime.assert ((exception).vector in {0..255})
      throw (.raised (.Exception_Info exception))
    | error => throw error

end X86.Helpers
