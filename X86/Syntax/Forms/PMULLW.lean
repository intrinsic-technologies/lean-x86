-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMULLW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMULLW where
  -- PMULLW_MMXq_MEMq: REG0=MMX_R():rw:q:i16 MEM0:r:q:i16
  | PMULLW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PMULLW_MMXq_MMXq: REG0=MMX_R():rw:q:i16 REG1=MMX_B():r:q:i16
  | PMULLW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PMULLW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PMULLW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PMULLW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PMULLW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMULLW.xedForm : Forms.PMULLW → XedForm
  | .PMULLW_MMXq_MEMq _ _ => .PMULLW_MMXq_MEMq
  | .PMULLW_MMXq_MMXq _ _ => .PMULLW_MMXq_MMXq
  | .PMULLW_XMMdq_MEMdq _ _ => .PMULLW_XMMdq_MEMdq
  | .PMULLW_XMMdq_XMMdq _ _ => .PMULLW_XMMdq_XMMdq

def Forms.PMULLW.encodingFits : Forms.PMULLW → Bool
  | .PMULLW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PMULLW_MMXq_MMXq _ _ => true
  | .PMULLW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PMULLW_XMMdq_XMMdq _ _ => true

end X86.Syntax
