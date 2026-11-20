-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/F2XM1.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.F2XM1 where
  -- F2XM1: REG0=XED_REG_ST0:rw:SUPP:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | F2XM1
  deriving Repr, BEq, Inhabited

def Forms.F2XM1.xedForm : Forms.F2XM1 → XedForm
  | .F2XM1 => .F2XM1

def Forms.F2XM1.encodingFits : Forms.F2XM1 → Bool
  | .F2XM1  => true

end X86.Syntax
