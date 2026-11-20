-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CLTS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CLTS where
  -- CLTS
  | CLTS
  deriving Repr, BEq, Inhabited

def Forms.CLTS.xedForm : Forms.CLTS → XedForm
  | .CLTS => .CLTS

def Forms.CLTS.encodingFits : Forms.CLTS → Bool
  | .CLTS  => true

end X86.Syntax
