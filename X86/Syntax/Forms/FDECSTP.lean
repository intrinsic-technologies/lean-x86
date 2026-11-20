-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FDECSTP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FDECSTP where
  -- FDECSTP: REG0=XED_REG_X87STATUS:rw:SUPP
  | FDECSTP
  deriving Repr, BEq, Inhabited

def Forms.FDECSTP.xedForm : Forms.FDECSTP → XedForm
  | .FDECSTP => .FDECSTP

def Forms.FDECSTP.encodingFits : Forms.FDECSTP → Bool
  | .FDECSTP  => true

end X86.Syntax
