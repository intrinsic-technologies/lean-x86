-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ORPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ORPD where
  -- ORPD_XMMxuq_MEMxuq: REG0=XMM_R():rw:xuq MEM0:r:xuq
  | ORPD_XMMxuq_MEMxuq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ORPD_XMMxuq_XMMxuq: REG0=XMM_R():rw:xuq REG1=XMM_B():r:xuq
  | ORPD_XMMxuq_XMMxuq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ORPD.xedForm : Forms.ORPD → XedForm
  | .ORPD_XMMxuq_MEMxuq _ _ => .ORPD_XMMxuq_MEMxuq
  | .ORPD_XMMxuq_XMMxuq _ _ => .ORPD_XMMxuq_XMMxuq

def Forms.ORPD.encodingFits : Forms.ORPD → Bool
  | .ORPD_XMMxuq_MEMxuq _ mem0 => mem0.encodingFits
  | .ORPD_XMMxuq_XMMxuq _ _ => true

end X86.Syntax
