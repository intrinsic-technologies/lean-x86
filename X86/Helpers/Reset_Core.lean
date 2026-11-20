-- Generated from data/definitions.xml.gz: Reset_Core; do not edit.
-- Source SHA256: d06871b5d09ec9341fd81d0e10af4df159dec33385f0579995425f95533a35b1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Reset_Core)
import X86.Runtime
import X86.Helpers.Clear_Debug_Traps
import X86.Helpers.Get_Init_Segment_Value
import X86.Helpers.Monitor.Clear_FSM
import X86.Helpers.Reset_Events
import X86.Helpers.Reset_VMX
import X86.Helpers.Set_Segment_Base
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
  [X86.Reset_MSRs.Binding σ]
  [X86.Reset_Registers.Binding σ]

def Reset_Core (is_cold_reset : Bool) : Runtime.SpecM Exception (State σ) Unit := do
  modify ({ · with RIP := (65520 : Bits 64) })

  CS.setselector (61440 : Bits 16)
  CS.setdescriptor (Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64))
  CS.assign (← Set_Segment_Base 4294901760 (← get).CS)
  CS.setdescriptor (← Segment_Descriptor.setLimit.partial (← get).CS.descriptor (65535 : Bits 20))
  CS.setdescriptor (← Segment_Descriptor.setA.partial (← get).CS.descriptor (1 : Runtime.Bit))
  CS.setdescriptor (← Segment_Descriptor.setR.partial (← get).CS.descriptor (1 : Runtime.Bit))
  CS.setdescriptor (← Segment_Descriptor.setS.partial (← get).CS.descriptor (1 : Runtime.Bit))
  CS.setdescriptor (← Segment_Descriptor.setP.partial (← get).CS.descriptor (1 : Runtime.Bit))
  CS.setdescriptor_valid (some true)
  CS.setis_code (some true)

  DS.assign (← Get_Init_Segment_Value)
  ES.assign (← Get_Init_Segment_Value)
  FS.assign (← Get_Init_Segment_Value)
  FS.setis_64bit_mode_data_segment (some true)
  GS.assign (← Get_Init_Segment_Value)
  GS.setis_64bit_mode_data_segment (some true)
  SS.assign (← Get_Init_Segment_Value)
  SS.setis_stack (some true)

  -- todo:
  -- EDX := 000n06xxH
  -- Where “n” is the Extended Model Value for the respective processor, and “xx” := don’t care.

  GDTR.setbase (← Std.Bits.Zero 64)
  GDTR.setlimit (65535 : Bits 16)

  IDTR.setbase (← Std.Bits.Zero 64)
  IDTR.setlimit (65535 : Bits 16)

  LDTR.setselector (← Std.Bits.Zero 16)
  LDTR.assign (← Set_Segment_Base (← Std.Bits.Zero 64) (← get).LDTR)
  LDTR.setdescriptor (Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64))
  LDTR.setdescriptor (← Segment_Descriptor.setLimit.partial (← get).LDTR.descriptor (65535 : Bits 20))
  LDTR.setdescriptor (← Segment_Descriptor.setType.partial (← get).LDTR.descriptor (2 : Bits 4))
  LDTR.setdescriptor (← Segment_Descriptor.setP.partial (← get).LDTR.descriptor (1 : Runtime.Bit))
  LDTR.setdescriptor_valid (some true)

  TR.setselector (← Std.Bits.Zero 16)
  TR.assign (← Set_Segment_Base (← Std.Bits.Zero 64) (← get).TR)
  TR.setdescriptor (Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64))
  TR.setdescriptor (← Segment_Descriptor.setLimit.partial (← get).TR.descriptor (65535 : Bits 20))
  TR.setdescriptor (← Segment_Descriptor.setType.partial (← get).TR.descriptor (11 : Bits 4))
  TR.setdescriptor (← Segment_Descriptor.setP.partial (← get).TR.descriptor (1 : Runtime.Bit))
  TR.setdescriptor_valid (some true)

  XINIT_BV.setSlice 0 1 (1 : Runtime.Bit)

  Reset_Registers is_cold_reset
  Reset_MSRs is_cold_reset
  Reset_VMX
  Reset_Events
  Monitor.Clear_FSM
  modify ({ · with «SMM::In_SMM» := false })
  modify ({ · with Thread_Status := Thread_Status_Type.THREAD_ACTIVE })
  Clear_Debug_Traps
  modify ({ · with Repeat_String_Operation := false })
  modify ({ · with Repeat_String_RF_Pending := false })
  Repeat_String_RF_Pending_RIP.assign (← Std.Bits.Zero 64)
  modify ({ · with «MSRLIST::In_Process» := false })

  «Random_Numbers::HW_NRND_GEN».setReady false
  «Random_Numbers::HW_NRND_GEN».setData (← Std.Bits.Zero 384)

  modify ({ · with «TSX::HLE_Active» := false })
  modify ({ · with «TSX::HLE_Nest_Count» := (0 : Int) })
  «TSX::HLE_Restart_RIP».assign (← Std.Bits.Zero 64)
  -- this is implementation dependent, not sure where this value comes from yet
  modify ({ · with «TSX::MAX_HLE_NEST_COUNT» := (7 : Int) })

  modify ({ · with «TSX::RTM_Nest_Count» := (0 : Int) })
  modify ({ · with «TSX::RTM_Active» := false })
  «TSX::RTM_Fallback_RIP».assign (← Std.Bits.Zero 64)
  -- this is implementation dependent, not sure where this value comes from yet
  modify ({ · with «TSX::MAX_RTM_NEST_COUNT» := (7 : Int) })

  modify ({ · with «TSX::SUSLDTRK_Active» := false })

  modify ({ · with «SMX::In_Measured_Environment» := false })

end X86.Helpers
