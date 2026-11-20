-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CBW-CWDE-CDQE.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CBW where
  -- CBW: REG0=XED_REG_AX:w:SUPP REG1=XED_REG_AL:r:SUPP
  | CBW
  -- CDQE: REG0=XED_REG_RAX:w:SUPP REG1=XED_REG_EAX:r:SUPP
  | CDQE
  -- CWDE: REG0=XED_REG_EAX:w:SUPP REG1=XED_REG_AX:r:SUPP
  | CWDE
  deriving Repr, BEq, Inhabited

def Forms.CBW.xedForm : Forms.CBW → XedForm
  | .CBW => .CBW
  | .CDQE => .CDQE
  | .CWDE => .CWDE

def Forms.CBW.encodingFits : Forms.CBW → Bool
  | .CBW  => true
  | .CDQE  => true
  | .CWDE  => true

end X86.Syntax
