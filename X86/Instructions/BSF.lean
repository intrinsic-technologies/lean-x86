-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 614132ab9e15b90f2c995a243e0a330fe4800c2371dd8f47b71edcca3722014b
-- Bit Scan Forward
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=BSF)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Count_Trailing_Zero_Bits
import X86.Helpers.Std.Bits.Is_Parity_Odd
import X86.Helpers.Std.Bits.Is_Zero
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
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.BSF
    (operand_size : Int) (src : Bits operand_size) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bool) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let (result, write_result) : (Bits operand_size × Bool) ← do
    if (← Std.Bits.Is_Zero (size := operand_size) src) then
      let result : Bits operand_size ← UNSPECIFIED (size := operand_size)
      let write_result : Bool := false
      RFLAGS.setZF 1
      pure (result, write_result)
    else
      let result : Bits operand_size ← Runtime.CheckedSlice.read (← Std.Bits.Count_Trailing_Zero_Bits (size := operand_size) src) 0 operand_size
      let write_result : Bool := true
      RFLAGS.setZF 0
      pure (result, write_result)

  RFLAGS.setOF 0
  RFLAGS.setSF 0
  RFLAGS.setAF 0
  RFLAGS.setPF (if (← Std.Bits.Is_Parity_Odd (size := operand_size) src) then 0 else 1)
  RFLAGS.setCF 0
  return (result, write_result)

-- BSF_GPRv_GPRv_0: 0F BC /r
def Instructions.BSF_GPRv_GPRv_0
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.BSF operand_size src

  if write_result then
    Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- BSF_GPRv_MEMv_0: 0F BC /r
def Instructions.BSF_GPRv_MEMv_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Instructions.Operations.BSF operand_size src

  if write_result then
    Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
