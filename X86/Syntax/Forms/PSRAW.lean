-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSRAW-PSRAD-PSRAQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSRAW where
  -- PSRAD_MMXq_IMMb: REG0=MMX_B():rw:q:i32 IMM0:r:b
  | PSRAD_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate)
  -- PSRAD_MMXq_MEMq: REG0=MMX_R():rw:q:i32 MEM0:r:q
  | PSRAD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSRAD_MMXq_MMXq: REG0=MMX_R():rw:q:i32 REG1=MMX_B():r:q
  | PSRAD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSRAD_XMMdq_IMMb: REG0=XMM_B():rw:dq:i32 IMM0:r:b
  | PSRAD_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  -- PSRAD_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i32 MEM0:r:dq:u64
  | PSRAD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSRAD_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i32 REG1=XMM_B():r:dq:u64
  | PSRAD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PSRAW_MMXq_IMMb: REG0=MMX_B():rw:q:i16 IMM0:r:b
  | PSRAW_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate)
  -- PSRAW_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q
  | PSRAW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSRAW_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q
  | PSRAW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSRAW_XMMdq_IMMb: REG0=XMM_B():rw:dq:i16 IMM0:r:b
  | PSRAW_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  -- PSRAW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i16 MEM0:r:dq:u64
  | PSRAW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSRAW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i16 REG1=XMM_B():r:dq:u64
  | PSRAW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PSRAW.xedForm : Forms.PSRAW → XedForm
  | .PSRAD_MMXq_IMMb _ _ => .PSRAD_MMXq_IMMb
  | .PSRAD_MMXq_MEMq _ _ => .PSRAD_MMXq_MEMq
  | .PSRAD_MMXq_MMXq _ _ => .PSRAD_MMXq_MMXq
  | .PSRAD_XMMdq_IMMb _ _ => .PSRAD_XMMdq_IMMb
  | .PSRAD_XMMdq_MEMdq _ _ => .PSRAD_XMMdq_MEMdq
  | .PSRAD_XMMdq_XMMdq _ _ => .PSRAD_XMMdq_XMMdq
  | .PSRAW_MMXq_IMMb _ _ => .PSRAW_MMXq_IMMb
  | .PSRAW_MMXq_MEMq _ _ => .PSRAW_MMXq_MEMq
  | .PSRAW_MMXq_MMXq _ _ => .PSRAW_MMXq_MMXq
  | .PSRAW_XMMdq_IMMb _ _ => .PSRAW_XMMdq_IMMb
  | .PSRAW_XMMdq_MEMdq _ _ => .PSRAW_XMMdq_MEMdq
  | .PSRAW_XMMdq_XMMdq _ _ => .PSRAW_XMMdq_XMMdq

def Forms.PSRAW.encodingFits : Forms.PSRAW → Bool
  | .PSRAD_MMXq_IMMb _ imm0 => imm0.encodingFits
  | .PSRAD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSRAD_MMXq_MMXq _ _ => true
  | .PSRAD_XMMdq_IMMb _ imm0 => imm0.encodingFits
  | .PSRAD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSRAD_XMMdq_XMMdq _ _ => true
  | .PSRAW_MMXq_IMMb _ imm0 => imm0.encodingFits
  | .PSRAW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSRAW_MMXq_MMXq _ _ => true
  | .PSRAW_XMMdq_IMMb _ imm0 => imm0.encodingFits
  | .PSRAW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSRAW_XMMdq_XMMdq _ _ => true

end X86.Syntax
