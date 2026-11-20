-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVNTDQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVNTDQ where
  -- MOVNTDQ_MEMdq_XMMdq: MEM0:w:dq REG0=XMM_R():r:dq
  | MOVNTDQ_MEMdq_XMMdq (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVNTDQ.xedForm : Forms.MOVNTDQ → XedForm
  | .MOVNTDQ_MEMdq_XMMdq _ _ => .MOVNTDQ_MEMdq_XMMdq

def Forms.MOVNTDQ.encodingFits : Forms.MOVNTDQ → Bool
  | .MOVNTDQ_MEMdq_XMMdq mem0 _ => mem0.encodingFits

end X86.Syntax
