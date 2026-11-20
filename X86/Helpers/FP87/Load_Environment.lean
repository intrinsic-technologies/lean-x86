-- Generated from data/definitions.xml.gz: FP87::Load_Environment; do not edit.
-- Source SHA256: 4a65625e22204f63f933b2f0510e72cfa8c0dcaf35a5309862589c101bfeb5c6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ALoad_Environment)
import X86.Runtime
import X86.Helpers.Calculate_Offset
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.FP87.Is_Unmasked_Exception
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Segment
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def FP87.Load_Environment
    (segment : Segment) (offset : Bits 64) (operand_size address_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits 16 × Bits 16 × Bits 16 × Bits 64 × Bits 16 × Bits 11 × Bits 64 × Bits 16) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let mode : Execution_Mode ← Current_Mode

  let mut fcs : Runtime.InitializedBits 16 := Runtime.InitializedBits.empty 16
  let mut fds : Runtime.InitializedBits 16 := Runtime.InitializedBits.empty 16

  let mut (control, status, tag_word, fip, fdp, fop) : (FP87_Control_Type × FP87_Status_Type × Bits 16 × Bits 64 × Bits 64 × Bits 11) ← do
    if operand_size == 16 then
      let control : FP87_Control_Type ← Logical_Mem_Read segment (← Calculate_Offset offset 0 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      let status : FP87_Status_Type ← Logical_Mem_Read segment (← Calculate_Offset offset 2 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      let tag_word : Bits 16 ← Logical_Mem_Read segment (← Calculate_Offset offset 4 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      let mut fip : Bits 64 ← Std.Bits.Zero_Extend (source_size := 16) (← Logical_Mem_Read segment (← Calculate_Offset offset 6 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) 64

      -- 16-Bit Real-Address Mode or Virtual-8086 Mode
      let (fdp, fop) : (Bits 64 × Bits 11) ← do
        if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
          let fip_opcode : Bits 16 ← Logical_Mem_Read segment (← Calculate_Offset offset 8 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          let mut fdp : Bits 64 ← Std.Bits.Zero_Extend (source_size := 16) (← Logical_Mem_Read segment (← Calculate_Offset offset 10 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) 64
          let fdp_data : Bits 16 ← Logical_Mem_Read segment (← Calculate_Offset offset 12 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          fip := (← setSliceChecked fip 16 4 (← fip_opcode[15:12]))
          let fop : Bits 11 ← fip_opcode[0 +: 11]
          fdp := (← setSliceChecked fdp 16 4 (← fdp_data[15:12]))
          pure (fdp, fop)
        else
          fcs := (← Runtime.InitializedBits.writeSlice fcs 0 16 (← Logical_Mem_Read segment (← Calculate_Offset offset 8 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false))
          let fdp : Bits 64 ← Std.Bits.Zero_Extend (source_size := 16) (← Logical_Mem_Read segment (← Calculate_Offset offset 10 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) 64
          fds := Runtime.InitializedBits.ofValue (← Logical_Mem_Read segment (← Calculate_Offset offset 12 address_size) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
          let fop : Bits 11 ← Std.Bits.Zero 11
          pure (fdp, fop)
      pure (control, status, tag_word, fip, fdp, fop)
    else
      let control_data : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 0 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      let status_data : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 4 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      let tag_word_data : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 8 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      let control : FP87_Control_Type ← control_data[0 +: 16]
      let status : FP87_Status_Type ← status_data[0 +: 16]
      let tag_word : Bits 16 ← tag_word_data[0 +: 16]

      -- 32-Bit Real-Address Mode or Virtual-8086 Mode
      let (fip, fdp, fop) : (Bits 64 × Bits 64 × Bits 11) ← do
        if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
          let fip_data : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 12 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          let fip_opcode : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 16 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          let fdp_data_1 : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 20 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          let fdp_data_2 : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 24 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          let fip : Bits 64 ← concatBits (leftSize := 48) (rightSize := 16) (← concatBits (leftSize := 32) (rightSize := 16) (← Std.Bits.Zero 32) (← fip_opcode[12 +: 16])) (← fip_data[0 +: 16])
          let fop : Bits 11 ← fip_opcode[0 +: 11]
          let fdp : Bits 64 ← concatBits (leftSize := 48) (rightSize := 16) (← concatBits (leftSize := 32) (rightSize := 16) (← Std.Bits.Zero 32) (← fdp_data_2[12 +: 16])) (← fdp_data_1[0 +: 16])
          pure (fip, fdp, fop)
        else
          let fip : Bits 64 ← Std.Bits.Zero_Extend (source_size := 32) (← Logical_Mem_Read segment (← Calculate_Offset offset 12 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) 64
          let fcs_opcode : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 16 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          let fdp : Bits 64 ← Std.Bits.Zero_Extend (source_size := 32) (← Logical_Mem_Read segment (← Calculate_Offset offset 20 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) 64
          let fds_data : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset offset 24 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          let fop : Bits 11 ← fcs_opcode[16 +: 11]
          fcs := Runtime.InitializedBits.ofValue (← fcs_opcode[0 +: 16])
          fds := Runtime.InitializedBits.ofValue (← fds_data[0 +: 16])
          pure (fip, fdp, fop)
      pure (control, status, tag_word, fip, fdp, fop)

  control := FP87_Control_Type.setRESERVED_ONE control (1 : Runtime.Bit)
  control := FP87_Control_Type.setRESERVED_ZERO control (← Std.Bits.Zero 4)

  if (← FP87.Is_Unmasked_Exception (FP87_Status_Type.Exception_Flags status) (FP87_Control_Type.Exception_Masks control)) then
    status := FP87_Status_Type.setES status (1 : Runtime.Bit)
    status := FP87_Status_Type.setB status (1 : Runtime.Bit)
  else
    status := FP87_Status_Type.setES status (0 : Runtime.Bit)
    status := FP87_Status_Type.setB status (0 : Runtime.Bit)

  return (control, status, tag_word, fip, (← Runtime.InitializedBits.read fcs), fop, fdp, (← Runtime.InitializedBits.read fds))

end X86.Helpers
