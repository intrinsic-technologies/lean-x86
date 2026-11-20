-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOV_DR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOV_DR where
  -- MOV_DR_DR_GPR64: REG0=DR_R():w REG1=GPR64_B():r
  | MOV_DR_DR_GPR64 (reg0 : Registers.DR) (reg1 : Registers.GPR64)
  -- MOV_DR_GPR64_DR: REG0=GPR64_B():w REG1=DR_R():r
  | MOV_DR_GPR64_DR (reg0 : Registers.GPR64) (reg1 : Registers.DR)
  deriving Repr, BEq, Inhabited

def Forms.MOV_DR.xedForm : Forms.MOV_DR → XedForm
  | .MOV_DR_DR_GPR64 _ _ => .MOV_DR_DR_GPR64
  | .MOV_DR_GPR64_DR _ _ => .MOV_DR_GPR64_DR

def Forms.MOV_DR.encodingFits : Forms.MOV_DR → Bool
  | .MOV_DR_DR_GPR64 _ _ => true
  | .MOV_DR_GPR64_DR _ _ => true

end X86.Syntax
