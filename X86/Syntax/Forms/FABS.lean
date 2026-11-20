-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FABS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FABS where
  -- FABS: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FABS
  deriving Repr, BEq, Inhabited

def Forms.FABS.xedForm : Forms.FABS → XedForm
  | .FABS => .FABS

def Forms.FABS.encodingFits : Forms.FABS → Bool
  | .FABS  => true

end X86.Syntax
