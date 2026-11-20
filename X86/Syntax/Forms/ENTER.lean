-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ENTER.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ENTER where
  -- ENTER_IMMw_IMMb: IMM0:r:w IMM1:r:b REG0=XED_REG_STACKPUSH:rw:spw:SUPP REG1=OrBP():rw:SUPP
  | ENTER_IMMw_IMMb (imm0 : Immediate) (imm1 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.ENTER.xedForm : Forms.ENTER → XedForm
  | .ENTER_IMMw_IMMb _ _ => .ENTER_IMMw_IMMb

def Forms.ENTER.encodingFits : Forms.ENTER → Bool
  | .ENTER_IMMw_IMMb imm0 imm1 => imm0.encodingFits && imm1.encodingFits

end X86.Syntax
