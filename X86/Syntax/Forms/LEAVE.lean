-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LEAVE.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LEAVE where
  -- LEAVE: MEM0:r:SUPP:v BASE0=ArBP():r:SUPP SEG0=FINAL_SSEG0():r:SUPP REG0=OrBP():rw:SUPP REG1=OrSP():rw:SUPP
  | LEAVE
  deriving Repr, BEq, Inhabited

def Forms.LEAVE.xedForm : Forms.LEAVE → XedForm
  | .LEAVE => .LEAVE

def Forms.LEAVE.encodingFits : Forms.LEAVE → Bool
  | .LEAVE  => true

end X86.Syntax
