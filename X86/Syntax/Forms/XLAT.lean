-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/XLAT-XLATB.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.XLAT where
  -- XLAT: MEM0:r:SUPP:b BASE0=ArBX():r:SUPP  INDEX=XED_REG_AL:r:SUPP  REG0=XED_REG_AL:w:SUPP SEG0=FINAL_DSEG():r:SUPP SCALE=1:r:SUPP
  | XLAT
  deriving Repr, BEq, Inhabited

def Forms.XLAT.xedForm : Forms.XLAT → XedForm
  | .XLAT => .XLAT

def Forms.XLAT.encodingFits : Forms.XLAT → Bool
  | .XLAT  => true

end X86.Syntax
