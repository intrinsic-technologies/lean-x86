-- Generated from data/definitions.xml.gz: Task_Switch; do not edit.
-- Source SHA256: 1403a6965b7e37182e2afe38c6339c5caaa028c4b31aab4df0f9629cae463e1d
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Task_Switch)
import X86.Runtime
import X86.Helpers.CET.Check_Expected_Target
import X86.Helpers.CET.Get_And_Check_Token
import X86.Helpers.CET.Get_Expected_Target
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.CET.Is_Valid_Shadow_Stack_Address
import X86.Helpers.CET.Set_Tracker_Status
import X86.Helpers.CET.Shadow_Stack_Clear_Token_Busy_Bit
import X86.Helpers.CET.Shadow_Stack_Switch
import X86.Helpers.CP_Error_Code
import X86.Helpers.Check_New_TSS
import X86.Helpers.Check_TSS_Readability
import X86.Helpers.Check_Task_Descriptor_Writeability
import X86.Helpers.Clear_Debug_Single_Step_Traps
import X86.Helpers.Clear_Old_Task_Busy_Bit
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_System_Segment_Size
import X86.Helpers.Is_Aligned
import X86.Helpers.Is_End_Branch_Enabled
import X86.Helpers.Load_New_TSS
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Push_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_Control_Protection_Exception
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Set_New_Task_Busy_Bit
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Unreachable
import X86.Helpers.Store_Old_TSS
import X86.Helpers.Task_State_Segment
import X86.Helpers.Task_Switch_Initiator
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

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
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Task_Switch
    (new_task : Segment) (initiator : Task_Switch_Initiator) (old_tss_flags : RFLAGS_Type) (return_ip : Bits 64) (push_error_code : Bool) (error_code : Bits 32) :
    Runtime.SpecM Exception (State σ) Unit := do

  if ((← get).IA32_EFER.LMA == 1) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_task.selector))

  Check_New_TSS new_task initiator

  Store_Old_TSS return_ip initiator old_tss_flags

  Check_TSS_Readability new_task

  if ((initiator == Task_Switch_Initiator.Task_Switch_Jmp) || (initiator == Task_Switch_Initiator.Task_Switch_Call) || (initiator == Task_Switch_Initiator.Task_Switch_Task_Gate_In_IDT)) then
    Check_Task_Descriptor_Writeability new_task

  if ((initiator == Task_Switch_Initiator.Task_Switch_Jmp) || (initiator == Task_Switch_Initiator.Task_Switch_Iret)) then
    Check_Task_Descriptor_Writeability (← get).TR

  if ((initiator == Task_Switch_Initiator.Task_Switch_Call) || (initiator == Task_Switch_Initiator.Task_Switch_Task_Gate_In_IDT)) then
    Logical_Mem_Write (size := 16) new_task TSS_LINK_OFFSET (← get).TR.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

  let old_task : Segment := (← get).TR

  -- 7. Load the task register with the segment selector and descriptor for the new task's TSS
  if ((initiator == Task_Switch_Initiator.Task_Switch_Jmp) || (initiator == Task_Switch_Initiator.Task_Switch_Call) || (initiator == Task_Switch_Initiator.Task_Switch_Task_Gate_In_IDT)) then
    -- 13. If the task switch was initiated with a CALL instruction, JMP instruction, an exception, or an interrupt, the
    --     processor sets the busy (B) flag in the new task’s TSS descriptor; if initiated with an IRET instruction, the busy
    --     (B) flag is left set.
    TR.assign (← Set_New_Task_Busy_Bit new_task.selector)
  else
    modify ({ · with TR := new_task })

  -- 10. If the task switch was initiated with a JMP or IRET instruction, the processor clears the busy (B) flag in the
  --     current (old) task’s TSS descriptor; if initiated with a CALL instruction, an exception, or an interrupt: the busy
  --    (B) flag is left set. (See Table 8-2.)
  if ((initiator == Task_Switch_Initiator.Task_Switch_Jmp) || (initiator == Task_Switch_Initiator.Task_Switch_Iret)) then
    Clear_Old_Task_Busy_Bit old_task.selector

  let mut push_cs_lip_ssp : Bool := false
  let mut verify_cs_lip : Bool := false
  let mut expected_cs : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut expected_lip : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut new_ssp : SSP_Type := (← get).SSP
  let mut old_ssp : SSP_Type := (← get).SSP
  -- 8. If CET is enabled, the processor performs following shadow stack actions:
  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    let new_tss_cs : Bits 32 ← Logical_Mem_Read (← get).TR TSS_CS_OFFSET 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
    let new_cs_selector : Segment_Selector ← new_tss_cs[0 +: 16]
    let new_tss_eflags : RFLAGS_Type ← Std.Bits.Zero_Extend (source_size := 32) (← Logical_Mem_Read (← get).TR TSS_EFLAGS_OFFSET 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) 64
    let new_task_cpl : Int := if RFLAGS_Type.VM new_tss_eflags == 1 then 3 else Unsigned (Segment_Selector.RPL new_cs_selector)

    if ((initiator == Task_Switch_Initiator.Task_Switch_Call) || (initiator == Task_Switch_Initiator.Task_Switch_Task_Gate_In_IDT)) then
      if ((← get).CPL == 3 and decide (new_task_cpl < (← get).CPL)) then
        -- user -> supervisor
        IA32_PL3_SSP.assign (← get).SSP
      else
        -- no privilege change (supervisor -> supervisor or supervisor -> user)
        push_cs_lip_ssp := true
        expected_cs := Runtime.InitializedBits.ofValue (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 64)
        expected_lip := Runtime.InitializedBits.ofValue (← Compute_Linear_Address (← get).CS (← get).RIP (← get).CS)
        new_ssp := (← get).SSP

    if (initiator == Task_Switch_Initiator.Task_Switch_Iret) then
      if (new_task_cpl == (← get).CPL or new_task_cpl != 3) then
        -- no privilege change or supervisor/user -> supervisor IRET
        let (expected_cs_1, expected_lip_1, new_ssp_1, old_ssp_1) ← CET.Get_Expected_Target
        expected_cs := Runtime.InitializedBits.ofValue expected_cs_1
        expected_lip := Runtime.InitializedBits.ofValue expected_lip_1
        new_ssp := new_ssp_1
        old_ssp := old_ssp_1
        verify_cs_lip := true
      -- Clear busy flag on current shadow stack
      if (← Is_Aligned (n := 64) old_ssp 8) then
        let _ ← CET.Shadow_Stack_Clear_Token_Busy_Bit old_ssp
      SSP.assign (← Std.Bits.Zero 64)

  if (← get).Debug_Single_Step_Trap_Detected then
    Clear_Debug_Single_Step_Traps

  -- 9. The TSS state is loaded into the processor. This includes the LDTR register, the PDBR (control register CR3), the
  --    EFLAGS register, the EIP register, the general-purpose registers, and the segment selectors. A fault during the
  --    load of this state may corrupt architectural state. (If paging is not enabled, a PDBR value is read from the new
  --    task's TSS, but it is not loaded into CR3.)
  Load_New_TSS (← get).TR initiator

  -- 15. If CET is enabled, the processor performs following shadow stack actions:
  if ((← CET.Is_Shadow_Stack_Enabled (← get).CPL) or (← Is_End_Branch_Enabled (← get).CPL)) then
    if ((← RFLAGS.VM) == 1) then
      liftM (Report_Invalid_TSS (← Get_Error_Code_From_Selector (← get).TR.selector))

  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    match initiator with
    | Task_Switch_Initiator.Task_Switch_Call | Task_Switch_Initiator.Task_Switch_Jmp | Task_Switch_Initiator.Task_Switch_Task_Gate_In_IDT => do
      new_ssp := (← Std.Bits.Zero_Extend (source_size := 32) (← Logical_Mem_Read (← get).TR TSS_SSP_OFFSET 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) 64)

      let (_token, token_valid) ← CET.Get_And_Check_Token new_ssp push_cs_lip_ssp (← get).CS

      if (not token_valid) then
        liftM (Report_Invalid_TSS (← Get_Error_Code_From_Selector (← get).TR.selector))

      SSP.assign (← (do if push_cs_lip_ssp then pure (← CET.Shadow_Stack_Switch new_ssp (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 64) return_ip (← get).CS) else pure new_ssp))

    | Task_Switch_Initiator.Task_Switch_Iret => do
      if verify_cs_lip then
        CET.Check_Expected_Target (← get).CS (← get).RIP (← Runtime.InitializedBits.read expected_cs) (← Runtime.InitializedBits.read expected_lip) new_ssp
      else
        new_ssp := (← get).IA32_PL3_SSP

      if (not (← Is_Aligned (n := 64) new_ssp 4)) then
        Report_Control_Protection_Exception CP_Error_Code.FAR_RET_or_IRET

      if (not (← CET.Is_Valid_Shadow_Stack_Address new_ssp (← get).CS)) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

      modify ({ · with SSP := new_ssp })

  if (← Is_End_Branch_Enabled (← get).CPL) then
    if ((initiator == Task_Switch_Initiator.Task_Switch_Jmp) || (initiator == Task_Switch_Initiator.Task_Switch_Call) || (initiator == Task_Switch_Initiator.Task_Switch_Task_Gate_In_IDT)) then
      CET.Set_Tracker_Status (← get).CPL

  if push_error_code then
    Runtime.assert (initiator == Task_Switch_Initiator.Task_Switch_Task_Gate_In_IDT)
    match (← Get_System_Segment_Size new_task) with
    | 16 => do
      RSP_write (← Push_Stack (← get).SS (← RSP) (← get).CS 16 16 (← error_code[0 +: 16]) false)
    | 32 => do
      RSP_write (← Push_Stack (← get).SS (← RSP) (← get).CS 32 32 error_code false)
    | 64 => do
      RSP_write (← Push_Stack (← get).SS (← RSP) (← get).CS 64 64 (← Std.Bits.Zero_Extend (source_size := 32) error_code 64) false)
    | _ => do
      Std.Unreachable

  -- clear local breakpoints on task switch
  DR7.setL0 0
  DR7.setL1 0
  DR7.setL2 0
  DR7.setL3 0
  DR7.setLE 0

  modify ({ · with Committed_To_Task_Switch := false })

end X86.Helpers
