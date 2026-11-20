-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FPREM1.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FPREM1 where
  -- FPREM1: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_ST1:r:SUPP:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FPREM1
  deriving Repr, BEq, Inhabited

def Forms.FPREM1.xedForm : Forms.FPREM1 → XedForm
  | .FPREM1 => .FPREM1

def Forms.FPREM1.encodingFits : Forms.FPREM1 → Bool
  | .FPREM1  => true

end X86.Syntax
