-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/WBINVD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.WBINVD where
  -- WBINVD
  | WBINVD
  deriving Repr, BEq, Inhabited

def Forms.WBINVD.xedForm : Forms.WBINVD → XedForm
  | .WBINVD => .WBINVD

def Forms.WBINVD.encodingFits : Forms.WBINVD → Bool
  | .WBINVD  => true

end X86.Syntax
