-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/HLT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.HLT where
  -- HLT
  | HLT
  deriving Repr, BEq, Inhabited

def Forms.HLT.xedForm : Forms.HLT → XedForm
  | .HLT => .HLT

def Forms.HLT.encodingFits : Forms.HLT → Bool
  | .HLT  => true

end X86.Syntax
