-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMAXUB-PMAXUW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMAXUB where
  -- PMAXUB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PMAXUB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMAXUB_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PMAXUB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMAXUB_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PMAXUB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMAXUB_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PMAXUB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMAXUB.xedForm : Forms.PMAXUB → XedForm
  | .PMAXUB_MMXq_MEMq _ _ => .PMAXUB_MMXq_MEMq
  | .PMAXUB_MMXq_MMXq _ _ => .PMAXUB_MMXq_MMXq
  | .PMAXUB_XMMdq_MEMdq _ _ => .PMAXUB_XMMdq_MEMdq
  | .PMAXUB_XMMdq_XMMdq _ _ => .PMAXUB_XMMdq_XMMdq

def Forms.PMAXUB.encodingFits : Forms.PMAXUB → Bool
  | .PMAXUB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMAXUB_MMXq_MMXq _ _ => true
  | .PMAXUB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMAXUB_XMMdq_XMMdq _ _ => true

end X86.Syntax
