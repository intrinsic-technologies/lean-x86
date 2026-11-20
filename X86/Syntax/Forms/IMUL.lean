-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/IMUL.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.IMUL where
  -- IMUL_GPR8: REG0=GPR8_B():r REG1=XED_REG_AL:r:SUPP REG2=XED_REG_AX:w:SUPP
  | IMUL_GPR8 (reg0 : Registers.GPR8)
  -- IMUL_GPRv: REG0=GPRv_B():r REG1=OrAX():rw:SUPP REG2=OrDX():w:SUPP
  | IMUL_GPRv (reg0 : Registers.GPRv)
  -- IMUL_GPRv_GPRv: REG0=GPRv_R():rw REG1=GPRv_B():r
  | IMUL_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- IMUL_GPRv_GPRv_IMMb: REG0=GPRv_R():w REG1=GPRv_B():r IMM0:r:b:i8
  | IMUL_GPRv_GPRv_IMMb (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) (imm0 : Immediate)
  -- IMUL_GPRv_GPRv_IMMz: REG0=GPRv_R():w REG1=GPRv_B():r IMM0:r:z
  | IMUL_GPRv_GPRv_IMMz (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) (imm0 : Immediate)
  -- IMUL_GPRv_MEMv: REG0=GPRv_R():rw MEM0:r:v
  | IMUL_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- IMUL_GPRv_MEMv_IMMb: REG0=GPRv_R():w MEM0:r:v IMM0:r:b:i8
  | IMUL_GPRv_MEMv_IMMb (reg0 : Registers.GPRv) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- IMUL_GPRv_MEMv_IMMz: REG0=GPRv_R():w MEM0:r:v IMM0:r:z
  | IMUL_GPRv_MEMv_IMMz (reg0 : Registers.GPRv) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- IMUL_MEMb: MEM0:r:b REG0=XED_REG_AL:r:SUPP REG1=XED_REG_AX:w:SUPP
  | IMUL_MEMb (mem0 : MemoryOperand)
  -- IMUL_MEMv: MEM0:r:v REG0=OrAX():rw:SUPP REG1=OrDX():w:SUPP
  | IMUL_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.IMUL.xedForm : Forms.IMUL → XedForm
  | .IMUL_GPR8 _ => .IMUL_GPR8
  | .IMUL_GPRv _ => .IMUL_GPRv
  | .IMUL_GPRv_GPRv _ _ => .IMUL_GPRv_GPRv
  | .IMUL_GPRv_GPRv_IMMb _ _ _ => .IMUL_GPRv_GPRv_IMMb
  | .IMUL_GPRv_GPRv_IMMz _ _ _ => .IMUL_GPRv_GPRv_IMMz
  | .IMUL_GPRv_MEMv _ _ => .IMUL_GPRv_MEMv
  | .IMUL_GPRv_MEMv_IMMb _ _ _ => .IMUL_GPRv_MEMv_IMMb
  | .IMUL_GPRv_MEMv_IMMz _ _ _ => .IMUL_GPRv_MEMv_IMMz
  | .IMUL_MEMb _ => .IMUL_MEMb
  | .IMUL_MEMv _ => .IMUL_MEMv

def Forms.IMUL.encodingFits : Forms.IMUL → Bool
  | .IMUL_GPR8 _ => true
  | .IMUL_GPRv _ => true
  | .IMUL_GPRv_GPRv _ _ => true
  | .IMUL_GPRv_GPRv_IMMb _ _ imm0 => imm0.encodingFits
  | .IMUL_GPRv_GPRv_IMMz _ _ imm0 => imm0.encodingFits
  | .IMUL_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .IMUL_GPRv_MEMv_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .IMUL_GPRv_MEMv_IMMz _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .IMUL_MEMb mem0 => mem0.encodingFits
  | .IMUL_MEMv mem0 => mem0.encodingFits

end X86.Syntax
