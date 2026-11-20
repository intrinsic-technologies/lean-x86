-- Generated from data/instruction/PSRLW-PSRLD-PSRLQ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 5eb649e543f9d4a5f8bcb88c608dc6a63225572299cbe0c5c2a0bafda3ced9e4
-- Description: data/sdm/PSRLW-PSRLD-PSRLQ.docbook
-- Shifts the bits in the individual data elements (words, doublewords, or quadword) in the
-- destination operand (first operand) to the right by the number of bits specified in the count
-- operand (second operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PSRLW%2FPSRLD%2FPSRLQ)
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
import X86.Helpers.Mem_Fetch
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
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Shift_Right_Logical
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Power2
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

def Instructions.Operations.PSRL
    (element_size register_size shift_size : Int) (src1 : Bits register_size) (shift_distance : Bits shift_size) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)
  Runtime.assert (0 ≤ shift_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    let op1 : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      pure (← src1[i *: element_size])
    let count : Int ← do
      if decide (shift_size > 64) then
        pure (Unsigned (← shift_distance[0 +: 64]))
      else
        pure (Unsigned shift_distance)
    let r : Bits element_size ← Std.Bits.Shift_Right_Logical (size := element_size) op1 count
    Runtime.assert (decide (i * element_size ≤ register_size - element_size))
    Runtime.assert (decide (0 ≤ element_size))
    result := (← setSliceChecked result (i * element_size) element_size r)
  return result

def Instructions.Operations.PSRL_m
    (element_size register_size shift_size : Int) (old : Bits register_size) (k : Bits 64) (src1 : Bits register_size) (shift_distance : Bits shift_size) (_context : Instruction_Context) (_mod : Bits 2) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)
  Runtime.assert (0 ≤ shift_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    if ((← k[i +: 1]) == 1) then
      let op1 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src1[i *: element_size])
      let count : Int ← do
        if decide (shift_size > 64) then
          pure (Unsigned (← shift_distance[0 +: 64]))
        else
          pure (Unsigned shift_distance)
      let r : Bits element_size ← Std.Bits.Shift_Right_Logical (size := element_size) op1 count
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size r)
    else
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size (← (do Runtime.assert (decide (i * element_size ≤ register_size - element_size)); Runtime.assert (decide (0 ≤ element_size)); pure (← old[i *: element_size]))))
  return result

def Instructions.Operations.PSRL_z
    (element_size register_size shift_size : Int) (k : Bits 64) (src1 : Bits register_size) (shift_distance : Bits shift_size) (_context : Instruction_Context) (_mod : Bits 2) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)
  Runtime.assert (0 ≤ shift_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    if ((← k[i +: 1]) == 1) then
      let op1 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src1[i *: element_size])
      let count : Int ← do
        if decide (shift_size > 64) then
          pure (Unsigned (← shift_distance[0 +: 64]))
        else
          pure (Unsigned shift_distance)
      let r : Bits element_size ← Std.Bits.Shift_Right_Logical (size := element_size) op1 count
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size r)
    else
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size (← Std.Bits.Zero element_size))
  return result

-- PSRLW_MMXq_IMMb: NP 0F 71 /2 ib
-- CPUID group: PENTIUMMMX
def Instructions.PSRLW_MMXq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let shift_size : Int := 8
  let element_size : Int := 16

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX rm) 0 register_size)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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
  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX rm result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLD_MMXq_IMMb: NP 0F 72 /2 ib
-- CPUID group: PENTIUMMMX
def Instructions.PSRLD_MMXq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let shift_size : Int := 8
  let element_size : Int := 32

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX rm) 0 register_size)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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
  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX rm result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLQ_MMXq_IMMb: NP 0F 73 /2 ib
-- CPUID group: PENTIUMMMX
def Instructions.PSRLQ_MMXq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let shift_size : Int := 8
  let element_size : Int := 64

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX rm) 0 register_size)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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
  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX rm result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLW_XMMdq_IMMb: 66 0F 71 /2 ib
