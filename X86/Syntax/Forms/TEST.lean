-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/TEST.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.TEST where
  -- TEST_AL_IMMb: REG0=XED_REG_AL:r:IMPL IMM0:r:b:i8
  | TEST_AL_IMMb (imm0 : Immediate)
  -- TEST_GPR8_GPR8: REG0=GPR8_B():r REG1=GPR8_R():r
  | TEST_GPR8_GPR8 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- TEST_GPR8_IMMb_F6r0: REG0=GPR8_B():r IMM0:r:b:i8
  | TEST_GPR8_IMMb_F6r0 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- TEST_GPR8_IMMb_F6r1: REG0=GPR8_B():r IMM0:r:b:i8
  | TEST_GPR8_IMMb_F6r1 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- TEST_GPRv_GPRv: REG0=GPRv_B():r REG1=GPRv_R():r
  | TEST_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- TEST_GPRv_IMMz_F7r0: REG0=GPRv_B():r IMM0:r:z
  | TEST_GPRv_IMMz_F7r0 (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- TEST_GPRv_IMMz_F7r1: REG0=GPRv_B():r IMM0:r:z
  | TEST_GPRv_IMMz_F7r1 (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- TEST_MEMb_GPR8: MEM0:r:b REG0=GPR8_R():r
  | TEST_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- TEST_MEMb_IMMb_F6r0: MEM0:r:b IMM0:r:b:i8
  | TEST_MEMb_IMMb_F6r0 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- TEST_MEMb_IMMb_F6r1: MEM0:r:b IMM0:r:b:i8
  | TEST_MEMb_IMMb_F6r1 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- TEST_MEMv_GPRv: MEM0:r:v REG0=GPRv_R():r
  | TEST_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- TEST_MEMv_IMMz_F7r0: MEM0:r:v IMM0:r:z
  | TEST_MEMv_IMMz_F7r0 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- TEST_MEMv_IMMz_F7r1: MEM0:r:v IMM0:r:z
  | TEST_MEMv_IMMz_F7r1 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- TEST_OrAX_IMMz: REG0=OrAX():r:IMPL IMM0:r:z
  | TEST_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.TEST.xedForm : Forms.TEST → XedForm
  | .TEST_AL_IMMb _ => .TEST_AL_IMMb
  | .TEST_GPR8_GPR8 _ _ => .TEST_GPR8_GPR8
  | .TEST_GPR8_IMMb_F6r0 _ _ => .TEST_GPR8_IMMb_F6r0
  | .TEST_GPR8_IMMb_F6r1 _ _ => .TEST_GPR8_IMMb_F6r1
  | .TEST_GPRv_GPRv _ _ => .TEST_GPRv_GPRv
  | .TEST_GPRv_IMMz_F7r0 _ _ => .TEST_GPRv_IMMz_F7r0
  | .TEST_GPRv_IMMz_F7r1 _ _ => .TEST_GPRv_IMMz_F7r1
  | .TEST_MEMb_GPR8 _ _ => .TEST_MEMb_GPR8
  | .TEST_MEMb_IMMb_F6r0 _ _ => .TEST_MEMb_IMMb_F6r0
  | .TEST_MEMb_IMMb_F6r1 _ _ => .TEST_MEMb_IMMb_F6r1
  | .TEST_MEMv_GPRv _ _ => .TEST_MEMv_GPRv
  | .TEST_MEMv_IMMz_F7r0 _ _ => .TEST_MEMv_IMMz_F7r0
  | .TEST_MEMv_IMMz_F7r1 _ _ => .TEST_MEMv_IMMz_F7r1
  | .TEST_OrAX_IMMz _ _ => .TEST_OrAX_IMMz

def Forms.TEST.encodingFits : Forms.TEST → Bool
  | .TEST_AL_IMMb imm0 => imm0.encodingFits
  | .TEST_GPR8_GPR8 _ _ => true
  | .TEST_GPR8_IMMb_F6r0 _ imm0 => imm0.encodingFits
  | .TEST_GPR8_IMMb_F6r1 _ imm0 => imm0.encodingFits
  | .TEST_GPRv_GPRv _ _ => true
  | .TEST_GPRv_IMMz_F7r0 _ imm0 => imm0.encodingFits
  | .TEST_GPRv_IMMz_F7r1 _ imm0 => imm0.encodingFits
  | .TEST_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .TEST_MEMb_IMMb_F6r0 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .TEST_MEMb_IMMb_F6r1 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .TEST_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .TEST_MEMv_IMMz_F7r0 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .TEST_MEMv_IMMz_F7r1 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .TEST_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax
