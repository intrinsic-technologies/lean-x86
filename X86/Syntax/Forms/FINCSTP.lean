-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FINCSTP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FINCSTP where
  -- FINCSTP: REG0=XED_REG_X87STATUS:rw:SUPP
  | FINCSTP
  deriving Repr, BEq, Inhabited

def Forms.FINCSTP.xedForm : Forms.FINCSTP → XedForm
  | .FINCSTP => .FINCSTP

def Forms.FINCSTP.encodingFits : Forms.FINCSTP → Bool
  | .FINCSTP  => true

end X86.Syntax
