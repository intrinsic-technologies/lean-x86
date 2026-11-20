-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LOOP-LOOPcc.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LOOP where
  -- LOOPE_RELBRb: RELBR:r:b:i8 REG0=ArCX():rw:SUPP REG1=rIP():rw:SUPP
  | LOOPE_RELBRb (relbr : RelativeOperand)
  -- LOOPNE_RELBRb: RELBR:r:b:i8 REG0=ArCX():rw:SUPP REG1=rIP():rw:SUPP
  | LOOPNE_RELBRb (relbr : RelativeOperand)
  -- LOOP_RELBRb: RELBR:r:b:i8 REG0=ArCX():rw:SUPP REG1=rIP():rw:SUPP
  | LOOP_RELBRb (relbr : RelativeOperand)
  deriving Repr, BEq, Inhabited

def Forms.LOOP.xedForm : Forms.LOOP → XedForm
  | .LOOPE_RELBRb _ => .LOOPE_RELBRb
  | .LOOPNE_RELBRb _ => .LOOPNE_RELBRb
  | .LOOP_RELBRb _ => .LOOP_RELBRb

def Forms.LOOP.encodingFits : Forms.LOOP → Bool
  | .LOOPE_RELBRb relbr => relbr.encodingFits
  | .LOOPNE_RELBRb relbr => relbr.encodingFits
  | .LOOP_RELBRb relbr => relbr.encodingFits

end X86.Syntax
