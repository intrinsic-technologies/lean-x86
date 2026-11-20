-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSRLW-PSRLD-PSRLQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSRLW where
  -- PSRLD_MMXq_IMMb: REG0=MMX_B():rw:q:u32 IMM0:r:b
  | PSRLD_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate)
  -- PSRLD_MMXq_MEMq: REG0=MMX_R():rw:q:u32 MEM0:r:q
  | PSRLD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSRLD_MMXq_MMXq: REG0=MMX_R():rw:q:u32 REG1=MMX_B():r:q
  | PSRLD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSRLD_XMMdq_IMMb: REG0=XMM_B():rw:dq:u32 IMM0:r:b
  | PSRLD_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  -- PSRLD_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSRLD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSRLD_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSRLD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSRLQ_MMXq_IMMb: REG0=MMX_B():rw:q:u64 IMM0:r:b
  | PSRLQ_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate)
  -- PSRLQ_MMXq_MEMq: REG0=MMX_R():rw:q:u64 MEM0:r:q
  | PSRLQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSRLQ_MMXq_MMXq: REG0=MMX_R():rw:q:u64 REG1=MMX_B():r:q
  | PSRLQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSRLQ_XMMdq_IMMb: REG0=XMM_B():rw:dq:u64 IMM0:r:b
  | PSRLQ_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  -- PSRLQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSRLQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSRLQ_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSRLQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSRLW_MMXq_IMMb: REG0=MMX_B():rw:q:u16 IMM0:r:b
  | PSRLW_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate)
  -- PSRLW_MMXq_MEMq: REG0=MMX_R():rw:q:u16 MEM0:r:q
  | PSRLW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSRLW_MMXq_MMXq: REG0=MMX_R():rw:q:u16 REG1=MMX_B():r:q
  | PSRLW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSRLW_XMMdq_IMMb: REG0=XMM_B():rw:dq:u16 IMM0:r:b
  | PSRLW_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  -- PSRLW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSRLW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSRLW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSRLW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PSRLW.xedForm : Forms.PSRLW → XedForm
  | .PSRLD_MMXq_IMMb _ _ => .PSRLD_MMXq_IMMb
  | .PSRLD_MMXq_MEMq _ _ => .PSRLD_MMXq_MEMq
  | .PSRLD_MMXq_MMXq _ _ => .PSRLD_MMXq_MMXq
  | .PSRLD_XMMdq_IMMb _ _ => .PSRLD_XMMdq_IMMb
  | .PSRLD_XMMdq_MEMdq _ _ => .PSRLD_XMMdq_MEMdq
  | .PSRLD_XMMdq_XMMdq _ _ => .PSRLD_XMMdq_XMMdq
  | .PSRLQ_MMXq_IMMb _ _ => .PSRLQ_MMXq_IMMb
  | .PSRLQ_MMXq_MEMq _ _ => .PSRLQ_MMXq_MEMq
  | .PSRLQ_MMXq_MMXq _ _ => .PSRLQ_MMXq_MMXq
  | .PSRLQ_XMMdq_IMMb _ _ => .PSRLQ_XMMdq_IMMb
  | .PSRLQ_XMMdq_MEMdq _ _ => .PSRLQ_XMMdq_MEMdq
  | .PSRLQ_XMMdq_XMMdq _ _ => .PSRLQ_XMMdq_XMMdq
  | .PSRLW_MMXq_IMMb _ _ => .PSRLW_MMXq_IMMb
  | .PSRLW_MMXq_MEMq _ _ => .PSRLW_MMXq_MEMq
  | .PSRLW_MMXq_MMXq _ _ => .PSRLW_MMXq_MMXq
  | .PSRLW_XMMdq_IMMb _ _ => .PSRLW_XMMdq_IMMb
  | .PSRLW_XMMdq_MEMdq _ _ => .PSRLW_XMMdq_MEMdq
  | .PSRLW_XMMdq_XMMdq _ _ => .PSRLW_XMMdq_XMMdq

def Forms.PSRLW.encodingFits : Forms.PSRLW → Bool
  | .PSRLD_MMXq_IMMb _ imm0 => imm0.encodingFits
  | .PSRLD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSRLD_MMXq_MMXq _ _ => true
  | .PSRLD_XMMdq_IMMb _ imm0 => imm0.encodingFits
  | .PSRLD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSRLD_XMMdq_XMMdq _ _ => true
  | .PSRLQ_MMXq_IMMb _ imm0 => imm0.encodingFits
  | .PSRLQ_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSRLQ_MMXq_MMXq _ _ => true
  | .PSRLQ_XMMdq_IMMb _ imm0 => imm0.encodingFits
  | .PSRLQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSRLQ_XMMdq_XMMdq _ _ => true
  | .PSRLW_MMXq_IMMb _ imm0 => imm0.encodingFits
  | .PSRLW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSRLW_MMXq_MMXq _ _ => true
  | .PSRLW_XMMdq_IMMb _ imm0 => imm0.encodingFits
  | .PSRLW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSRLW_XMMdq_XMMdq _ _ => true

end X86.Syntax
