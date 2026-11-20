-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CLD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CLD where
  -- CLD
  | CLD
  deriving Repr, BEq, Inhabited

def Forms.CLD.xedForm : Forms.CLD → XedForm
  | .CLD => .CLD

def Forms.CLD.encodingFits : Forms.CLD → Bool
  | .CLD  => true

end X86.Syntax
