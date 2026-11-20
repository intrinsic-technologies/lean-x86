-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/BTC.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.BTC where
  -- BTC_GPRv_GPRv: REG0=GPRv_B():rw REG1=GPRv_R():r
  | BTC_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- BTC_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | BTC_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- BTC_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | BTC_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- BTC_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | BTC_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- BTC_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | BTC_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- BTC_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | BTC_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.BTC.xedForm : Forms.BTC → XedForm
  | .BTC_GPRv_GPRv _ _ => .BTC_GPRv_GPRv
  | .BTC_GPRv_IMMb _ _ => .BTC_GPRv_IMMb
  | .BTC_LOCK_MEMv_GPRv _ _ => .BTC_LOCK_MEMv_GPRv
  | .BTC_LOCK_MEMv_IMMb _ _ => .BTC_LOCK_MEMv_IMMb
  | .BTC_MEMv_GPRv _ _ => .BTC_MEMv_GPRv
  | .BTC_MEMv_IMMb _ _ => .BTC_MEMv_IMMb

def Forms.BTC.encodingFits : Forms.BTC → Bool
  | .BTC_GPRv_GPRv _ _ => true
  | .BTC_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .BTC_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .BTC_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .BTC_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .BTC_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits

end X86.Syntax
