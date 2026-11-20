-- Generated from data/definitions.xml.gz: Physical_Mem_Write_PTW; do not edit.
-- Source SHA256: c3960eae784790ac4d522b48969e035b794e699dead7e578fdb0054fdeef21d8
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Physical_Mem_Write_PTW)
import X86.Runtime
import X86.Helpers.Memory_Type
import X86.Helpers.Paging_Level_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Physical_Mem_Write_PTW.Binding (σ : Type) where
  call (address : Bits 64) (memory_type : Memory_Type) (level : Paging_Level_Type) (value : Bits 8) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Physical_Mem_Write_PTW.Binding

variable {σ : Type}

variable
  [X86.Helpers.Physical_Mem_Write_PTW.Binding σ]

def Physical_Mem_Write_PTW
    (address : Bits 64) (memory_type : Memory_Type) (level : Paging_Level_Type) (value : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Physical_Mem_Write_PTW.Binding.call address memory_type level value)

end X86.Helpers
