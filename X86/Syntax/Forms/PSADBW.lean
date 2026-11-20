-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSADBW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSADBW where
  -- PSADBW_MMXq_MEMq: REG0=MMX_R():rw:q MEM0:r:q
  | PSADBW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- PSADBW_MMXq_MMXq: REG0=MMX_R():rw:q REG1=MMX_B():r:q
  | PSADBW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX)
  -- PSADBW_XMMdq_MEMdq: REG0=XMM_R():rw:dq MEM0:r:dq
  | PSADBW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- PSADBW_XMMdq_XMMdq: REG0=XMM_R():rw:dq REG1=XMM_B():r:dq
  | PSADBW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PSADBW.xedForm : Forms.PSADBW → XedForm
  | .PSADBW_MMXq_MEMq _ _ => .PSADBW_MMXq_MEMq
  | .PSADBW_MMXq_MMXq _ _ => .PSADBW_MMXq_MMXq
  | .PSADBW_XMMdq_MEMdq _ _ => .PSADBW_XMMdq_MEMdq
  | .PSADBW_XMMdq_XMMdq _ _ => .PSADBW_XMMdq_XMMdq

def Forms.PSADBW.encodingFits : Forms.PSADBW → Bool
  | .PSADBW_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .PSADBW_MMXq_MMXq _ _ => true
  | .PSADBW_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .PSADBW_XMMdq_XMMdq _ _ => true

end X86.Syntax
