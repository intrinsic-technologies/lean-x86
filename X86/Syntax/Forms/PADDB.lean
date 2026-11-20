-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PADDB-PADDW-PADDD-PADDQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PADDB where
  -- PADDB_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PADDB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PADDB_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PADDB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PADDB_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PADDB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PADDB_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PADDB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PADDD_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PADDD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PADDD_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PADDD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PADDD_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PADDD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PADDD_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PADDD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PADDQ_MMXq_MEMq: REG0=MMX_R():rw:q:u64 MEM0:r:q:u64
  | PADDQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PADDQ_MMXq_MMXq: REG0=MMX_R():rw:q:u64 REG1=MMX_B():r:q:u64
  | PADDQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PADDQ_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PADDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PADDQ_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PADDQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- PADDW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PADDW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PADDW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PADDW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PADDW_XMMdq_MEMdq: REG0=XMM_R():rw:dq:i16 MEM0:r:dq:i16
  | PADDW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PADDW_XMMdq_XMMdq: REG0=XMM_R():rw:dq:i16 REG1=XMM_B():r:dq:i16
  | PADDW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PADDB.xedForm : Forms.PADDB → XedForm
  | .PADDB_MMXq_MEMq _ _ => .PADDB_MMXq_MEMq
  | .PADDB_MMXq_MMXq _ _ => .PADDB_MMXq_MMXq
  | .PADDB_XMMdq_MEMdq _ _ => .PADDB_XMMdq_MEMdq
  | .PADDB_XMMdq_XMMdq _ _ => .PADDB_XMMdq_XMMdq
  | .PADDD_MMXq_MEMq _ _ => .PADDD_MMXq_MEMq
  | .PADDD_MMXq_MMXq _ _ => .PADDD_MMXq_MMXq
  | .PADDD_XMMdq_MEMdq _ _ => .PADDD_XMMdq_MEMdq
  | .PADDD_XMMdq_XMMdq _ _ => .PADDD_XMMdq_XMMdq
  | .PADDQ_MMXq_MEMq _ _ => .PADDQ_MMXq_MEMq
  | .PADDQ_MMXq_MMXq _ _ => .PADDQ_MMXq_MMXq
  | .PADDQ_XMMdq_MEMdq _ _ => .PADDQ_XMMdq_MEMdq
  | .PADDQ_XMMdq_XMMdq _ _ => .PADDQ_XMMdq_XMMdq
  | .PADDW_MMXq_MEMq _ _ => .PADDW_MMXq_MEMq
  | .PADDW_MMXq_MMXq _ _ => .PADDW_MMXq_MMXq
  | .PADDW_XMMdq_MEMdq _ _ => .PADDW_XMMdq_MEMdq
  | .PADDW_XMMdq_XMMdq _ _ => .PADDW_XMMdq_XMMdq

def Forms.PADDB.encodingFits : Forms.PADDB → Bool
  | .PADDB_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PADDB_MMXq_MMXq _ _ => true
  | .PADDB_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PADDB_XMMdq_XMMdq _ _ => true
  | .PADDD_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PADDD_MMXq_MMXq _ _ => true
  | .PADDD_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PADDD_XMMdq_XMMdq _ _ => true
  | .PADDQ_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PADDQ_MMXq_MMXq _ _ => true
  | .PADDQ_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PADDQ_XMMdq_XMMdq _ _ => true
  | .PADDW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PADDW_MMXq_MMXq _ _ => true
  | .PADDW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PADDW_XMMdq_XMMdq _ _ => true

end X86.Syntax
