-- Generated from data/instruction/CALL.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: c668837241e52aa45b611f5d4b41a7afcc68169f20b8bbb44c5e91f3a787cfbe
-- Description: data/sdm/CALL.docbook
-- Saves procedure linking information on the stack and branches to the called procedure specified
-- using the target operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CALL)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.Branch_Near
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.CET.Is_Valid_Shadow_Stack_Address
import X86.Helpers.CET.Set_Tracker_Status
import X86.Helpers.CET.Shadow_Stack_Push
import X86.Helpers.CET.Shadow_Stack_Set_Token_Busy_Bit
import X86.Helpers.CET.Shadow_Stack_Switch
import X86.Helpers.Call_More_Privilege
import X86.Helpers.Check_New_RIP
import X86.Helpers.Code_Segment_Checks
import X86.Helpers.Current_Mode
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Get_System_Segment_Size
import X86.Helpers.Get_Target_From_Gate
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Handle_Task
import X86.Helpers.IA32_CET
import X86.Helpers.IA32_SSP
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Aligned
import X86.Helpers.Is_End_Branch_Enabled
import X86.Helpers.Is_End_Branch_Enabled_And_Not_Suppressed
import X86.Helpers.Is_Non_Conforming_Code_Segment
import X86.Helpers.Is_Task_Segment
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Push_Stack
import X86.Helpers.Read_GPR
import X86.Helpers.Registers
import X86.Helpers.Relative_Branch_Wrap
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Segment_Type
import X86.Helpers.Set_Canonical_Wrt_Paging_Mode
import X86.Helpers.Set_Segment_Access_Bit
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Unreachable
import X86.Helpers.Task_Switch_Initiator
import X86.Helpers.Update_Stack_Pointer
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]
  [X86.Helpers.Check_New_TSS.Binding σ]
  [X86.Helpers.Load_New_TSS.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.CALL_FAR
    (operand_size : Int) (offset : Bits operand_size) (segment_selector : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let mode : Execution_Mode ← Current_Mode
  let mut new_rsp : Bits 64 ← RSP

  if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
    if (operand_size == 32) then
      new_rsp := (← Push_Stack (← get).SS new_rsp (← get).CS 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 32) false)
      new_rsp := (← Push_Stack (← get).SS new_rsp (← get).CS 32 32 (← Runtime.CheckedSlice.read (← get).Next_IP 0 32) false)
    else
      if (operand_size == 16) then
        new_rsp := (← Push_Stack (← get).SS new_rsp (← get).CS 16 16 (← get).CS.selector false)
        new_rsp := (← Push_Stack (← get).SS new_rsp (← get).CS 16 16 (← Runtime.CheckedSlice.read (← get).Next_IP 0 16) false)
      else
        Std.Unreachable

    let new_cs : Segment ← Load_Real_Or_VM86_Segment mode segment_selector (← get).CS
    let new_rip : Bits 64 ← Std.Bits.Zero_Extend (source_size := operand_size) offset 64

    Check_New_RIP new_cs new_rip
    Branch_Far new_cs new_rip
    RSP_write new_rsp
  else
    let new_cs_selector : Segment_Selector := segment_selector
    let mut new_cs : Segment ← Load_Segment_Descriptor new_cs_selector (← get).CS false

    let mut stack_access_size : Int := operand_size

    let mut new_rip : Bits 64 ← Std.Bits.Zero_Extend (source_size := operand_size) offset 64

    let calling_procedure : Segment := new_cs

    if (← Is_Task_Segment new_cs) then
      Handle_Task new_cs Task_Switch_Initiator.Task_Switch_Call (← get).Next_IP
    else
      let seg_type : Segment_Type ← Get_Segment_Type new_cs

      match seg_type with
      | Segment_Type.System16Bit_Call_Gate | Segment_Type.System_Call_Gate => do
        if ((← CR4.FRED) == 1 or decide (Unsigned (← Segment_Descriptor.DPL.partial calling_procedure.descriptor) < (← get).CPL) or decide (Unsigned (← Segment_Descriptor.DPL.partial calling_procedure.descriptor) < Unsigned (Segment_Selector.RPL calling_procedure.selector))) then
          liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector calling_procedure.selector))

        let (new_cs_1, new_rip_1) ← Get_Target_From_Gate calling_procedure Vectored_Event_Type.Hardware_Exception
        new_cs := new_cs_1
        new_rip := new_rip_1
        stack_access_size := (← Get_System_Segment_Size calling_procedure)

        if (decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) > (← get).CPL)) then
          liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))
      | Segment_Type.Conforming_Code_Segment => do
        if (decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) > (← get).CPL)) then
          liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))
      | Segment_Type.Non_Conforming_Code_Segment => do
        if (decide (Unsigned (Segment_Selector.RPL new_cs.selector) > (← get).CPL) or Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) != (← get).CPL) then
          liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))
      | _ => do
        liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

      Code_Segment_Checks new_cs

      if ((← Segment_Descriptor.A.partial new_cs.descriptor) == 0) then
        new_cs := (← Set_Segment_Access_Bit new_cs false)

      let mut new_ss : Segment := (← get).SS
      let mut privilege_level_change : Bool := false
      if ((← Is_Non_Conforming_Code_Segment new_cs) and decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < (← get).CPL)) then
        let (new_ss_1, new_rsp_1) ← Call_More_Privilege new_cs (← Segment_Descriptor.Parameter_count.partial calling_procedure.descriptor) stack_access_size
        new_ss := new_ss_1
        new_rsp := new_rsp_1
        privilege_level_change := true
      else
        new_cs := { new_cs with selector := Segment_Selector.setRPL new_cs.selector (← Runtime.CheckedSlice.read (← get).CPL 0 2) }

      match stack_access_size with
      | 16 => do
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← get).CS.selector false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← Runtime.CheckedSlice.read (← get).Next_IP 0 16) false)
      | 32 => do
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 32) false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Runtime.CheckedSlice.read (← get).Next_IP 0 32) false)
      | 64 => do
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 64) false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 (← get).Next_IP false)
      | _ => throw .unmatchedCase

      Check_New_RIP new_cs new_rip

      if privilege_level_change then
        if ((← CET.Is_Shadow_Stack_Enabled (← get).CPL) and (← get).CPL == 3) then
          IA32_PL3_SSP.assign (← (do if (← get).IA32_EFER.LMA == 1 then pure (← Set_Canonical_Wrt_Paging_Mode (← get).SSP) else pure (← get).SSP))

        if (← CET.Is_Shadow_Stack_Enabled (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor))) then
          let new_ssp : SSP_Type ← IA32_SSP (← Segment_Descriptor.DPL.partial new_cs.descriptor)

          if (not (← CET.Is_Valid_Shadow_Stack_Address new_ssp new_cs) or not (← Is_Aligned (n := 64) new_ssp 8)) then
            liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

          -- Token and CS:LIP:oldSSP pushed on shadow stack
          -- must be contained in a naturally aligned 32-byte region
          let new_ssp_after_push : Bits 64 ← Std.Bits.Subtract_int (n := 64) new_ssp 24
          if ((← new_ssp[63:5]) != (← new_ssp_after_push[63:5])) then
            liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

          if (not (← CET.Shadow_Stack_Set_Token_Busy_Bit new_ssp)) then
            liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

          SSP.assign (← (do if (← Segment_Descriptor.DPL.partial (← get).SS.descriptor) != 3 then pure (← CET.Shadow_Stack_Switch new_ssp (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 64) (← get).Next_IP new_cs) else pure new_ssp))
      else
        if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
          if (not (← Is_64Bit_Code_Segment new_cs) and not (← Std.Bits.Is_Zero (size := 32) (← sliceInclusive (← get).SSP 63 32))) then
            liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

          SSP.assign (← CET.Shadow_Stack_Switch (← get).SSP (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 64) (← get).Next_IP new_cs)

      if (← Is_End_Branch_Enabled (← get).CPL) then
        CET.Set_Tracker_Status (← get).CPL

      Branch_Far new_cs new_rip
      Update_Stack_Pointer new_ss new_rsp

