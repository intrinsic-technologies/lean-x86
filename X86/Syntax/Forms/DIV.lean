-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/DIV.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.DIV where
  -- DIV_GPR8: REG0=GPR8_B():r REG1=XED_REG_AX:rw:SUPP
  | DIV_GPR8 (reg0 : Registers.GPR8)
  -- DIV_GPRv: REG0=GPRv_B():r REG1=OrAX():rw:SUPP REG2=OrDX():rw:SUPP
  | DIV_GPRv (reg0 : Registers.GPRv)
  -- DIV_MEMb: MEM0:r:b REG0=XED_REG_AX:rw:SUPP
  | DIV_MEMb (mem0 : MemoryOperand)
  -- DIV_MEMv: MEM0:r:v REG0=OrAX():rw:SUPP REG1=OrDX():rw:SUPP
  | DIV_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.DIV.xedForm : Forms.DIV → XedForm
  | .DIV_GPR8 _ => .DIV_GPR8
  | .DIV_GPRv _ => .DIV_GPRv
  | .DIV_MEMb _ => .DIV_MEMb
  | .DIV_MEMv _ => .DIV_MEMv

def Forms.DIV.encodingFits : Forms.DIV → Bool
  | .DIV_GPR8 _ => true
  | .DIV_GPRv _ => true
  | .DIV_MEMb mem0 => mem0.encodingFits
  | .DIV_MEMv mem0 => mem0.encodingFits

end X86.Syntax
