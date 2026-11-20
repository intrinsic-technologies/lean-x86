-- Generated from data/definitions.xml.gz: Report_Segment_Not_Present; do not edit.
-- Source SHA256: 7faca77f802cdc65a6b376a24990cb74638a9d8df57cef45c99f19a1098951be
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Segment_Not_Present)
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
def Report_Segment_Not_Present {α : Type} (error_code : Bits 32) : Result α := do
  throw (.raised (↑({
    vector := NP_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := error_code
  } : Exception_Info) : Exception))

end X86.Helpers
