-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSUBSB-PSUBSW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSUBSB where
  -- PSUBSB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSUBSB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSUBSB_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSUBSB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSUBSB_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSUBSB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSUBSB_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSUBSB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSUBSW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSUBSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSUBSW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSUBSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSUBSW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSUBSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSUBSW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSUBSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PSUBSB.xedForm : Forms.PSUBSB → XedForm
  | .PSUBSB_MMXq_MEMq _ _ => .PSUBSB_MMXq_MEMq
  | .PSUBSB_MMXq_MMXq _ _ => .PSUBSB_MMXq_MMXq
  | .PSUBSB_XMMdq_MEMdq _ _ => .PSUBSB_XMMdq_MEMdq
  | .PSUBSB_XMMdq_XMMdq _ _ => .PSUBSB_XMMdq_XMMdq
  | .PSUBSW_MMXq_MEMq _ _ => .PSUBSW_MMXq_MEMq
  | .PSUBSW_MMXq_MMXq _ _ => .PSUBSW_MMXq_MMXq
  | .PSUBSW_XMMdq_MEMdq _ _ => .PSUBSW_XMMdq_MEMdq
  | .PSUBSW_XMMdq_XMMdq _ _ => .PSUBSW_XMMdq_XMMdq

def Forms.PSUBSB.encodingFits : Forms.PSUBSB → Bool
  | .PSUBSB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSUBSB_MMXq_MMXq _ _ => true
  | .PSUBSB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSUBSB_XMMdq_XMMdq _ _ => true
  | .PSUBSW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSUBSW_MMXq_MMXq _ _ => true
  | .PSUBSW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSUBSW_XMMdq_XMMdq _ _ => true

end X86.Syntax
