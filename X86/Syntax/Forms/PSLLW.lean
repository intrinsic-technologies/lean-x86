-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSLLW-PSLLD-PSLLQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSLLW where
  -- PSLLD_MMXq_IMMb: REG0=MMX_B():rw:q:u32 IMM0:r:b
  | PSLLD_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate)
  -- PSLLD_MMXq_MEMq: REG0=MMX_R():rw:q:u32 MEM0:r:q
  | PSLLD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSLLD_MMXq_MMXq: REG0=MMX_R():rw:q:u32 REG1=MMX_B():r:q
  | PSLLD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSLLD_XMMdq_IMMb: REG0=XMM_B():rw:dq:u32 IMM0:r:b
  | PSLLD_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  -- PSLLD_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSLLD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSLLD_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSLLD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSLLQ_MMXq_IMMb: REG0=MMX_B():rw:q:u64 IMM0:r:b
  | PSLLQ_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate)
  -- PSLLQ_MMXq_MEMq: REG0=MMX_R():rw:q:u64 MEM0:r:q
  | PSLLQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSLLQ_MMXq_MMXq: REG0=MMX_R():rw:q:u64 REG1=MMX_B():r:q
  | PSLLQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSLLQ_XMMdq_IMMb: REG0=XMM_B():rw:dq:u64 IMM0:r:b
  | PSLLQ_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  -- PSLLQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq:u64 MEM0:r:dq:u64
  | PSLLQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSLLQ_XMMdq_XMMdq: REG0=XMM_R():rw:dq:u64 REG1=XMM_B():r:dq:u64
  | PSLLQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSLLW_MMXq_IMMb: REG0=MMX_B():rw:q:u16 IMM0:r:b
  | PSLLW_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate)
  -- PSLLW_MMXq_MEMq: REG0=MMX_R():rw:q:u16 MEM0:r:q
  | PSLLW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSLLW_MMXq_MMXq: REG0=MMX_R():rw:q:u16 REG1=MMX_B():r:q
  | PSLLW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSLLW_XMMdq_IMMb: REG0=XMM_B():rw:dq:u16 IMM0:r:b
  | PSLLW_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  -- PSLLW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:u16 MEM0:r:dq
  | PSLLW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSLLW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:u16 REG1=XMM_B():r:dq
  | PSLLW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PSLLW.xedForm : Forms.PSLLW → XedForm
  | .PSLLD_MMXq_IMMb _ _ => .PSLLD_MMXq_IMMb
  | .PSLLD_MMXq_MEMq _ _ => .PSLLD_MMXq_MEMq
  | .PSLLD_MMXq_MMXq _ _ => .PSLLD_MMXq_MMXq
  | .PSLLD_XMMdq_IMMb _ _ => .PSLLD_XMMdq_IMMb
  | .PSLLD_XMMdq_MEMdq _ _ => .PSLLD_XMMdq_MEMdq
  | .PSLLD_XMMdq_XMMdq _ _ => .PSLLD_XMMdq_XMMdq
  | .PSLLQ_MMXq_IMMb _ _ => .PSLLQ_MMXq_IMMb
  | .PSLLQ_MMXq_MEMq _ _ => .PSLLQ_MMXq_MEMq
  | .PSLLQ_MMXq_MMXq _ _ => .PSLLQ_MMXq_MMXq
  | .PSLLQ_XMMdq_IMMb _ _ => .PSLLQ_XMMdq_IMMb
  | .PSLLQ_XMMdq_MEMdq _ _ => .PSLLQ_XMMdq_MEMdq
  | .PSLLQ_XMMdq_XMMdq _ _ => .PSLLQ_XMMdq_XMMdq
  | .PSLLW_MMXq_IMMb _ _ => .PSLLW_MMXq_IMMb
  | .PSLLW_MMXq_MEMq _ _ => .PSLLW_MMXq_MEMq
  | .PSLLW_MMXq_MMXq _ _ => .PSLLW_MMXq_MMXq
  | .PSLLW_XMMdq_IMMb _ _ => .PSLLW_XMMdq_IMMb
  | .PSLLW_XMMdq_MEMdq _ _ => .PSLLW_XMMdq_MEMdq
  | .PSLLW_XMMdq_XMMdq _ _ => .PSLLW_XMMdq_XMMdq

def Forms.PSLLW.encodingFits : Forms.PSLLW → Bool
  | .PSLLD_MMXq_IMMb _ imm0 => imm0.encodingFits
  | .PSLLD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSLLD_MMXq_MMXq _ _ => true
  | .PSLLD_XMMdq_IMMb _ imm0 => imm0.encodingFits
  | .PSLLD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSLLD_XMMdq_XMMdq _ _ => true
  | .PSLLQ_MMXq_IMMb _ imm0 => imm0.encodingFits
  | .PSLLQ_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSLLQ_MMXq_MMXq _ _ => true
  | .PSLLQ_XMMdq_IMMb _ imm0 => imm0.encodingFits
  | .PSLLQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSLLQ_XMMdq_XMMdq _ _ => true
  | .PSLLW_MMXq_IMMb _ imm0 => imm0.encodingFits
  | .PSLLW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSLLW_MMXq_MMXq _ _ => true
  | .PSLLW_XMMdq_IMMb _ imm0 => imm0.encodingFits
  | .PSLLW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSLLW_XMMdq_XMMdq _ _ => true

end X86.Syntax
