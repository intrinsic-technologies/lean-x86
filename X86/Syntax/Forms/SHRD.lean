-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SHRD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SHRD where
  -- SHRD_GPRv_GPRv_CL: REG0=GPRv_B():rcw REG1=GPRv_R():r REG2=XED_REG_CL:r:IMPL
  | SHRD_GPRv_GPRv_CL (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- SHRD_GPRv_GPRv_IMMb: REG0=GPRv_B():rcw REG1=GPRv_R():r IMM0:r:b
  | SHRD_GPRv_GPRv_IMMb (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) (imm0 : Immediate)
  -- SHRD_MEMv_GPRv_CL: MEM0:rcw:v REG0=GPRv_R():r REG1=XED_REG_CL:r:IMPL
  | SHRD_MEMv_GPRv_CL (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- SHRD_MEMv_GPRv_IMMb: MEM0:rcw:v REG0=GPRv_R():r IMM0:r:b
  | SHRD_MEMv_GPRv_IMMb (mem0 : MemoryOperand) (reg0 : Registers.GPRv) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.SHRD.xedForm : Forms.SHRD → XedForm
  | .SHRD_GPRv_GPRv_CL _ _ => .SHRD_GPRv_GPRv_CL
  | .SHRD_GPRv_GPRv_IMMb _ _ _ => .SHRD_GPRv_GPRv_IMMb
  | .SHRD_MEMv_GPRv_CL _ _ => .SHRD_MEMv_GPRv_CL
  | .SHRD_MEMv_GPRv_IMMb _ _ _ => .SHRD_MEMv_GPRv_IMMb

def Forms.SHRD.encodingFits : Forms.SHRD → Bool
  | .SHRD_GPRv_GPRv_CL _ _ => true
  | .SHRD_GPRv_GPRv_IMMb _ _ imm0 => imm0.encodingFits
  | .SHRD_MEMv_GPRv_CL mem0 _ => mem0.encodingFits
  | .SHRD_MEMv_GPRv_IMMb mem0 _ imm0 => mem0.encodingFits && imm0.encodingFits

end X86.Syntax
