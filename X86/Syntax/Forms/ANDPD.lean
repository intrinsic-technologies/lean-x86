-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ANDPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ANDPD where
  -- ANDPD_XMMxuq_MEMxuq: REG0=XMM_R():rw:xuq MEM0:r:xuq
  | ANDPD_XMMxuq_MEMxuq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ANDPD_XMMxuq_XMMxuq: REG0=XMM_R():rw:xuq REG1=XMM_B():r:xuq
  | ANDPD_XMMxuq_XMMxuq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ANDPD.xedForm : Forms.ANDPD → XedForm
  | .ANDPD_XMMxuq_MEMxuq _ _ => .ANDPD_XMMxuq_MEMxuq
  | .ANDPD_XMMxuq_XMMxuq _ _ => .ANDPD_XMMxuq_XMMxuq

def Forms.ANDPD.encodingFits : Forms.ANDPD → Bool
  | .ANDPD_XMMxuq_MEMxuq _ mem0 => mem0.encodingFits
  | .ANDPD_XMMxuq_XMMxuq _ _ => true

end X86.Syntax
