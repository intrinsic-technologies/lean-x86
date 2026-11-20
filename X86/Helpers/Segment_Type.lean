-- Generated from data/definitions.xml.gz: Segment_Type; do not edit.
-- Source SHA256: 3ecc26d99008c4b1c287e1e075e2bb36624f753c05db78a95ea1c8ac3a328e9a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Segment_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Segment_Type where
  | System_Reserved_Zero
  | System_16Bit_TSS_Available
  | System_LDT
  | System16Bit_TSS_Busy
  | System16Bit_Call_Gate
  | System_Task_Gate
  | System_16Bit_Interrupt_Gate
  | System_16Bit_Trap_Gate
  | System_Reserved_1000
  | System_TSS_Available
  | System_Reserved_1010
  | System_TSS_Busy
  | System_Call_Gate
  | System_Reserved_1101
  | System_Interrupt_Gate
  | System_Trap_Gate
  | Conforming_Code_Segment
  | Non_Conforming_Code_Segment
  | Data_Segment
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
