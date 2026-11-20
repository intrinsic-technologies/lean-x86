-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SMSW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SMSW where
  -- SMSW_GPRv: REG0=GPRv_B():w REG1=XED_REG_CR0:r:SUPP
  | SMSW_GPRv (reg0 : Registers.GPRv)
  -- SMSW_MEMw: MEM0:w:w REG0=XED_REG_CR0:r:SUPP
  | SMSW_MEMw (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.SMSW.xedForm : Forms.SMSW → XedForm
  | .SMSW_GPRv _ => .SMSW_GPRv
  | .SMSW_MEMw _ => .SMSW_MEMw

def Forms.SMSW.encodingFits : Forms.SMSW → Bool
  | .SMSW_GPRv _ => true
  | .SMSW_MEMw mem0 => mem0.encodingFits

end X86.Syntax
