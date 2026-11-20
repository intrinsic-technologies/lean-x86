-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PINSRW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PINSRW where
  -- PINSRW_MMXq_GPR32_IMMb: REG0=MMX_R():rw:q:u16 REG1=GPR32_B():r IMM0:r:b
  | PINSRW_MMXq_GPR32_IMMb (reg0 : Registers.MMX) (reg1 : Registers.GPR32) (imm0 : Immediate)
  -- PINSRW_MMXq_MEMw_IMMb: REG0=MMX_R():rw:q:u16 MEM0:r:w:u16 IMM0:r:b
  | PINSRW_MMXq_MEMw_IMMb (reg0 : Registers.MMX) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- PINSRW_XMMdq_GPR32_IMMb: REG0=XMM_R():rw:dq REG1=GPR32_B():r IMM0:r:b
  | PINSRW_XMMdq_GPR32_IMMb (reg0 : Registers.XMM) (reg1 : Registers.GPR32) (imm0 : Immediate)
  -- PINSRW_XMMdq_MEMw_IMMb: REG0=XMM_R():rw:dq MEM0:r:w IMM0:r:b
  | PINSRW_XMMdq_MEMw_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.PINSRW.xedForm : Forms.PINSRW → XedForm
  | .PINSRW_MMXq_GPR32_IMMb _ _ _ => .PINSRW_MMXq_GPR32_IMMb
  | .PINSRW_MMXq_MEMw_IMMb _ _ _ => .PINSRW_MMXq_MEMw_IMMb
  | .PINSRW_XMMdq_GPR32_IMMb _ _ _ => .PINSRW_XMMdq_GPR32_IMMb
  | .PINSRW_XMMdq_MEMw_IMMb _ _ _ => .PINSRW_XMMdq_MEMw_IMMb

def Forms.PINSRW.encodingFits : Forms.PINSRW → Bool
  | .PINSRW_MMXq_GPR32_IMMb _ _ imm0 => imm0.encodingFits
  | .PINSRW_MMXq_MEMw_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .PINSRW_XMMdq_GPR32_IMMb _ _ imm0 => imm0.encodingFits
  | .PINSRW_XMMdq_MEMw_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits

end X86.Syntax