-- CPUID group: SSE2
def Instructions.PSRLW_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 16

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← Calculate_RM mod rm context) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSRLD_XMMdq_IMMb: 66 0F 72 /2 ib
-- CPUID group: SSE2
def Instructions.PSRLD_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← Calculate_RM mod rm context) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSRLQ_XMMdq_IMMb: 66 0F 73 /2 ib
-- CPUID group: SSE2
def Instructions.PSRLQ_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 64

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← Calculate_RM mod rm context) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMdq_XMMdq_IMMb: VEX.L0.66.0F.WIG 71 /2 ib
-- CPUID group: AVX
def Instructions.VPSRLW_XMMdq_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 16

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMdq_XMMdq_IMMb: VEX.L0.66.0F.WIG 72 /2 ib
-- CPUID group: AVX
def Instructions.VPSRLD_XMMdq_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMdq_XMMdq_IMMb: VEX.L0.66.0F.WIG 73 /2 ib
-- CPUID group: AVX
def Instructions.VPSRLQ_XMMdq_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 64

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_YMMqq_YMMqq_IMMb: VEX.L1.66.0F.WIG 71 /2 ib
-- CPUID group: AVX2
def Instructions.VPSRLW_YMMqq_YMMqq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 16

  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_YMMqq_YMMqq_IMMb: VEX.L1.66.0F.WIG 72 /2 ib
-- CPUID group: AVX2
def Instructions.VPSRLD_YMMqq_YMMqq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 32

  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_YMMqq_YMMqq_IMMb: VEX.L1.66.0F.WIG 73 /2 ib
-- CPUID group: AVX2
def Instructions.VPSRLQ_YMMqq_YMMqq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 64

  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- PSRLW_MMXq_MEMq: NP 0F D1 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSRLW_MMXq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let shift_size : Int := 64
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  FP87_Status.setTOP 0
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLW_MMXq_MMXq: NP 0F D1 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSRLW_MMXq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let shift_size : Int := 64
  let element_size : Int := 16

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let shift_distance : Bits 64 ← Runtime.CheckedSlice.read (← Read_MMX rm) 0 64

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLD_MMXq_MEMq: NP 0F D2 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSRLD_MMXq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let shift_size : Int := 64
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  FP87_Status.setTOP 0
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLD_MMXq_MMXq: NP 0F D2 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSRLD_MMXq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let shift_size : Int := 64
  let element_size : Int := 32

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let shift_distance : Bits 64 ← Runtime.CheckedSlice.read (← Read_MMX rm) 0 64

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLQ_MMXq_MEMq: NP 0F D3 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSRLQ_MMXq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let shift_size : Int := 64
  let element_size : Int := 64

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  FP87_Status.setTOP 0
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLQ_MMXq_MMXq: NP 0F D3 /r
-- CPUID group: PENTIUMMMX
def Instructions.PSRLQ_MMXq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let shift_size : Int := 64
  let element_size : Int := 64

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX reg) 0 register_size)
  let shift_distance : Bits 64 ← Runtime.CheckedSlice.read (← Read_MMX rm) 0 64

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_MMX reg result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PSRLW_XMMdq_MEMdq: 66 0F D1 /r
-- CPUID group: SSE2
def Instructions.PSRLW_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSRLW_XMMdq_XMMdq: 66 0F D1 /r
-- CPUID group: SSE2
def Instructions.PSRLW_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 16

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSRLD_XMMdq_MEMdq: 66 0F D2 /r
-- CPUID group: SSE2
def Instructions.PSRLD_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSRLD_XMMdq_XMMdq: 66 0F D2 /r
-- CPUID group: SSE2
def Instructions.PSRLD_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSRLQ_XMMdq_MEMdq: 66 0F D3 /r
-- CPUID group: SSE2
def Instructions.PSRLQ_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 64

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSRLQ_XMMdq_XMMdq: 66 0F D3 /r
-- CPUID group: SSE2
def Instructions.PSRLQ_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 64

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMdq_XMMdq_MEMdq: VEX.L0.66.0F.WIG D1 /r
-- CPUID group: AVX
def Instructions.VPSRLW_XMMdq_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMdq_XMMdq_XMMdq: VEX.L0.66.0F.WIG D1 /r
-- CPUID group: AVX
def Instructions.VPSRLW_XMMdq_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 16

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMdq_XMMdq_MEMdq: VEX.L0.66.0F.WIG D2 /r
-- CPUID group: AVX
def Instructions.VPSRLD_XMMdq_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMdq_XMMdq_XMMdq: VEX.L0.66.0F.WIG D2 /r
-- CPUID group: AVX
def Instructions.VPSRLD_XMMdq_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMdq_XMMdq_MEMdq: VEX.L0.66.0F.WIG D3 /r
-- CPUID group: AVX
def Instructions.VPSRLQ_XMMdq_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 64

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMdq_XMMdq_XMMdq: VEX.L0.66.0F.WIG D3 /r
-- CPUID group: AVX
def Instructions.VPSRLQ_XMMdq_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 64

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_YMMqq_YMMqq_MEMdq: VEX.L1.66.0F.WIG D1 /r
-- CPUID group: AVX2
def Instructions.VPSRLW_YMMqq_YMMqq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_YMMqq_YMMqq_XMMq: VEX.L1.66.0F.WIG D1 /r
-- CPUID group: AVX2
def Instructions.VPSRLW_YMMqq_YMMqq_XMMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 64
  let element_size : Int := 16

  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 64 ← Read_XMM (← Calculate_RM mod rm context) 64

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_YMMqq_YMMqq_MEMdq: VEX.L1.66.0F.WIG D2 /r
-- CPUID group: AVX2
def Instructions.VPSRLD_YMMqq_YMMqq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_YMMqq_YMMqq_XMMq: VEX.L1.66.0F.WIG D2 /r
-- CPUID group: AVX2
def Instructions.VPSRLD_YMMqq_YMMqq_XMMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 64
  let element_size : Int := 32

  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 64 ← Read_XMM (← Calculate_RM mod rm context) 64

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_YMMqq_YMMqq_MEMdq: VEX.L1.66.0F.WIG D3 /r
-- CPUID group: AVX2
def Instructions.VPSRLQ_YMMqq_YMMqq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 64

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_YMMqq_YMMqq_XMMq: VEX.L1.66.0F.WIG D3 /r
-- CPUID group: AVX2
def Instructions.VPSRLQ_YMMqq_YMMqq_XMMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 64
  let element_size : Int := 64

  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 64 ← Read_XMM (← Calculate_RM mod rm context) 64

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

  let result : Bits register_size ← Instructions.Operations.PSRL element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLB_XMMu8_MASKmskw_MEMu8_IMM8_AVX512_MASK: EVEX.L0.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_128_AVX10
