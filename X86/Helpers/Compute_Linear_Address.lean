-- Generated from data/definitions.xml.gz: Compute_Linear_Address; do not edit.
-- Source SHA256: fd9fe6b9d8c79232f2320edf0067731c69ad49b86e369269c150c055778f6bd0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Compute_Linear_Address)
import X86.Runtime
import X86.Helpers.Get_Segment_Base
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_System_Segment
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Compute_Linear_Address
    (segment : Segment) (offset : Bits 64) (code_segment : Segment) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  if (← Is_64Bit_Code_Segment code_segment) then
    if (← (do
      let operand := some (← Is_System_Segment segment)
      let operand_1 := segment.is_64bit_mode_data_segment
      let value ← Runtime.readInitialized operand
      let value_1 ← Runtime.readInitialized operand_1
      pure (value or value_1))) then
      return (← Get_Segment_Base segment) + offset
    else
      return offset
  else
    if ((← get).IA32_EFER.LMA == 1 and (← Is_System_Segment segment)) then
      return (← Get_Segment_Base segment) + offset
    else
      let linear_address : Bits 64 := (← Get_Segment_Base segment) + offset
      return (← Std.Bits.Zero_Extend (source_size := 32) (← linear_address[0 +: 32]) 64)

end X86.Helpers
