-- Generated from data/definitions.xml.gz: Report_Divide_Error; do not edit.
-- Source SHA256: 29817d97fa28a2a66f726161a9cd0e311e4dd8a4449e120b3a807cd97772cd76
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Divide_Error)
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
def Report_Divide_Error {α : Type} : Result α := do
  throw (.raised (↑({
    vector := DE_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := (← Std.Bits.Zero 32)
  } : Exception_Info) : Exception))

end X86.Helpers
