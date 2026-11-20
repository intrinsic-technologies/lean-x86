-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ENDBR64.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ENDBR64 where
  -- ENDBR64
  | ENDBR64
  deriving Repr, BEq, Inhabited

def Forms.ENDBR64.xedForm : Forms.ENDBR64 → XedForm
  | .ENDBR64 => .ENDBR64

def Forms.ENDBR64.encodingFits : Forms.ENDBR64 → Bool
  | .ENDBR64  => true

end X86.Syntax
