-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 471d9b3286a6ac3b8582941915efbae0afdcf22ad7a72824a61714bb23d3ea1f
import X86.Runtime
import X86.Helpers.Decode_EVEX_1
import X86.Helpers.Decode_EVEX_2
import X86.Helpers.Decode_EVEX_3
import X86.Helpers.Decode_EVEX_4
import X86.Helpers.Decode_EVEX_5
import X86.Helpers.Decode_EVEX_6
import X86.Helpers.Decode_EVEX_7
import X86.Helpers.Decode_Legacy_0
import X86.Helpers.Decode_Legacy_1
import X86.Helpers.Decode_Legacy_2
import X86.Helpers.Decode_Legacy_3
import X86.Helpers.Decode_Prefixes
import X86.Helpers.Decode_VEX_1
import X86.Helpers.Decode_VEX_2
import X86.Helpers.Decode_VEX_3
import X86.Helpers.Decode_VEX_4
import X86.Helpers.Decode_VEX_5
import X86.Helpers.Decode_VEX_6
import X86.Helpers.Decode_VEX_7
import X86.Helpers.Instruction_Context
import X86.Helpers.Instruction_Map
import X86.Helpers.Report_Invalid_Opcode
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
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.__Fuzz_Next_Mem_Write.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.MODEP5]
  [X86.Config.Value.Max_Physical_Address]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Max_Linear_Address]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]
  [X86.Config.Value.Feature_Ingore_FCS_FDS_Deprecation]
  [X86.Config.Value.Feature_LAM_Moffs_Displacement]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

@[noinline, nospecialize]
def Fetch_And_Execute  : Runtime.PartialSpecM Exception (State σ) Unit := do
  let (context, map, opcode_ip, byte) ← Decode_Prefixes (← get).RIP

  -- SDM Vol.2B REP: a repeat prefix belongs to one string instruction.
  -- Narrowing only: any REP string keeps the flag, not just the one that set it.
  -- Only a legacy map 0 opcode without an extended prefix can be a REP string, and its
  -- opcode is the byte that follows the legacy prefixes.
  let mut repeats_string : Bool := false
  if (context.rep_prefix != 0 and map == Instruction_Map.Map_Legacy_0 and not context.rex2_prefix_present) then
    repeats_string := ((byte == (108 : Bits 8)) || (byte == (109 : Bits 8)) || (byte == (110 : Bits 8)) || (byte == (111 : Bits 8)) || (byte == (164 : Bits 8)) || (byte == (165 : Bits 8)) || (byte == (166 : Bits 8)) || (byte == (167 : Bits 8)) || (byte == (170 : Bits 8)) || (byte == (171 : Bits 8)) || (byte == (172 : Bits 8)) || (byte == (173 : Bits 8)) || (byte == (174 : Bits 8)) || (byte == (175 : Bits 8)))
  -- Keep the out-of-profile APX REX2 path.
  let preserve_repeat : Bool := context.rex2_prefix_present or repeats_string

  match map with
  | Instruction_Map.Map_Legacy_0 => do
    Decode_Legacy_0 opcode_ip context
  | Instruction_Map.Map_Legacy_1 => do
    Decode_Legacy_1 opcode_ip context
  | Instruction_Map.Map_Legacy_2 => do
    Runtime.liftTotal (Decode_Legacy_2 opcode_ip context)
  | Instruction_Map.Map_Legacy_3 => do
    Runtime.liftTotal (Decode_Legacy_3 opcode_ip context)

  | Instruction_Map.Map_VEX_1 => do
    Runtime.liftTotal (Decode_VEX_1 opcode_ip context)
  | Instruction_Map.Map_VEX_2 => do
    Runtime.liftTotal (Decode_VEX_2 opcode_ip context)
  | Instruction_Map.Map_VEX_3 => do
    Runtime.liftTotal (Decode_VEX_3 opcode_ip context)
  | Instruction_Map.Map_VEX_4 => do
    Runtime.liftTotal (Decode_VEX_4 opcode_ip context)
  | Instruction_Map.Map_VEX_5 => do
    Runtime.liftTotal (Decode_VEX_5 opcode_ip context)
  | Instruction_Map.Map_VEX_6 => do
    Runtime.liftTotal (Decode_VEX_6 opcode_ip context)
  | Instruction_Map.Map_VEX_7 => do
    Runtime.liftTotal (Decode_VEX_7 opcode_ip context)

  | Instruction_Map.Map_EVEX_1 => do
    Runtime.liftTotal (Decode_EVEX_1 opcode_ip context)
  | Instruction_Map.Map_EVEX_2 => do
    Runtime.liftTotal (Decode_EVEX_2 opcode_ip context)
  | Instruction_Map.Map_EVEX_3 => do
    Runtime.liftTotal (Decode_EVEX_3 opcode_ip context)
  | Instruction_Map.Map_EVEX_4 => do
    Runtime.liftTotal (Decode_EVEX_4 opcode_ip context)
  | Instruction_Map.Map_EVEX_5 => do
    Runtime.liftTotal (Decode_EVEX_5 opcode_ip context)
  | Instruction_Map.Map_EVEX_6 => do
    Runtime.liftTotal (Decode_EVEX_6 opcode_ip context)
  | Instruction_Map.Map_EVEX_7 => do
    Runtime.liftTotal (Decode_EVEX_7 opcode_ip context)

  | Instruction_Map.Map_Invalid => do
    liftM (Report_Invalid_Opcode)

  if (not preserve_repeat) then
    modify ({ · with Repeat_String_Operation := false })

end X86.Helpers
