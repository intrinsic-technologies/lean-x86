-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 31b78b3f3af16c58b2c27adf2a6dc25e9c72a6b21573a514b07757ed1ecfa32c
import X86.Runtime
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Unimplemented_Feature
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.Unimplemented_Feature.Binding σ]

-- SDM 093 Vol. 1 Sections 8.6-8.7: ES records pending unmasked exceptions;
-- CR0.NE selects native #MF delivery. Legacy FERR#/IGNNE# signaling is unsupported.
def FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
     :
    Runtime.SpecM Exception (State σ) Unit := do
  if ((← FP87_Status.ES) == 0) then
    return ()
  if ((← CR0.NE) == 0) then
    Unimplemented_Feature "pending x87 exception requires legacy FERR#/IGNNE# signaling" false true
    return ()
  throw (.raised (↑({ vector := MF_Exception, linear_address := 0, error_code := 0 } : Exception_Info) : Exception))

end X86.Helpers
