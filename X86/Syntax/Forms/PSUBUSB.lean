-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSUBUSB-PSUBUSW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSUBUSB where
  -- PSUBUSB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSUBUSB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSUBUSB_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSUBUSB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSUBUSB_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSUBUSB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSUBUSB_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSUBUSB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSUBUSW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSUBUSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSUBUSW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSUBUSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSUBUSW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSUBUSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSUBUSW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSUBUSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PSUBUSB.xedForm : Forms.PSUBUSB → XedForm
  | .PSUBUSB_MMXq_MEMq _ _ => .PSUBUSB_MMXq_MEMq
  | .PSUBUSB_MMXq_MMXq _ _ => .PSUBUSB_MMXq_MMXq
  | .PSUBUSB_XMMdq_MEMdq _ _ => .PSUBUSB_XMMdq_MEMdq
  | .PSUBUSB_XMMdq_XMMdq _ _ => .PSUBUSB_XMMdq_XMMdq
  | .PSUBUSW_MMXq_MEMq _ _ => .PSUBUSW_MMXq_MEMq
  | .PSUBUSW_MMXq_MMXq _ _ => .PSUBUSW_MMXq_MMXq
  | .PSUBUSW_XMMdq_MEMdq _ _ => .PSUBUSW_XMMdq_MEMdq
  | .PSUBUSW_XMMdq_XMMdq _ _ => .PSUBUSW_XMMdq_XMMdq

def Forms.PSUBUSB.encodingFits : Forms.PSUBUSB → Bool
  | .PSUBUSB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSUBUSB_MMXq_MMXq _ _ => true
  | .PSUBUSB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSUBUSB_XMMdq_XMMdq _ _ => true
  | .PSUBUSW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSUBUSW_MMXq_MMXq _ _ => true
  | .PSUBUSW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSUBUSW_XMMdq_XMMdq _ _ => true

end X86.Syntax
