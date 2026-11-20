-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MFENCE.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MFENCE where
  -- MFENCE
  | MFENCE
  deriving Repr, BEq, Inhabited

def Forms.MFENCE.xedForm : Forms.MFENCE → XedForm
  | .MFENCE => .MFENCE

def Forms.MFENCE.encodingFits : Forms.MFENCE → Bool
  | .MFENCE  => true

end X86.Syntax
