-- Generated from data/definitions.xml.gz: Report_Debug_Exception; do not edit.
-- Source SHA256: 708422527ecff3996084f978032cc07d73baa73c9de9d98f9d0e7ea326e36507
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Debug_Exception)
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
def Report_Debug_Exception {α : Type} : Result α := do
  throw (.raised (↑({
    vector := DB_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := (← Std.Bits.Zero 32)
  } : Exception_Info) : Exception))

end X86.Helpers
