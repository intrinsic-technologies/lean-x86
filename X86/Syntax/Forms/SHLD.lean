-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SHLD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SHLD where
  -- SHLD_GPRv_GPRv_CL: REG0=GPRv_B():rcw REG1=GPRv_R():r REG2=XED_REG_CL:r:IMPL
  | SHLD_GPRv_GPRv_CL (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- SHLD_GPRv_GPRv_IMMb: REG0=GPRv_B():rcw REG1=GPRv_R():r IMM0:r:b
  | SHLD_GPRv_GPRv_IMMb (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) (imm0 : Immediate)
  -- SHLD_MEMv_GPRv_CL: MEM0:rcw:v REG0=GPRv_R():r REG1=XED_REG_CL:r:IMPL
  | SHLD_MEMv_GPRv_CL (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- SHLD_MEMv_GPRv_IMMb: MEM0:rcw:v REG0=GPRv_R():r IMM0:r:b
  | SHLD_MEMv_GPRv_IMMb (mem0 : MemoryOperand) (reg0 : Registers.GPRv) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.SHLD.xedForm : Forms.SHLD → XedForm
  | .SHLD_GPRv_GPRv_CL _ _ => .SHLD_GPRv_GPRv_CL
  | .SHLD_GPRv_GPRv_IMMb _ _ _ => .SHLD_GPRv_GPRv_IMMb
  | .SHLD_MEMv_GPRv_CL _ _ => .SHLD_MEMv_GPRv_CL
  | .SHLD_MEMv_GPRv_IMMb _ _ _ => .SHLD_MEMv_GPRv_IMMb

def Forms.SHLD.encodingFits : Forms.SHLD → Bool
  | .SHLD_GPRv_GPRv_CL _ _ => true
  | .SHLD_GPRv_GPRv_IMMb _ _ imm0 => imm0.encodingFits
  | .SHLD_MEMv_GPRv_CL mem0 _ => mem0.encodingFits
  | .SHLD_MEMv_GPRv_IMMb mem0 _ imm0 => mem0.encodingFits && imm0.encodingFits

end X86.Syntax
