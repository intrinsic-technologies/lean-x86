-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FYL2X.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FYL2X where
  -- FYL2X: REG0=XED_REG_ST0:r:SUPP:f80 REG1=XED_REG_ST1:rw:SUPP:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FYL2X
  deriving Repr, BEq, Inhabited

def Forms.FYL2X.xedForm : Forms.FYL2X → XedForm
  | .FYL2X => .FYL2X

def Forms.FYL2X.encodingFits : Forms.FYL2X → Bool
  | .FYL2X  => true

end X86.Syntax