def Instructions.VPSRLB_XMMu8_MASKmskw_MEMu8_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLB_XMMu8_MASKmskw_XMMu8_IMM8_AVX512_MASK: EVEX.L0.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_128_AVX10
def Instructions.VPSRLB_XMMu8_MASKmskw_XMMu8_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 8

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLB_XMMu8_MASKmskw_MEMu8_IMM8_AVX512_ZERO: EVEX.L0.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_128_AVX10
def Instructions.VPSRLB_XMMu8_MASKmskw_MEMu8_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLB_XMMu8_MASKmskw_XMMu8_IMM8_AVX512_ZERO: EVEX.L0.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_128_AVX10
def Instructions.VPSRLB_XMMu8_MASKmskw_XMMu8_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLB_XMMu8_MASKmskw_XMMu8_MEMu8_AVX512_MASK: EVEX.L0.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_128_AVX10
def Instructions.VPSRLB_XMMu8_MASKmskw_XMMu8_MEMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLB_XMMu8_MASKmskw_XMMu8_XMMu8_AVX512_MASK: EVEX.L0.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_128_AVX10
def Instructions.VPSRLB_XMMu8_MASKmskw_XMMu8_XMMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 8

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLB_XMMu8_MASKmskw_XMMu8_MEMu8_AVX512_ZERO: EVEX.L0.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_128_AVX10
def Instructions.VPSRLB_XMMu8_MASKmskw_XMMu8_MEMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLB_XMMu8_MASKmskw_XMMu8_XMMu8_AVX512_ZERO: EVEX.L0.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_128_AVX10
def Instructions.VPSRLB_XMMu8_MASKmskw_XMMu8_XMMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK: EVEX.L0.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSRLW_XMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMu16_MASKmskw_XMMu16_IMM8_AVX512_MASK: EVEX.L0.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSRLW_XMMu16_MASKmskw_XMMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 16

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO: EVEX.L0.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSRLW_XMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMu16_MASKmskw_XMMu16_IMM8_AVX512_ZERO: EVEX.L0.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSRLW_XMMu16_MASKmskw_XMMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMu16_MASKmskw_XMMu16_MEMu16_AVX512_MASK: EVEX.L0.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSRLW_XMMu16_MASKmskw_XMMu16_MEMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMu16_MASKmskw_XMMu16_XMMu16_AVX512_MASK: EVEX.L0.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSRLW_XMMu16_MASKmskw_XMMu16_XMMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 16

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMu16_MASKmskw_XMMu16_MEMu16_AVX512_ZERO: EVEX.L0.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSRLW_XMMu16_MASKmskw_XMMu16_MEMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLW_XMMu16_MASKmskw_XMMu16_XMMu16_AVX512_ZERO: EVEX.L0.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSRLW_XMMu16_MASKmskw_XMMu16_XMMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMu32_MASKmskw_MEMu32_IMM8_AVX512_MASK: EVEX.L0.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLD_XMMu32_MASKmskw_MEMu32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1)) then
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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMu32_MASKmskw_XMMu32_IMM8_AVX512_MASK: EVEX.L0.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLD_XMMu32_MASKmskw_XMMu32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 32

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMu32_MASKmskw_MEMu32_IMM8_AVX512_ZERO: EVEX.L0.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLD_XMMu32_MASKmskw_MEMu32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let shift_size : Int := 8
  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1)) then
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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMu32_MASKmskw_XMMu32_IMM8_AVX512_ZERO: EVEX.L0.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLD_XMMu32_MASKmskw_XMMu32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_MASK: EVEX.L0.66.0F.W0 D2 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLD_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_MASK: EVEX.L0.66.0F.W0 D2 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLD_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 32

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_ZERO: EVEX.L0.66.0F.W0 D2 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLD_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLD_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_ZERO: EVEX.L0.66.0F.W0 D2 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLD_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMu64_MASKmskw_MEMu64_IMM8_AVX512_MASK: EVEX.L0.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLQ_XMMu64_MASKmskw_MEMu64_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMu64_MASKmskw_XMMu64_IMM8_AVX512_MASK: EVEX.L0.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLQ_XMMu64_MASKmskw_XMMu64_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 64

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMu64_MASKmskw_MEMu64_IMM8_AVX512_ZERO: EVEX.L0.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLQ_XMMu64_MASKmskw_MEMu64_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let shift_size : Int := 8
  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMu64_MASKmskw_XMMu64_IMM8_AVX512_ZERO: EVEX.L0.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLQ_XMMu64_MASKmskw_XMMu64_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMu64_MASKmskw_XMMu64_MEMu64_AVX512_MASK: EVEX.L0.66.0F.W1 D3 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLQ_XMMu64_MASKmskw_XMMu64_MEMu64_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMu64_MASKmskw_XMMu64_XMMu64_AVX512_MASK: EVEX.L0.66.0F.W1 D3 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLQ_XMMu64_MASKmskw_XMMu64_XMMu64_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 64

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMu64_MASKmskw_XMMu64_MEMu64_AVX512_ZERO: EVEX.L0.66.0F.W1 D3 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLQ_XMMu64_MASKmskw_XMMu64_MEMu64_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLQ_XMMu64_MASKmskw_XMMu64_XMMu64_AVX512_ZERO: EVEX.L0.66.0F.W1 D3 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VPSRLQ_XMMu64_MASKmskw_XMMu64_XMMu64_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 128
  let element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSRLB_YMMu8_MASKmskw_MEMu8_IMM8_AVX512_MASK: EVEX.L1.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_256_AVX10