def Instructions.Operations.CALL_NEAR
    (operand_size : Int) (context : Instruction_Context) (src : Bits operand_size) (is_relative is_indirect is_no_track : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let new_rip : Bits 64 ← do
    if is_relative then
      Relative_Branch_Wrap context.operand_size ((← get).Next_IP + (← Std.Bits.Sign_Extend (source_size := operand_size) src 64))
    else
      Std.Bits.Zero_Extend (source_size := operand_size) src 64

  let update_shadow_stack : Bool := (← CET.Is_Shadow_Stack_Enabled (← get).CPL) and (not is_relative or not (← Std.Bits.Is_Zero (size := operand_size) src))

  if (not update_shadow_stack) then
    Check_New_RIP (← get).CS new_rip

  let new_rsp : Bits 64 ← Push_Stack (← get).SS (← RSP) (← get).CS operand_size operand_size (← (do Runtime.assert (decide (operand_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← get).Next_IP 0 operand_size))) false

  if update_shadow_stack then
    Check_New_RIP (← get).CS new_rip
    SSP.assign (← CET.Shadow_Stack_Push (size_in_bits := (Std.Integer.Max operand_size 32)) (← get).SSP (← (do Runtime.assert (decide (Std.Integer.Max operand_size 32 ≤ 64)); Runtime.assert (decide (0 ≤ Std.Integer.Max operand_size 32)); pure (← Runtime.CheckedSlice.read (← get).Next_IP 0 (Std.Integer.Max operand_size 32)))))

  RSP_write new_rsp
  Branch_Near new_rip

  if (is_indirect and (← Is_End_Branch_Enabled_And_Not_Suppressed (← get).CPL)) then
    if ((← IA32_CET (← get).CPL).NO_TRACK_EN == 0 or not is_no_track) then
      CET.Set_Tracker_Status (← get).CPL

-- CALL_FAR_PTRp_IMMw: 9A ct iw
def Instructions.CALL_FAR_PTRp_IMMw
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let offset : Bits operand_size ← Mem_Fetch ip operand_size
  let segment_selector : Bits 16 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide operand_size 8)) 16

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide operand_size 8)) 2)

  Instructions.Operations.CALL_FAR operand_size offset segment_selector

