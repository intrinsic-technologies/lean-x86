-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FRNDINT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FRNDINT where
  -- FRNDINT: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FRNDINT
  deriving Repr, BEq, Inhabited

def Forms.FRNDINT.xedForm : Forms.FRNDINT → XedForm
  | .FRNDINT => .FRNDINT

def Forms.FRNDINT.encodingFits : Forms.FRNDINT → Bool
  | .FRNDINT  => true

end X86.Syntax
