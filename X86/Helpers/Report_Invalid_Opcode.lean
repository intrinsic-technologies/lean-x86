-- Generated from data/definitions.xml.gz: Report_Invalid_Opcode; do not edit.
-- Source SHA256: cbd60431c99803cf2f061e70d63615d9cb1cd788a9faa73aef138fe6a30e6716
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Invalid_Opcode)
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
def Report_Invalid_Opcode {α : Type} : Result α := do
  throw (.raised (↑({
    vector := UD_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := (← Std.Bits.Zero 32)
  } : Exception_Info) : Exception))

end X86.Helpers
