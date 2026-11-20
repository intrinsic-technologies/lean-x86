-- Generated from data/instruction/BT.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 47fa36df3cae0c1dced5c69073c04db90e75cac5efa16ced61f4855dc74bce45
-- Description: data/sdm/BT.docbook
-- Selects the bit in a bit string (specified with the first operand, called the bit base) at the
-- bit-position designated by the bit offset (specified by the second operand) and stores the value
-- of the bit in the CF flag.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=BT)
import X86.Runtime
import X86.Helpers.Calculate_Bit_Offset
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Integer.Positive_Remainder
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

def Instructions.Operations.BT
    (operand_size : Int) (src1 src2 : Bits operand_size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let bit_offset : Int ← Std.Integer.Positive_Remainder (Unsigned src2) operand_size
  RFLAGS.setCF (← src1[bit_offset +: 1])

  RFLAGS.setOF (← UNSPECIFIED (size := 1))
  RFLAGS.setSF (← UNSPECIFIED (size := 1))
  RFLAGS.setAF (← UNSPECIFIED (size := 1))
  RFLAGS.setPF (← UNSPECIFIED (size := 1))

-- BT_GPRv_IMMb: 0F BA /4 ib
def Instructions.BT_GPRv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.BT operand_size src1 src2

-- BT_MEMv_IMMb: 0F BA /4 ib
def Instructions.BT_MEMv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) operand_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  Instructions.Operations.BT operand_size src1 src2

-- BT_GPRv_GPRv: 0F A3 /r
def Instructions.BT_GPRv_GPRv
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.BT operand_size src1 src2

-- BT_MEMv_GPRv: 0F A3 /r
def Instructions.BT_MEMv_GPRv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let bit_offset : Bits 64 ← Calculate_Bit_Offset (operand_size := operand_size) src2
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative (ea_offset + bit_offset) next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.BT operand_size src1 src2

end X86
