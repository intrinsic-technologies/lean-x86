-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: b7d447e99fd846ce2902a922fb1467a28512ddf8c42318f4d1749b45ae7acaed
import X86.Runtime
import X86.Helpers.Check_Debug_Traps
import X86.Helpers.Clear_Debug_Traps
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Taken
import X86.Helpers.Fetch_And_Execute
import X86.Helpers.Handle_Asynchronous_Event
import X86.Helpers.Handle_Exception
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.In_PVI_Mode
import X86.Helpers.In_VME_Mode
import X86.Helpers.Instruction_Ended
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Thread_Status_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Address_Of_IO_Bitmap_A.Binding σ]
  [X86.Address_Of_IO_Bitmap_B.Binding σ]
  [X86.CR0_Guest_Host_Mask.Binding σ]
  [X86.CR0_Read_Shadow.Binding σ]
  [X86.CR3_Target_Count.Binding σ]
  [X86.CR3_Target_Value0.Binding σ]
  [X86.CR3_Target_Value1.Binding σ]
  [X86.CR3_Target_Value2.Binding σ]
  [X86.CR3_Target_Value3.Binding σ]
  [X86.CR4_Guest_Host_Mask.Binding σ]
  [X86.CR4_Read_Shadow.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]
  [X86.Helpers.Cache.Flush_By_Address.Binding σ]
  [X86.Helpers.Cache.Invalidate.Binding σ]
  [X86.Helpers.Cache.Prefetch_By_Address.Binding σ]
  [X86.Helpers.Cache.Writeback.Binding σ]
  [X86.Helpers.Check_New_TSS.Binding σ]
  [X86.Helpers.Emulate_F2XM1.Binding σ]
  [X86.Helpers.Emulate_FCOS.Binding σ]
  [X86.Helpers.Emulate_FPATAN.Binding σ]
  [X86.Helpers.Emulate_FPTAN.Binding σ]
  [X86.Helpers.Emulate_FSIN.Binding σ]
  [X86.Helpers.Emulate_FSINCOS.Binding σ]
  [X86.Helpers.Emulate_FYL2X.Binding σ]
  [X86.Helpers.Emulate_FYL2XP1.Binding σ]
  [X86.Helpers.Emulate_RCPSS.Binding σ]
  [X86.Helpers.Emulate_RSQRTSS.Binding σ]
  [X86.Helpers.Enter_SMM.Binding σ]
  [X86.Helpers.FRED.Event_Delivery.Binding σ]
  [X86.Helpers.Get_Repeat_String_Stride.Binding σ]
  [X86.Helpers.Handle_Vectored_Event.Semantics σ]
  [X86.Helpers.IO_Read.Binding σ]
  [X86.Helpers.IO_Write.Binding σ]
  [X86.Helpers.Load_New_TSS.Binding σ]
  [X86.Helpers.Memory_Fence.Binding σ]
  [X86.Helpers.Memory_Load_Fence.Binding σ]
  [X86.Helpers.Memory_Store_Fence.Binding σ]
  [X86.Helpers.Other_MSR_Commit.Binding σ]
  [X86.Helpers.Other_MSR_Read.Binding σ]
  [X86.Helpers.Other_MSR_Read_Allowed.Binding σ]
  [X86.Helpers.Other_MSR_Write_Allowed.Binding σ]
  [X86.Helpers.Other_MSR_Write_Behavior.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Read_Time_Stamp_Counter.Binding σ]
  [X86.Helpers.Select_Buffered_Stack_Return_Swap.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Fault.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Order.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Probe.Binding σ]
  [X86.Helpers.Select_FP87_Remainder_Reduction.Binding σ]
  [X86.Helpers.Select_FXSAVE_AC.Binding σ]
  [X86.Helpers.Select_FXSAVE_Fields.Binding σ]
  [X86.Helpers.Select_FXSAVE_Page_Fault_Priority.Binding σ]
  [X86.Helpers.Select_FXSAVE_Reserved_Header.Binding σ]
  [X86.Helpers.Select_FXSAVE_Reserved_Slot.Binding σ]
  [X86.Helpers.Select_FXSAVE_Schedule_Domain.Binding σ]
  [X86.Helpers.Select_FXSAVE_Write_Swap.Binding σ]
  [X86.Helpers.Select_Stack_Return_Validation_Fault.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.Invalidate_All_Translation_Caches.Binding σ]
  [X86.Invalidate_Translation_Caches.Binding σ]
  [X86.Read_MXCSR_DAZ16.Binding σ]
  [X86.Read_MXCSR_FTZ16.Binding σ]
  [X86.Reset_MSRs.Binding σ]
  [X86.Reset_Registers.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.__Fuzz_Next_Mem_Write.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Next_Cycle.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.MODEP5]
  [X86.Config.Value.Max_Physical_Address]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Max_Linear_Address]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]
  [X86.Config.Value.Feature_Ingore_FCS_FDS_Deprecation]
  [X86.Config.Value.Feature_LAM_Moffs_Displacement]
  [X86.Accelerate (X86.Helpers.Check_Debug_Traps.source (σ := σ))]
  [X86.Accelerate (X86.Helpers.Handle_Asynchronous_Event.source (σ := σ))]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

