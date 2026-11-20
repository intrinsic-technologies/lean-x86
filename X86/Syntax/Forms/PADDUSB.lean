-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PADDUSB-PADDUSW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PADDUSB where
  -- PADDUSB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PADDUSB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PADDUSB_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PADDUSB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PADDUSB_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PADDUSB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PADDUSB_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PADDUSB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PADDUSW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PADDUSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PADDUSW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PADDUSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PADDUSW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PADDUSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PADDUSW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PADDUSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PADDUSB.xedForm : Forms.PADDUSB → XedForm
  | .PADDUSB_MMXq_MEMq _ _ => .PADDUSB_MMXq_MEMq
  | .PADDUSB_MMXq_MMXq _ _ => .PADDUSB_MMXq_MMXq
  | .PADDUSB_XMMdq_MEMdq _ _ => .PADDUSB_XMMdq_MEMdq
  | .PADDUSB_XMMdq_XMMdq _ _ => .PADDUSB_XMMdq_XMMdq
  | .PADDUSW_MMXq_MEMq _ _ => .PADDUSW_MMXq_MEMq
  | .PADDUSW_MMXq_MMXq _ _ => .PADDUSW_MMXq_MMXq
  | .PADDUSW_XMMdq_MEMdq _ _ => .PADDUSW_XMMdq_MEMdq
  | .PADDUSW_XMMdq_XMMdq _ _ => .PADDUSW_XMMdq_XMMdq

def Forms.PADDUSB.encodingFits : Forms.PADDUSB → Bool
  | .PADDUSB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PADDUSB_MMXq_MMXq _ _ => true
  | .PADDUSB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PADDUSB_XMMdq_XMMdq _ _ => true
  | .PADDUSW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PADDUSW_MMXq_MMXq _ _ => true
  | .PADDUSW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PADDUSW_XMMdq_XMMdq _ _ => true

end X86.Syntax
