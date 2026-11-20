-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSIN.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSIN where
  -- FSIN: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FSIN
  deriving Repr, BEq, Inhabited

def Forms.FSIN.xedForm : Forms.FSIN → XedForm
  | .FSIN => .FSIN

def Forms.FSIN.encodingFits : Forms.FSIN → Bool
  | .FSIN  => true

end X86.Syntax
