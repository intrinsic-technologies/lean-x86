-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/BTS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.BTS where
  -- BTS_GPRv_GPRv: REG0=GPRv_B():rw REG1=GPRv_R():r
  | BTS_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- BTS_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | BTS_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- BTS_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | BTS_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- BTS_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | BTS_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- BTS_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | BTS_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- BTS_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | BTS_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.BTS.xedForm : Forms.BTS → XedForm
  | .BTS_GPRv_GPRv _ _ => .BTS_GPRv_GPRv
  | .BTS_GPRv_IMMb _ _ => .BTS_GPRv_IMMb
  | .BTS_LOCK_MEMv_GPRv _ _ => .BTS_LOCK_MEMv_GPRv
  | .BTS_LOCK_MEMv_IMMb _ _ => .BTS_LOCK_MEMv_IMMb
  | .BTS_MEMv_GPRv _ _ => .BTS_MEMv_GPRv
  | .BTS_MEMv_IMMb _ _ => .BTS_MEMv_IMMb

def Forms.BTS.encodingFits : Forms.BTS → Bool
  | .BTS_GPRv_GPRv _ _ => true
  | .BTS_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .BTS_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .BTS_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .BTS_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .BTS_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits

end X86.Syntax
