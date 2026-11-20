-- Generated from a local ISA specification; do not edit.
-- Source SHA256: f047cc529b35353cc43ef0538fb0a627618ea70d5a9bd854ac54b85c0dde3bca
import X86.Runtime
import X86.Helpers.Std.End_Execution
import X86.Helpers.Std.External_Failure
import X86.Helpers.Thread_Status_Type
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

-- SDM093 Vol. 3B 20.3.1.1: fault, debug-cause and repeat-iteration RF rules.
def Flags_To_Save_On_Exception
    (event_type : Vectored_Event_Type) (vector : Int) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.assert (vector in {0..255})

  match event_type with
  | Vectored_Event_Type.Software_Interrupt_INTn | Vectored_Event_Type.Privileged_Software_Exception_INT1 | Vectored_Event_Type.Software_Exception_INT3_Or_INTO => do
    return (← get).RFLAGS
  | Vectored_Event_Type.External_Interrupt | Vectored_Event_Type.Non_Maskable_Interrupt => do
    return (← (do if (← get).Repeat_String_Operation then pure ((← get).RFLAGS or 65536) else pure (← get).RFLAGS))
  | Vectored_Event_Type.Hardware_Exception => do
    if ((vector == (0 : Int)) || (vector == (5 : Int)) || (vector == (6 : Int)) || (vector == (7 : Int)) || (vector == (10 : Int)) || (vector == (11 : Int)) || (vector == (12 : Int)) || (vector == (13 : Int)) || (vector == (14 : Int)) || (vector == (16 : Int)) || (vector == (17 : Int)) || (vector == (19 : Int)) || (vector == (21 : Int))) then
      return (← get).RFLAGS or 65536
    else
      if ((vector == (8 : Int)) || (vector == (18 : Int))) then
        return (← get).RFLAGS
      else
        if (vector == 1) then
          match (← get).Execution_Debug_Cause with
          | Debug_Cause.Debug_General_Detect => do
            return (← get).RFLAGS or 65536
          | Debug_Cause.Debug_Instruction_Breakpoint => do
            return (← get).RFLAGS
          | Debug_Cause.Debug_Trap => do
            return (← (do if (← get).Repeat_String_Operation then pure ((← get).RFLAGS or 65536) else pure (← get).RFLAGS))
          | Debug_Cause.Debug_No_Exception => do
            Std.External_Failure "unsupported source event operation: debug exception delivery requires a detected cause"
        else
          Std.External_Failure "unsupported source event operation: Flags_To_Save_On_Exception"
  | _ => do
    Std.External_Failure "unsupported source event operation: Flags_To_Save_On_Exception"

-- SDM093 Vol. 3A table 7-5: a fault during double-fault delivery enters shutdown.
-- This procedure never returns normally; its result type is unrestricted.
def Triple_Fault_Shutdown {α : Type} : Runtime.SpecM Exception (State σ) α := do
  modify ({ · with Thread_Status := Thread_Status_Type.THREAD_SHUTDOWN })
  Std.End_Execution false

end X86.Helpers
