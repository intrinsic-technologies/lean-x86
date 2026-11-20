-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PAVGB-PAVGW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PAVGB where
  -- PAVGB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PAVGB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PAVGB_MMXq_MMXq: REG0=MMX_R():rw:q:i8 REG1=MMX_B():r:q:i8
  | PAVGB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PAVGB_XMMdq_MEMdq: REG0=XMM_R():rw:dq:u8 MEM0:r:dq:u8
  | PAVGB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PAVGB_XMMdq_XMMdq: REG0=XMM_R():rw:dq:u8 REG1=XMM_B():r:dq:u8
  | PAVGB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PAVGW_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q:i16
  | PAVGW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PAVGW_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q:i16
  | PAVGW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PAVGW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:u16 MEM0:r:dq:u16
  | PAVGW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PAVGW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:u16 REG1=XMM_B():r:dq:u16
  | PAVGW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PAVGB.xedForm : Forms.PAVGB → XedForm
  | .PAVGB_MMXq_MEMq _ _ => .PAVGB_MMXq_MEMq
  | .PAVGB_MMXq_MMXq _ _ => .PAVGB_MMXq_MMXq
  | .PAVGB_XMMdq_MEMdq _ _ => .PAVGB_XMMdq_MEMdq
  | .PAVGB_XMMdq_XMMdq _ _ => .PAVGB_XMMdq_XMMdq
  | .PAVGW_MMXq_MEMq _ _ => .PAVGW_MMXq_MEMq
  | .PAVGW_MMXq_MMXq _ _ => .PAVGW_MMXq_MMXq
  | .PAVGW_XMMdq_MEMdq _ _ => .PAVGW_XMMdq_MEMdq
  | .PAVGW_XMMdq_XMMdq _ _ => .PAVGW_XMMdq_XMMdq

def Forms.PAVGB.encodingFits : Forms.PAVGB → Bool
  | .PAVGB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PAVGB_MMXq_MMXq _ _ => true
  | .PAVGB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PAVGB_XMMdq_XMMdq _ _ => true
  | .PAVGW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PAVGW_MMXq_MMXq _ _ => true
  | .PAVGW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PAVGW_XMMdq_XMMdq _ _ => true

end X86.Syntax
