-- Generated from data/definitions.xml.gz: Get_Repeat_String_Stride; do not edit.
-- Source SHA256: d131b7f38e0a6696a0b30e6774c7e65b19927d4be48a97573b0e9c7dd413e87e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Repeat_String_Stride)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Get_Repeat_String_Stride.Binding (σ : Type) where
  call (operand_size count : Int) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Int)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Get_Repeat_String_Stride.Binding

variable {σ : Type}

variable
  [X86.Helpers.Get_Repeat_String_Stride.Binding σ]

def Get_Repeat_String_Stride
    (operand_size count : Int) :
    Runtime.SpecM Exception (State σ) (Int) := do
  Runtime.liftNoSourceException (liftM (Get_Repeat_String_Stride.Binding.call operand_size count (← get)))

end X86.Helpers
