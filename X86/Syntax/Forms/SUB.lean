-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SUB.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SUB where
  -- SUB_AL_IMMb: REG0=XED_REG_AL:rw:IMPL IMM0:r:b:i8
  | SUB_AL_IMMb (imm0 : Immediate)
  -- SUB_GPR8_GPR8_28: REG0=GPR8_B():rw REG1=GPR8_R():r
  | SUB_GPR8_GPR8_28 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- SUB_GPR8_GPR8_2A: REG0=GPR8_R():rw REG1=GPR8_B():r
  | SUB_GPR8_GPR8_2A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- SUB_GPR8_IMMb_80r5: REG0=GPR8_B():rw IMM0:r:b:i8
  | SUB_GPR8_IMMb_80r5 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- SUB_GPR8_MEMb: REG0=GPR8_R():rw MEM0:r:b
  | SUB_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- SUB_GPRv_GPRv_29: REG0=GPRv_B():rw REG1=GPRv_R():r
  | SUB_GPRv_GPRv_29 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- SUB_GPRv_GPRv_2B: REG0=GPRv_R():rw REG1=GPRv_B():r
  | SUB_GPRv_GPRv_2B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- SUB_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b:i8
  | SUB_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- SUB_GPRv_IMMz: REG0=GPRv_B():rw IMM0:r:z
  | SUB_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- SUB_GPRv_MEMv: REG0=GPRv_R():rw MEM0:r:v
  | SUB_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- SUB_LOCK_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | SUB_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- SUB_LOCK_MEMb_IMMb_80r5: MEM0:rw:b IMM0:r:b:i8
  | SUB_LOCK_MEMb_IMMb_80r5 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SUB_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | SUB_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- SUB_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | SUB_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SUB_LOCK_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | SUB_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SUB_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | SUB_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- SUB_MEMb_IMMb_80r5: MEM0:rw:b IMM0:r:b:i8
  | SUB_MEMb_IMMb_80r5 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SUB_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | SUB_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- SUB_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | SUB_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SUB_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | SUB_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SUB_OrAX_IMMz: REG0=OrAX():rw:IMPL IMM0:r:z
  | SUB_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.SUB.xedForm : Forms.SUB → XedForm
  | .SUB_AL_IMMb _ => .SUB_AL_IMMb
  | .SUB_GPR8_GPR8_28 _ _ => .SUB_GPR8_GPR8_28
  | .SUB_GPR8_GPR8_2A _ _ => .SUB_GPR8_GPR8_2A
  | .SUB_GPR8_IMMb_80r5 _ _ => .SUB_GPR8_IMMb_80r5
  | .SUB_GPR8_MEMb _ _ => .SUB_GPR8_MEMb
  | .SUB_GPRv_GPRv_29 _ _ => .SUB_GPRv_GPRv_29
  | .SUB_GPRv_GPRv_2B _ _ => .SUB_GPRv_GPRv_2B
  | .SUB_GPRv_IMMb _ _ => .SUB_GPRv_IMMb
  | .SUB_GPRv_IMMz _ _ => .SUB_GPRv_IMMz
  | .SUB_GPRv_MEMv _ _ => .SUB_GPRv_MEMv
  | .SUB_LOCK_MEMb_GPR8 _ _ => .SUB_LOCK_MEMb_GPR8
  | .SUB_LOCK_MEMb_IMMb_80r5 _ _ => .SUB_LOCK_MEMb_IMMb_80r5
  | .SUB_LOCK_MEMv_GPRv _ _ => .SUB_LOCK_MEMv_GPRv
  | .SUB_LOCK_MEMv_IMMb _ _ => .SUB_LOCK_MEMv_IMMb
  | .SUB_LOCK_MEMv_IMMz _ _ => .SUB_LOCK_MEMv_IMMz
  | .SUB_MEMb_GPR8 _ _ => .SUB_MEMb_GPR8
  | .SUB_MEMb_IMMb_80r5 _ _ => .SUB_MEMb_IMMb_80r5
  | .SUB_MEMv_GPRv _ _ => .SUB_MEMv_GPRv
  | .SUB_MEMv_IMMb _ _ => .SUB_MEMv_IMMb
  | .SUB_MEMv_IMMz _ _ => .SUB_MEMv_IMMz
  | .SUB_OrAX_IMMz _ _ => .SUB_OrAX_IMMz

def Forms.SUB.encodingFits : Forms.SUB → Bool
  | .SUB_AL_IMMb imm0 => imm0.encodingFits
  | .SUB_GPR8_GPR8_28 _ _ => true
  | .SUB_GPR8_GPR8_2A _ _ => true
  | .SUB_GPR8_IMMb_80r5 _ imm0 => imm0.encodingFits
  | .SUB_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .SUB_GPRv_GPRv_29 _ _ => true
  | .SUB_GPRv_GPRv_2B _ _ => true
  | .SUB_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .SUB_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .SUB_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .SUB_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .SUB_LOCK_MEMb_IMMb_80r5 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SUB_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .SUB_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SUB_LOCK_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SUB_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .SUB_MEMb_IMMb_80r5 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SUB_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .SUB_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SUB_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SUB_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax
