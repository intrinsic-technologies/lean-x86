-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/NEG.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.NEG where
  -- NEG_GPR8: REG0=GPR8_B():rw
  | NEG_GPR8 (reg0 : Registers.GPR8)
  -- NEG_GPRv: REG0=GPRv_B():rw
  | NEG_GPRv (reg0 : Registers.GPRv)
  -- NEG_LOCK_MEMb: MEM0:rw:b
  | NEG_LOCK_MEMb (mem0 : MemoryOperand)
  -- NEG_LOCK_MEMv: MEM0:rw:v
  | NEG_LOCK_MEMv (mem0 : MemoryOperand)
  -- NEG_MEMb: MEM0:rw:b
  | NEG_MEMb (mem0 : MemoryOperand)
  -- NEG_MEMv: MEM0:rw:v
  | NEG_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.NEG.xedForm : Forms.NEG → XedForm
  | .NEG_GPR8 _ => .NEG_GPR8
  | .NEG_GPRv _ => .NEG_GPRv
  | .NEG_LOCK_MEMb _ => .NEG_LOCK_MEMb
  | .NEG_LOCK_MEMv _ => .NEG_LOCK_MEMv
  | .NEG_MEMb _ => .NEG_MEMb
  | .NEG_MEMv _ => .NEG_MEMv

def Forms.NEG.encodingFits : Forms.NEG → Bool
  | .NEG_GPR8 _ => true
  | .NEG_GPRv _ => true
  | .NEG_LOCK_MEMb mem0 => mem0.encodingFits
  | .NEG_LOCK_MEMv mem0 => mem0.encodingFits
  | .NEG_MEMb mem0 => mem0.encodingFits
  | .NEG_MEMv mem0 => mem0.encodingFits

end X86.Syntax
