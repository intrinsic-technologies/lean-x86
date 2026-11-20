-- Generated from data/definitions.xml.gz: Check_Alignment; do not edit.
-- Source SHA256: c02d1931f2cee87afc3c2c12ad95836ee8bd8f604a4c69e202f50e6a5302b053
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Alignment)
import X86.Runtime
import X86.Helpers.Is_Aligned
import X86.Helpers.Report_Alignment_Check_Exception
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Check_Alignment (address : Bits 64) (num_bytes : Int) : Result Unit := do
  if (not (← Is_Aligned (n := 64) address num_bytes)) then
    liftM (Report_Alignment_Check_Exception (← Std.Bits.Zero 32))

end X86.Helpers
