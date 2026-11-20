-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/INC.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.INC where
  -- INC_GPR8: REG0=GPR8_B():rw
  | INC_GPR8 (reg0 : Registers.GPR8)
  -- INC_GPRv_FFr0: REG0=GPRv_B():rw
  | INC_GPRv_FFr0 (reg0 : Registers.GPRv)
  -- INC_LOCK_MEMb: MEM0:rw:b
  | INC_LOCK_MEMb (mem0 : MemoryOperand)
  -- INC_LOCK_MEMv: MEM0:rw:v
  | INC_LOCK_MEMv (mem0 : MemoryOperand)
  -- INC_MEMb: MEM0:rw:b
  | INC_MEMb (mem0 : MemoryOperand)
  -- INC_MEMv: MEM0:rw:v
  | INC_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.INC.xedForm : Forms.INC → XedForm
  | .INC_GPR8 _ => .INC_GPR8
  | .INC_GPRv_FFr0 _ => .INC_GPRv_FFr0
  | .INC_LOCK_MEMb _ => .INC_LOCK_MEMb
  | .INC_LOCK_MEMv _ => .INC_LOCK_MEMv
  | .INC_MEMb _ => .INC_MEMb
  | .INC_MEMv _ => .INC_MEMv

def Forms.INC.encodingFits : Forms.INC → Bool
  | .INC_GPR8 _ => true
  | .INC_GPRv_FFr0 _ => true
  | .INC_LOCK_MEMb mem0 => mem0.encodingFits
  | .INC_LOCK_MEMv mem0 => mem0.encodingFits
  | .INC_MEMb mem0 => mem0.encodingFits
  | .INC_MEMv mem0 => mem0.encodingFits

end X86.Syntax
