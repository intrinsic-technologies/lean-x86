-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FINIT-FNINIT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FINIT where
  -- FNINIT: REG0=XED_REG_X87CONTROL:w:SUPP REG1=XED_REG_X87TAG:w:SUPP  REG2=XED_REG_X87STATUS:w:SUPP
  | FNINIT
  deriving Repr, BEq, Inhabited

def Forms.FINIT.xedForm : Forms.FINIT → XedForm
  | .FNINIT => .FNINIT

def Forms.FINIT.encodingFits : Forms.FINIT → Bool
  | .FNINIT  => true

end X86.Syntax
