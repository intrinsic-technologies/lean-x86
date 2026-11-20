-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 7022b91c97073c1920ffe24231d8152cf3058db623ed7b98d3c05b70241ffe4c
import X86.Runtime
import X86.Helpers.Asynchronous_Event_Type
import X86.Helpers.Enter_SMM
import X86.Helpers.Monitor.Clear_FSM
import X86.Helpers.Reset_Core
import X86.Helpers.Std.Unreachable
import X86.Helpers.Take_Interrupt
import X86.Helpers.Thread_Status_Type
import X86.Helpers.Unimplemented_Feature
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Enter_SMM.Binding σ]
  [X86.Helpers.Handle_Vectored_Event.Semantics σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.Reset_MSRs.Binding σ]
  [X86.Reset_Registers.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Handle_Asynchronous_Event.source  : Runtime.SpecM Exception (State σ) (Bool) := do
  let taken_event : Asynchronous_Event_Type := (← get).Current_Event
  modify ({ · with Current_Event := Asynchronous_Event_Type.No_Event })
  let last_instruction_set_IF : Bool := (← get).Event_Blocked.STI_BLOCKING
  Event_Blocked.setSTI_BLOCKING false

  -- Previous-instruction debug traps precede pending IRQs and NMIs.
  if (((taken_event == Asynchronous_Event_Type.Interrupt_Event) || (taken_event == Asynchronous_Event_Type.NMI_Event)) and (← (do let subject := (← get).Thread_Status; pure ((subject == Thread_Status_Type.THREAD_ACTIVE) || (subject == Thread_Status_Type.THREAD_HALTED)))) and not (← get).Event_Blocked.MOVSS_BLOCKING and not ((← get).AET_EVENT_CTRL.ENABLE == 1 and (← get).AET_EVENT_CTRL.DATA_BREAKPOINT == 1) and ((← get).Debug_Single_Step_Trap_Detected or (← get).Debug_Task_Switch_Trap_Detected or (← get).Debug_Breakpoint_Trap_Detected or (← get).Debug_Bus_Lock_Trap_Detected)) then
    modify ({ · with Current_Event := taken_event })
    return false

  -- Keep a pending input until CPU interrupt blocking permits delivery.
  if (taken_event == Asynchronous_Event_Type.Interrupt_Event and ((← RFLAGS.IF) == 0 or (← get).Event_Blocked.MOVSS_BLOCKING or (← get).Thread_Status == Thread_Status_Type.THREAD_SHUTDOWN) or taken_event == Asynchronous_Event_Type.NMI_Event and ((← get).Event_Blocked.NMI_BLOCKED or (← get).Event_Blocked.MOVSS_BLOCKING)) then
    modify ({ · with Current_Event := taken_event })
    return false

  if (taken_event != Asynchronous_Event_Type.No_Event) then
    if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
      Unimplemented_Feature "Events in VMX" false true

    Monitor.Clear_FSM
  match taken_event with
  | Asynchronous_Event_Type.No_Event => do
    return false
  | Asynchronous_Event_Type.Reset_Event => do
    Reset_Core true
    return true
  | Asynchronous_Event_Type.Init_Event => do
    Reset_Core false
    return true
  | Asynchronous_Event_Type.PSMI_Event => do
    Enter_SMM true
  | Asynchronous_Event_Type.SMI_Event => do
    Enter_SMM false
  | Asynchronous_Event_Type.NMI_Event => do
    Event_Blocked.setNMI_BLOCKED true
    Take_Interrupt Vectored_Event_Type.Non_Maskable_Interrupt 2 (← get).RIP
    modify ({ · with Thread_Status := Thread_Status_Type.THREAD_ACTIVE })
    return true
  | Asynchronous_Event_Type.Interrupt_Event => do
    if last_instruction_set_IF then
      -- interrupts are blocked on the instruction after STI
      modify ({ · with Current_Event := Asynchronous_Event_Type.Interrupt_Event })
    else
      modify ({ · with Thread_Status := Thread_Status_Type.THREAD_ACTIVE })
      Take_Interrupt Vectored_Event_Type.External_Interrupt (← get).Interrupt_Vector (← get).RIP
      return true
  | Asynchronous_Event_Type.MONITOR_Wake_Event => do
    Std.Unreachable
  | _ => do
    return false
  -- todo: other injectable events
  return false

def Handle_Asynchronous_Event [X86.Accelerate (Handle_Asynchronous_Event.source (σ := σ))]
     :
    Runtime.SpecM Exception (State σ) (Bool) := do
  accelerated Handle_Asynchronous_Event.source

end X86.Helpers
