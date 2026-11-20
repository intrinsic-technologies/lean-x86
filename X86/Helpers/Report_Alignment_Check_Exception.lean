-- Generated from data/definitions.xml.gz: Report_Alignment_Check_Exception; do not edit.
-- Source SHA256: 72dcce08b8dee31f8d63a6b98d5109191e109bcf4268a3005cda440cf80c45c6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Alignment_Check_Exception)
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
def Report_Alignment_Check_Exception {α : Type} (error_code : Bits 32) : Result α := do
  throw (.raised (↑({
    vector := AC_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := error_code
  } : Exception_Info) : Exception))

end X86.Helpers
