-- Generated from data/instruction/PSUBB-PSUBW-PSUBD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: ad77cecfb7dd03d5b72eff3a741f2021d4320059d6cca412043892a1295b290a
-- Description: data/sdm/PSUBB-PSUBW-PSUBD.docbook
-- Performs a SIMD subtract of the packed integers of the source operand (second operand) from the
-- packed integers of the destination operand (first operand), and stores the packed integer
-- results in the destination operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PSUBB%2FPSUBW%2FPSUBD)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Masked_Vector_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_MMX
import X86.Helpers.Read_Mask
import X86.Helpers.Read_XMM
import X86.Helpers.Read_YMM
import X86.Helpers.Read_ZMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Write_MMX
import X86.Helpers.Write_XMM
import X86.Helpers.Write_YMM
import X86.Helpers.Write_ZMM
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

def Instructions.Operations.PSUB
    (element_size register_size : Int) (src1 src2 : Bits register_size) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    let op1 : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      pure (← src1[i *: element_size])
    let op2 : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      pure (← src2[i *: element_size])
    let r : Bits element_size := op1 - op2
    Runtime.assert (decide (i * element_size ≤ register_size - element_size))
    Runtime.assert (decide (0 ≤ element_size))
    result := (← setSliceChecked result (i * element_size) element_size r)
  return result

def Instructions.Operations.PSUB_m
    (element_size register_size : Int) (old : Bits register_size) (k : Bits 64) (src1 src2 : Bits register_size) (_context : Instruction_Context) (_mod : Bits 2) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    if ((← k[i +: 1]) == 1) then
      let op1 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src1[i *: element_size])
      let op2 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src2[i *: element_size])
      let r : Bits element_size := op1 - op2
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size r)
    else
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size (← (do Runtime.assert (decide (i * element_size ≤ register_size - element_size)); Runtime.assert (decide (0 ≤ element_size)); pure (← old[i *: element_size]))))
  return result

def Instructions.Operations.PSUB_z
    (element_size register_size : Int) (k : Bits 64) (src1 src2 : Bits register_size) (_context : Instruction_Context) (_mod : Bits 2) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    if ((← k[i +: 1]) == 1) then
      let op1 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src1[i *: element_size])
      let op2 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src2[i *: element_size])
      let r : Bits element_size := op1 - op2
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size r)
    else
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size (← Std.Bits.Zero element_size))
  return result

-- PSUBB_MMXq_MEMq: NP 0F F8 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSUBB_MMXq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let element_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  FP87_Status.setTOP 0
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSUBB_MMXq_MMXq: NP 0F F8 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSUBB_MMXq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let element_size : Int := 8

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let src2 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX rm) 0 register_size)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  FP87_Status.setTOP 0
  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSUBW_MMXq_MEMq: NP 0F F9 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSUBW_MMXq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  FP87_Status.setTOP 0
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSUBW_MMXq_MMXq: NP 0F F9 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSUBW_MMXq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let element_size : Int := 16

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let src2 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX rm) 0 register_size)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  FP87_Status.setTOP 0
  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSUBD_MMXq_MEMq: NP 0F FA /r
-- CPUID group: PENTIUMMMX
def Instructions.PSUBD_MMXq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  FP87_Status.setTOP 0
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSUBD_MMXq_MMXq: NP 0F FA /r
-- CPUID group: PENTIUMMMX
def Instructions.PSUBD_MMXq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let element_size : Int := 32

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let src2 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX rm) 0 register_size)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  FP87_Status.setTOP 0
  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSUBB_XMMdq_MEMdq: 66 0F F8 /r
