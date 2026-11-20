-- Generated from data/instruction/CVTPI2PS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 5629b7c639688e41ce019cb740ee3007bb17a6ace8008296735670c7e801591b
-- Description: data/sdm/CVTPI2PS.docbook
-- Converts two packed signed doubleword integers in the source operand (second operand) to two
-- packed single precision floating-point values in the destination operand (first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CVTPI2PS)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.FP.Check_Exceptions
import X86.Helpers.FP.Decode_Rounding_Mode
import X86.Helpers.FP.From_Int
import X86.Helpers.FP.Prioritize_Operand_Exceptions
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_MMX
import X86.Helpers.Read_XMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Rounding_Mode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Write_XMM
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.CVTPI2PS
    (old : Bits 128) (src : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 128) := do
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let rounding_mode : Rounding_Mode ← FP.Decode_Rounding_Mode (← MXCSR.RC)
  let mut all_exceptions : Bits 6 ← Std.Bits.Zero 6
  let mut result : Bits 128 := old
  for i in intRange (0 : Int) (1 : Int) do
    let op : Bits 32 ← do
      Runtime.assert (decide (i * 32 ≤ 32))
      pure (← src[i *: 32])
    let (r, exceptions) ← FP.From_Int (source_size := 32) op true 32 rounding_mode
    all_exceptions := all_exceptions or (← FP.Prioritize_Operand_Exceptions exceptions exception_masks)
    Runtime.assert (decide (i * 32 ≤ 96))
    result := (← setSliceChecked result (i * (32 : Int)) 32 r)
  FP.Check_Exceptions all_exceptions exception_masks
  return result

-- CVTPI2PS_XMMq_MEMq: NP 0F 2A /r
-- CPUID group: SSE
def Instructions.CVTPI2PS_XMMq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits 64 ← Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 128 ← Instructions.Operations.CVTPI2PS old src

  Write_XMM (size := 128) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- CVTPI2PS_XMMq_MMXq: NP 0F 2A /r
-- CPUID group: SSE
def Instructions.CVTPI2PS_XMMq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let old : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let src : Bits 64 ← Runtime.CheckedSlice.read (← Read_MMX rm) 0 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  FP87_Status.setTOP 0
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)
  modify ({ · with Next_IP := ip })

  let result : Bits 128 ← Instructions.Operations.CVTPI2PS old src

  Write_XMM (size := 128) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

end X86
