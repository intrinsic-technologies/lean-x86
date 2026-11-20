-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVDQ2Q.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVDQ2Q where
  -- MOVDQ2Q_MMXq_XMMq: REG0=MMX_R():w:q:u64 REG1=XMM_B():r:q:u64
  | MOVDQ2Q_MMXq_XMMq (reg0 : Registers.MMX) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVDQ2Q.xedForm : Forms.MOVDQ2Q → XedForm
  | .MOVDQ2Q_MMXq_XMMq _ _ => .MOVDQ2Q_MMXq_XMMq

def Forms.MOVDQ2Q.encodingFits : Forms.MOVDQ2Q → Bool
  | .MOVDQ2Q_MMXq_XMMq _ _ => true

end X86.Syntax
