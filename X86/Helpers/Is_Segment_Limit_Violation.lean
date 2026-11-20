-- Generated from data/definitions.xml.gz: Is_Segment_Limit_Violation; do not edit.
-- Source SHA256: 34fdf7bde2327a82570124fbb763ee79de221e50aecc1a935215e749fb8dc724
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Segment_Limit_Violation)
import X86.Runtime
import X86.Helpers.Get_Segment_Base
import X86.Helpers.Get_Segment_Limit
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Subtract_int
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Is_Segment_Limit_Violation
    (segment : Segment) (offset : Bits 64) (num_bytes : Int) :
    Except (Runtime.Error Empty) (Bool) := do
  let limit : Int ← Get_Segment_Limit segment
  let low_byte : Int := Unsigned offset
  let high_byte : Int := Unsigned (← Std.Bits.Subtract_int (n := 64) (← Std.Bits.Add_int (n := 64) offset num_bytes) 1)

  if ((← Is_Data_Segment segment) and (← Segment_Descriptor.Conforming.partial segment.descriptor) == 1) then
    -- expand down (data segment only)
    let upper_limit : Int ← do
      if (← Segment_Descriptor.D.partial segment.descriptor) == 1 then
        pure (Unsigned (4294967295 : Bits 32))
      else
        pure (Unsigned (65535 : Bits 32))

    if (decide (low_byte ≤ limit) or decide (low_byte > upper_limit) or decide (high_byte ≤ limit) or decide (high_byte > upper_limit)) then
      return true
  else
    -- For Core, the combination of limit := 0xffffffff (4G), base= 0 and G-bit := 1
    -- is treated as flat segment
    if ((← Config.Read.Feature_4G_Limit_Treated_As_Flat_Segment (exception := Empty)) and limit == Unsigned (4294967295 : Bits 32) and (← Std.Bits.Is_Zero (size := 64) (← Get_Segment_Base segment)) and (← Segment_Descriptor.G.partial segment.descriptor) == 1) then
      return false
    else
      if (decide (high_byte > limit)) then
        return true

  return false

end X86.Helpers
