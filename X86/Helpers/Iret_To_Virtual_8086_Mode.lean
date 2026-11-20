-- Generated from data/definitions.xml.gz: Iret_To_Virtual_8086_Mode; do not edit.
-- Source SHA256: 5d6573ac3b6646f6c5216f40bb4a263b1c0a15e0fb88811d08c88e4e36b7a0b7
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Iret_To_Virtual_8086_Mode)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.CET.Shadow_Stack_Clear_Token_Busy_Bit
import X86.Helpers.CP_Error_Code
import X86.Helpers.Check_New_RIP
import X86.Helpers.Check_Segment_Limit
import X86.Helpers.Execution_Mode
import X86.Helpers.Is_Aligned
import X86.Helpers.Load_Data_Segment
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Load_Stack_Segment
import X86.Helpers.Pop_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_Control_Protection_Exception
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Iret_To_Virtual_8086_Mode
    (operand_size : Int) (new_cs_selector : Segment_Selector) (new_flags : RFLAGS_Type) (new_rip curr_rsp : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  if ((← CR4.CET) == 1 and ((← get).IA32_U_CET.ENDBR_EN == 1 or (← get).IA32_U_CET.SH_STK_EN == 1)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let new_cs : Segment ← Load_Real_Or_VM86_Segment Execution_Mode.Virtual_8086_Mode new_cs_selector (← get).CS

  let effective_rip : Bits 64 ← Std.Bits.Zero_Extend (source_size := 16) (← new_rip[15:0]) 64
  Check_Segment_Limit new_cs effective_rip 1

  let mut new_rsp : Bits 64 ← Std.Bits.Zero 64
  let mut temp_rsp : Bits 64 := curr_rsp

  if (operand_size == 16) then
    let (new_rsp_part_1, temp_rsp_2) ← Pop_Stack (← get).SS temp_rsp 16 32
    new_rsp := (← setSliceChecked new_rsp 0 16 new_rsp_part_1)
    temp_rsp := temp_rsp_2
  else
    let (new_rsp_part, temp_rsp_1) ← Pop_Stack (← get).SS temp_rsp 32 32
    new_rsp := (← setSliceChecked new_rsp 0 32 new_rsp_part)
    temp_rsp := temp_rsp_1

  let (new_ss_selector, temp_rsp_3) ← Pop_Stack (← get).SS temp_rsp 16 32
  temp_rsp := temp_rsp_3

  let (new_es_selector, temp_rsp_4) ← Pop_Stack (← get).SS temp_rsp 16 32
  temp_rsp := temp_rsp_4

  let (new_ds_selector, temp_rsp_5) ← Pop_Stack (← get).SS temp_rsp 16 32
  temp_rsp := temp_rsp_5

  let (new_fs_selector, temp_rsp_6) ← Pop_Stack (← get).SS temp_rsp 16 32
  temp_rsp := temp_rsp_6

  let (new_gs_selector, temp_rsp_7) ← Pop_Stack (← get).SS temp_rsp 16 32
  temp_rsp := temp_rsp_7

  if (← CET.Is_Shadow_Stack_Enabled 3) then
    if (not (← Is_Aligned (n := 64) (← get).SSP 8)) then
      Report_Control_Protection_Exception CP_Error_Code.FAR_RET_or_IRET

  -- perform the segment loads below with a CPL of 3
  -- which is the effective CPL for Virtual_8086_Mode
  modify ({ · with CPL := (3 : Int) })

  SS.assign (← Load_Stack_Segment new_ss_selector (← get).SS (← get).CPL new_flags true)
  ES.assign (← Load_Data_Segment new_es_selector (← get).ES new_flags false)
  DS.assign (← Load_Data_Segment new_ds_selector (← get).DS new_flags false)
  FS.assign (← Load_Data_Segment new_fs_selector (← get).FS new_flags false)
  GS.assign (← Load_Data_Segment new_gs_selector (← get).GS new_flags false)

  Check_New_RIP new_cs effective_rip

  -- update RSP according to operand size instead of stack size
  if (operand_size == 16) then
    let mut RSP_target_1 ← RSP
    RSP_target_1 := (← setSliceChecked RSP_target_1 0 16 (← new_rsp[0 +: 16]))
    RSP_write RSP_target_1
  else
    let mut RSP_target ← RSP
    RSP_target := (← setSliceChecked RSP_target 0 32 (← new_rsp[0 +: 32]))
    RSP_write RSP_target

  modify ({ · with RFLAGS := new_flags })
  Branch_Far new_cs effective_rip

  -- Now past all faulting points; safe to free the token. The token free is done using the old SSP
  -- and using a supervisor override as old CPL was a supervisor privilege level
  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    let _ ← CET.Shadow_Stack_Clear_Token_Busy_Bit (← get).SSP

end X86.Helpers
