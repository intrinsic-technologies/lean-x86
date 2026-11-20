-- Generated from data/definitions.xml.gz: FRED::Event_Delivery; do not edit.
-- Source SHA256: ae0f13dbf9c3fbd48ccee1bb944dc4a0251bb8415d17fec7c7e7882fe8aa1963
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FRED%3A%3AEvent_Delivery)
import X86.Runtime
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class FRED.Event_Delivery.Binding (σ : Type) where
  call (event_type : Vectored_Event_Type) (vector : Int) (error_code : Bits 32) (return_ip : Bits 64) (from_syscall from_sysenter : Bool) :
    Runtime.SpecM Exception (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] FRED.Event_Delivery.Binding

variable {σ : Type}

variable
  [X86.Helpers.FRED.Event_Delivery.Binding σ]

def FRED.Event_Delivery
    (event_type : Vectored_Event_Type) (vector : Int) (error_code : Bits 32) (return_ip : Bits 64) (from_syscall : Bool := false) (from_sysenter : Bool := false) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (vector in {0..255})

  try
    FRED.Event_Delivery.Binding.call event_type vector error_code return_ip from_syscall from_sysenter
  catch
    | .raised (.Exception_Info exception) =>
      Runtime.assert ((exception).vector in {0..255})
      throw (.raised (.Exception_Info exception))
    | error => throw error

end X86.Helpers
