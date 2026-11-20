-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/STMXCSR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.STMXCSR where
  -- STMXCSR_MEMd: MEM0:w:d REG0=XED_REG_MXCSR:r:SUPP
  | STMXCSR_MEMd (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.STMXCSR.xedForm : Forms.STMXCSR → XedForm
  | .STMXCSR_MEMd _ => .STMXCSR_MEMd

def Forms.STMXCSR.encodingFits : Forms.STMXCSR → Bool
  | .STMXCSR_MEMd mem0 => mem0.encodingFits

end X86.Syntax
