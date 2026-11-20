-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ANDNPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ANDNPD where
  -- ANDNPD_XMMxuq_MEMxuq: REG0=XMM_R():rw:xuq MEM0:r:xuq
  | ANDNPD_XMMxuq_MEMxuq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ANDNPD_XMMxuq_XMMxuq: REG0=XMM_R():rw:xuq REG1=XMM_B():r:xuq
  | ANDNPD_XMMxuq_XMMxuq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ANDNPD.xedForm : Forms.ANDNPD → XedForm
  | .ANDNPD_XMMxuq_MEMxuq _ _ => .ANDNPD_XMMxuq_MEMxuq
  | .ANDNPD_XMMxuq_XMMxuq _ _ => .ANDNPD_XMMxuq_XMMxuq

def Forms.ANDNPD.encodingFits : Forms.ANDNPD → Bool
  | .ANDNPD_XMMxuq_MEMxuq _ mem0 => mem0.encodingFits
  | .ANDNPD_XMMxuq_XMMxuq _ _ => true

end X86.Syntax
