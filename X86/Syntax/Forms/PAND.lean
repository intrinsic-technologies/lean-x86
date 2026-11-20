-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PAND.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PAND where
  -- PAND_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PAND_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PAND_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PAND_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PAND_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PAND_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PAND_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PAND_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PAND.xedForm : Forms.PAND → XedForm
  | .PAND_MMXq_MEMq _ _ => .PAND_MMXq_MEMq
  | .PAND_MMXq_MMXq _ _ => .PAND_MMXq_MMXq
  | .PAND_XMMdq_MEMdq _ _ => .PAND_XMMdq_MEMdq
  | .PAND_XMMdq_XMMdq _ _ => .PAND_XMMdq_XMMdq

def Forms.PAND.encodingFits : Forms.PAND → Bool
  | .PAND_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PAND_MMXq_MMXq _ _ => true
  | .PAND_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PAND_XMMdq_XMMdq _ _ => true

end X86.Syntax
