-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 012261a6fffbb1c3d510f2e17989102a082179260f64f563b51d05fc68cbec1b
import X86.Runtime
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Check_MXCSR_Reserved_Bits (value : MXCSR_Type) : Result Unit := do
  if (not (← Std.Bits.Is_Zero (size := 16) (MXCSR_Type.RESERVED value))) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

end X86.Helpers
