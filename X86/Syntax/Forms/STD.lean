-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/STD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.STD where
  -- STD
  | STD
  deriving Repr, BEq, Inhabited

def Forms.STD.xedForm : Forms.STD → XedForm
  | .STD => .STD

def Forms.STD.encodingFits : Forms.STD → Bool
  | .STD  => true

end X86.Syntax
