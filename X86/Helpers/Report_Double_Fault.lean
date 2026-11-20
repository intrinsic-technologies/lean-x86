-- Generated from data/definitions.xml.gz: Report_Double_Fault; do not edit.
-- Source SHA256: 749c809adcad160b8d2ab499efa9411123d692faf1f0a8098f28049e148dd2b4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Double_Fault)
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
def Report_Double_Fault {α : Type} : Result α := do
  -- always push an error code of 0 onto the stack of the #DF handler
  throw (.raised (↑({
    vector := DF_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := (← Std.Bits.Zero 32)
  } : Exception_Info) : Exception))

end X86.Helpers
