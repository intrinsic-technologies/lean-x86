-- Generated from data/instruction/SHRD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: aaa9dfcaaa5ce20c948ec6c3088d9c396b6dd083f3ff4e8180479e45c14e5684
-- Description: data/sdm/SHRD.docbook
-- The SHRD instruction is useful for multi-precision shifts of 64 bits or more.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SHRD)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Parity_Even
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.UFloatCompare
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.SHRD
    (operand_size : Int) (src1 src2 : Bits operand_size) (src3 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let count : Int ← do
    if operand_size == 64 then
      pure (Unsigned (← src3[5:0]))
    else
      pure (Unsigned (← src3[4:0]))
  let result : Bits operand_size ← do
    if count == 0 then
      -- Note that this will zero the upper half of the operand when operand_size == 32
      let result : Bits operand_size := src1
      pure result
    else
      if decide (count > operand_size) then
        -- note: this case is only possible for 16-bit operand size due to the masking above
        let result : Bits operand_size ← UNSPECIFIED (size := operand_size)
        RFLAGS.setOF (← UNSPECIFIED (size := 1))
        RFLAGS.setSF (← UNSPECIFIED (size := 1))
        RFLAGS.setZF (← UNSPECIFIED (size := 1))
        RFLAGS.setAF (← UNSPECIFIED (size := 1))
        RFLAGS.setPF (← UNSPECIFIED (size := 1))
        RFLAGS.setCF (← UNSPECIFIED (size := 1))
        pure result
      else
        let result : Bits operand_size ← do
          Runtime.assert (decide (count + operand_size ≤ operand_size + operand_size))
          Runtime.assert (decide (0 ≤ count))
          pure (← Runtime.CheckedSlice.read (← concatBits (leftSize := operand_size) (rightSize := operand_size) src2 src1) count operand_size)
        if (count == 1) then
          RFLAGS.setOF ((← src1[operand_size - 1 +: 1]) xor (← result[operand_size - 1 +: 1]))
        else
          RFLAGS.setOF (← UNSPECIFIED (size := 1))
        RFLAGS.setSF (← result[operand_size - 1 +: 1])
        RFLAGS.setZF (← Bit (← Std.Bits.Is_Zero (size := operand_size) result))
        RFLAGS.setAF (← UNSPECIFIED (size := 1))
        RFLAGS.setPF (← Bit (← Std.Bits.Is_Parity_Even (size := 8) (← result[0 +: 8])))
        RFLAGS.setCF (← src1[count - 1 +: 1])
        pure result
  return result

-- SHRD_GPRv_GPRv_IMMb: 0F AC /r ib
def Instructions.SHRD_GPRv_GPRv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let src3 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.SHRD operand_size src1 src2 src3

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- SHRD_MEMv_GPRv_IMMb: 0F AC /r ib
def Instructions.SHRD_MEMv_GPRv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let src3 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.SHRD operand_size src1 src2 src3

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SHRD_GPRv_GPRv_CL: 0F AD /r
def Instructions.SHRD_GPRv_GPRv_CL
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let src3 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.SHRD operand_size src1 src2 src3

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- SHRD_MEMv_GPRv_CL: 0F AD /r
def Instructions.SHRD_MEMv_GPRv_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let src3 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.SHRD operand_size src1 src2 src3

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

end X86
