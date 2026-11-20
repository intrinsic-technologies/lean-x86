-- Generated from data/definitions.xml.gz: Get_Segment_Type; do not edit.
-- Source SHA256: 888369811b7101f77e4f1212ae7b6d1f2770a3365e13de67c26eed2f293f629f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Segment_Type)
import X86.Runtime
import X86.Helpers.Is_Conforming_Code_Segment
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Is_Non_Conforming_Code_Segment
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Get_Segment_Type (segment : Segment) : Except (Runtime.Error Empty) (Segment_Type) := do
  if (← Is_Conforming_Code_Segment segment) then
    return Segment_Type.Conforming_Code_Segment
  else
    if (← Is_Non_Conforming_Code_Segment segment) then
      return Segment_Type.Non_Conforming_Code_Segment
    else
      if (← Is_Data_Segment segment) then
        return Segment_Type.Data_Segment
      else
        match Unsigned (← Segment_Descriptor.«Type».partial segment.descriptor) with
        | 0b0000 => do
          return Segment_Type.System_Reserved_Zero
        | 0b0001 => do
          return Segment_Type.System_16Bit_TSS_Available
        | 0b0010 => do
          return Segment_Type.System_LDT
        | 0b0011 => do
          return Segment_Type.System16Bit_TSS_Busy
        | 0b0100 => do
          return Segment_Type.System16Bit_Call_Gate
        | 0b0101 => do
          return Segment_Type.System_Task_Gate
        | 0b0110 => do
          return Segment_Type.System_16Bit_Interrupt_Gate
        | 0b0111 => do
          return Segment_Type.System_16Bit_Trap_Gate
        | 0b1000 => do
          return Segment_Type.System_Reserved_1000
        | 0b1001 => do
          return Segment_Type.System_TSS_Available
        | 0b1010 => do
          return Segment_Type.System_Reserved_1010
        | 0b1011 => do
          return Segment_Type.System_TSS_Busy
        | 0b1100 => do
          return Segment_Type.System_Call_Gate
        | 0b1101 => do
          return Segment_Type.System_Reserved_1101
        | 0b1110 => do
          return Segment_Type.System_Interrupt_Gate
        | 0b1111 => do
          return Segment_Type.System_Trap_Gate
        | _ => throw .unmatchedCase

end X86.Helpers