@[noinline, nospecialize]
def Step  : Runtime.PartialSpecM Exception (State σ) Unit := do

  let branch_taken_on_previous_step : Bool := (← get).Branch_Taken
  modify ({ · with Branch_Taken := false })
  modify ({ · with Execution_Debug_Cause := Debug_Cause.Debug_No_Exception })
  modify ({ · with «FRED::Event_Delivery_In_Progress» := false })
  Runtime.liftTotal (Concurrent_Exception.setvalid false)
  Runtime.liftTotal (Default_Error_Code.assign (← Std.Bits.Zero 32))
  modify ({ · with Committed_To_Task_Switch := false })
  modify ({ · with Saving_Task_State_During_Task_Switch := false })
  modify ({ · with CET_Tracker_Updated := false })

  let last_instruction_sets_MOV_SS_blocking : Bool := (← get).Event_Blocked.MOVSS_BLOCKING

  try
    if (not (← Runtime.liftTotal (Handle_Asynchronous_Event))) then
      match (← get).Thread_Status with
      | Thread_Status_Type.THREAD_ACTIVE => do
        if (((← Runtime.liftTotal (In_PVI_Mode)) or (← Runtime.liftTotal (In_VME_Mode))) and (← Runtime.liftTotal (RFLAGS.VIF)) == 1 and (← Runtime.liftTotal (RFLAGS.VIP)) == 1) then
          liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

        Runtime.liftTotal (Check_Debug_Traps branch_taken_on_previous_step)

        -- SDM, Volume 3B, section 18.3.1.1 "Instruction-Breakpoint Exception Condition", "The RF Flag
        -- is cleared at the start of the instruction after the check for code breakpoint, CS limit
        -- violation and FP exceptions".
        -- We currently don't have the granularity to clear this in the appropriate place...
        Runtime.liftTotal (RFLAGS.setRF 0)
        modify ({ · with Repeat_String_RF_Pending := false })

        Fetch_And_Execute

        if last_instruction_sets_MOV_SS_blocking then
          Runtime.liftTotal (Event_Blocked.setMOVSS_BLOCKING false)

        if (not (← get).Branch_Taken and not (← get).Repeat_String_Operation and not (← get).«MSRLIST::In_Process») then
          Runtime.liftTotal (RIP.assign (← get).Next_IP)
          if (not (← Runtime.liftTotal (In_64Bit_Mode))) then
            Runtime.liftTotal (RIP.setSlice 32 32 (← Std.Bits.Zero 32))

      | Thread_Status_Type.THREAD_HALTED => do
        Runtime.liftTotal (Check_Debug_Traps false)
      | Thread_Status_Type.THREAD_SHUTDOWN => do
        pure ()
      | Thread_Status_Type.THREAD_WAIT_FOR_SIPI => do
        pure ()
      | Thread_Status_Type.THREAD_MWAITING => do
        pure ()
      | Thread_Status_Type.THREAD_WAIT_FOR_WAKEUP => do
        pure ()
    else
      modify ({ · with Repeat_String_Operation := false })
      modify ({ · with Repeat_String_RF_Pending := false })
      modify ({ · with «MSRLIST::In_Process» := false })
  catch exception =>
    match exception with
    | .raised (.Exception_Taken _) =>
      Runtime.liftTotal (Event_Blocked.setMOVSS_BLOCKING false)
      modify ({ · with Repeat_String_Operation := false })
      modify ({ · with Repeat_String_RF_Pending := false })
      modify ({ · with «MSRLIST::In_Process» := false })
    | .raised (.Exception_Info e) =>
      Handle_Exception e.vector e.linear_address e.error_code
      Runtime.liftTotal (Event_Blocked.setMOVSS_BLOCKING false)
      modify ({ · with Repeat_String_Operation := false })
      modify ({ · with Repeat_String_RF_Pending := false })
      modify ({ · with «MSRLIST::In_Process» := false })
      if last_instruction_sets_MOV_SS_blocking then
        Runtime.liftTotal (Clear_Debug_Traps)
    | .raised (.Instruction_Ended _) =>
      pure ()
    | _ => throw exception

  Runtime.liftTotal (__Trace_Next_Cycle)

end X86.Helpers