def Instructions.VPSRLB_YMMu8_MASKmskw_MEMu8_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 8

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLB_YMMu8_MASKmskw_YMMu8_IMM8_AVX512_MASK: EVEX.L1.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_256_AVX10
def Instructions.VPSRLB_YMMu8_MASKmskw_YMMu8_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 8

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLB_YMMu8_MASKmskw_MEMu8_IMM8_AVX512_ZERO: EVEX.L1.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_256_AVX10
def Instructions.VPSRLB_YMMu8_MASKmskw_MEMu8_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 8

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLB_YMMu8_MASKmskw_YMMu8_IMM8_AVX512_ZERO: EVEX.L1.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_256_AVX10
def Instructions.VPSRLB_YMMu8_MASKmskw_YMMu8_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLB_YMMu8_MASKmskw_YMMu8_MEMu8_AVX512_MASK: EVEX.L1.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_256_AVX10
def Instructions.VPSRLB_YMMu8_MASKmskw_YMMu8_MEMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLB_YMMu8_MASKmskw_YMMu8_XMMu8_AVX512_MASK: EVEX.L1.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_256_AVX10
def Instructions.VPSRLB_YMMu8_MASKmskw_YMMu8_XMMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 8

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLB_YMMu8_MASKmskw_YMMu8_MEMu8_AVX512_ZERO: EVEX.L1.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_256_AVX10
def Instructions.VPSRLB_YMMu8_MASKmskw_YMMu8_MEMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLB_YMMu8_MASKmskw_YMMu8_XMMu8_AVX512_ZERO: EVEX.L1.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_256_AVX10
def Instructions.VPSRLB_YMMu8_MASKmskw_YMMu8_XMMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_YMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK: EVEX.L1.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSRLW_YMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 16

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLW_YMMu16_MASKmskw_YMMu16_IMM8_AVX512_MASK: EVEX.L1.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSRLW_YMMu16_MASKmskw_YMMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 16

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLW_YMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO: EVEX.L1.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSRLW_YMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 16

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLW_YMMu16_MASKmskw_YMMu16_IMM8_AVX512_ZERO: EVEX.L1.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSRLW_YMMu16_MASKmskw_YMMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLW_YMMu16_MASKmskw_YMMu16_MEMu16_AVX512_MASK: EVEX.L1.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSRLW_YMMu16_MASKmskw_YMMu16_MEMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_YMMu16_MASKmskw_YMMu16_XMMu16_AVX512_MASK: EVEX.L1.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSRLW_YMMu16_MASKmskw_YMMu16_XMMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 16

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_YMMu16_MASKmskw_YMMu16_MEMu16_AVX512_ZERO: EVEX.L1.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSRLW_YMMu16_MASKmskw_YMMu16_MEMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_YMMu16_MASKmskw_YMMu16_XMMu16_AVX512_ZERO: EVEX.L1.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSRLW_YMMu16_MASKmskw_YMMu16_XMMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_YMMu32_MASKmskw_MEMu32_IMM8_AVX512_MASK: EVEX.L1.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLD_YMMu32_MASKmskw_MEMu32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1)) then
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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_YMMu32_MASKmskw_YMMu32_IMM8_AVX512_MASK: EVEX.L1.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLD_YMMu32_MASKmskw_YMMu32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 32

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_YMMu32_MASKmskw_MEMu32_IMM8_AVX512_ZERO: EVEX.L1.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLD_YMMu32_MASKmskw_MEMu32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let shift_size : Int := 8
  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1)) then
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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_YMMu32_MASKmskw_YMMu32_IMM8_AVX512_ZERO: EVEX.L1.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLD_YMMu32_MASKmskw_YMMu32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_MASK: EVEX.L1.66.0F.W0 D2 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLD_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_YMMu32_MASKmskw_YMMu32_XMMu32_AVX512_MASK: EVEX.L1.66.0F.W0 D2 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLD_YMMu32_MASKmskw_YMMu32_XMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 32

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_ZERO: EVEX.L1.66.0F.W0 D2 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLD_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_YMMu32_MASKmskw_YMMu32_XMMu32_AVX512_ZERO: EVEX.L1.66.0F.W0 D2 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLD_YMMu32_MASKmskw_YMMu32_XMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_YMMu64_MASKmskw_MEMu64_IMM8_AVX512_MASK: EVEX.L1.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLQ_YMMu64_MASKmskw_MEMu64_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_YMMu64_MASKmskw_YMMu64_IMM8_AVX512_MASK: EVEX.L1.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLQ_YMMu64_MASKmskw_YMMu64_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 64

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_YMMu64_MASKmskw_MEMu64_IMM8_AVX512_ZERO: EVEX.L1.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLQ_YMMu64_MASKmskw_MEMu64_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let shift_size : Int := 8
  let register_size : Int := 256
  let element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_YMMu64_MASKmskw_YMMu64_IMM8_AVX512_ZERO: EVEX.L1.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLQ_YMMu64_MASKmskw_YMMu64_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_YMMu64_MASKmskw_YMMu64_MEMu64_AVX512_MASK: EVEX.L1.66.0F.W1 D3 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLQ_YMMu64_MASKmskw_YMMu64_MEMu64_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_YMMu64_MASKmskw_YMMu64_XMMu64_AVX512_MASK: EVEX.L1.66.0F.W1 D3 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLQ_YMMu64_MASKmskw_YMMu64_XMMu64_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 64

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_YMMu64_MASKmskw_YMMu64_MEMu64_AVX512_ZERO: EVEX.L1.66.0F.W1 D3 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLQ_YMMu64_MASKmskw_YMMu64_MEMu64_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_YMMu64_MASKmskw_YMMu64_XMMu64_AVX512_ZERO: EVEX.L1.66.0F.W1 D3 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VPSRLQ_YMMu64_MASKmskw_YMMu64_XMMu64_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 128
  let element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLB_ZMMu8_MASKmskw_MEMu8_IMM8_AVX512_MASK: EVEX.L2.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_512_AVX10
