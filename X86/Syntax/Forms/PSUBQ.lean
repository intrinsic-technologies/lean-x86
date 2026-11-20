-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSUBQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSUBQ where
  -- PSUBQ_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSUBQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSUBQ_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSUBQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSUBQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSUBQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSUBQ_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSUBQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PSUBQ.xedForm : Forms.PSUBQ → XedForm
  | .PSUBQ_MMXq_MEMq _ _ => .PSUBQ_MMXq_MEMq
  | .PSUBQ_MMXq_MMXq _ _ => .PSUBQ_MMXq_MMXq
  | .PSUBQ_XMMdq_MEMdq _ _ => .PSUBQ_XMMdq_MEMdq
  | .PSUBQ_XMMdq_XMMdq _ _ => .PSUBQ_XMMdq_XMMdq

def Forms.PSUBQ.encodingFits : Forms.PSUBQ → Bool
  | .PSUBQ_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSUBQ_MMXq_MMXq _ _ => true
  | .PSUBQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSUBQ_XMMdq_XMMdq _ _ => true

end X86.Syntax
