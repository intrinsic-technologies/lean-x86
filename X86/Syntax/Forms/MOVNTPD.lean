-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVNTPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVNTPD where
  -- MOVNTPD_MEMdq_XMMpd: MEM0:w:dq REG0=XMM_R():r:pd
  | MOVNTPD_MEMdq_XMMpd (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVNTPD.xedForm : Forms.MOVNTPD → XedForm
  | .MOVNTPD_MEMdq_XMMpd _ _ => .MOVNTPD_MEMdq_XMMpd

def Forms.MOVNTPD.encodingFits : Forms.MOVNTPD → Bool
  | .MOVNTPD_MEMdq_XMMpd mem0 _ => mem0.encodingFits

end X86.Syntax
