-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: d525909ec9781dfb71b9576360292beb787cc9e4084ebca45154ed59e8688c48
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.CET.Get_And_Check_Token
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.CET.Set_Tracker_Status
import X86.Helpers.CET.Shadow_Stack_Switch
import X86.Helpers.Check_New_RIP
import X86.Helpers.Clear_Debug_Single_Step_Traps
import X86.Helpers.Current_Mode
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Execution_Mode
import X86.Helpers.FRED.Event_Delivery
import X86.Helpers.Flags_To_Save_On_Exception
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Event_Error_Code_From_Selector
import X86.Helpers.Get_IDT_Error_Code
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Get_System_Segment_Size
import X86.Helpers.Get_Target_From_Gate
import X86.Helpers.Handle_Task_Gate
import X86.Helpers.IA32_SSP
import X86.Helpers.Is_Conforming_Code_Segment
import X86.Helpers.Is_End_Branch_Enabled
import X86.Helpers.Is_Non_Conforming_Code_Segment
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Is_Segment_Limit_Violation
import X86.Helpers.Linear_Mem_Read
import X86.Helpers.Load_Interrupt_Or_Trap_Gate_Descriptor
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Push_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Report_Segment_Not_Present
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Segment_Type
import X86.Helpers.Selector_Error_Code
import X86.Helpers.Set_Canonical_Wrt_Paging_Mode
import X86.Helpers.Set_Segment_Access_Bit
import X86.Helpers.Should_Push_Error_Code
import X86.Helpers.Stack_Switch
import X86.Helpers.Std.Bits.Unsigned_Saturate
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Unreachable
import X86.Helpers.Task_Switch
import X86.Helpers.Task_Switch_Initiator
import X86.Helpers.Thread_Status_Type
import X86.Helpers.UFloatCompare
import X86.Helpers.Update_Stack_Pointer
import X86.Helpers.VMX.Check_Exception_Bitmap
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Optional typed boundary; the source implementation is retained below.
class Handle_Vectored_Event.Semantics (σ : Type) where
  call (event_type : Vectored_Event_Type) (vector : Int) (error_code : Bits 32) (return_ip : Bits 64) :
    Runtime.SpecM Exception (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Handle_Vectored_Event.Semantics

variable {σ : Type}

variable
  [X86.Exception_Bitmap.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]
  [X86.Helpers.Check_New_TSS.Binding σ]
  [X86.Helpers.FRED.Event_Delivery.Binding σ]
  [X86.Helpers.Handle_Vectored_Event.Semantics σ]
  [X86.Helpers.Load_New_TSS.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.Page_Fault_Error_Code_Mask.Binding σ]
  [X86.Page_Fault_Error_Code_Match.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Handle_Vectored_Event
    (event_type : Vectored_Event_Type) (vector : Int) (error_code : Bits 32) (return_ip : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (vector in {0..255})

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if (((event_type == Vectored_Event_Type.Hardware_Exception) || (event_type == Vectored_Event_Type.Privileged_Software_Exception_INT1) || (event_type == Vectored_Event_Type.Software_Exception_INT3_Or_INTO)) and decide (vector < 32)) then
      VMX.Check_Exception_Bitmap vector error_code

  if ((← CR4.FRED) == 1) then
    FRED.Event_Delivery event_type vector error_code return_ip false false
    return ()

  if ((← get).Thread_Status == Thread_Status_Type.THREAD_HALTED and event_type == Vectored_Event_Type.Hardware_Exception and vector == DB_Exception) then
    modify ({ · with Thread_Status := Thread_Status_Type.THREAD_ACTIVE })

  if ((event_type == Vectored_Event_Type.Software_Interrupt_INTn) || (event_type == Vectored_Event_Type.Software_Exception_INT3_Or_INTO)) then
    if (← get).Event_Blocked.MOVSS_BLOCKING then
      modify ({ · with Debug_Breakpoints_Matched := (0 : Bits 4) })
  else
    if (event_type == Vectored_Event_Type.Hardware_Exception) then
      -- For hardware exceptions, clear pending data-breakpoint state to prevent stale #DB at handler
      modify ({ · with Debug_Breakpoint_Trap_Detected := false })
      modify ({ · with Debug_Breakpoints_Matched := (0 : Bits 4) })

  let flags_to_save : Bits 64 ← Flags_To_Save_On_Exception event_type vector
  let push_error_code : Bool ← Should_Push_Error_Code event_type vector

  -- If the vectored event is an exception that occurred during a task switch after
  -- committing to the task switch, clear Committed_To_Task_Switch so any exception that
  -- may be generated during handling of the current exception will have the correct scope.
  -- Note that flags_to_save is calculated before clearing Committed_To_Task_Switch.
  modify ({ · with Committed_To_Task_Switch := false })

  let interrupt_gate_selector : Segment_Selector ← Std.Bits.Unsigned_Saturate vector 16
  let interrupt_gate : Segment ← Load_Interrupt_Or_Trap_Gate_Descriptor event_type vector interrupt_gate_selector
  let gate_type : Segment_Type ← Get_Segment_Type interrupt_gate

  if ((← Current_Mode) != Execution_Mode.Real_Address_Mode) then
    let valid_gate_type : Bool ← do
      if (← get).IA32_EFER.LMA == 1 then
        pure ((gate_type == Segment_Type.System_Interrupt_Gate) || (gate_type == Segment_Type.System_Trap_Gate))
      else
        pure ((gate_type == Segment_Type.System_Task_Gate) || (gate_type == Segment_Type.System_16Bit_Interrupt_Gate) || (gate_type == Segment_Type.System_16Bit_Trap_Gate) || (gate_type == Segment_Type.System_Interrupt_Gate) || (gate_type == Segment_Type.System_Trap_Gate))

    if (not valid_gate_type) then
      liftM (Report_General_Protection_Exception (← Get_IDT_Error_Code event_type vector))

    if ((event_type == Vectored_Event_Type.Software_Interrupt_INTn) || (event_type == Vectored_Event_Type.Software_Exception_INT3_Or_INTO)) then
      if (decide (Unsigned (← Segment_Descriptor.DPL.partial interrupt_gate.descriptor) < (← get).CPL)) then
        liftM (Report_General_Protection_Exception (← Get_IDT_Error_Code event_type vector))

    if ((← Segment_Descriptor.P.partial interrupt_gate.descriptor) == 0) then
      liftM (Report_Segment_Not_Present (← Get_IDT_Error_Code event_type vector))

  if (gate_type == Segment_Type.System_Task_Gate) then
    let new_task : Segment ← Handle_Task_Gate interrupt_gate
    Task_Switch new_task Task_Switch_Initiator.Task_Switch_Task_Gate_In_IDT flags_to_save return_ip push_error_code error_code
  else
    let mut (new_cs, target_offset) ← Get_Target_From_Gate interrupt_gate event_type vector

    if ((← Segment_Descriptor.P.partial new_cs.descriptor) == 0) then
      liftM (Report_Segment_Not_Present (← Get_Event_Error_Code_From_Selector event_type new_cs.selector))

    if ((← Segment_Descriptor.A.partial new_cs.descriptor) == 0) then
      new_cs := (← Set_Segment_Access_Bit new_cs false)

    let is_stack_switch : Bool ← do
      if not (← Is_Null_Segment_Selector (← get).SS.selector) and not (← Runtime.readInitialized (← get).SS.descriptor_valid) then
        pure true
      else
        if (← Is_Non_Conforming_Code_Segment new_cs) then
          pure (decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < (← get).CPL))
        else
          pure false

    let mut new_ss : Segment := (← get).SS
    let mut new_rsp : Bits 64 ← RSP
    let tss_limit_ext : Runtime.Bit ← Bit (not ((event_type == Vectored_Event_Type.Software_Interrupt_INTn) || (event_type == Vectored_Event_Type.Software_Exception_INT3_Or_INTO)))

    if ((← get).IA32_EFER.LMA == 1 and (← Segment_Descriptor.IST.partial interrupt_gate.descriptor) != 0) then
      let index : Int := Unsigned (← Segment_Descriptor.IST.partial interrupt_gate.descriptor)
      let tr_offset : Int := index * 8 + 28
      if (← Is_Segment_Limit_Violation (← get).TR (← tr_offset[0 +: 64]) 8) then
        let mut tss_error_code : Selector_Error_Code ← Get_Error_Code_From_Selector (← get).TR.selector
        tss_error_code := Selector_Error_Code.setEXT tss_error_code tss_limit_ext
        liftM (Report_Invalid_TSS tss_error_code)
      new_rsp := (← Logical_Mem_Read (← get).TR (← tr_offset[0 +: 64]) 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)

      if (decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < (← get).CPL)) then
        -- In IA-32e mode a new SS selector is not loaded from the TSS
        -- Instead, the new SS selector is forced to NULL
        -- and the SS selector’s RPL field is set to the new CPL
        new_ss := (← Null_Segment (← get).SS)
        new_ss := { new_ss with selector := Segment_Selector.setRPL new_ss.selector (← Segment_Descriptor.DPL.partial new_cs.descriptor) }
    else
      if is_stack_switch then
        let (new_ss_1, new_rsp_1) ← Stack_Switch new_cs tss_limit_ext
        new_ss := new_ss_1
        new_rsp := new_rsp_1
        -- faults on the stack accesses below would report the stack selector in the error code
        Default_Error_Code.assign (← Get_Error_Code_From_Selector new_ss.selector)

    if ((← get).IA32_EFER.LMA == 1) then
      new_rsp := (← setSliceChecked new_rsp 0 4 (0 : Bits 4))

    -- the stack accesses below should be done at the new CPL

    let target_segment_size : Int ← Get_System_Segment_Size interrupt_gate

    Default_Error_Code.setEXT (← Bit (event_type == Vectored_Event_Type.External_Interrupt or event_type == Vectored_Event_Type.Non_Maskable_Interrupt or event_type == Vectored_Event_Type.Privileged_Software_Exception_INT1))

    if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
      if (Segment_Selector.RPL new_cs.selector != 0) then
        liftM (Report_General_Protection_Exception (← Get_Event_Error_Code_From_Selector event_type new_cs.selector))

      if ((← Is_Conforming_Code_Segment new_cs) or (← Segment_Descriptor.DPL.partial new_cs.descriptor) == 3) then
        liftM (Report_General_Protection_Exception (← Get_Event_Error_Code_From_Selector event_type new_cs.selector))

      match target_segment_size with
      | 16 => do
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← get).GS.selector false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← get).FS.selector false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← get).DS.selector false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← get).ES.selector false)
      | 32 => do
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).GS.selector 32) false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).FS.selector 32) false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).DS.selector 32) false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).ES.selector 32) false)
      | _ => do
        Std.Unreachable

    match target_segment_size with
    | 16 => do
      if is_stack_switch then
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← get).SS.selector false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← Runtime.CheckedSlice.read (← RSP) 0 16) false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← flags_to_save[0 +: 16]) false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← get).CS.selector false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← return_ip[0 +: 16]) false)
      if push_error_code then
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← error_code[0 +: 16]) false)
    | 32 => do
      if is_stack_switch then
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).SS.selector 32) false)
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Runtime.CheckedSlice.read (← RSP) 0 32) false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← flags_to_save[0 +: 32]) false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 32) false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← return_ip[0 +: 32]) false)
      if push_error_code then
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 error_code false)
    | 64 => do
      -- In IA32e mode, the stack pointer (SS:RSP) is pushed unconditionally
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 (← Std.Bits.Zero_Extend (source_size := 16) (← get).SS.selector 64) false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 (← RSP) false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 flags_to_save false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 64) false)
      new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 return_ip false)
      if push_error_code then
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 (← Std.Bits.Zero_Extend (source_size := 32) error_code 64) false)
    | _ => do
      Std.Unreachable

    Default_Error_Code.assign (← Std.Bits.Zero 32)

    Check_New_RIP new_cs target_offset

    if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
      GS.assign (← Null_Segment (← get).GS)
      FS.assign (← Null_Segment (← get).FS)
      DS.assign (← Null_Segment (← get).DS)
      ES.assign (← Null_Segment (← get).ES)

    if ((← CET.Is_Shadow_Stack_Enabled (← get).CPL) and (← get).CPL == 3) then
      IA32_PL3_SSP.assign (← (do if (← get).IA32_EFER.LMA == 1 then pure (← Set_Canonical_Wrt_Paging_Mode (← get).SSP) else pure (← get).SSP))

    if (← CET.Is_Shadow_Stack_Enabled (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor))) then
      let mut new_ssp : SSP_Type := (← get).SSP
      let mut set_token_busy_bit : Bool := false

      if ((← get).IA32_EFER.LMA == 1 and (← Segment_Descriptor.IST.partial interrupt_gate.descriptor) != 0) then
        let index : Int := Unsigned (← Segment_Descriptor.IST.partial interrupt_gate.descriptor)
        let linear_address : Bits 64 := (← get).IA32_INTERRUPT_SSP_TABLE_ADDR + (← (index * 8)[0 +: 64])
        new_ssp := (← Linear_Mem_Read linear_address 64 true)
        set_token_busy_bit := true
      else
        if (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) != (← get).CPL) then
          new_ssp := (← IA32_SSP (← Segment_Descriptor.DPL.partial new_cs.descriptor))
          set_token_busy_bit := true

      let shadow_stack_switch : Bool := Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) == (← get).CPL or (← get).CPL != 3 and decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) < (← get).CPL)

      if set_token_busy_bit then
        let (_token, token_valid) ← CET.Get_And_Check_Token new_ssp shadow_stack_switch new_cs

        if (not token_valid) then
          liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

      SSP.assign (← (do if shadow_stack_switch then pure (← CET.Shadow_Stack_Switch new_ssp (← Std.Bits.Zero_Extend (source_size := 16) (← get).CS.selector 64) return_ip new_cs) else pure new_ssp))

    if (← Is_End_Branch_Enabled (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor))) then
      CET.Set_Tracker_Status (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor))

    Clear_Debug_Single_Step_Traps
    if (event_type == Vectored_Event_Type.Hardware_Exception or event_type == Vectored_Event_Type.Privileged_Software_Exception_INT1) then
      modify ({ · with Debug_Breakpoint_Trap_Detected := false })
      modify ({ · with Debug_Breakpoints_Matched := (0 : Bits 4) })
    RFLAGS.setTF 0
    if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
      RFLAGS.setIF 0
      RFLAGS.setRF 0
      RFLAGS.setAC 0
    else
      if ((gate_type == Segment_Type.System_16Bit_Interrupt_Gate) || (gate_type == Segment_Type.System_Interrupt_Gate)) then
        RFLAGS.setIF 0

      RFLAGS.setVM 0
      RFLAGS.setRF 0
      RFLAGS.setNT 0

    if (← Is_Conforming_Code_Segment new_cs) then
      new_cs := { new_cs with selector := Segment_Selector.setRPL new_cs.selector (← Runtime.CheckedSlice.read (← get).CPL 0 2) }

    Branch_Far new_cs target_offset
    Update_Stack_Pointer new_ss new_rsp

def Handle_Vectored_Event.interpreted
    (event_type : Vectored_Event_Type) (vector : Int) (error_code : Bits 32) (return_ip : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (vector in {0..255})

  Handle_Vectored_Event.Semantics.call event_type vector error_code return_ip

@[instance_reducible]
def Handle_Vectored_Event.defaultSemantics : Handle_Vectored_Event.Semantics σ := ⟨Handle_Vectored_Event⟩

end X86.Helpers
