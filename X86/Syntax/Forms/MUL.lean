-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MUL.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MUL where
  -- MUL_GPR8: REG0=GPR8_B():r REG1=XED_REG_AL:r:SUPP REG2=XED_REG_AX:w:SUPP
  | MUL_GPR8 (reg0 : Registers.GPR8)
  -- MUL_GPRv: REG0=GPRv_B():r REG1=OrAX():rw:SUPP REG2=OrDX():w:SUPP
  | MUL_GPRv (reg0 : Registers.GPRv)
  -- MUL_MEMb: MEM0:r:b REG0=XED_REG_AL:r:SUPP REG1=XED_REG_AX:w:SUPP
  | MUL_MEMb (mem0 : MemoryOperand)
  -- MUL_MEMv: MEM0:r:v REG0=OrAX():rw:SUPP REG1=OrDX():w:SUPP
  | MUL_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MUL.xedForm : Forms.MUL → XedForm
  | .MUL_GPR8 _ => .MUL_GPR8
  | .MUL_GPRv _ => .MUL_GPRv
  | .MUL_MEMb _ => .MUL_MEMb
  | .MUL_MEMv _ => .MUL_MEMv

def Forms.MUL.encodingFits : Forms.MUL → Bool
  | .MUL_GPR8 _ => true
  | .MUL_GPRv _ => true
  | .MUL_MEMb mem0 => mem0.encodingFits
  | .MUL_MEMv mem0 => mem0.encodingFits

end X86.Syntax
