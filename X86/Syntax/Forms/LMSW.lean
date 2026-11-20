-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LMSW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LMSW where
  -- LMSW_GPR16: REG0=GPR16_B():r REG1=XED_REG_CR0:w:SUPP
  | LMSW_GPR16 (reg0 : Registers.GPR16)
  -- LMSW_MEMw: MEM0:r:w REG0=XED_REG_CR0:w:SUPP
  | LMSW_MEMw (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LMSW.xedForm : Forms.LMSW → XedForm
  | .LMSW_GPR16 _ => .LMSW_GPR16
  | .LMSW_MEMw _ => .LMSW_MEMw

def Forms.LMSW.encodingFits : Forms.LMSW → Bool
  | .LMSW_GPR16 _ => true
  | .LMSW_MEMw mem0 => mem0.encodingFits

end X86.Syntax
