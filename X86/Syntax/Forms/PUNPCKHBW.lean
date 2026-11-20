-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PUNPCKHBW-PUNPCKHWD-PUNPCKHDQ-PUNPCKHQDQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PUNPCKHBW where
  -- PUNPCKHBW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PUNPCKHBW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PUNPCKHBW_MMXq_MMXd: REG0=MMX_R():rw:q REG1=MMX_B():r:d
  | PUNPCKHBW_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PUNPCKHBW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PUNPCKHBW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PUNPCKHBW_XMMdq_XMMq: REG0=XMM_R():rw:dq REG1=XMM_B():r:q
  | PUNPCKHBW_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PUNPCKHDQ_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PUNPCKHDQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PUNPCKHDQ_MMXq_MMXd: REG0=MMX_R():rw:q REG1=MMX_B():r:d
  | PUNPCKHDQ_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PUNPCKHDQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PUNPCKHDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PUNPCKHDQ_XMMdq_XMMq: REG0=XMM_R():rw:dq REG1=XMM_B():r:q
  | PUNPCKHDQ_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PUNPCKHQDQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PUNPCKHQDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PUNPCKHQDQ_XMMdq_XMMq: REG0=XMM_R():rw:dq REG1=XMM_B():r:q
  | PUNPCKHQDQ_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PUNPCKHWD_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PUNPCKHWD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PUNPCKHWD_MMXq_MMXd: REG0=MMX_R():rw:q REG1=MMX_B():r:d
  | PUNPCKHWD_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PUNPCKHWD_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PUNPCKHWD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PUNPCKHWD_XMMdq_XMMq: REG0=XMM_R():rw:dq REG1=XMM_B():r:q
  | PUNPCKHWD_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PUNPCKHBW.xedForm : Forms.PUNPCKHBW → XedForm
  | .PUNPCKHBW_MMXq_MEMq _ _ => .PUNPCKHBW_MMXq_MEMq
  | .PUNPCKHBW_MMXq_MMXd _ _ => .PUNPCKHBW_MMXq_MMXd
  | .PUNPCKHBW_XMMdq_MEMdq _ _ => .PUNPCKHBW_XMMdq_MEMdq
  | .PUNPCKHBW_XMMdq_XMMq _ _ => .PUNPCKHBW_XMMdq_XMMq
  | .PUNPCKHDQ_MMXq_MEMq _ _ => .PUNPCKHDQ_MMXq_MEMq
  | .PUNPCKHDQ_MMXq_MMXd _ _ => .PUNPCKHDQ_MMXq_MMXd
  | .PUNPCKHDQ_XMMdq_MEMdq _ _ => .PUNPCKHDQ_XMMdq_MEMdq
  | .PUNPCKHDQ_XMMdq_XMMq _ _ => .PUNPCKHDQ_XMMdq_XMMq
  | .PUNPCKHQDQ_XMMdq_MEMdq _ _ => .PUNPCKHQDQ_XMMdq_MEMdq
  | .PUNPCKHQDQ_XMMdq_XMMq _ _ => .PUNPCKHQDQ_XMMdq_XMMq
  | .PUNPCKHWD_MMXq_MEMq _ _ => .PUNPCKHWD_MMXq_MEMq
  | .PUNPCKHWD_MMXq_MMXd _ _ => .PUNPCKHWD_MMXq_MMXd
  | .PUNPCKHWD_XMMdq_MEMdq _ _ => .PUNPCKHWD_XMMdq_MEMdq
  | .PUNPCKHWD_XMMdq_XMMq _ _ => .PUNPCKHWD_XMMdq_XMMq

def Forms.PUNPCKHBW.encodingFits : Forms.PUNPCKHBW → Bool
  | .PUNPCKHBW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PUNPCKHBW_MMXq_MMXd _ _ => true
  | .PUNPCKHBW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PUNPCKHBW_XMMdq_XMMq _ _ => true
  | .PUNPCKHDQ_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PUNPCKHDQ_MMXq_MMXd _ _ => true
  | .PUNPCKHDQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PUNPCKHDQ_XMMdq_XMMq _ _ => true
  | .PUNPCKHQDQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PUNPCKHQDQ_XMMdq_XMMq _ _ => true
  | .PUNPCKHWD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PUNPCKHWD_MMXq_MMXd _ _ => true
  | .PUNPCKHWD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PUNPCKHWD_XMMdq_XMMq _ _ => true

end X86.Syntax
