-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MASKMOVQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MASKMOVQ where
  -- MASKMOVQ_MMXq_MMXq: REG0=MMX_R():r:q:u8 REG1=MMX_B():r:q:i8 MEM0:w:q:SUPP BASE0=ArDI():r:SUPP SEG0=FINAL_DSEG():r:SUPP
  | MASKMOVQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  deriving Repr, BEq, Inhabited

def Forms.MASKMOVQ.xedForm : Forms.MASKMOVQ → XedForm
  | .MASKMOVQ_MMXq_MMXq _ _ => .MASKMOVQ_MMXq_MMXq

def Forms.MASKMOVQ.encodingFits : Forms.MASKMOVQ → Bool
  | .MASKMOVQ_MMXq_MMXq _ _ => true

end X86.Syntax
