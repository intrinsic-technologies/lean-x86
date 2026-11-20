-- Generated from data/instruction/LSL.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: f2a32a90700b4a280d7dd23ed4bbcc948ec0242d6bda53f76bc06872ecb60053
-- Description: data/sdm/LSL.docbook
-- Loads the segment limit from the segment descriptor (see below) specified with the second
-- operand (source operand) into the first operand (destination operand) and sets the ZF flag in
-- the EFLAGS register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LSL)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Descriptor_High
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Segment_Base
import X86.Helpers.Get_Segment_Limit
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Conforming_Code_Segment
import X86.Helpers.Is_Local_Segment_Selector
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Is_System_Segment
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Load_Segment_Descriptor_High
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Read_GPR
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Segment_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Write_GPR
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.LSL
    (operand_size : Int) (src_size : Int) (src : Bits src_size) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bool) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (src_size == 16 || src_size == 32)

  let _mode : Execution_Mode ← Current_Mode

  let segment_selector : Segment_Selector ← src[0 +: 16]
  let mut result : Runtime.InitializedBits operand_size := Runtime.InitializedBits.empty operand_size

  let valid_segment : Bool ← do
    if (← Is_Null_Segment_Selector segment_selector) then
      let valid_segment : Bool := false
      pure valid_segment
    else
      let descriptor_index : Int := Unsigned (← concatBits (leftSize := 13) (rightSize := 3) (Segment_Selector.Index segment_selector) (0 : Bits 3))
      let _base : Bits 64 ← do
        if (← Is_Local_Segment_Selector segment_selector) then
          Get_Segment_Base (← get).LDTR
        else
          pure (← get).GDTR.base
      let limit : Int ← do
        if (← Is_Local_Segment_Selector segment_selector) then
          Get_Segment_Limit (← get).LDTR
        else
          pure (Unsigned (← get).GDTR.limit)
      let descriptor_access_size : Int := 8

      let valid_segment : Bool ← do
        if decide (descriptor_index + descriptor_access_size - 1 > limit) then
          let valid_segment : Bool := false
          pure valid_segment
        else
          let segment : Segment ← Load_Segment_Descriptor segment_selector (← Null_Segment (← get).DS) false
          let seg_type : Segment_Type ← Get_Segment_Type segment

          let mut valid_segment : Bool ← do
            if (← Is_System_Segment segment) then
              let valid_segment : Bool ← do
                if (← Current_Mode) == Execution_Mode.IA32e_Mode then
                  let mut valid_segment : Bool := ((seg_type == Segment_Type.System_LDT) || (seg_type == Segment_Type.System_TSS_Available) || (seg_type == Segment_Type.System_TSS_Busy))
                  -- IA-32e system descriptors are 16 bytes; check that the complete descriptor fits
                  if (valid_segment and decide (descriptor_index + 15 > limit)) then
                    valid_segment := false
                  -- For IA-32e system descriptors, verify that Type2 (bits 44:40 of the upper half) is zero
                  if valid_segment then
                    let descriptor_high : Descriptor_High ← Load_Segment_Descriptor_High segment_selector
                    if (not (← Std.Bits.Is_Zero (size := 5) (Descriptor_High.Type2 descriptor_high))) then
                      valid_segment := false
                  pure valid_segment
                else
                  let valid_segment : Bool := ((seg_type == Segment_Type.System_16Bit_TSS_Available) || (seg_type == Segment_Type.System_LDT) || (seg_type == Segment_Type.System16Bit_TSS_Busy) || (seg_type == Segment_Type.System_TSS_Available) || (seg_type == Segment_Type.System_TSS_Busy))
                  pure valid_segment
              pure valid_segment
            else
              let valid_segment : Bool := true
              pure valid_segment

          if (not (← Is_Conforming_Code_Segment segment)) then
            if (decide (Unsigned (← Segment_Descriptor.DPL.partial segment.descriptor) < (← get).CPL) or decide (Unsigned (← Segment_Descriptor.DPL.partial segment.descriptor) < Unsigned (Segment_Selector.RPL segment_selector))) then
              valid_segment := false

          if valid_segment then
            RFLAGS.setZF 1
            let segment_limit : Int ← Get_Segment_Limit segment
            result := Runtime.InitializedBits.ofValue (← (do if operand_size == 64 then pure (← Std.Bits.Zero_Extend (source_size := 32) (← segment_limit[0 +: 32]) operand_size) else pure (← segment_limit[0 +: operand_size])))
          pure valid_segment
      pure valid_segment

  if (not valid_segment) then
    RFLAGS.setZF 0
    result := Runtime.InitializedBits.ofValue (← UNSPECIFIED (size := operand_size))

  -- like LAR, the destination is left unmodified when the selector is invalid
  let write_result : Bool := valid_segment
  return ((← Runtime.InitializedBits.read result), write_result)

-- LSL_GPRv_GPRz: 0F 03 /r
def Instructions.LSL_GPRv_GPRz
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src_size : Int := Std.Integer.Min operand_size 32

  let src : Bits (Std.Integer.Min operand_size 32) ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (Std.Integer.Min operand_size 32)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.LSL operand_size src_size (BitVec.cast (by omega) src : Bits src_size)

  if write_result then
    Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- LSL_GPRv_MEMw: 0F 03 /r
def Instructions.LSL_GPRv_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Instructions.Operations.LSL operand_size src_size src

  if write_result then
    Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
