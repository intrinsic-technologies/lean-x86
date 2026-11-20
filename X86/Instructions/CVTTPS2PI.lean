-- Generated from data/instruction/CVTTPS2PI.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: e16ebfb4e618f50a42696184949cb6a62ef5a98834b64029ba659da451c05d4d
-- Description: data/sdm/CVTTPS2PI.docbook
-- Converts two packed single precision floating-point values in the source operand (second
-- operand) to two packed signed doubleword integers in the destination operand (first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CVTTPS2PI)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Effective_Address
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_XMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Write_MMX
import X86.Instructions.CVTTPS2DQ
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

-- CVTTPS2PI_MMXq_MEMq: NP 0F 2C /r
-- CPUID group: SSE
def Instructions.CVTTPS2PI_MMXq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let result_size : Int := 64
  let element_size : Int := 32
  let result_element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  let src : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (FP87_Status.setTOP 0)
  Runtime.liftTotal (FP87_Tag_Word.assign (← Std.Bits.Zero 16))
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTTPf2i element_size register_size result_element_size result_size src

  Runtime.liftTotal (Write_MMX reg result)

-- CVTTPS2PI_MMXq_XMMq: NP 0F 2C /r
-- CPUID group: SSE
def Instructions.CVTTPS2PI_MMXq_XMMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 64
  let element_size : Int := 32
  let result_element_size : Int := 32

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  Runtime.liftTotal (FP87_Status.setTOP 0)
  Runtime.liftTotal (FP87_Tag_Word.assign (← Std.Bits.Zero 16))
  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTTPf2i element_size register_size result_element_size result_size src

  Runtime.liftTotal (Write_MMX reg result)

end X86
