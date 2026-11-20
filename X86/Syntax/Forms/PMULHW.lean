-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMULHW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMULHW where
  -- PMULHW_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q:i16
  | PMULHW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMULHW_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q:i16
  | PMULHW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMULHW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i16 MEM0:r:dq:i16
  | PMULHW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMULHW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i16 REG1=XMM_B():r:dq:i16
  | PMULHW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMULHW.xedForm : Forms.PMULHW → XedForm
  | .PMULHW_MMXq_MEMq _ _ => .PMULHW_MMXq_MEMq
  | .PMULHW_MMXq_MMXq _ _ => .PMULHW_MMXq_MMXq
  | .PMULHW_XMMdq_MEMdq _ _ => .PMULHW_XMMdq_MEMdq
  | .PMULHW_XMMdq_XMMdq _ _ => .PMULHW_XMMdq_XMMdq

def Forms.PMULHW.encodingFits : Forms.PMULHW → Bool
  | .PMULHW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMULHW_MMXq_MMXq _ _ => true
  | .PMULHW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMULHW_XMMdq_XMMdq _ _ => true

end X86.Syntax
