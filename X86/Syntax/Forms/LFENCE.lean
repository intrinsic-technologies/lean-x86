-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LFENCE.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LFENCE where
  -- LFENCE
  | LFENCE
  deriving Repr, BEq, Inhabited

def Forms.LFENCE.xedForm : Forms.LFENCE → XedForm
  | .LFENCE => .LFENCE

def Forms.LFENCE.encodingFits : Forms.LFENCE → Bool
  | .LFENCE  => true

end X86.Syntax
