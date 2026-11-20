-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVQ where
  -- MOVQ_GPR64_MMXq: REG0=GPR64_B():w REG1=MMX_R():r:q
  | MOVQ_GPR64_MMXq (reg0 : Registers.GPR64) (reg1 : Registers.MMX)
  -- MOVQ_GPR64_XMMq: REG0=GPR64_B():w REG1=XMM_R():r:q
  | MOVQ_GPR64_XMMq (reg0 : Registers.GPR64) (reg1 : Registers.XMM)
  -- MOVQ_MEMq_MMXq_0F7E: MEM0:w:q REG0=MMX_R():r:q
  | MOVQ_MEMq_MMXq_0F7E (mem0 : MemoryOperand) (reg0 : Registers.MMX)
  -- MOVQ_MEMq_MMXq_0F7F: MEM0:w:q REG0=MMX_R():r:q
  | MOVQ_MEMq_MMXq_0F7F (mem0 : MemoryOperand) (reg0 : Registers.MMX)
  -- MOVQ_MEMq_XMMq_0F7E: MEM0:w:q REG0=XMM_R():r:q
  | MOVQ_MEMq_XMMq_0F7E (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVQ_MEMq_XMMq_0FD6: MEM0:w:q REG0=XMM_R():r:q
  | MOVQ_MEMq_XMMq_0FD6 (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVQ_MMXq_GPR64: REG0=MMX_R():w:q REG1=GPR64_B():r
  | MOVQ_MMXq_GPR64 (reg0 : Registers.MMX) (reg1 : Registers.GPR64)
  -- MOVQ_MMXq_MEMq_0F6E: REG0=MMX_R():w:q MEM0:r:q
  | MOVQ_MMXq_MEMq_0F6E (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- MOVQ_MMXq_MEMq_0F6F: REG0=MMX_R():w:q MEM0:r:q
  | MOVQ_MMXq_MEMq_0F6F (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- MOVQ_MMXq_MMXq_0F6F: REG0=MMX_R():w:q REG1=MMX_B():r:q
  | MOVQ_MMXq_MMXq_0F6F (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- MOVQ_MMXq_MMXq_0F7F: REG0=MMX_B():w:q REG1=MMX_R():r:q
  | MOVQ_MMXq_MMXq_0F7F (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- MOVQ_XMMdq_GPR64: REG0=XMM_R():w:dq REG1=GPR64_B():r
  | MOVQ_XMMdq_GPR64 (reg0 : Registers.XMM) (reg1 : Registers.GPR64)
  -- MOVQ_XMMdq_MEMq_0F6E: REG0=XMM_R():w:dq MEM0:r:q
  | MOVQ_XMMdq_MEMq_0F6E (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVQ_XMMdq_MEMq_0F7E: REG0=XMM_R():w:dq MEM0:r:q
  | MOVQ_XMMdq_MEMq_0F7E (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVQ_XMMdq_XMMq_0F7E: REG0=XMM_R():w:dq REG1=XMM_B():r:q
  | MOVQ_XMMdq_XMMq_0F7E (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVQ_XMMdq_XMMq_0FD6: REG0=XMM_B():w:dq REG1=XMM_R():r:q
  | MOVQ_XMMdq_XMMq_0FD6 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVQ.xedForm : Forms.MOVQ → XedForm
  | .MOVQ_GPR64_MMXq _ _ => .MOVQ_GPR64_MMXq
  | .MOVQ_GPR64_XMMq _ _ => .MOVQ_GPR64_XMMq
  | .MOVQ_MEMq_MMXq_0F7E _ _ => .MOVQ_MEMq_MMXq_0F7E
  | .MOVQ_MEMq_MMXq_0F7F _ _ => .MOVQ_MEMq_MMXq_0F7F
  | .MOVQ_MEMq_XMMq_0F7E _ _ => .MOVQ_MEMq_XMMq_0F7E
  | .MOVQ_MEMq_XMMq_0FD6 _ _ => .MOVQ_MEMq_XMMq_0FD6
  | .MOVQ_MMXq_GPR64 _ _ => .MOVQ_MMXq_GPR64
  | .MOVQ_MMXq_MEMq_0F6E _ _ => .MOVQ_MMXq_MEMq_0F6E
  | .MOVQ_MMXq_MEMq_0F6F _ _ => .MOVQ_MMXq_MEMq_0F6F
  | .MOVQ_MMXq_MMXq_0F6F _ _ => .MOVQ_MMXq_MMXq_0F6F
  | .MOVQ_MMXq_MMXq_0F7F _ _ => .MOVQ_MMXq_MMXq_0F7F
  | .MOVQ_XMMdq_GPR64 _ _ => .MOVQ_XMMdq_GPR64
  | .MOVQ_XMMdq_MEMq_0F6E _ _ => .MOVQ_XMMdq_MEMq_0F6E
  | .MOVQ_XMMdq_MEMq_0F7E _ _ => .MOVQ_XMMdq_MEMq_0F7E
  | .MOVQ_XMMdq_XMMq_0F7E _ _ => .MOVQ_XMMdq_XMMq_0F7E
  | .MOVQ_XMMdq_XMMq_0FD6 _ _ => .MOVQ_XMMdq_XMMq_0FD6

def Forms.MOVQ.encodingFits : Forms.MOVQ → Bool
  | .MOVQ_GPR64_MMXq _ _ => true
  | .MOVQ_GPR64_XMMq _ _ => true
  | .MOVQ_MEMq_MMXq_0F7E mem0 _ => mem0.encodingFits
  | .MOVQ_MEMq_MMXq_0F7F mem0 _ => mem0.encodingFits
  | .MOVQ_MEMq_XMMq_0F7E mem0 _ => mem0.encodingFits
  | .MOVQ_MEMq_XMMq_0FD6 mem0 _ => mem0.encodingFits
  | .MOVQ_MMXq_GPR64 _ _ => true
  | .MOVQ_MMXq_MEMq_0F6E _ mem0 => mem0.encodingFits
  | .MOVQ_MMXq_MEMq_0F6F _ mem0 => mem0.encodingFits
  | .MOVQ_MMXq_MMXq_0F6F _ _ => true
  | .MOVQ_MMXq_MMXq_0F7F _ _ => true
  | .MOVQ_XMMdq_GPR64 _ _ => true
  | .MOVQ_XMMdq_MEMq_0F6E _ mem0 => mem0.encodingFits
  | .MOVQ_XMMdq_MEMq_0F7E _ mem0 => mem0.encodingFits
  | .MOVQ_XMMdq_XMMq_0F7E _ _ => true
  | .MOVQ_XMMdq_XMMq_0FD6 _ _ => true

end X86.Syntax
