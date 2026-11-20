-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FTST.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FTST where
  -- FTST: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FTST
  deriving Repr, BEq, Inhabited

def Forms.FTST.xedForm : Forms.FTST → XedForm
  | .FTST => .FTST

def Forms.FTST.encodingFits : Forms.FTST → Bool
  | .FTST  => true

end X86.Syntax
