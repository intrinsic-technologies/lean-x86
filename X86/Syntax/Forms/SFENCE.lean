-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SFENCE.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SFENCE where
  -- SFENCE
  | SFENCE
  deriving Repr, BEq, Inhabited

def Forms.SFENCE.xedForm : Forms.SFENCE → XedForm
  | .SFENCE => .SFENCE

def Forms.SFENCE.encodingFits : Forms.SFENCE → Bool
  | .SFENCE  => true

end X86.Syntax
