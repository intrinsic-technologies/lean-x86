-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CMC.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CMC where
  -- CMC
  | CMC
  deriving Repr, BEq, Inhabited

def Forms.CMC.xedForm : Forms.CMC → XedForm
  | .CMC => .CMC

def Forms.CMC.encodingFits : Forms.CMC → Bool
  | .CMC  => true

end X86.Syntax
