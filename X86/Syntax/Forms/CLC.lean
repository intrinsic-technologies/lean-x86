-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CLC.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CLC where
  -- CLC
  | CLC
  deriving Repr, BEq, Inhabited

def Forms.CLC.xedForm : Forms.CLC → XedForm
  | .CLC => .CLC

def Forms.CLC.encodingFits : Forms.CLC → Bool
  | .CLC  => true

end X86.Syntax
