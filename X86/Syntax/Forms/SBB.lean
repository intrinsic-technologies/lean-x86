-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SBB.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SBB where
  -- SBB_AL_IMMb: REG0=XED_REG_AL:rw:IMPL IMM0:r:b:i8
  | SBB_AL_IMMb (imm0 : Immediate)
  -- SBB_GPR8_GPR8_18: REG0=GPR8_B():rw REG1=GPR8_R():r
  | SBB_GPR8_GPR8_18 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- SBB_GPR8_GPR8_1A: REG0=GPR8_R():rw REG1=GPR8_B():r
  | SBB_GPR8_GPR8_1A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- SBB_GPR8_IMMb_80r3: REG0=GPR8_B():rw IMM0:r:b:i8
  | SBB_GPR8_IMMb_80r3 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- SBB_GPR8_MEMb: REG0=GPR8_R():rw MEM0:r:b
  | SBB_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- SBB_GPRv_GPRv_19: REG0=GPRv_B():rw REG1=GPRv_R():r
  | SBB_GPRv_GPRv_19 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- SBB_GPRv_GPRv_1B: REG0=GPRv_R():rw REG1=GPRv_B():r
  | SBB_GPRv_GPRv_1B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- SBB_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b:i8
  | SBB_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- SBB_GPRv_IMMz: REG0=GPRv_B():rw IMM0:r:z
  | SBB_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- SBB_GPRv_MEMv: REG0=GPRv_R():rw MEM0:r:v
  | SBB_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- SBB_LOCK_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | SBB_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- SBB_LOCK_MEMb_IMMb_80r3: MEM0:rw:b IMM0:r:b:i8
  | SBB_LOCK_MEMb_IMMb_80r3 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SBB_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | SBB_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- SBB_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | SBB_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SBB_LOCK_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | SBB_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SBB_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | SBB_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- SBB_MEMb_IMMb_80r3: MEM0:rw:b IMM0:r:b:i8
  | SBB_MEMb_IMMb_80r3 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SBB_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | SBB_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- SBB_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | SBB_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SBB_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | SBB_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SBB_OrAX_IMMz: REG0=OrAX():rw:IMPL IMM0:r:z
  | SBB_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.SBB.xedForm : Forms.SBB → XedForm
  | .SBB_AL_IMMb _ => .SBB_AL_IMMb
  | .SBB_GPR8_GPR8_18 _ _ => .SBB_GPR8_GPR8_18
  | .SBB_GPR8_GPR8_1A _ _ => .SBB_GPR8_GPR8_1A
  | .SBB_GPR8_IMMb_80r3 _ _ => .SBB_GPR8_IMMb_80r3
  | .SBB_GPR8_MEMb _ _ => .SBB_GPR8_MEMb
  | .SBB_GPRv_GPRv_19 _ _ => .SBB_GPRv_GPRv_19
  | .SBB_GPRv_GPRv_1B _ _ => .SBB_GPRv_GPRv_1B
  | .SBB_GPRv_IMMb _ _ => .SBB_GPRv_IMMb
  | .SBB_GPRv_IMMz _ _ => .SBB_GPRv_IMMz
  | .SBB_GPRv_MEMv _ _ => .SBB_GPRv_MEMv
  | .SBB_LOCK_MEMb_GPR8 _ _ => .SBB_LOCK_MEMb_GPR8
  | .SBB_LOCK_MEMb_IMMb_80r3 _ _ => .SBB_LOCK_MEMb_IMMb_80r3
  | .SBB_LOCK_MEMv_GPRv _ _ => .SBB_LOCK_MEMv_GPRv
  | .SBB_LOCK_MEMv_IMMb _ _ => .SBB_LOCK_MEMv_IMMb
  | .SBB_LOCK_MEMv_IMMz _ _ => .SBB_LOCK_MEMv_IMMz
  | .SBB_MEMb_GPR8 _ _ => .SBB_MEMb_GPR8
  | .SBB_MEMb_IMMb_80r3 _ _ => .SBB_MEMb_IMMb_80r3
  | .SBB_MEMv_GPRv _ _ => .SBB_MEMv_GPRv
  | .SBB_MEMv_IMMb _ _ => .SBB_MEMv_IMMb
  | .SBB_MEMv_IMMz _ _ => .SBB_MEMv_IMMz
  | .SBB_OrAX_IMMz _ _ => .SBB_OrAX_IMMz

def Forms.SBB.encodingFits : Forms.SBB → Bool
  | .SBB_AL_IMMb imm0 => imm0.encodingFits
  | .SBB_GPR8_GPR8_18 _ _ => true
  | .SBB_GPR8_GPR8_1A _ _ => true
  | .SBB_GPR8_IMMb_80r3 _ imm0 => imm0.encodingFits
  | .SBB_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .SBB_GPRv_GPRv_19 _ _ => true
  | .SBB_GPRv_GPRv_1B _ _ => true
  | .SBB_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .SBB_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .SBB_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .SBB_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .SBB_LOCK_MEMb_IMMb_80r3 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SBB_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .SBB_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SBB_LOCK_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SBB_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .SBB_MEMb_IMMb_80r3 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SBB_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .SBB_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SBB_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SBB_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax
