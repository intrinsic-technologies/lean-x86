-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PXOR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PXOR where
  -- PXOR_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PXOR_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PXOR_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PXOR_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PXOR_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PXOR_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PXOR_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PXOR_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PXOR.xedForm : Forms.PXOR → XedForm
  | .PXOR_MMXq_MEMq _ _ => .PXOR_MMXq_MEMq
  | .PXOR_MMXq_MMXq _ _ => .PXOR_MMXq_MMXq
  | .PXOR_XMMdq_MEMdq _ _ => .PXOR_XMMdq_MEMdq
  | .PXOR_XMMdq_XMMdq _ _ => .PXOR_XMMdq_XMMdq

def Forms.PXOR.encodingFits : Forms.PXOR → Bool
  | .PXOR_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PXOR_MMXq_MMXq _ _ => true
  | .PXOR_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PXOR_XMMdq_XMMdq _ _ => true

end X86.Syntax
