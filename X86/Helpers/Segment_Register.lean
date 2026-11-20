-- Generated from data/definitions.xml.gz: Segment_Register; do not edit.
-- Source SHA256: fc3d1101a340986ed32cd7305eceb7e83368e70505d77d5b2b04dd628aa0e5f4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Segment_Register)
import X86.Runtime
import X86.Helpers.Seg_Reg
import X86.Helpers.Segment
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Segment_Register (r : Seg_Reg) : Runtime.SpecM Exception (State σ) (Segment) := do
  match r with
  | Seg_Reg.Seg_Reg_CS => do
    return (← get).CS
  | Seg_Reg.Seg_Reg_DS => do
    return (← get).DS
  | Seg_Reg.Seg_Reg_ES => do
    return (← get).ES
  | Seg_Reg.Seg_Reg_FS => do
    return (← get).FS
  | Seg_Reg.Seg_Reg_GS => do
    return (← get).GS
  | Seg_Reg.Seg_Reg_SS => do
    return (← get).SS

def Segment_Register_write
    (r : Seg_Reg) (value : Segment) :
    Runtime.SpecM Exception (State σ) Unit := do
  match r with
  | Seg_Reg.Seg_Reg_CS => do
    modify ({ · with CS := value })
    CS.setis_code (some true)
  | Seg_Reg.Seg_Reg_DS => do
    modify ({ · with DS := value })
  | Seg_Reg.Seg_Reg_ES => do
    modify ({ · with ES := value })
  | Seg_Reg.Seg_Reg_FS => do
    modify ({ · with FS := value })
    FS.setis_64bit_mode_data_segment (some true)
  | Seg_Reg.Seg_Reg_GS => do
    modify ({ · with GS := value })
    GS.setis_64bit_mode_data_segment (some true)
  | Seg_Reg.Seg_Reg_SS => do
    modify ({ · with SS := value })
    SS.setis_stack (some true)

end X86.Helpers
