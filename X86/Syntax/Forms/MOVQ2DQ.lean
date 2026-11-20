-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVQ2DQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVQ2DQ where
  -- MOVQ2DQ_XMMdq_MMXq: REG0=XMM_R():w:dq:u64 REG1=MMX_B():r:q:u64
  | MOVQ2DQ_XMMdq_MMXq (reg0 : Registers.XMM) (reg1 : Registers.MMX)
  deriving Repr, BEq, Inhabited

def Forms.MOVQ2DQ.xedForm : Forms.MOVQ2DQ → XedForm
  | .MOVQ2DQ_XMMdq_MMXq _ _ => .MOVQ2DQ_XMMdq_MMXq

def Forms.MOVQ2DQ.encodingFits : Forms.MOVQ2DQ → Bool
  | .MOVQ2DQ_XMMdq_MMXq _ _ => true

end X86.Syntax
