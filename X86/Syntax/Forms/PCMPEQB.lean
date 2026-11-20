-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PCMPEQB-PCMPEQW-PCMPEQD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PCMPEQB where
  -- PCMPEQB_MMXq_MEMq: REG0=MMX_R():rw:q:i8 MEM0:r:q:i8
  | PCMPEQB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PCMPEQB_MMXq_MMXq: REG0=MMX_R():rw:q:i8 REG1=MMX_B():r:q:i8
  | PCMPEQB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PCMPEQB_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i8 MEM0:r:dq:i8
  | PCMPEQB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PCMPEQB_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i8 REG1=XMM_B():r:dq:i8
  | PCMPEQB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PCMPEQD_MMXq_MEMq: REG0=MMX_R():rw:q:i32 MEM0:r:q:i32
  | PCMPEQD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PCMPEQD_MMXq_MMXq: REG0=MMX_R():rw:q:i32 REG1=MMX_B():r:q:i32
  | PCMPEQD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PCMPEQD_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i32 MEM0:r:dq:i32
  | PCMPEQD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PCMPEQD_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i32 REG1=XMM_B():r:dq:i32
  | PCMPEQD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PCMPEQW_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q:i16
  | PCMPEQW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PCMPEQW_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q:i16
  | PCMPEQW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PCMPEQW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i16 MEM0:r:dq:i16
  | PCMPEQW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PCMPEQW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i16 REG1=XMM_B():r:dq:i16
  | PCMPEQW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PCMPEQB.xedForm : Forms.PCMPEQB → XedForm
  | .PCMPEQB_MMXq_MEMq _ _ => .PCMPEQB_MMXq_MEMq
  | .PCMPEQB_MMXq_MMXq _ _ => .PCMPEQB_MMXq_MMXq
  | .PCMPEQB_XMMdq_MEMdq _ _ => .PCMPEQB_XMMdq_MEMdq
  | .PCMPEQB_XMMdq_XMMdq _ _ => .PCMPEQB_XMMdq_XMMdq
  | .PCMPEQD_MMXq_MEMq _ _ => .PCMPEQD_MMXq_MEMq
  | .PCMPEQD_MMXq_MMXq _ _ => .PCMPEQD_MMXq_MMXq
  | .PCMPEQD_XMMdq_MEMdq _ _ => .PCMPEQD_XMMdq_MEMdq
  | .PCMPEQD_XMMdq_XMMdq _ _ => .PCMPEQD_XMMdq_XMMdq
  | .PCMPEQW_MMXq_MEMq _ _ => .PCMPEQW_MMXq_MEMq
  | .PCMPEQW_MMXq_MMXq _ _ => .PCMPEQW_MMXq_MMXq
  | .PCMPEQW_XMMdq_MEMdq _ _ => .PCMPEQW_XMMdq_MEMdq
  | .PCMPEQW_XMMdq_XMMdq _ _ => .PCMPEQW_XMMdq_XMMdq

def Forms.PCMPEQB.encodingFits : Forms.PCMPEQB → Bool
  | .PCMPEQB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PCMPEQB_MMXq_MMXq _ _ => true
  | .PCMPEQB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PCMPEQB_XMMdq_XMMdq _ _ => true
  | .PCMPEQD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PCMPEQD_MMXq_MMXq _ _ => true
  | .PCMPEQD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PCMPEQD_XMMdq_XMMdq _ _ => true
  | .PCMPEQW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PCMPEQW_MMXq_MMXq _ _ => true
  | .PCMPEQW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PCMPEQW_XMMdq_XMMdq _ _ => true

end X86.Syntax
