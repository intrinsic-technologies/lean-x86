-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/NOT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.NOT where
  -- NOT_GPR8: REG0=GPR8_B():rw
  | NOT_GPR8 (reg0 : Registers.GPR8)
  -- NOT_GPRv: REG0=GPRv_B():rw
  | NOT_GPRv (reg0 : Registers.GPRv)
  -- NOT_LOCK_MEMb: MEM0:rw:b
  | NOT_LOCK_MEMb (mem0 : MemoryOperand)
  -- NOT_LOCK_MEMv: MEM0:rw:v
  | NOT_LOCK_MEMv (mem0 : MemoryOperand)
  -- NOT_MEMb: MEM0:rw:b
  | NOT_MEMb (mem0 : MemoryOperand)
  -- NOT_MEMv: MEM0:rw:v
  | NOT_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.NOT.xedForm : Forms.NOT → XedForm
  | .NOT_GPR8 _ => .NOT_GPR8
  | .NOT_GPRv _ => .NOT_GPRv
  | .NOT_LOCK_MEMb _ => .NOT_LOCK_MEMb
  | .NOT_LOCK_MEMv _ => .NOT_LOCK_MEMv
  | .NOT_MEMb _ => .NOT_MEMb
  | .NOT_MEMv _ => .NOT_MEMv

def Forms.NOT.encodingFits : Forms.NOT → Bool
  | .NOT_GPR8 _ => true
  | .NOT_GPRv _ => true
  | .NOT_LOCK_MEMb mem0 => mem0.encodingFits
  | .NOT_LOCK_MEMv mem0 => mem0.encodingFits
  | .NOT_MEMb mem0 => mem0.encodingFits
  | .NOT_MEMv mem0 => mem0.encodingFits

end X86.Syntax
