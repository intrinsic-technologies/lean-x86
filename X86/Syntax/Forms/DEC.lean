-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/DEC.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.DEC where
  -- DEC_GPR8: REG0=GPR8_B():rw
  | DEC_GPR8 (reg0 : Registers.GPR8)
  -- DEC_GPRv_FFr1: REG0=GPRv_B():rw
  | DEC_GPRv_FFr1 (reg0 : Registers.GPRv)
  -- DEC_LOCK_MEMb: MEM0:rw:b
  | DEC_LOCK_MEMb (mem0 : MemoryOperand)
  -- DEC_LOCK_MEMv: MEM0:rw:v
  | DEC_LOCK_MEMv (mem0 : MemoryOperand)
  -- DEC_MEMb: MEM0:rw:b
  | DEC_MEMb (mem0 : MemoryOperand)
  -- DEC_MEMv: MEM0:rw:v
  | DEC_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.DEC.xedForm : Forms.DEC → XedForm
  | .DEC_GPR8 _ => .DEC_GPR8
  | .DEC_GPRv_FFr1 _ => .DEC_GPRv_FFr1
  | .DEC_LOCK_MEMb _ => .DEC_LOCK_MEMb
  | .DEC_LOCK_MEMv _ => .DEC_LOCK_MEMv
  | .DEC_MEMb _ => .DEC_MEMb
  | .DEC_MEMv _ => .DEC_MEMv

def Forms.DEC.encodingFits : Forms.DEC → Bool
  | .DEC_GPR8 _ => true
  | .DEC_GPRv_FFr1 _ => true
  | .DEC_LOCK_MEMb mem0 => mem0.encodingFits
  | .DEC_LOCK_MEMv mem0 => mem0.encodingFits
  | .DEC_MEMb mem0 => mem0.encodingFits
  | .DEC_MEMv mem0 => mem0.encodingFits

end X86.Syntax
