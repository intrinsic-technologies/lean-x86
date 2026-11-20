-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMULHUW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMULHUW where
  -- PMULHUW_MMXq_MEMq: REG0=MMX_R():rw:q:u16 MEM0:r:q:u16
  | PMULHUW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMULHUW_MMXq_MMXq: REG0=MMX_R():rw:q:u16 REG1=MMX_B():r:q:u16
  | PMULHUW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMULHUW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:u16 MEM0:r:dq:u16
  | PMULHUW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMULHUW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:u16 REG1=XMM_B():r:dq:u16
  | PMULHUW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMULHUW.xedForm : Forms.PMULHUW → XedForm
  | .PMULHUW_MMXq_MEMq _ _ => .PMULHUW_MMXq_MEMq
  | .PMULHUW_MMXq_MMXq _ _ => .PMULHUW_MMXq_MMXq
  | .PMULHUW_XMMdq_MEMdq _ _ => .PMULHUW_XMMdq_MEMdq
  | .PMULHUW_XMMdq_XMMdq _ _ => .PMULHUW_XMMdq_XMMdq

def Forms.PMULHUW.encodingFits : Forms.PMULHUW → Bool
  | .PMULHUW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMULHUW_MMXq_MMXq _ _ => true
  | .PMULHUW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMULHUW_XMMdq_XMMdq _ _ => true

end X86.Syntax
