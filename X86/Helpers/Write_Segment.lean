-- Generated from data/definitions.xml.gz: Write_Segment; do not edit.
-- Source SHA256: e0111732fb131442a61222946b5b06007262113d3a481573a187d0f5b49048ce
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_Segment)
import X86.Runtime
import X86.Helpers.Load_Data_Segment
import X86.Helpers.Load_Stack_Segment
import X86.Helpers.Std.Unreachable
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]

def Write_Segment
    (rrr : Bits 3) (selector : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  match Unsigned rrr with
  | 0b000 => do
    ES.assign (← Load_Data_Segment selector (← get).ES (← get).RFLAGS false)
  -- Not allowed to write to CS
  | 0b001 => do
    Std.Unreachable
  | 0b010 => do
    SS.assign (← Load_Stack_Segment selector (← get).SS (← get).CPL (← get).RFLAGS true)
    -- loading SS toggles the bit instead of just setting it
    Event_Blocked.setMOVSS_BLOCKING (not (← get).Event_Blocked.MOVSS_BLOCKING)
  | 0b011 => do
    DS.assign (← Load_Data_Segment selector (← get).DS (← get).RFLAGS false)
  | 0b100 => do
    FS.assign (← Load_Data_Segment selector (← get).FS (← get).RFLAGS false)
  | 0b101 => do
    GS.assign (← Load_Data_Segment selector (← get).GS (← get).RFLAGS false)
  | _ => do
    Std.Unreachable

end X86.Helpers
