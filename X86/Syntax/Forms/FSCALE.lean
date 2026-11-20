-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSCALE.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSCALE where
  -- FSCALE: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_ST1:r:SUPP:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FSCALE
  deriving Repr, BEq, Inhabited

def Forms.FSCALE.xedForm : Forms.FSCALE → XedForm
  | .FSCALE => .FSCALE

def Forms.FSCALE.encodingFits : Forms.FSCALE → Bool
  | .FSCALE  => true

end X86.Syntax
