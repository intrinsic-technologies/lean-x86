import Prelude.Execution.Registers
import X86.UserProcess.Profile
import X86.Machine.Processor

namespace Prelude

variable {σ : Type}

open X86 X86.UserProcess

/-- The selected processor reports a source-encoded capability in this live state. -/
def ReportsCPUFeature (processor : Machine.Processor) (s : X86.State σ)
    (feature : CPUID_Feature) (enabled : Bool) : Prop :=
  letI := processor.cpuidBinding (σ := σ)
  ((Read_CPUID_Feature feature).run s).1.toOption = some enabled

/--
CPU configuration for executing 64-bit x86 integer instructions. Ensures that:

- The expected 64-bit mode, segment configuration, and privilege range
- Paging and address-checking features supported by the proofs
- Debug controls with hardware breakpoints and AET disabled

General-purpose and vector registers are unrestricted.
-/
structure SupportedIntegerCPU (processor : Machine.Processor) (s : X86.State σ) : Prop where
  cs : s.CS = userCodeSegment
  ss : s.SS = userStackSegment
  ds : s.DS = {userStackSegment with is_stack := some false}
  es : s.ES = {userStackSegment with is_stack := some false}
  cpl : 0 ≤ s.CPL ∧ s.CPL ≤ 3
  cr0 : SupportedIntegerCR0 s.CR0
  cr4 : SupportedIntegerCR4 s.CR4
  efer : SupportedIntegerEFER s.IA32_EFER
  maxPhysical : processor.config.Max_Physical_Address = 52
  early : processor.config.Feature_Early_Page_Access_Bit_Update = false
  lam : ReportsCPUFeature processor s CPUID_LAM_Encoding false
  lass : ReportsCPUFeature processor s CPUID_LASS_Encoding false
  debug : DR7.BreakpointsDisabled s.DR7
  aet : s.AET_EVENT_CTRL.ENABLE = 0

/--
SSE feature and control-register requirements. Ensures that:

- The CPU advertises SSE support
- CR0.EM and CR0.TS are clear, permitting SSE execution without emulation or task-switch traps
- CR4.OSFXSR and CR4.OSXMMEXCPT are set, enabling SSE state and exception support

Other control-register bits are unrestricted.
-/
structure SupportedSSE (processor : Machine.Processor) (s : X86.State σ) : Prop where
  feature : ReportsCPUFeature processor s CPUID_SSE_Encoding true
  cr0 : CR0.SSEEnabled s.CR0
  cr4 : CR4.SSEEnabled s.CR4

/--
Execution state ready to begin an instruction. These conditions require:

- An active thread with no pending asynchronous event or interrupt-blocking state
- No detected debug traps, with the trap and resume flags clear
- No string-repeat or MSR-list operation in progress

Arithmetic flags, oracle position, and trace history are unrestricted.
-/
structure ExecutionReady (s : X86.State σ) : Prop where
  event : s.Current_Event = .No_Event
  active : s.Thread_Status = .THREAD_ACTIVE
  sti : s.Event_Blocked.STI_BLOCKING = false
  movss : s.Event_Blocked.MOVSS_BLOCKING = false
  singleStep : s.Debug_Single_Step_Trap_Detected = false
  taskSwitch : s.Debug_Task_Switch_Trap_Detected = false
  breakpoint : s.Debug_Breakpoint_Trap_Detected = false
  busLock : s.Debug_Bus_Lock_Trap_Detected = false
  tf : RFLAGS.TrapFlagClear s.RFLAGS
  rf : RFLAGS.ResumeFlagClear s.RFLAGS
  repeatClear : s.Repeat_String_Operation = false
  msr : s.«MSRLIST::In_Process» = false

end Prelude
