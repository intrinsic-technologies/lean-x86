-- Generated from data/definitions.xml.gz: FP87::Store_Environment; do not edit.
-- Source SHA256: 7120b347e0da16931f5eef9c613bbcaeb63488e21003969fcdb34bf1aaa98a66
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AStore_Environment)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Calculate_Offset
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.FP87.Calculate_Abridged_Tag_Word
import X86.Helpers.FP87.Expand_Abridged_Tag_Word
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Shift_Left_Logical
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
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Fuzz_Next_Mem_Write.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_Ingore_FCS_FDS_Deprecation]

def FP87.Store_Environment
    (segment : Segment) (offset : Bits 64) (operand_size address_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let mode : Execution_Mode ← Current_Mode

  -- update the tag word using the values in the FP registers
  FP87_Tag_Word.assign (← FP87.Expand_Abridged_Tag_Word (← FP87.Calculate_Abridged_Tag_Word))

  -- Core processors ignore the FCS/FDS CPUID deprecation setting in Real mode
  let ignore_fcs_fds : Bool := (← CPUID_FCS_FDS_DEPRECATION) and not ((← Config.Read.Feature_Ingore_FCS_FDS_Deprecation (exception := Exception)) and ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)))
  let fcs : Bits 16 ← do
    if ignore_fcs_fds then
      Std.Bits.Zero 16
    else
      pure (← get).FP87_FCS
  let fds : Bits 16 ← do
    if ignore_fcs_fds then
      Std.Bits.Zero 16
    else
      pure (← get).FP87_FDS

  if (operand_size == 16) then
    Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 0 address_size) (← get).FP87_Control Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 2 address_size) (← get).FP87_Status Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 4 address_size) (← get).FP87_Tag_Word Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

    -- 16-Bit Real-Address Mode or Virtual-8086 Mode
    if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
      let fip : Bits 64 := (← get).FP87_FIP + (← Std.Bits.Shift_Left_Logical (size := 64) (← Std.Bits.Zero_Extend (source_size := 16) fcs 64) 4)
      let fdp : Bits 64 := (← get).FP87_FDP + (← Std.Bits.Shift_Left_Logical (size := 64) (← Std.Bits.Zero_Extend (source_size := 16) fds 64) 4)
      Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 6 address_size) (← fip[0 +: 16]) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 8 address_size) (← concatBits (leftSize := 5) (rightSize := 11) (← concatBits (leftSize := 4) (rightSize := 1) (← fip[19:16]) (← Std.Bits.Zero 1)) (← get).FP87_FOP) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      -- "Errata", errata 047 "x87 FDP Value May be Saved Incorrectly",
      -- "Execution of the FSAVE, FNSAVE, FSTENV, FNSTENV instructions in real-address mode or
      -- virtual-8086 mode may save an incorrect value for the x87 FDP (FPU data pointer).
      __Fuzz_Next_Mem_Write "FDP"
      Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 10 address_size) (← fdp[0 +: 16]) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      __Fuzz_Next_Mem_Write "FDS"
      Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 12 address_size) (← concatBits (leftSize := 4) (rightSize := 12) (← fdp[19:16]) (← Std.Bits.Zero 12)) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    else
      Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 6 address_size) (← Runtime.CheckedSlice.read (← get).FP87_FIP 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 8 address_size) fcs Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 10 address_size) (← Runtime.CheckedSlice.read (← get).FP87_FDP 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      Logical_Mem_Write (size := 16) segment (← Calculate_Offset offset 12 address_size) fds Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
  else
    Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 0 address_size) (← concatBits (leftSize := 16) (rightSize := 16) (← Std.Bits.All_Ones 16) (← get).FP87_Control) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 4 address_size) (← concatBits (leftSize := 16) (rightSize := 16) (← Std.Bits.All_Ones 16) (← get).FP87_Status) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 8 address_size) (← concatBits (leftSize := 16) (rightSize := 16) (← Std.Bits.All_Ones 16) (← get).FP87_Tag_Word) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

    -- 32-Bit Real-Address Mode or Virtual-8086 Mode
    if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
      let fip : Bits 64 := (← get).FP87_FIP + (← Std.Bits.Shift_Left_Logical (size := 64) (← Std.Bits.Zero_Extend (source_size := 16) fcs 64) 4)
      let fdp : Bits 64 := (← get).FP87_FDP + (← Std.Bits.Shift_Left_Logical (size := 64) (← Std.Bits.Zero_Extend (source_size := 16) fds 64) 4)
      Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 12 address_size) (← concatBits (leftSize := 16) (rightSize := 16) (← Std.Bits.All_Ones 16) (← fip[0 +: 16])) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 16 address_size) (← concatBits (leftSize := 21) (rightSize := 11) (← concatBits (leftSize := 20) (rightSize := 1) (← concatBits (leftSize := 4) (rightSize := 16) (← Std.Bits.Zero 4) (← fip[31:16])) (← Std.Bits.Zero 1)) (← get).FP87_FOP) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      -- "Errata", errata 047 "x87 FDP Value May be Saved Incorrectly",
      -- "Execution of the FSAVE, FNSAVE, FSTENV, FNSTENV instructions in real-address mode or
      -- virtual-8086 mode may save an incorrect value for the x87 FDP (FPU data pointer).
      __Fuzz_Next_Mem_Write "FDP"
      Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 20 address_size) (← concatBits (leftSize := 16) (rightSize := 16) (← Std.Bits.All_Ones 16) (← fdp[0 +: 16])) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      __Fuzz_Next_Mem_Write "FDS"
      Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 24 address_size) (← concatBits (leftSize := 20) (rightSize := 12) (← concatBits (leftSize := 4) (rightSize := 16) (← Std.Bits.Zero 4) (← fdp[31:16])) (← Std.Bits.Zero 12)) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    else
      Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 12 address_size) (← Runtime.CheckedSlice.read (← get).FP87_FIP 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 16 address_size) (← concatBits (leftSize := 16) (rightSize := 16) (← concatBits (leftSize := 5) (rightSize := 11) (← Std.Bits.Zero 5) (← get).FP87_FOP) fcs) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 20 address_size) (← Runtime.CheckedSlice.read (← get).FP87_FDP 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
      Logical_Mem_Write (size := 32) segment (← Calculate_Offset offset 24 address_size) (← concatBits (leftSize := 16) (rightSize := 16) (← Std.Bits.All_Ones 16) fds) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

end X86.Helpers
