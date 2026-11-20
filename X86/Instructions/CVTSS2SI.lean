-- Generated from data/instruction/CVTSS2SI.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: badf04051d6b9a24fbfa1ae88f766880637b0b2cb345153303a1bbb01cd27534
-- Description: data/sdm/CVTSS2SI.docbook
-- Converts a single precision floating-point value in the source operand (the second operand) to a
-- signed integer in the destination operand (the first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CVTSS2SI)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.FP.Check_Exceptions
import X86.Helpers.FP.Decode_Rounding_Mode
import X86.Helpers.FP.Get_DAZ
import X86.Helpers.FP.To_Int
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_XMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Rounding_Mode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Write_GPR
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
  [X86.Read_MXCSR_DAZ16.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.CVTSf2SI
    (element_size register_size result_size : Int) (src : Bits register_size) (context : Instruction_Context) (mod : Bits 2) :
    Runtime.PartialSpecM Exception (State σ) (Bits result_size) := do
  Runtime.assert (0 ≤ register_size)
  Runtime.assert (0 ≤ result_size)

  let denormals_are_zeros : Bool ← Runtime.liftTotal (FP.Get_DAZ element_size)
  let exception_masks : Bits 6 ← Runtime.liftTotal (MXCSR.Exception_Masks)
  let suppress_all_exceptions : Bool := context.evex_b == 1 and mod == 3
  let rc : Bits 2 ← do
    if context.evex_b == 1 and mod == 3 then
      pure context.evex_LLRC
    else
      pure (← Runtime.liftTotal (MXCSR.RC))
  let rounding_mode : Rounding_Mode ← FP.Decode_Rounding_Mode rc
  let mut result : Bits result_size ← Std.Bits.Zero result_size
  let op : Bits element_size ← src[0 +: element_size]
  let (r, exceptions) ← FP.To_Int (N := element_size) op true result_size denormals_are_zeros rounding_mode false
  let reported_exceptions : FP_Exception_Flags_Type ← do
    if suppress_all_exceptions then
      pure (← Std.Bits.Zero 6)
    else
      pure exceptions
  Runtime.liftTotal (FP.Check_Exceptions reported_exceptions exception_masks)
  result := r
  return result

-- CVTSS2SI_GPR32d_MEMss: F3 0F 2D /r
-- CPUID group: SSE
def Instructions.CVTSS2SI_GPR32d_MEMss
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 32
  let result_size : Int := 32
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- CVTSS2SI_GPR32d_XMMss: F3 0F 2D /r
-- CPUID group: SSE
def Instructions.CVTSS2SI_GPR32d_XMMss
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- CVTSS2SI_GPR64q_MEMss: F3 0F 2D /r
-- CPUID group: SSE
def Instructions.CVTSS2SI_GPR64q_MEMss
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 32
  let result_size : Int := 64
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- CVTSS2SI_GPR64q_XMMss: F3 0F 2D /r
-- CPUID group: SSE
def Instructions.CVTSS2SI_GPR64q_XMMss
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 64
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32d_MEMd_1: VEX.LIG.F3.0F.W0 2D /r
-- CPUID group: AVX
def Instructions.VCVTSS2SI_GPR32d_MEMd_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 32
  let result_size : Int := 32
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32d_XMMd_1: VEX.LIG.F3.0F.W0 2D /r
-- CPUID group: AVX
def Instructions.VCVTSS2SI_GPR32d_XMMd_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32d_MEMd_0: VEX.LIG.F3.0F.WIG 2D /r
-- CPUID group: AVX
def Instructions.VCVTSS2SI_GPR32d_MEMd_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 32
  let result_size : Int := 32
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← Runtime.liftTotal (In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32d_XMMd_0: VEX.LIG.F3.0F.WIG 2D /r
-- CPUID group: AVX
def Instructions.VCVTSS2SI_GPR32d_XMMd_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← Runtime.liftTotal (In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32i32_MEMf32_AVX512_1: EVEX.128.F3.0F.W0 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR32i32_MEMf32_AVX512_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 32
  let result_size : Int := 32
  let element_size : Int := 32

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32i32_XMMf32_AVX512_1: EVEX.128.F3.0F.W0 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR32i32_XMMf32_AVX512_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32i32_MEMf32_AVX512_0: EVEX.128.F3.0F.WIG 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR32i32_MEMf32_AVX512_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 32
  let result_size : Int := 32
  let element_size : Int := 32

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← Runtime.liftTotal (In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32i32_XMMf32_AVX512_0: EVEX.128.F3.0F.WIG 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR32i32_XMMf32_AVX512_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← Runtime.liftTotal (In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR64q_MEMd: VEX.LIG.F3.0F.W1 2D /r
-- CPUID group: AVX
def Instructions.VCVTSS2SI_GPR64q_MEMd
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 32
  let result_size : Int := 64
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR64q_XMMd: VEX.LIG.F3.0F.W1 2D /r
-- CPUID group: AVX
def Instructions.VCVTSS2SI_GPR64q_XMMd
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 64
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR64i64_MEMf32_AVX512: EVEX.128.F3.0F.W1 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR64i64_MEMf32_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 32
  let result_size : Int := 64
  let element_size : Int := 32

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR64i64_XMMf32_AVX512_0: EVEX.128.F3.0F.W1 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR64i64_XMMf32_AVX512_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 64
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32i32_XMMf32_AVX512_3: EVEX.128.F3.0F.W0 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR32i32_XMMf32_AVX512_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR32i32_XMMf32_AVX512_2: EVEX.128.F3.0F.WIG 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR32i32_XMMf32_AVX512_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← Runtime.liftTotal (In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VCVTSS2SI_GPR64i64_XMMf32_AVX512_1: EVEX.128.F3.0F.W1 2D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCVTSS2SI_GPR64i64_XMMf32_AVX512_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 64
  let element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTSf2SI element_size register_size result_size src context mod

  Runtime.liftTotal (Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

end X86
