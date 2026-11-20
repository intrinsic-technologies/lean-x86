-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SWAPGS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SWAPGS where
  -- SWAPGS: REG0=XED_REG_GSBASE:rw:SUPP
  | SWAPGS
  deriving Repr, BEq, Inhabited

def Forms.SWAPGS.xedForm : Forms.SWAPGS → XedForm
  | .SWAPGS => .SWAPGS

def Forms.SWAPGS.encodingFits : Forms.SWAPGS → Bool
  | .SWAPGS  => true

end X86.Syntax
