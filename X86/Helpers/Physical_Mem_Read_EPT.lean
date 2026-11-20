-- Generated from data/definitions.xml.gz: Physical_Mem_Read_EPT; do not edit.
-- Source SHA256: 155596bf65f346e6649e1cebc1ddcbc7bb6163a6571e8867c2e7d62e33ba18fa
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Physical_Mem_Read_EPT)
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
class Physical_Mem_Read_EPT.Binding (σ : Type) where
  call (address : Bits 64) (size : Int) (memory_type : Memory_Type) (ia_paging_level ept_level : Paging_Level_Type) :
    Runtime.SpecM Empty (State σ) (Bits size)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Physical_Mem_Read_EPT.Binding

variable {σ : Type}

variable
  [X86.Helpers.Physical_Mem_Read_EPT.Binding σ]

def Physical_Mem_Read_EPT
    (address : Bits 64) (size : Int) (memory_type : Memory_Type) (ia_paging_level ept_level : Paging_Level_Type) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  Runtime.liftNoSourceException (Physical_Mem_Read_EPT.Binding.call address size memory_type ia_paging_level ept_level)

end X86.Helpers
