-- Generated from data/definitions.xml.gz: CET::Shadow_Stack_Switch; do not edit.
-- Source SHA256: 08639d50d8eebb967a1d8b0bbd99b3c30f1f6ae5cf0df6b8e389a46ee1489101
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AShadow_Stack_Switch)
import X86.Runtime
import X86.Helpers.CET.Shadow_Stack_Push
import X86.Helpers.CET.Shadow_Stack_Write
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Align_Down
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]

def CET.Shadow_Stack_Switch
    (old_ssp : SSP_Type) (cs_selector return_ip : Bits 64) (new_cs : Segment) :
    Runtime.SpecM Exception (State σ) (SSP_Type) := do

  CET.Shadow_Stack_Write (size_in_bits := 32) (← Std.Bits.Subtract_int (n := 64) old_ssp 4) (← Std.Bits.Zero 32) false false (← get).CPL

  let mut temp_ssp : SSP_Type ← CET.Shadow_Stack_Push (size_in_bits := 64) (← Std.Bits.Align_Down (size := 64) old_ssp 8) cs_selector
  let temp_lip : Bits 64 ← Compute_Linear_Address (← get).CS return_ip (← get).CS
  temp_ssp := (← CET.Shadow_Stack_Push (size_in_bits := 64) temp_ssp temp_lip)
  temp_ssp := (← CET.Shadow_Stack_Push (size_in_bits := 64) temp_ssp (← get).SSP)
  return (← (do if (← Is_64Bit_Code_Segment new_cs) then pure temp_ssp else pure (← Std.Bits.Zero_Extend (source_size := 32) (← temp_ssp[0 +: 32]) 64)))

end X86.Helpers
