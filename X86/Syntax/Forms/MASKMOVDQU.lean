-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MASKMOVDQU.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MASKMOVDQU where
  -- MASKMOVDQU_XMMxub_XMMxub: REG0=XMM_R():r:xub REG1=XMM_B():r:xub MEM0:w:SUPP:xub BASE0=ArDI():r:SUPP SEG0=FINAL_DSEG():r:SUPP
  | MASKMOVDQU_XMMxub_XMMxub (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MASKMOVDQU.xedForm : Forms.MASKMOVDQU → XedForm
  | .MASKMOVDQU_XMMxub_XMMxub _ _ => .MASKMOVDQU_XMMxub_XMMxub

def Forms.MASKMOVDQU.encodingFits : Forms.MASKMOVDQU → Bool
  | .MASKMOVDQU_XMMxub_XMMxub _ _ => true

end X86.Syntax
