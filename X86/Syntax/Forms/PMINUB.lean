-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMINUB-PMINUW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMINUB where
  -- PMINUB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PMINUB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMINUB_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PMINUB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMINUB_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PMINUB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMINUB_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PMINUB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMINUB.xedForm : Forms.PMINUB → XedForm
  | .PMINUB_MMXq_MEMq _ _ => .PMINUB_MMXq_MEMq
  | .PMINUB_MMXq_MMXq _ _ => .PMINUB_MMXq_MMXq
  | .PMINUB_XMMdq_MEMdq _ _ => .PMINUB_XMMdq_MEMdq
  | .PMINUB_XMMdq_XMMdq _ _ => .PMINUB_XMMdq_XMMdq

def Forms.PMINUB.encodingFits : Forms.PMINUB → Bool
  | .PMINUB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMINUB_MMXq_MMXq _ _ => true
  | .PMINUB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMINUB_XMMdq_XMMdq _ _ => true

end X86.Syntax
