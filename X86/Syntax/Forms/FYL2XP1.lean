-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FYL2XP1.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FYL2XP1 where
  -- FYL2XP1: REG0=XED_REG_ST0:r:SUPP:f80 REG1=XED_REG_ST1:rw:SUPP:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FYL2XP1
  deriving Repr, BEq, Inhabited

def Forms.FYL2XP1.xedForm : Forms.FYL2XP1 → XedForm
  | .FYL2XP1 => .FYL2XP1

def Forms.FYL2XP1.encodingFits : Forms.FYL2XP1 → Bool
  | .FYL2XP1  => true

end X86.Syntax
