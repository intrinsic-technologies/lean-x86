-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FPATAN.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FPATAN where
  -- FPATAN: REG0=XED_REG_ST0:r:SUPP:f80 REG1=XED_REG_ST1:rw:SUPP:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FPATAN
  deriving Repr, BEq, Inhabited

def Forms.FPATAN.xedForm : Forms.FPATAN → XedForm
  | .FPATAN => .FPATAN

def Forms.FPATAN.encodingFits : Forms.FPATAN → Bool
  | .FPATAN  => true

end X86.Syntax
