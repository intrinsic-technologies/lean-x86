-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMINSB-PMINSW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMINSB where
  -- PMINSW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PMINSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMINSW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PMINSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMINSW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PMINSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMINSW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PMINSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMINSB.xedForm : Forms.PMINSB → XedForm
  | .PMINSW_MMXq_MEMq _ _ => .PMINSW_MMXq_MEMq
  | .PMINSW_MMXq_MMXq _ _ => .PMINSW_MMXq_MMXq
  | .PMINSW_XMMdq_MEMdq _ _ => .PMINSW_XMMdq_MEMdq
  | .PMINSW_XMMdq_XMMdq _ _ => .PMINSW_XMMdq_XMMdq

def Forms.PMINSB.encodingFits : Forms.PMINSB → Bool
  | .PMINSW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMINSW_MMXq_MMXq _ _ => true
  | .PMINSW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMINSW_XMMdq_XMMdq _ _ => true

end X86.Syntax
