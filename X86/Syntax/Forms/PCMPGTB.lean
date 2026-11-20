-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PCMPGTB-PCMPGTW-PCMPGTD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PCMPGTB where
  -- PCMPGTB_MMXq_MEMq: REG0=MMX_R():rw:q:i8 MEM0:r:q:i8
  | PCMPGTB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PCMPGTB_MMXq_MMXq: REG0=MMX_R():rw:q:i8 REG1=MMX_B():r:q:i8
  | PCMPGTB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PCMPGTB_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i8 MEM0:r:dq:i8
  | PCMPGTB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PCMPGTB_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i8 REG1=XMM_B():r:dq:i8
  | PCMPGTB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PCMPGTD_MMXq_MEMq: REG0=MMX_R():rw:q:i32 MEM0:r:q:i32
  | PCMPGTD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PCMPGTD_MMXq_MMXq: REG0=MMX_R():rw:q:i32 REG1=MMX_B():r:q:i32
  | PCMPGTD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PCMPGTD_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i32 MEM0:r:dq:i32
  | PCMPGTD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PCMPGTD_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i32 REG1=XMM_B():r:dq:i32
  | PCMPGTD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PCMPGTW_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q:i16
  | PCMPGTW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PCMPGTW_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q:i16
  | PCMPGTW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PCMPGTW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i16 MEM0:r:dq:i16
  | PCMPGTW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PCMPGTW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i16 REG1=XMM_B():r:dq:i16
  | PCMPGTW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PCMPGTB.xedForm : Forms.PCMPGTB → XedForm
  | .PCMPGTB_MMXq_MEMq _ _ => .PCMPGTB_MMXq_MEMq
  | .PCMPGTB_MMXq_MMXq _ _ => .PCMPGTB_MMXq_MMXq
  | .PCMPGTB_XMMdq_MEMdq _ _ => .PCMPGTB_XMMdq_MEMdq
  | .PCMPGTB_XMMdq_XMMdq _ _ => .PCMPGTB_XMMdq_XMMdq
  | .PCMPGTD_MMXq_MEMq _ _ => .PCMPGTD_MMXq_MEMq
  | .PCMPGTD_MMXq_MMXq _ _ => .PCMPGTD_MMXq_MMXq
  | .PCMPGTD_XMMdq_MEMdq _ _ => .PCMPGTD_XMMdq_MEMdq
  | .PCMPGTD_XMMdq_XMMdq _ _ => .PCMPGTD_XMMdq_XMMdq
  | .PCMPGTW_MMXq_MEMq _ _ => .PCMPGTW_MMXq_MEMq
  | .PCMPGTW_MMXq_MMXq _ _ => .PCMPGTW_MMXq_MMXq
  | .PCMPGTW_XMMdq_MEMdq _ _ => .PCMPGTW_XMMdq_MEMdq
  | .PCMPGTW_XMMdq_XMMdq _ _ => .PCMPGTW_XMMdq_XMMdq

def Forms.PCMPGTB.encodingFits : Forms.PCMPGTB → Bool
  | .PCMPGTB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PCMPGTB_MMXq_MMXq _ _ => true
  | .PCMPGTB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PCMPGTB_XMMdq_XMMdq _ _ => true
  | .PCMPGTD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PCMPGTD_MMXq_MMXq _ _ => true
  | .PCMPGTD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PCMPGTD_XMMdq_XMMdq _ _ => true
  | .PCMPGTW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PCMPGTW_MMXq_MMXq _ _ => true
  | .PCMPGTW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PCMPGTW_XMMdq_XMMdq _ _ => true

end X86.Syntax
