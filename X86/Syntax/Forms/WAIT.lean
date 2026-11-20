-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/WAIT-FWAIT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.WAIT where
  -- FWAIT
  | FWAIT
  deriving Repr, BEq, Inhabited

def Forms.WAIT.xedForm : Forms.WAIT → XedForm
  | .FWAIT => .FWAIT

def Forms.WAIT.encodingFits : Forms.WAIT → Bool
  | .FWAIT  => true

end X86.Syntax
