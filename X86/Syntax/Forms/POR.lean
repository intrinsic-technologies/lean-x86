-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/POR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.POR where
  -- POR_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | POR_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- POR_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | POR_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- POR_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | POR_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- POR_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | POR_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.POR.xedForm : Forms.POR → XedForm
  | .POR_MMXq_MEMq _ _ => .POR_MMXq_MEMq
  | .POR_MMXq_MMXq _ _ => .POR_MMXq_MMXq
  | .POR_XMMdq_MEMdq _ _ => .POR_XMMdq_MEMdq
  | .POR_XMMdq_XMMdq _ _ => .POR_XMMdq_XMMdq

def Forms.POR.encodingFits : Forms.POR → Bool
  | .POR_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .POR_MMXq_MMXq _ _ => true
  | .POR_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .POR_XMMdq_XMMdq _ _ => true

end X86.Syntax
