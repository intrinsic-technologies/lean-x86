-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVNTQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVNTQ where
  -- MOVNTQ_MEMq_MMXq: MEM0:w:q REG0=MMX_R():r:q
  | MOVNTQ_MEMq_MMXq (mem0 : MemoryOperand) (reg0 : Registers.MMX)
  deriving Repr, BEq, Inhabited

def Forms.MOVNTQ.xedForm : Forms.MOVNTQ → XedForm
  | .MOVNTQ_MEMq_MMXq _ _ => .MOVNTQ_MEMq_MMXq

def Forms.MOVNTQ.encodingFits : Forms.MOVNTQ → Bool
  | .MOVNTQ_MEMq_MMXq mem0 _ => mem0.encodingFits

end X86.Syntax
