-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FXTRACT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FXTRACT where
  -- FXTRACT: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_ST1:w:SUPP:f80 REG2=XED_REG_X87PUSH:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FXTRACT
  deriving Repr, BEq, Inhabited

def Forms.FXTRACT.xedForm : Forms.FXTRACT → XedForm
  | .FXTRACT => .FXTRACT

def Forms.FXTRACT.encodingFits : Forms.FXTRACT → Bool
  | .FXTRACT  => true

end X86.Syntax
