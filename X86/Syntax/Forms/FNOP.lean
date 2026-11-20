-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FNOP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FNOP where
  -- FNOP
  | FNOP
  deriving Repr, BEq, Inhabited

def Forms.FNOP.xedForm : Forms.FNOP → XedForm
  | .FNOP => .FNOP

def Forms.FNOP.encodingFits : Forms.FNOP → Bool
  | .FNOP  => true

end X86.Syntax
