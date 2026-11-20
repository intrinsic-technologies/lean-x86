-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FCOS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FCOS where
  -- FCOS: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FCOS
  deriving Repr, BEq, Inhabited

def Forms.FCOS.xedForm : Forms.FCOS → XedForm
  | .FCOS => .FCOS

def Forms.FCOS.encodingFits : Forms.FCOS → Bool
  | .FCOS  => true

end X86.Syntax