-- CPUID group: SSE2
def Instructions.PSUBB_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSUBB_XMMdq_XMMdq: 66 0F F8 /r
-- CPUID group: SSE2
def Instructions.PSUBB_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 8

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSUBW_XMMdq_MEMdq: 66 0F F9 /r
-- CPUID group: SSE2
def Instructions.PSUBW_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSUBW_XMMdq_XMMdq: 66 0F F9 /r
-- CPUID group: SSE2
def Instructions.PSUBW_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 16

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSUBD_XMMdq_MEMdq: 66 0F FA /r
-- CPUID group: SSE2
def Instructions.PSUBD_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSUBD_XMMdq_XMMdq: 66 0F FA /r
-- CPUID group: SSE2
def Instructions.PSUBD_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBB_XMMdq_XMMdq_MEMdq: VEX.L0.66.0F.WIG F8 /r
-- CPUID group: AVX
def Instructions.VPSUBB_XMMdq_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBB_XMMdq_XMMdq_XMMdq: VEX.L0.66.0F.WIG F8 /r
-- CPUID group: AVX
def Instructions.VPSUBB_XMMdq_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 8

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBW_XMMdq_XMMdq_MEMdq: VEX.L0.66.0F.WIG F9 /r
-- CPUID group: AVX
def Instructions.VPSUBW_XMMdq_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBW_XMMdq_XMMdq_XMMdq: VEX.L0.66.0F.WIG F9 /r
-- CPUID group: AVX
def Instructions.VPSUBW_XMMdq_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 16

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBD_XMMdq_XMMdq_MEMdq: VEX.L0.66.0F.WIG FA /r
-- CPUID group: AVX
def Instructions.VPSUBD_XMMdq_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBD_XMMdq_XMMdq_XMMdq: VEX.L0.66.0F.WIG FA /r
-- CPUID group: AVX
def Instructions.VPSUBD_XMMdq_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBB_YMMqq_YMMqq_MEMqq: VEX.L1.66.0F.WIG F8 /r
-- CPUID group: AVX2
def Instructions.VPSUBB_YMMqq_YMMqq_MEMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_YMMqq_YMMqq_YMMqq: VEX.L1.66.0F.WIG F8 /r
-- CPUID group: AVX2
def Instructions.VPSUBB_YMMqq_YMMqq_YMMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 8

  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_YMMqq_YMMqq_MEMqq: VEX.L1.66.0F.WIG F9 /r
-- CPUID group: AVX2
def Instructions.VPSUBW_YMMqq_YMMqq_MEMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_YMMqq_YMMqq_YMMqq: VEX.L1.66.0F.WIG F9 /r
-- CPUID group: AVX2
def Instructions.VPSUBW_YMMqq_YMMqq_YMMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 16

  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_YMMqq_YMMqq_MEMqq: VEX.L1.66.0F.WIG FA /r
