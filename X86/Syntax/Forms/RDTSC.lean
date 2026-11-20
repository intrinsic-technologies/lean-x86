-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/RDTSC.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.RDTSC where
  -- RDTSC: REG0=XED_REG_EAX:w:SUPP REG1=XED_REG_EDX:w:SUPP REG2=XED_REG_TSC:r:SUPP
  | RDTSC
  deriving Repr, BEq, Inhabited

def Forms.RDTSC.xedForm : Forms.RDTSC → XedForm
  | .RDTSC => .RDTSC

def Forms.RDTSC.encodingFits : Forms.RDTSC → Bool
  | .RDTSC  => true

end X86.Syntax
