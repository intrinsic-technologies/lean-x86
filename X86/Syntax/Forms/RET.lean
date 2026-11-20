-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/RET.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.RET where
  -- RET_FAR: REG0=XED_REG_STACKPOP:rw:spw2:SUPP REG1=rIP():w:SUPP
  | RET_FAR
  -- RET_FAR_IMMw: IMM0:r:w REG0=XED_REG_STACKPOP:rw:spw2:SUPP REG1=rIP():w:SUPP
  | RET_FAR_IMMw (imm0 : Immediate)
  -- RET_NEAR: REG0=XED_REG_STACKPOP:rw:spw:SUPP REG1=rIP():w:SUPP
  | RET_NEAR
  -- RET_NEAR_IMMw: IMM0:r:w REG0=XED_REG_STACKPOP:rw:spw:SUPP REG1=rIP():w:SUPP
  | RET_NEAR_IMMw (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.RET.xedForm : Forms.RET → XedForm
  | .RET_FAR => .RET_FAR
  | .RET_FAR_IMMw _ => .RET_FAR_IMMw
  | .RET_NEAR => .RET_NEAR
  | .RET_NEAR_IMMw _ => .RET_NEAR_IMMw

def Forms.RET.encodingFits : Forms.RET → Bool
  | .RET_FAR  => true
  | .RET_FAR_IMMw imm0 => imm0.encodingFits
  | .RET_NEAR  => true
  | .RET_NEAR_IMMw imm0 => imm0.encodingFits

end X86.Syntax
