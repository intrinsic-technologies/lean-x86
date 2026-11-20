-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSUBB-PSUBW-PSUBD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSUBB where
  -- PSUBB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSUBB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSUBB_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSUBB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSUBB_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSUBB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSUBB_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSUBB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSUBD_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSUBD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSUBD_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSUBD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSUBD_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSUBD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSUBD_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSUBD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSUBW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSUBW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSUBW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSUBW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSUBW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSUBW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSUBW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSUBW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PSUBB.xedForm : Forms.PSUBB → XedForm
  | .PSUBB_MMXq_MEMq _ _ => .PSUBB_MMXq_MEMq
  | .PSUBB_MMXq_MMXq _ _ => .PSUBB_MMXq_MMXq
  | .PSUBB_XMMdq_MEMdq _ _ => .PSUBB_XMMdq_MEMdq
  | .PSUBB_XMMdq_XMMdq _ _ => .PSUBB_XMMdq_XMMdq
  | .PSUBD_MMXq_MEMq _ _ => .PSUBD_MMXq_MEMq
  | .PSUBD_MMXq_MMXq _ _ => .PSUBD_MMXq_MMXq
  | .PSUBD_XMMdq_MEMdq _ _ => .PSUBD_XMMdq_MEMdq
  | .PSUBD_XMMdq_XMMdq _ _ => .PSUBD_XMMdq_XMMdq
  | .PSUBW_MMXq_MEMq _ _ => .PSUBW_MMXq_MEMq
  | .PSUBW_MMXq_MMXq _ _ => .PSUBW_MMXq_MMXq
  | .PSUBW_XMMdq_MEMdq _ _ => .PSUBW_XMMdq_MEMdq
  | .PSUBW_XMMdq_XMMdq _ _ => .PSUBW_XMMdq_XMMdq

def Forms.PSUBB.encodingFits : Forms.PSUBB → Bool
  | .PSUBB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSUBB_MMXq_MMXq _ _ => true
  | .PSUBB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSUBB_XMMdq_XMMdq _ _ => true
  | .PSUBD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSUBD_MMXq_MMXq _ _ => true
  | .PSUBD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSUBD_XMMdq_XMMdq _ _ => true
  | .PSUBW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSUBW_MMXq_MMXq _ _ => true
  | .PSUBW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSUBW_XMMdq_XMMdq _ _ => true

end X86.Syntax
