-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PUNPCKLBW-PUNPCKLWD-PUNPCKLDQ-PUNPCKLQDQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PUNPCKLBW where
  -- PUNPCKLBW_MMXq_MEMd: REG0=MMX_R():rw:q:u8 MEM0:r:d:u8
  | PUNPCKLBW_MMXq_MEMd (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PUNPCKLBW_MMXq_MMXd: REG0=MMX_R():rw:q:u8 REG1=MMX_B():r:d:u8
  | PUNPCKLBW_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PUNPCKLBW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PUNPCKLBW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PUNPCKLBW_XMMdq_XMMq: REG0=XMM_R():rw:dq REG1=XMM_B():r:q
  | PUNPCKLBW_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PUNPCKLDQ_MMXq_MEMd: REG0=MMX_R():rw:q:u32 MEM0:r:d:u32
  | PUNPCKLDQ_MMXq_MEMd (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PUNPCKLDQ_MMXq_MMXd: REG0=MMX_R():rw:q:u32 REG1=MMX_B():r:d:u32
  | PUNPCKLDQ_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PUNPCKLDQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PUNPCKLDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PUNPCKLDQ_XMMdq_XMMq: REG0=XMM_R():rw:dq REG1=XMM_B():r:q
  | PUNPCKLDQ_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PUNPCKLQDQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PUNPCKLQDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PUNPCKLQDQ_XMMdq_XMMq: REG0=XMM_R():rw:dq REG1=XMM_B():r:q
  | PUNPCKLQDQ_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PUNPCKLWD_MMXq_MEMd: REG0=MMX_R():rw:q:u16 MEM0:r:d:u16
  | PUNPCKLWD_MMXq_MEMd (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PUNPCKLWD_MMXq_MMXd: REG0=MMX_R():rw:q:u16 REG1=MMX_B():r:d:u16
  | PUNPCKLWD_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PUNPCKLWD_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PUNPCKLWD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PUNPCKLWD_XMMdq_XMMq: REG0=XMM_R():rw:dq REG1=XMM_B():r:q
  | PUNPCKLWD_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PUNPCKLBW.xedForm : Forms.PUNPCKLBW → XedForm
  | .PUNPCKLBW_MMXq_MEMd _ _ => .PUNPCKLBW_MMXq_MEMd
  | .PUNPCKLBW_MMXq_MMXd _ _ => .PUNPCKLBW_MMXq_MMXd
  | .PUNPCKLBW_XMMdq_MEMdq _ _ => .PUNPCKLBW_XMMdq_MEMdq
  | .PUNPCKLBW_XMMdq_XMMq _ _ => .PUNPCKLBW_XMMdq_XMMq
  | .PUNPCKLDQ_MMXq_MEMd _ _ => .PUNPCKLDQ_MMXq_MEMd
  | .PUNPCKLDQ_MMXq_MMXd _ _ => .PUNPCKLDQ_MMXq_MMXd
  | .PUNPCKLDQ_XMMdq_MEMdq _ _ => .PUNPCKLDQ_XMMdq_MEMdq
  | .PUNPCKLDQ_XMMdq_XMMq _ _ => .PUNPCKLDQ_XMMdq_XMMq
  | .PUNPCKLQDQ_XMMdq_MEMdq _ _ => .PUNPCKLQDQ_XMMdq_MEMdq
  | .PUNPCKLQDQ_XMMdq_XMMq _ _ => .PUNPCKLQDQ_XMMdq_XMMq
  | .PUNPCKLWD_MMXq_MEMd _ _ => .PUNPCKLWD_MMXq_MEMd
  | .PUNPCKLWD_MMXq_MMXd _ _ => .PUNPCKLWD_MMXq_MMXd
  | .PUNPCKLWD_XMMdq_MEMdq _ _ => .PUNPCKLWD_XMMdq_MEMdq
  | .PUNPCKLWD_XMMdq_XMMq _ _ => .PUNPCKLWD_XMMdq_XMMq

def Forms.PUNPCKLBW.encodingFits : Forms.PUNPCKLBW → Bool
  | .PUNPCKLBW_MMXq_MEMd _ mem0 => mem0.encodingFits
  | .PUNPCKLBW_MMXq_MMXd _ _ => true
  | .PUNPCKLBW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PUNPCKLBW_XMMdq_XMMq _ _ => true
  | .PUNPCKLDQ_MMXq_MEMd _ mem0 => mem0.encodingFits
  | .PUNPCKLDQ_MMXq_MMXd _ _ => true
  | .PUNPCKLDQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PUNPCKLDQ_XMMdq_XMMq _ _ => true
  | .PUNPCKLQDQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PUNPCKLQDQ_XMMdq_XMMq _ _ => true
  | .PUNPCKLWD_MMXq_MEMd _ mem0 => mem0.encodingFits
  | .PUNPCKLWD_MMXq_MMXd _ _ => true
  | .PUNPCKLWD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PUNPCKLWD_XMMdq_XMMq _ _ => true

end X86.Syntax
