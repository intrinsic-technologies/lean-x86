-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FPREM.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FPREM where
  -- FPREM: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_ST1:r:SUPP:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FPREM
  deriving Repr, BEq, Inhabited

def Forms.FPREM.xedForm : Forms.FPREM → XedForm
  | .FPREM => .FPREM

def Forms.FPREM.encodingFits : Forms.FPREM → Bool
  | .FPREM  => true

end X86.Syntax
