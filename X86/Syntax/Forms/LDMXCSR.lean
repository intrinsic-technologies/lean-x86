-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LDMXCSR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LDMXCSR where
  -- LDMXCSR_MEMd: MEM0:r:d REG0=XED_REG_MXCSR:w:SUPP
  | LDMXCSR_MEMd (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LDMXCSR.xedForm : Forms.LDMXCSR → XedForm
  | .LDMXCSR_MEMd _ => .LDMXCSR_MEMd

def Forms.LDMXCSR.encodingFits : Forms.LDMXCSR → Bool
  | .LDMXCSR_MEMd mem0 => mem0.encodingFits

end X86.Syntax
