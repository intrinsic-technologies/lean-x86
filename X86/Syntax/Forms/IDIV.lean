-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/IDIV.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.IDIV where
  -- IDIV_GPR8: REG0=GPR8_B():r REG1=XED_REG_AX:rw:SUPP
  | IDIV_GPR8 (reg0 : Registers.GPR8)
  -- IDIV_GPRv: REG0=GPRv_B():r REG1=OrAX():rw:SUPP REG2=OrDX():rw:SUPP
  | IDIV_GPRv (reg0 : Registers.GPRv)
  -- IDIV_MEMb: MEM0:r:b REG0=XED_REG_AX:rw:SUPP
  | IDIV_MEMb (mem0 : MemoryOperand)
  -- IDIV_MEMv: MEM0:r:v REG0=OrAX():rw:SUPP REG1=OrDX():rw:SUPP
  | IDIV_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.IDIV.xedForm : Forms.IDIV → XedForm
  | .IDIV_GPR8 _ => .IDIV_GPR8
  | .IDIV_GPRv _ => .IDIV_GPRv
  | .IDIV_MEMb _ => .IDIV_MEMb
  | .IDIV_MEMv _ => .IDIV_MEMv

def Forms.IDIV.encodingFits : Forms.IDIV → Bool
  | .IDIV_GPR8 _ => true
  | .IDIV_GPRv _ => true
  | .IDIV_MEMb mem0 => mem0.encodingFits
  | .IDIV_MEMv mem0 => mem0.encodingFits

end X86.Syntax
