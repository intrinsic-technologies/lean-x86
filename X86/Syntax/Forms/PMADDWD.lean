-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMADDWD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMADDWD where
  -- PMADDWD_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q:i16
  | PMADDWD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMADDWD_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q:i16
  | PMADDWD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMADDWD_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i16 MEM0:r:dq:i16
  | PMADDWD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMADDWD_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i16 REG1=XMM_B():r:dq:i16
  | PMADDWD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMADDWD.xedForm : Forms.PMADDWD → XedForm
  | .PMADDWD_MMXq_MEMq _ _ => .PMADDWD_MMXq_MEMq
  | .PMADDWD_MMXq_MMXq _ _ => .PMADDWD_MMXq_MMXq
  | .PMADDWD_XMMdq_MEMdq _ _ => .PMADDWD_XMMdq_MEMdq
  | .PMADDWD_XMMdq_XMMdq _ _ => .PMADDWD_XMMdq_XMMdq

def Forms.PMADDWD.encodingFits : Forms.PMADDWD → Bool
  | .PMADDWD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMADDWD_MMXq_MMXq _ _ => true
  | .PMADDWD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMADDWD_XMMdq_XMMdq _ _ => true

end X86.Syntax
