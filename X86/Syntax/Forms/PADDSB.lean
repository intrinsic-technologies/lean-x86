-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PADDSB-PADDSW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PADDSB where
  -- PADDSB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PADDSB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PADDSB_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PADDSB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PADDSB_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PADDSB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PADDSB_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PADDSB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PADDSW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PADDSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PADDSW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PADDSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PADDSW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PADDSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PADDSW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PADDSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PADDSB.xedForm : Forms.PADDSB → XedForm
  | .PADDSB_MMXq_MEMq _ _ => .PADDSB_MMXq_MEMq
  | .PADDSB_MMXq_MMXq _ _ => .PADDSB_MMXq_MMXq
  | .PADDSB_XMMdq_MEMdq _ _ => .PADDSB_XMMdq_MEMdq
  | .PADDSB_XMMdq_XMMdq _ _ => .PADDSB_XMMdq_XMMdq
  | .PADDSW_MMXq_MEMq _ _ => .PADDSW_MMXq_MEMq
  | .PADDSW_MMXq_MMXq _ _ => .PADDSW_MMXq_MMXq
  | .PADDSW_XMMdq_MEMdq _ _ => .PADDSW_XMMdq_MEMdq
  | .PADDSW_XMMdq_XMMdq _ _ => .PADDSW_XMMdq_XMMdq

def Forms.PADDSB.encodingFits : Forms.PADDSB → Bool
  | .PADDSB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PADDSB_MMXq_MMXq _ _ => true
  | .PADDSB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PADDSB_XMMdq_XMMdq _ _ => true
  | .PADDSW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PADDSW_MMXq_MMXq _ _ => true
  | .PADDSW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PADDSW_XMMdq_XMMdq _ _ => true

end X86.Syntax
