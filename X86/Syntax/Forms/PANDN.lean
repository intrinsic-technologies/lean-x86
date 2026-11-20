-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PANDN.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PANDN where
  -- PANDN_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PANDN_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PANDN_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PANDN_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PANDN_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PANDN_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PANDN_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PANDN_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PANDN.xedForm : Forms.PANDN → XedForm
  | .PANDN_MMXq_MEMq _ _ => .PANDN_MMXq_MEMq
  | .PANDN_MMXq_MMXq _ _ => .PANDN_MMXq_MMXq
  | .PANDN_XMMdq_MEMdq _ _ => .PANDN_XMMdq_MEMdq
  | .PANDN_XMMdq_XMMdq _ _ => .PANDN_XMMdq_XMMdq

def Forms.PANDN.encodingFits : Forms.PANDN → Bool
  | .PANDN_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PANDN_MMXq_MMXq _ _ => true
  | .PANDN_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PANDN_XMMdq_XMMdq _ _ => true

end X86.Syntax
