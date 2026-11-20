-- Generated from data/instruction/JMP.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: a18f2c92a1716a0500b3bae32b424069a3f0fe71e197624d6c166521b15663c5
-- Description: data/sdm/JMP.docbook
-- Transfers program control to a different point in the instruction stream without recording
-- return information.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=JMP)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.Branch_Near
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.CET.Set_Tracker_Status
import X86.Helpers.Check_New_RIP
import X86.Helpers.Code_Segment_Checks
import X86.Helpers.Current_Mode
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Get_Target_From_Gate
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Handle_Task
import X86.Helpers.IA32_CET
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_End_Branch_Enabled
import X86.Helpers.Is_End_Branch_Enabled_And_Not_Suppressed
import X86.Helpers.Is_Non_Conforming_Code_Segment
import X86.Helpers.Is_Task_Segment
import X86.Helpers.Is_Valid_Code_Segment
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Registers
import X86.Helpers.Relative_Branch_Wrap
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Segment_Type
import X86.Helpers.Set_Segment_Access_Bit
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Task_Switch_Initiator
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

def Instructions.Operations.JMP_FAR
    (operand_size : Int) (offset : Bits operand_size) (segment_selector : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let mode : Execution_Mode ← Current_Mode
  if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
    let new_cs : Segment ← Load_Real_Or_VM86_Segment mode segment_selector (← get).CS
    let new_rip : Bits 64 ← Std.Bits.Zero_Extend (source_size := operand_size) offset 64
    Check_New_RIP new_cs new_rip
    Branch_Far new_cs new_rip
  else
    let mut new_cs : Segment ← Load_Segment_Descriptor segment_selector (← get).CS false

    -- Call-Gate
    let seg_type : Segment_Type ← Get_Segment_Type new_cs

    if ((seg_type == Segment_Type.System16Bit_Call_Gate) || (seg_type == Segment_Type.System_Call_Gate)) then
      if ((← CR4.FRED) == 1 or decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < (← get).CPL) or decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < Unsigned (Segment_Selector.RPL new_cs.selector))) then
        liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

      let (new_cs_1, new_rip) ← Get_Target_From_Gate new_cs Vectored_Event_Type.Hardware_Exception
      new_cs := new_cs_1

      if (not (← Is_Valid_Code_Segment new_cs (← get).CPL)) then
        liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

      Code_Segment_Checks new_cs

      if ((← Segment_Descriptor.A.partial new_cs.descriptor) == 0) then
        new_cs := (← Set_Segment_Access_Bit new_cs false)

      Check_New_RIP new_cs new_rip

      new_cs := { new_cs with selector := Segment_Selector.setRPL new_cs.selector (← Runtime.CheckedSlice.read (← get).CPL 0 2) }

      Branch_Far new_cs new_rip

      if (← Is_End_Branch_Enabled (← get).CPL) then
        CET.Set_Tracker_Status (← get).CPL
    else
      if (← Is_Task_Segment new_cs) then
        Handle_Task new_cs Task_Switch_Initiator.Task_Switch_Jmp (← get).Next_IP
      else
        if (not (← Is_Valid_Code_Segment new_cs (← get).CPL)) then
          liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

        if ((← Is_Non_Conforming_Code_Segment new_cs) and decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < Unsigned (Segment_Selector.RPL new_cs.selector))) then
          liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

        Code_Segment_Checks new_cs

        let new_rip : Bits 64 ← Std.Bits.Zero_Extend (source_size := operand_size) offset 64
        Check_New_RIP new_cs new_rip

        if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
          if (not (← Is_64Bit_Code_Segment new_cs) and not (← Std.Bits.Is_Zero (size := 32) (← sliceInclusive (← get).SSP 63 32))) then
            liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

        if ((← Segment_Descriptor.A.partial new_cs.descriptor) == 0) then
          new_cs := (← Set_Segment_Access_Bit new_cs false)

        new_cs := { new_cs with selector := Segment_Selector.setRPL new_cs.selector (← Runtime.CheckedSlice.read (← get).CPL 0 2) }

        if ((← In_64Bit_Mode) and not (← Is_64Bit_Code_Segment new_cs)) then
          let mut RSP_target ← RSP
          RSP_target := (← setSliceChecked RSP_target 32 32 (← Std.Bits.Zero 32))
          RSP_write RSP_target

        Branch_Far new_cs new_rip

        if (← Is_End_Branch_Enabled (← get).CPL) then
          CET.Set_Tracker_Status (← get).CPL

def Instructions.Operations.JMP_NEAR
    (operand_size : Int) (context : Instruction_Context) (src : Bits operand_size) (is_indirect is_no_track : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let new_rip : Bits 64 ← do
    if is_indirect then
      Std.Bits.Zero_Extend (source_size := operand_size) src 64
    else
      Relative_Branch_Wrap context.operand_size ((← get).Next_IP + (← Std.Bits.Sign_Extend (source_size := operand_size) src 64))

  Check_New_RIP (← get).CS new_rip
  Branch_Near new_rip

  if (is_indirect and (← Is_End_Branch_Enabled_And_Not_Suppressed (← get).CPL)) then
    if ((← IA32_CET (← get).CPL).NO_TRACK_EN == 0 or not is_no_track) then
      CET.Set_Tracker_Status (← get).CPL

-- JMP_FAR_PTRp_IMMw: EA ct iw
def Instructions.JMP_FAR_PTRp_IMMw
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

  Instructions.Operations.JMP_FAR operand_size offset segment_selector

-- JMP_FAR_MEMp2: FF /5
def Instructions.JMP_FAR_MEMp2
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

  Instructions.Operations.JMP_FAR operand_size offset segment_selector

-- JMP_RELBRd: E9 cd
def Instructions.JMP_RELBRd
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let is_indirect : Bool := false
  let is_no_track : Bool := false

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.JMP_NEAR operand_size context src is_indirect is_no_track

-- JMP_RELBRz: E9 ct
def Instructions.JMP_RELBRz
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let is_indirect : Bool := false
  let is_no_track : Bool := false

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.JMP_NEAR operand_size context src is_indirect is_no_track

-- JMP_RELBRb_0: EB cb
def Instructions.JMP_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let is_indirect : Bool := false
  let is_no_track : Bool := false

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.JMP_NEAR operand_size context src is_indirect is_no_track

-- JMP_RELBRb_1: EB cb
def Instructions.JMP_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let is_indirect : Bool := false
  let is_no_track : Bool := false

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.JMP_NEAR operand_size context src is_indirect is_no_track

-- JMP_GPRv: FF /4
def Instructions.JMP_GPRv
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else 64

  let is_indirect : Bool := true
  let is_no_track : Bool := context.no_track_prefix

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.JMP_NEAR operand_size context src is_indirect is_no_track

-- JMP_MEMv: FF /4
def Instructions.JMP_MEMv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else 64
  let address_size : Int := context.address_size

  let is_indirect : Bool := true
  let is_no_track : Bool := context.no_track_prefix

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.JMP_NEAR operand_size context src is_indirect is_no_track

end X86