-- CPUID group: AVX2
def Instructions.VPSUBD_YMMqq_YMMqq_MEMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_YMMqq_YMMqq_YMMqq: VEX.L1.66.0F.WIG FA /r
-- CPUID group: AVX2
def Instructions.VPSUBD_YMMqq_YMMqq_YMMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 32

  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB element_size register_size src1 src2

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_XMMu8_MASKmskw_XMMu8_MEMu8_AVX512_MASK: EVEX.L0.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSUBB_XMMu8_MASKmskw_XMMu8_MEMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBB_XMMu8_MASKmskw_XMMu8_XMMu8_AVX512_MASK: EVEX.L0.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSUBB_XMMu8_MASKmskw_XMMu8_XMMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 8

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBB_XMMu8_MASKmskw_XMMu8_MEMu8_AVX512_ZERO: EVEX.L0.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSUBB_XMMu8_MASKmskw_XMMu8_MEMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBB_XMMu8_MASKmskw_XMMu8_XMMu8_AVX512_ZERO: EVEX.L0.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSUBB_XMMu8_MASKmskw_XMMu8_XMMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBW_XMMu16_MASKmskw_XMMu16_MEMu16_AVX512_MASK: EVEX.L0.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSUBW_XMMu16_MASKmskw_XMMu16_MEMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBW_XMMu16_MASKmskw_XMMu16_XMMu16_AVX512_MASK: EVEX.L0.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSUBW_XMMu16_MASKmskw_XMMu16_XMMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 16

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBW_XMMu16_MASKmskw_XMMu16_MEMu16_AVX512_ZERO: EVEX.L0.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSUBW_XMMu16_MASKmskw_XMMu16_MEMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBW_XMMu16_MASKmskw_XMMu16_XMMu16_AVX512_ZERO: EVEX.L0.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSUBW_XMMu16_MASKmskw_XMMu16_XMMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBD_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_MASK: EVEX.L0.66.0F.W0 FA /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSUBD_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBD_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_MASK: EVEX.L0.66.0F.W0 FA /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSUBD_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBD_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_ZERO: EVEX.L0.66.0F.W0 FA /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSUBD_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBD_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_ZERO: EVEX.L0.66.0F.W0 FA /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSUBD_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSUBB_YMMu8_MASKmskw_YMMu8_MEMu8_AVX512_MASK: EVEX.L1.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSUBB_YMMu8_MASKmskw_YMMu8_MEMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 8

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_YMMu8_MASKmskw_YMMu8_YMMu8_AVX512_MASK: EVEX.L1.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSUBB_YMMu8_MASKmskw_YMMu8_YMMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 8

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_YMMu8_MASKmskw_YMMu8_MEMu8_AVX512_ZERO: EVEX.L1.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSUBB_YMMu8_MASKmskw_YMMu8_MEMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 8

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_YMMu8_MASKmskw_YMMu8_YMMu8_AVX512_ZERO: EVEX.L1.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSUBB_YMMu8_MASKmskw_YMMu8_YMMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_YMMu16_MASKmskw_YMMu16_MEMu16_AVX512_MASK: EVEX.L1.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSUBW_YMMu16_MASKmskw_YMMu16_MEMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 16

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_YMMu16_MASKmskw_YMMu16_YMMu16_AVX512_MASK: EVEX.L1.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSUBW_YMMu16_MASKmskw_YMMu16_YMMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 16

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_YMMu16_MASKmskw_YMMu16_MEMu16_AVX512_ZERO: EVEX.L1.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSUBW_YMMu16_MASKmskw_YMMu16_MEMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 16

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_YMMu16_MASKmskw_YMMu16_YMMu16_AVX512_ZERO: EVEX.L1.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSUBW_YMMu16_MASKmskw_YMMu16_YMMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_MASK: EVEX.L1.66.0F.W0 FA /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSUBD_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_YMMu32_MASKmskw_YMMu32_YMMu32_AVX512_MASK: EVEX.L1.66.0F.W0 FA /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSUBD_YMMu32_MASKmskw_YMMu32_YMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 32

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_ZERO: EVEX.L1.66.0F.W0 FA /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSUBD_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_YMMu32_MASKmskw_YMMu32_YMMu32_AVX512_ZERO: EVEX.L1.66.0F.W0 FA /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSUBD_YMMu32_MASKmskw_YMMu32_YMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_ZMMu8_MASKmskw_ZMMu8_MEMu8_AVX512_MASK: EVEX.L2.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSUBB_ZMMu8_MASKmskw_ZMMu8_MEMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 8

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_ZMMu8_MASKmskw_ZMMu8_ZMMu8_AVX512_MASK: EVEX.L2.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSUBB_ZMMu8_MASKmskw_ZMMu8_ZMMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 8

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_ZMMu8_MASKmskw_ZMMu8_MEMu8_AVX512_ZERO: EVEX.L2.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSUBB_ZMMu8_MASKmskw_ZMMu8_MEMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 8

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBB_ZMMu8_MASKmskw_ZMMu8_ZMMu8_AVX512_ZERO: EVEX.L2.66.0F.WIG F8 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSUBB_ZMMu8_MASKmskw_ZMMu8_ZMMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_ZMMu16_MASKmskw_ZMMu16_MEMu16_AVX512_MASK: EVEX.L2.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSUBW_ZMMu16_MASKmskw_ZMMu16_MEMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 16

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_ZMMu16_MASKmskw_ZMMu16_ZMMu16_AVX512_MASK: EVEX.L2.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSUBW_ZMMu16_MASKmskw_ZMMu16_ZMMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 16

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_ZMMu16_MASKmskw_ZMMu16_MEMu16_AVX512_ZERO: EVEX.L2.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSUBW_ZMMu16_MASKmskw_ZMMu16_MEMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 16

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBW_ZMMu16_MASKmskw_ZMMu16_ZMMu16_AVX512_ZERO: EVEX.L2.66.0F.WIG F9 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSUBW_ZMMu16_MASKmskw_ZMMu16_ZMMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_MASK: EVEX.L2.66.0F.W0 FA /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSUBD_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_ZMMu32_MASKmskw_ZMMu32_ZMMu32_AVX512_MASK: EVEX.L2.66.0F.W0 FA /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSUBD_ZMMu32_MASKmskw_ZMMu32_ZMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 32

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_m element_size register_size old k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_ZERO: EVEX.L2.66.0F.W0 FA /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSUBD_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSUBD_ZMMu32_MASKmskw_ZMMu32_ZMMu32_AVX512_ZERO: EVEX.L2.66.0F.W0 FA /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSUBD_ZMMu32_MASKmskw_ZMMu32_ZMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSUB_z element_size register_size k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