def Instructions.VPSRLB_ZMMu8_MASKmskw_MEMu8_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 8

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLB_ZMMu8_MASKmskw_ZMMu8_IMM8_AVX512_MASK: EVEX.L2.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_512_AVX10
def Instructions.VPSRLB_ZMMu8_MASKmskw_ZMMu8_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 8

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLB_ZMMu8_MASKmskw_MEMu8_IMM8_AVX512_ZERO: EVEX.L2.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_512_AVX10
def Instructions.VPSRLB_ZMMu8_MASKmskw_MEMu8_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 8

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLB_ZMMu8_MASKmskw_ZMMu8_IMM8_AVX512_ZERO: EVEX.L2.66.0F.WIG 71 /3 ib
-- CPUID group: AVX10_BYTESHIFT_512_AVX10
def Instructions.VPSRLB_ZMMu8_MASKmskw_ZMMu8_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLB_ZMMu8_MASKmskw_ZMMu8_MEMu8_AVX512_MASK: EVEX.L2.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_512_AVX10
def Instructions.VPSRLB_ZMMu8_MASKmskw_ZMMu8_MEMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLB_ZMMu8_MASKmskw_ZMMu8_XMMu8_AVX512_MASK: EVEX.L2.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_512_AVX10
def Instructions.VPSRLB_ZMMu8_MASKmskw_ZMMu8_XMMu8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 8

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLB_ZMMu8_MASKmskw_ZMMu8_MEMu8_AVX512_ZERO: EVEX.L2.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_512_AVX10
def Instructions.VPSRLB_ZMMu8_MASKmskw_ZMMu8_MEMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 8

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLB_ZMMu8_MASKmskw_ZMMu8_XMMu8_AVX512_ZERO: EVEX.L2.F2.0F.WIG D1 /r
-- CPUID group: AVX10_BYTESHIFT_512_AVX10
def Instructions.VPSRLB_ZMMu8_MASKmskw_ZMMu8_XMMu8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 8

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_ZMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK: EVEX.L2.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSRLW_ZMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 16

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLW_ZMMu16_MASKmskw_ZMMu16_IMM8_AVX512_MASK: EVEX.L2.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSRLW_ZMMu16_MASKmskw_ZMMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 16

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLW_ZMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO: EVEX.L2.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSRLW_ZMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 16

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLW_ZMMu16_MASKmskw_ZMMu16_IMM8_AVX512_ZERO: EVEX.L2.66.0F.WIG 71 /2 ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSRLW_ZMMu16_MASKmskw_ZMMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLW_ZMMu16_MASKmskw_ZMMu16_MEMu16_AVX512_MASK: EVEX.L2.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSRLW_ZMMu16_MASKmskw_ZMMu16_MEMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_ZMMu16_MASKmskw_ZMMu16_XMMu16_AVX512_MASK: EVEX.L2.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSRLW_ZMMu16_MASKmskw_ZMMu16_XMMu16_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 16

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_ZMMu16_MASKmskw_ZMMu16_MEMu16_AVX512_ZERO: EVEX.L2.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSRLW_ZMMu16_MASKmskw_ZMMu16_MEMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0)) then
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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLW_ZMMu16_MASKmskw_ZMMu16_XMMu16_AVX512_ZERO: EVEX.L2.66.0F.WIG D1 /r
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSRLW_ZMMu16_MASKmskw_ZMMu16_XMMu16_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_ZMMu32_MASKmskw_MEMu32_IMM8_AVX512_MASK: EVEX.L2.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLD_ZMMu32_MASKmskw_MEMu32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1)) then
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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_ZMMu32_MASKmskw_ZMMu32_IMM8_AVX512_MASK: EVEX.L2.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLD_ZMMu32_MASKmskw_ZMMu32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 32

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_ZMMu32_MASKmskw_MEMu32_IMM8_AVX512_ZERO: EVEX.L2.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLD_ZMMu32_MASKmskw_MEMu32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let shift_size : Int := 8
  let register_size : Int := 512
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1)) then
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

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_ZMMu32_MASKmskw_ZMMu32_IMM8_AVX512_ZERO: EVEX.L2.66.0F.W0 72 /2 ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLD_ZMMu32_MASKmskw_ZMMu32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0)) then
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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLD_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_MASK: EVEX.L2.66.0F.W0 D2 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLD_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_ZMMu32_MASKmskw_ZMMu32_XMMu32_AVX512_MASK: EVEX.L2.66.0F.W0 D2 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLD_ZMMu32_MASKmskw_ZMMu32_XMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 32

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_ZERO: EVEX.L2.66.0F.W0 D2 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLD_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLD_ZMMu32_MASKmskw_ZMMu32_XMMu32_AVX512_ZERO: EVEX.L2.66.0F.W0 D2 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLD_ZMMu32_MASKmskw_ZMMu32_XMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_ZMMu64_MASKmskw_MEMu64_IMM8_AVX512_MASK: EVEX.L2.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLQ_ZMMu64_MASKmskw_MEMu64_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_ZMMu64_MASKmskw_ZMMu64_IMM8_AVX512_MASK: EVEX.L2.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLQ_ZMMu64_MASKmskw_ZMMu64_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 64

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_ZMMu64_MASKmskw_MEMu64_IMM8_AVX512_ZERO: EVEX.L2.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLQ_ZMMu64_MASKmskw_MEMu64_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let shift_size : Int := 8
  let register_size : Int := 512
  let element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_ZMMu64_MASKmskw_ZMMu64_IMM8_AVX512_ZERO: EVEX.L2.66.0F.W1 73 /2 ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLQ_ZMMu64_MASKmskw_ZMMu64_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSRLQ_ZMMu64_MASKmskw_ZMMu64_MEMu64_AVX512_MASK: EVEX.L2.66.0F.W1 D3 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLQ_ZMMu64_MASKmskw_ZMMu64_MEMu64_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_ZMMu64_MASKmskw_ZMMu64_XMMu64_AVX512_MASK: EVEX.L2.66.0F.W1 D3 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLQ_ZMMu64_MASKmskw_ZMMu64_XMMu64_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 64

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSRL_m element_size register_size shift_size old k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_ZMMu64_MASKmskw_ZMMu64_MEMu64_AVX512_ZERO: EVEX.L2.66.0F.W1 D3 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLQ_ZMMu64_MASKmskw_ZMMu64_MEMu64_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let shift_distance : Bits shift_size ← Logical_Mem_Read segment effective_address shift_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSRLQ_ZMMu64_MASKmskw_ZMMu64_XMMu64_AVX512_ZERO: EVEX.L2.66.0F.W1 D3 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VPSRLQ_ZMMu64_MASKmskw_ZMMu64_XMMu64_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 128
  let element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let shift_distance : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.PSRL_z element_size register_size shift_size k src1 shift_distance context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
