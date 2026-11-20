-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/OR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.OR where
  -- OR_AL_IMMb: REG0=XED_REG_AL:rw:IMPL IMM0:r:b
  | OR_AL_IMMb (imm0 : Immediate)
  -- OR_GPR8_GPR8_08: REG0=GPR8_B():rw REG1=GPR8_R():r
  | OR_GPR8_GPR8_08 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- OR_GPR8_GPR8_0A: REG0=GPR8_R():rw REG1=GPR8_B():r
  | OR_GPR8_GPR8_0A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- OR_GPR8_IMMb_80r1: REG0=GPR8_B():rw IMM0:r:b:i8
  | OR_GPR8_IMMb_80r1 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- OR_GPR8_MEMb: REG0=GPR8_R():rw MEM0:r:b
  | OR_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- OR_GPRv_GPRv_09: REG0=GPRv_B():rw REG1=GPRv_R():r
  | OR_GPRv_GPRv_09 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- OR_GPRv_GPRv_0B: REG0=GPRv_R():rw REG1=GPRv_B():r
  | OR_GPRv_GPRv_0B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- OR_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b:i8
  | OR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- OR_GPRv_IMMz: REG0=GPRv_B():rw IMM0:r:z
  | OR_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- OR_GPRv_MEMv: REG0=GPRv_R():rw MEM0:r:v
  | OR_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- OR_LOCK_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | OR_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- OR_LOCK_MEMb_IMMb_80r1: MEM0:rw:b IMM0:r:b:i8
  | OR_LOCK_MEMb_IMMb_80r1 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- OR_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | OR_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- OR_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | OR_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- OR_LOCK_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | OR_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- OR_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | OR_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- OR_MEMb_IMMb_80r1: MEM0:rw:b IMM0:r:b:i8
  | OR_MEMb_IMMb_80r1 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- OR_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | OR_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- OR_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | OR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- OR_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | OR_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- OR_OrAX_IMMz: REG0=OrAX():rw:IMPL IMM0:r:z
  | OR_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.OR.xedForm : Forms.OR → XedForm
  | .OR_AL_IMMb _ => .OR_AL_IMMb
  | .OR_GPR8_GPR8_08 _ _ => .OR_GPR8_GPR8_08
  | .OR_GPR8_GPR8_0A _ _ => .OR_GPR8_GPR8_0A
  | .OR_GPR8_IMMb_80r1 _ _ => .OR_GPR8_IMMb_80r1
  | .OR_GPR8_MEMb _ _ => .OR_GPR8_MEMb
  | .OR_GPRv_GPRv_09 _ _ => .OR_GPRv_GPRv_09
  | .OR_GPRv_GPRv_0B _ _ => .OR_GPRv_GPRv_0B
  | .OR_GPRv_IMMb _ _ => .OR_GPRv_IMMb
  | .OR_GPRv_IMMz _ _ => .OR_GPRv_IMMz
  | .OR_GPRv_MEMv _ _ => .OR_GPRv_MEMv
  | .OR_LOCK_MEMb_GPR8 _ _ => .OR_LOCK_MEMb_GPR8
  | .OR_LOCK_MEMb_IMMb_80r1 _ _ => .OR_LOCK_MEMb_IMMb_80r1
  | .OR_LOCK_MEMv_GPRv _ _ => .OR_LOCK_MEMv_GPRv
  | .OR_LOCK_MEMv_IMMb _ _ => .OR_LOCK_MEMv_IMMb
  | .OR_LOCK_MEMv_IMMz _ _ => .OR_LOCK_MEMv_IMMz
  | .OR_MEMb_GPR8 _ _ => .OR_MEMb_GPR8
  | .OR_MEMb_IMMb_80r1 _ _ => .OR_MEMb_IMMb_80r1
  | .OR_MEMv_GPRv _ _ => .OR_MEMv_GPRv
  | .OR_MEMv_IMMb _ _ => .OR_MEMv_IMMb
  | .OR_MEMv_IMMz _ _ => .OR_MEMv_IMMz
  | .OR_OrAX_IMMz _ _ => .OR_OrAX_IMMz

def Forms.OR.encodingFits : Forms.OR → Bool
  | .OR_AL_IMMb imm0 => imm0.encodingFits
  | .OR_GPR8_GPR8_08 _ _ => true
  | .OR_GPR8_GPR8_0A _ _ => true
  | .OR_GPR8_IMMb_80r1 _ imm0 => imm0.encodingFits
  | .OR_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .OR_GPRv_GPRv_09 _ _ => true
  | .OR_GPRv_GPRv_0B _ _ => true
  | .OR_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .OR_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .OR_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .OR_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .OR_LOCK_MEMb_IMMb_80r1 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .OR_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .OR_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .OR_LOCK_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .OR_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .OR_MEMb_IMMb_80r1 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .OR_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .OR_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .OR_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .OR_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax
