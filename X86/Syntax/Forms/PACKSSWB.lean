-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PACKSSWB-PACKSSDW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PACKSSWB where
  -- PACKSSDW_MMXq_MEMq: REG0=MMX_R():rw:q:i32 MEM0:r:q:i32
  | PACKSSDW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PACKSSDW_MMXq_MMXq: REG0=MMX_R():rw:q:i32 REG1=MMX_B():r:q:i32
  | PACKSSDW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PACKSSDW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i32 MEM0:r:dq:i32
  | PACKSSDW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PACKSSDW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i32 REG1=XMM_B():r:dq:i32
  | PACKSSDW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PACKSSWB_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q:i16
  | PACKSSWB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PACKSSWB_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q:i16
  | PACKSSWB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PACKSSWB_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i16 MEM0:r:dq:i16
  | PACKSSWB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PACKSSWB_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i16 REG1=XMM_B():r:dq:i16
  | PACKSSWB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PACKSSWB.xedForm : Forms.PACKSSWB → XedForm
  | .PACKSSDW_MMXq_MEMq _ _ => .PACKSSDW_MMXq_MEMq
  | .PACKSSDW_MMXq_MMXq _ _ => .PACKSSDW_MMXq_MMXq
  | .PACKSSDW_XMMdq_MEMdq _ _ => .PACKSSDW_XMMdq_MEMdq
  | .PACKSSDW_XMMdq_XMMdq _ _ => .PACKSSDW_XMMdq_XMMdq
  | .PACKSSWB_MMXq_MEMq _ _ => .PACKSSWB_MMXq_MEMq
  | .PACKSSWB_MMXq_MMXq _ _ => .PACKSSWB_MMXq_MMXq
  | .PACKSSWB_XMMdq_MEMdq _ _ => .PACKSSWB_XMMdq_MEMdq
  | .PACKSSWB_XMMdq_XMMdq _ _ => .PACKSSWB_XMMdq_XMMdq

def Forms.PACKSSWB.encodingFits : Forms.PACKSSWB → Bool
  | .PACKSSDW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PACKSSDW_MMXq_MMXq _ _ => true
  | .PACKSSDW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PACKSSDW_XMMdq_XMMdq _ _ => true
  | .PACKSSWB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PACKSSWB_MMXq_MMXq _ _ => true
  | .PACKSSWB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PACKSSWB_XMMdq_XMMdq _ _ => true

end X86.Syntax
