-- Generated from data/definitions.xml.gz: Report_General_Protection_Exception; do not edit.
-- Source SHA256: 815cd51717a8e39021cea9a414482bda61f16290eb31332a3f53d2116d0b371b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_General_Protection_Exception)
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
def Report_General_Protection_Exception {α : Type} (error_code : Bits 32) : Result α := do
  throw (.raised (↑({
    vector := GP_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := error_code
  } : Exception_Info) : Exception))

end X86.Helpers
