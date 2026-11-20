-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FCLEX-FNCLEX.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FCLEX where
  -- FNCLEX: REG0=XED_REG_X87STATUS:w:SUPP
  | FNCLEX
  deriving Repr, BEq, Inhabited

def Forms.FCLEX.xedForm : Forms.FCLEX → XedForm
  | .FNCLEX => .FNCLEX

def Forms.FCLEX.encodingFits : Forms.FCLEX → Bool
  | .FNCLEX  => true

end X86.Syntax