-- CALL_NEAR_RELBRd: E8 cd
def Instructions.CALL_NEAR_RELBRd
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let is_relative : Bool := true
  let is_indirect : Bool := false
  let is_no_track : Bool := false

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.CALL_NEAR operand_size context src is_relative is_indirect is_no_track

-- CALL_NEAR_RELBRz: E8 ct
def Instructions.CALL_NEAR_RELBRz
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let is_relative : Bool := true
  let is_indirect : Bool := false
  let is_no_track : Bool := false

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.CALL_NEAR operand_size context src is_relative is_indirect is_no_track

-- CALL_NEAR_GPRv: FF /2
def Instructions.CALL_NEAR_GPRv
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else 64

  let is_relative : Bool := false
  let is_indirect : Bool := true
  let is_no_track : Bool := context.no_track_prefix

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.CALL_NEAR operand_size context src is_relative is_indirect is_no_track

-- CALL_NEAR_MEMv: FF /2
def Instructions.CALL_NEAR_MEMv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else 64
  let address_size : Int := context.address_size

  let is_relative : Bool := false
  let is_indirect : Bool := true
  let is_no_track : Bool := context.no_track_prefix

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.CALL_NEAR operand_size context src is_relative is_indirect is_no_track

-- CALL_FAR_MEMp2: FF /3
def Instructions.CALL_FAR_MEMp2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let offset : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let segment_selector : Bits 16 ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide operand_size 8)) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.CALL_FAR operand_size offset segment_selector

end X86
