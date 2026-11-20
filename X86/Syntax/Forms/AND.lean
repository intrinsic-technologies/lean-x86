-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/AND.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.AND where
  -- AND_AL_IMMb: REG0=XED_REG_AL:rw:IMPL IMM0:r:b:i8
  | AND_AL_IMMb (imm0 : Immediate)
  -- AND_GPR8_GPR8_20: REG0=GPR8_B():rw REG1=GPR8_R():r
  | AND_GPR8_GPR8_20 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- AND_GPR8_GPR8_22: REG0=GPR8_R():rw REG1=GPR8_B():r
  | AND_GPR8_GPR8_22 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- AND_GPR8_IMMb_80r4: REG0=GPR8_B():rw IMM0:r:b
  | AND_GPR8_IMMb_80r4 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- AND_GPR8_MEMb: REG0=GPR8_R():rw MEM0:r:b
  | AND_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- AND_GPRv_GPRv_21: REG0=GPRv_B():rw REG1=GPRv_R():r
  | AND_GPRv_GPRv_21 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- AND_GPRv_GPRv_23: REG0=GPRv_R():rw REG1=GPRv_B():r
  | AND_GPRv_GPRv_23 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- AND_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b:i8
  | AND_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- AND_GPRv_IMMz: REG0=GPRv_B():rw IMM0:r:z
  | AND_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- AND_GPRv_MEMv: REG0=GPRv_R():rw MEM0:r:v
  | AND_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- AND_LOCK_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | AND_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- AND_LOCK_MEMb_IMMb_80r4: MEM0:rw:b IMM0:r:b
  | AND_LOCK_MEMb_IMMb_80r4 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- AND_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | AND_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- AND_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | AND_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- AND_LOCK_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | AND_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- AND_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | AND_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- AND_MEMb_IMMb_80r4: MEM0:rw:b IMM0:r:b
  | AND_MEMb_IMMb_80r4 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- AND_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | AND_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- AND_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | AND_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- AND_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | AND_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- AND_OrAX_IMMz: REG0=OrAX():rw:IMPL IMM0:r:z
  | AND_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.AND.xedForm : Forms.AND → XedForm
  | .AND_AL_IMMb _ => .AND_AL_IMMb
  | .AND_GPR8_GPR8_20 _ _ => .AND_GPR8_GPR8_20
  | .AND_GPR8_GPR8_22 _ _ => .AND_GPR8_GPR8_22
  | .AND_GPR8_IMMb_80r4 _ _ => .AND_GPR8_IMMb_80r4
  | .AND_GPR8_MEMb _ _ => .AND_GPR8_MEMb
  | .AND_GPRv_GPRv_21 _ _ => .AND_GPRv_GPRv_21
  | .AND_GPRv_GPRv_23 _ _ => .AND_GPRv_GPRv_23
  | .AND_GPRv_IMMb _ _ => .AND_GPRv_IMMb
  | .AND_GPRv_IMMz _ _ => .AND_GPRv_IMMz
  | .AND_GPRv_MEMv _ _ => .AND_GPRv_MEMv
  | .AND_LOCK_MEMb_GPR8 _ _ => .AND_LOCK_MEMb_GPR8
  | .AND_LOCK_MEMb_IMMb_80r4 _ _ => .AND_LOCK_MEMb_IMMb_80r4
  | .AND_LOCK_MEMv_GPRv _ _ => .AND_LOCK_MEMv_GPRv
  | .AND_LOCK_MEMv_IMMb _ _ => .AND_LOCK_MEMv_IMMb
  | .AND_LOCK_MEMv_IMMz _ _ => .AND_LOCK_MEMv_IMMz
  | .AND_MEMb_GPR8 _ _ => .AND_MEMb_GPR8
  | .AND_MEMb_IMMb_80r4 _ _ => .AND_MEMb_IMMb_80r4
  | .AND_MEMv_GPRv _ _ => .AND_MEMv_GPRv
  | .AND_MEMv_IMMb _ _ => .AND_MEMv_IMMb
  | .AND_MEMv_IMMz _ _ => .AND_MEMv_IMMz
  | .AND_OrAX_IMMz _ _ => .AND_OrAX_IMMz

def Forms.AND.encodingFits : Forms.AND → Bool
  | .AND_AL_IMMb imm0 => imm0.encodingFits
  | .AND_GPR8_GPR8_20 _ _ => true
  | .AND_GPR8_GPR8_22 _ _ => true
  | .AND_GPR8_IMMb_80r4 _ imm0 => imm0.encodingFits
  | .AND_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .AND_GPRv_GPRv_21 _ _ => true
  | .AND_GPRv_GPRv_23 _ _ => true
  | .AND_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .AND_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .AND_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .AND_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .AND_LOCK_MEMb_IMMb_80r4 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .AND_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .AND_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .AND_LOCK_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .AND_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .AND_MEMb_IMMb_80r4 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .AND_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .AND_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .AND_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .AND_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax
