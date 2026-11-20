-- Generated from data/definitions.xml.gz: Report_Not_Available_Exception; do not edit.
-- Source SHA256: 8d76c6aec4404fc0f89cbc273fb51aacd13a35b218fd98c1b100d8809b4fece1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Not_Available_Exception)
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
def Report_Not_Available_Exception {α : Type} : Result α := do
  throw (.raised (↑({
    vector := NM_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := (← Std.Bits.Zero 32)
  } : Exception_Info) : Exception))

end X86.Helpers
