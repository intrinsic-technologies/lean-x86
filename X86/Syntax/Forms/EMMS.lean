-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/EMMS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.EMMS where
  -- EMMS
  | EMMS
  deriving Repr, BEq, Inhabited

def Forms.EMMS.xedForm : Forms.EMMS → XedForm
  | .EMMS => .EMMS

def Forms.EMMS.encodingFits : Forms.EMMS → Bool
  | .EMMS  => true

end X86.Syntax
