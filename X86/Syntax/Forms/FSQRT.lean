-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSQRT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSQRT where
  -- FSQRT: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FSQRT
  deriving Repr, BEq, Inhabited

def Forms.FSQRT.xedForm : Forms.FSQRT → XedForm
  | .FSQRT => .FSQRT

def Forms.FSQRT.encodingFits : Forms.FSQRT → Bool
  | .FSQRT  => true

end X86.Syntax
