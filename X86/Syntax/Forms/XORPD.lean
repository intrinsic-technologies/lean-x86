-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/XORPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.XORPD where
  -- XORPD_XMMxuq_MEMxuq: REG0=XMM_R():rw:xuq MEM0:r:xuq
  | XORPD_XMMxuq_MEMxuq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- XORPD_XMMxuq_XMMxuq: REG0=XMM_R():rw:xuq REG1=XMM_B():r:xuq
  | XORPD_XMMxuq_XMMxuq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.XORPD.xedForm : Forms.XORPD → XedForm
  | .XORPD_XMMxuq_MEMxuq _ _ => .XORPD_XMMxuq_MEMxuq
  | .XORPD_XMMxuq_XMMxuq _ _ => .XORPD_XMMxuq_XMMxuq

def Forms.XORPD.encodingFits : Forms.XORPD → Bool
  | .XORPD_XMMxuq_MEMxuq _ mem0 => mem0.encodingFits
  | .XORPD_XMMxuq_XMMxuq _ _ => true

end X86.Syntax
