-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FFREE.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FFREE where
  -- FFREEP_X87: REG0=X87():r:f80 REG1=XED_REG_X87TAG:w:SUPP REG2=XED_REG_X87POP:r:SUPP
  | FFREEP_X87 (reg0 : Registers.X87)
  -- FFREE_X87: REG0=X87():r:f80 REG1=XED_REG_X87TAG:w:SUPP
  | FFREE_X87 (reg0 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FFREE.xedForm : Forms.FFREE → XedForm
  | .FFREEP_X87 _ => .FFREEP_X87
  | .FFREE_X87 _ => .FFREE_X87

def Forms.FFREE.encodingFits : Forms.FFREE → Bool
  | .FFREEP_X87 _ => true
  | .FFREE_X87 _ => true

end X86.Syntax
