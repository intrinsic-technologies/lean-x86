-- Generated from data/definitions.xml.gz: Physical_Mem_Read_PTW; do not edit.
-- Source SHA256: 085ff76ad2e411b24d21fa480e3f9075e7bc6f42129a01fcf3cbeeec75f3c120
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Physical_Mem_Read_PTW)
import X86.Runtime
import X86.Helpers.Paging_Level_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Physical_Mem_Read_PTW.Binding (σ : Type) where
  call (la pa : Bits 64) (size : Int) (pat : Bits 3) (level : Paging_Level_Type) :
    Runtime.SpecM Exception (State σ) (Bits size)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Physical_Mem_Read_PTW.Binding

variable {σ : Type}

variable
  [X86.Helpers.Physical_Mem_Read_PTW.Binding σ]

def Physical_Mem_Read_PTW
    (la pa : Bits 64) (size : Int) (pat : Bits 3) (level : Paging_Level_Type) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  try
    Physical_Mem_Read_PTW.Binding.call la pa size pat level
  catch
    | .raised (.Exception_Info exception) =>
      Runtime.assert ((exception).vector in {0..255})
      throw (.raised (.Exception_Info exception))
    | error => throw error

end X86.Helpers
