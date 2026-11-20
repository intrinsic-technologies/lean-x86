-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMAXSB-PMAXSW-PMAXSD-PMAXSQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMAXSB where
  -- PMAXSW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PMAXSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMAXSW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PMAXSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMAXSW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PMAXSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMAXSW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PMAXSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMAXSB.xedForm : Forms.PMAXSB → XedForm
  | .PMAXSW_MMXq_MEMq _ _ => .PMAXSW_MMXq_MEMq
  | .PMAXSW_MMXq_MMXq _ _ => .PMAXSW_MMXq_MMXq
  | .PMAXSW_XMMdq_MEMdq _ _ => .PMAXSW_XMMdq_MEMdq
  | .PMAXSW_XMMdq_XMMdq _ _ => .PMAXSW_XMMdq_XMMdq

def Forms.PMAXSB.encodingFits : Forms.PMAXSB → Bool
  | .PMAXSW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMAXSW_MMXq_MMXq _ _ => true
  | .PMAXSW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMAXSW_XMMdq_XMMdq _ _ => true

end X86.Syntax
