-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVNTPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVNTPS where
  -- MOVNTPS_MEMdq_XMMps: MEM0:w:dq REG0=XMM_R():r:ps
  | MOVNTPS_MEMdq_XMMps (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVNTPS.xedForm : Forms.MOVNTPS → XedForm
  | .MOVNTPS_MEMdq_XMMps _ _ => .MOVNTPS_MEMdq_XMMps

def Forms.MOVNTPS.encodingFits : Forms.MOVNTPS → Bool
  | .MOVNTPS_MEMdq_XMMps mem0 _ => mem0.encodingFits

end X86.Syntax
