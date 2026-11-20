-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 9f4a49743d5bb7b00643a128eacd039e2ac6ca55fce4c3d8234b0eb0859692e5
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Clear_Debug_Traps
import X86.Helpers.Get_Instruction_Breakpoint_Match
import X86.Helpers.Report_Debug_Exception
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Unimplemented_Feature
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]

def Check_Debug_Traps.source
    (branch_taken_on_previous_step : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  let suppress_execute_breakpoints : Bool := (← get).AET_EVENT_CTRL.ENABLE == 1 and (← get).AET_EVENT_CTRL.CODE_BREAKPOINT == 1
  let suppress_data_breakpoints : Bool := (← get).AET_EVENT_CTRL.ENABLE == 1 and (← get).AET_EVENT_CTRL.DATA_BREAKPOINT == 1

  if (not (← get).Event_Blocked.MOVSS_BLOCKING and not suppress_data_breakpoints) then
    let (is_execute_breakpoint, execute_BP_matched) ← do
      if not (← get).Repeat_String_Operation and (← RFLAGS.RF) == 0 and not suppress_execute_breakpoints then
        Get_Instruction_Breakpoint_Match
      else
        pure (false, (← Std.Bits.Zero 4))

    if ((← get).Debug_Single_Step_Trap_Detected or (← get).Debug_Task_Switch_Trap_Detected or (← get).Debug_Breakpoint_Trap_Detected or (← get).Debug_Bus_Lock_Trap_Detected) then

      if (← get).Debug_Single_Step_Trap_Detected then
        DR6.setBS 1

      if (← get).Debug_Task_Switch_Trap_Detected then
        DR6.setBT 1

      if (← get).Debug_Bus_Lock_Trap_Detected then
        DR6.setBLD 0

      DR6.setB ((← get).Debug_Breakpoints_Matched or execute_BP_matched)
      Clear_Debug_Traps
      IA32_DEBUGCTL.setBTF 0

      if (← CPUID_PTTT) then
        Unimplemented_Feature "DR Match Trigger Inputs" false true
      else
        modify ({ · with Execution_Debug_Cause := Debug_Cause.Debug_Trap })
        liftM (Report_Debug_Exception)

    if is_execute_breakpoint then
      DR6.setB execute_BP_matched
      Clear_Debug_Traps
      IA32_DEBUGCTL.setBTF 0
      modify ({ · with Execution_Debug_Cause := Debug_Cause.Debug_Instruction_Breakpoint })
      liftM (Report_Debug_Exception)

  if ((← RFLAGS.TF) == 1 and ((← IA32_DEBUGCTL.BTF) == 0 or branch_taken_on_previous_step)) then
    modify ({ · with Debug_Single_Step_Trap_Detected := true })

def Check_Debug_Traps [X86.Accelerate (Check_Debug_Traps.source (σ := σ))]
    (branch_taken_on_previous_step : Bool := false) :
    Runtime.SpecM Exception (State σ) Unit := do
  accelerated Check_Debug_Traps.source branch_taken_on_previous_step

end X86.Helpers
