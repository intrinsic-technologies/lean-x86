-- Generated from data/definitions.xml.gz: Report_Invalid_TSS; do not edit.
-- Source SHA256: 5620f36388ca15da1990a22d13b312363270c411a62528446a0621ff689a6f7d
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Invalid_TSS)
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
def Report_Invalid_TSS {α : Type} (error_code : Bits 32) : Result α := do
  throw (.raised (↑({
    vector := TS_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := error_code
  } : Exception_Info) : Exception))

end X86.Helpers
