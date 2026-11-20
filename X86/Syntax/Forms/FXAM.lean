-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FXAM.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FXAM where
  -- FXAM: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FXAM
  deriving Repr, BEq, Inhabited

def Forms.FXAM.xedForm : Forms.FXAM → XedForm
  | .FXAM => .FXAM

def Forms.FXAM.encodingFits : Forms.FXAM → Bool
  | .FXAM  => true

end X86.Syntax
