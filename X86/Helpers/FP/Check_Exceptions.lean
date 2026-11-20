-- Generated from data/definitions.xml.gz: FP::Check_Exceptions; do not edit.
-- Source SHA256: 3b29cbb2635f7600a53df8111a0da1e88c9d6476cf725f06db9610d5171bd954
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3ACheck_Exceptions)
import X86.Runtime
import X86.Helpers.Clear_Debug_Traps
import X86.Helpers.FP.Prioritize_Exceptions
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_SIMD_FP_Exception
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Check_Exceptions
    (exceptions : FP_Exception_Flags_Type) (mask : Bits 6) :
    Runtime.SpecM Exception (State σ) Unit := do
  MXCSR.setException_Flags ((BitVec.cast (by omega) (← MXCSR.Exception_Flags) : Bits 6) or (← FP.Prioritize_Exceptions exceptions mask))

  let unmasked_exceptions : Bits 6 := exceptions and ~~~ mask
  if (not (← Std.Bits.Is_Zero (size := 6) unmasked_exceptions)) then
    Clear_Debug_Traps
    if ((← CR4.OSXMMEXCPT) == 0) then
      liftM (Report_Invalid_Opcode)
    else
      liftM (Report_SIMD_FP_Exception)

end X86.Helpers
