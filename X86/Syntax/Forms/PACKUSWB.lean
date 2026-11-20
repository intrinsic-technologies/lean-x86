-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PACKUSWB.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PACKUSWB where
  -- PACKUSWB_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q:i16
  | PACKUSWB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PACKUSWB_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q:i16
  | PACKUSWB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PACKUSWB_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i16 MEM0:r:dq:i16
  | PACKUSWB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PACKUSWB_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i16 REG1=XMM_B():r:dq:i16
  | PACKUSWB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PACKUSWB.xedForm : Forms.PACKUSWB → XedForm
  | .PACKUSWB_MMXq_MEMq _ _ => .PACKUSWB_MMXq_MEMq
  | .PACKUSWB_MMXq_MMXq _ _ => .PACKUSWB_MMXq_MMXq
  | .PACKUSWB_XMMdq_MEMdq _ _ => .PACKUSWB_XMMdq_MEMdq
  | .PACKUSWB_XMMdq_XMMdq _ _ => .PACKUSWB_XMMdq_XMMdq

def Forms.PACKUSWB.encodingFits : Forms.PACKUSWB → Bool
  | .PACKUSWB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PACKUSWB_MMXq_MMXq _ _ => true
  | .PACKUSWB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PACKUSWB_XMMdq_XMMdq _ _ => true

end X86.Syntax
