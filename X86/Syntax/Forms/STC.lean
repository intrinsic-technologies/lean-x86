-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/STC.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.STC where
  -- STC
  | STC
  deriving Repr, BEq, Inhabited

def Forms.STC.xedForm : Forms.STC → XedForm
  | .STC => .STC

def Forms.STC.encodingFits : Forms.STC → Bool
  | .STC  => true

end X86.Syntax
