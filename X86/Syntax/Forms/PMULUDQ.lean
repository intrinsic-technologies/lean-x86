-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMULUDQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMULUDQ where
  -- PMULUDQ_MMXq_MEMq: REG0=MMX_R():rw:q:u32 MEM0:r:q:u32
  | PMULUDQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMULUDQ_MMXq_MMXq: REG0=MMX_R():rw:q:u32 REG1=MMX_B():r:q:u32
  | PMULUDQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMULUDQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PMULUDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMULUDQ_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PMULUDQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMULUDQ.xedForm : Forms.PMULUDQ → XedForm
  | .PMULUDQ_MMXq_MEMq _ _ => .PMULUDQ_MMXq_MEMq
  | .PMULUDQ_MMXq_MMXq _ _ => .PMULUDQ_MMXq_MMXq
  | .PMULUDQ_XMMdq_MEMdq _ _ => .PMULUDQ_XMMdq_MEMdq
  | .PMULUDQ_XMMdq_XMMdq _ _ => .PMULUDQ_XMMdq_XMMdq

def Forms.PMULUDQ.encodingFits : Forms.PMULUDQ → Bool
  | .PMULUDQ_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMULUDQ_MMXq_MMXq _ _ => true
  | .PMULUDQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMULUDQ_XMMdq_XMMdq _ _ => true

end X86.Syntax
