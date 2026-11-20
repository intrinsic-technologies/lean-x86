-- Generated from data/definitions.xml.gz: Report_Stack_Fault; do not edit.
-- Source SHA256: dd949e959b8f0d86f25c241bd9096373b2e2fa3cdd67ead2b02f30f7c07b52a0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Stack_Fault)
import X86.Runtime
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- This procedure never returns normally; its result type is unrestricted.
def Report_Stack_Fault {α : Type} (error_code : Bits 32) : Result α := do
  throw (.raised (↑({
    vector := SS_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := error_code
  } : Exception_Info) : Exception))

end X86.Helpers
