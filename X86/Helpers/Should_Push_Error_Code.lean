-- Generated from data/definitions.xml.gz: Should_Push_Error_Code; do not edit.
-- Source SHA256: 9cd46473d59b249a212b15d36479cd0f59bde3dd1b3a639ea902e4f12c609035
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Should_Push_Error_Code)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Execution_Mode
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Should_Push_Error_Code
    (event_type : Vectored_Event_Type) (vector : Int) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (vector in {0..255})

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    return false

  if (event_type != Vectored_Event_Type.Hardware_Exception) then
    return false

  return ((vector == DF_Exception) || (vector == TS_Exception) || (vector == NP_Exception) || (vector == SS_Exception) || (vector == GP_Exception) || (vector == PF_Exception) || (vector == AC_Exception) || (vector == CP_Exception))

end X86.Helpers
