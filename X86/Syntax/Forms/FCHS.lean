-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FCHS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FCHS where
  -- FCHS: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FCHS
  deriving Repr, BEq, Inhabited

def Forms.FCHS.xedForm : Forms.FCHS → XedForm
  | .FCHS => .FCHS

def Forms.FCHS.encodingFits : Forms.FCHS → Bool
  | .FCHS  => true

end X86.Syntax
