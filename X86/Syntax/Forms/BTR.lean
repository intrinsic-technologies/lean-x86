-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/BTR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.BTR where
  -- BTR_GPRv_GPRv: REG0=GPRv_B():rw REG1=GPRv_R():r
  | BTR_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- BTR_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | BTR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- BTR_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | BTR_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- BTR_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | BTR_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- BTR_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | BTR_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- BTR_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | BTR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.BTR.xedForm : Forms.BTR → XedForm
  | .BTR_GPRv_GPRv _ _ => .BTR_GPRv_GPRv
  | .BTR_GPRv_IMMb _ _ => .BTR_GPRv_IMMb
  | .BTR_LOCK_MEMv_GPRv _ _ => .BTR_LOCK_MEMv_GPRv
  | .BTR_LOCK_MEMv_IMMb _ _ => .BTR_LOCK_MEMv_IMMb
  | .BTR_MEMv_GPRv _ _ => .BTR_MEMv_GPRv
  | .BTR_MEMv_IMMb _ _ => .BTR_MEMv_IMMb

def Forms.BTR.encodingFits : Forms.BTR → Bool
  | .BTR_GPRv_GPRv _ _ => true
  | .BTR_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .BTR_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .BTR_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .BTR_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .BTR_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits

end X86.Syntax
