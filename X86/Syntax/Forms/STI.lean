-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/STI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.STI where
  -- STI
  | STI
  deriving Repr, BEq, Inhabited

def Forms.STI.xedForm : Forms.STI → XedForm
  | .STI => .STI

def Forms.STI.encodingFits : Forms.STI → Bool
  | .STI  => true

end X86.Syntax
