-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SAL-SAR-SHL-SHR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SAL where
  -- SAR_GPR8_CL: REG0=GPR8_B():rw REG1=XED_REG_CL:r:IMPL
  | SAR_GPR8_CL (reg0 : Registers.GPR8)
  -- SAR_GPR8_IMMb: REG0=GPR8_B():rw IMM0:r:b
  | SAR_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- SAR_GPR8_ONE: REG0=GPR8_B():rw IMM0:r:b:IMPL
  | SAR_GPR8_ONE (reg0 : Registers.GPR8)
  -- SAR_GPRv_CL: REG0=GPRv_B():rw REG1=XED_REG_CL:r:IMPL
  | SAR_GPRv_CL (reg0 : Registers.GPRv)
  -- SAR_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | SAR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- SAR_GPRv_ONE: REG0=GPRv_B():rw IMM0:r:b:IMPL
  | SAR_GPRv_ONE (reg0 : Registers.GPRv)
  -- SAR_MEMb_CL: MEM0:rw:b REG0=XED_REG_CL:r:IMPL
  | SAR_MEMb_CL (mem0 : MemoryOperand)
  -- SAR_MEMb_IMMb: MEM0:rw:b IMM0:r:b
  | SAR_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SAR_MEMb_ONE: MEM0:rw:b IMM0:r:b:IMPL
  | SAR_MEMb_ONE (mem0 : MemoryOperand)
  -- SAR_MEMv_CL: MEM0:rw:v REG0=XED_REG_CL:r:IMPL
  | SAR_MEMv_CL (mem0 : MemoryOperand)
  -- SAR_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | SAR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SAR_MEMv_ONE: MEM0:rw:v IMM0:r:b:IMPL
  | SAR_MEMv_ONE (mem0 : MemoryOperand)
  -- SHL_GPR8_CL_D2r4: REG0=GPR8_B():rw REG1=XED_REG_CL:r:IMPL
  | SHL_GPR8_CL_D2r4 (reg0 : Registers.GPR8)
  -- SHL_GPR8_CL_D2r6: REG0=GPR8_B():rw REG1=XED_REG_CL:r:IMPL
  | SHL_GPR8_CL_D2r6 (reg0 : Registers.GPR8)
  -- SHL_GPR8_IMMb_C0r4: REG0=GPR8_B():rw IMM0:r:b
  | SHL_GPR8_IMMb_C0r4 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- SHL_GPR8_IMMb_C0r6: REG0=GPR8_B():rw IMM0:r:b
  | SHL_GPR8_IMMb_C0r6 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- SHL_GPR8_ONE_D0r4: REG0=GPR8_B():rw IMM0:r:b:IMPL
  | SHL_GPR8_ONE_D0r4 (reg0 : Registers.GPR8)
  -- SHL_GPR8_ONE_D0r6: REG0=GPR8_B():rw IMM0:r:b:IMPL
  | SHL_GPR8_ONE_D0r6 (reg0 : Registers.GPR8)
  -- SHL_GPRv_CL_D3r4: REG0=GPRv_B():rw REG1=XED_REG_CL:r:IMPL
  | SHL_GPRv_CL_D3r4 (reg0 : Registers.GPRv)
  -- SHL_GPRv_CL_D3r6: REG0=GPRv_B():rw REG1=XED_REG_CL:r:IMPL
  | SHL_GPRv_CL_D3r6 (reg0 : Registers.GPRv)
  -- SHL_GPRv_IMMb_C1r4: REG0=GPRv_B():rw IMM0:r:b
  | SHL_GPRv_IMMb_C1r4 (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- SHL_GPRv_IMMb_C1r6: REG0=GPRv_B():rw IMM0:r:b
  | SHL_GPRv_IMMb_C1r6 (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- SHL_GPRv_ONE_D1r4: REG0=GPRv_B():rw IMM0:r:b:IMPL
  | SHL_GPRv_ONE_D1r4 (reg0 : Registers.GPRv)
  -- SHL_GPRv_ONE_D1r6: REG0=GPRv_B():rw IMM0:r:b:IMPL
  | SHL_GPRv_ONE_D1r6 (reg0 : Registers.GPRv)
  -- SHL_MEMb_CL_D2r4: MEM0:rw:b REG0=XED_REG_CL:r:IMPL
  | SHL_MEMb_CL_D2r4 (mem0 : MemoryOperand)
  -- SHL_MEMb_CL_D2r6: MEM0:rw:b REG0=XED_REG_CL:r:IMPL
  | SHL_MEMb_CL_D2r6 (mem0 : MemoryOperand)
  -- SHL_MEMb_IMMb_C0r4: MEM0:rw:b IMM0:r:b
  | SHL_MEMb_IMMb_C0r4 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SHL_MEMb_IMMb_C0r6: MEM0:rw:b IMM0:r:b
  | SHL_MEMb_IMMb_C0r6 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SHL_MEMb_ONE_D0r4: MEM0:rw:b IMM0:r:b:IMPL
  | SHL_MEMb_ONE_D0r4 (mem0 : MemoryOperand)
  -- SHL_MEMb_ONE_D0r6: MEM0:rw:b IMM0:r:b:IMPL
  | SHL_MEMb_ONE_D0r6 (mem0 : MemoryOperand)
  -- SHL_MEMv_CL_D3r4: MEM0:rw:v REG0=XED_REG_CL:r:IMPL
  | SHL_MEMv_CL_D3r4 (mem0 : MemoryOperand)
  -- SHL_MEMv_CL_D3r6: MEM0:rw:v REG0=XED_REG_CL:r:IMPL
  | SHL_MEMv_CL_D3r6 (mem0 : MemoryOperand)
  -- SHL_MEMv_IMMb_C1r4: MEM0:rw:v IMM0:r:b
  | SHL_MEMv_IMMb_C1r4 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SHL_MEMv_IMMb_C1r6: MEM0:rw:v IMM0:r:b
  | SHL_MEMv_IMMb_C1r6 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SHL_MEMv_ONE_D1r4: MEM0:rw:v IMM0:r:b:IMPL
  | SHL_MEMv_ONE_D1r4 (mem0 : MemoryOperand)
  -- SHL_MEMv_ONE_D1r6: MEM0:rw:v IMM0:r:b:IMPL
  | SHL_MEMv_ONE_D1r6 (mem0 : MemoryOperand)
  -- SHR_GPR8_CL: REG0=GPR8_B():rw REG1=XED_REG_CL:r:IMPL
  | SHR_GPR8_CL (reg0 : Registers.GPR8)
  -- SHR_GPR8_IMMb: REG0=GPR8_B():rw IMM0:r:b
  | SHR_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- SHR_GPR8_ONE: REG0=GPR8_B():rw IMM0:r:b:IMPL
  | SHR_GPR8_ONE (reg0 : Registers.GPR8)
  -- SHR_GPRv_CL: REG0=GPRv_B():rw REG1=XED_REG_CL:r:IMPL
  | SHR_GPRv_CL (reg0 : Registers.GPRv)
  -- SHR_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | SHR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- SHR_GPRv_ONE: REG0=GPRv_B():rw IMM0:r:b:IMPL
  | SHR_GPRv_ONE (reg0 : Registers.GPRv)
  -- SHR_MEMb_CL: MEM0:rw:b REG0=XED_REG_CL:r:IMPL
  | SHR_MEMb_CL (mem0 : MemoryOperand)
  -- SHR_MEMb_IMMb: MEM0:rw:b IMM0:r:b
  | SHR_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SHR_MEMb_ONE: MEM0:rw:b IMM0:r:b:IMPL
  | SHR_MEMb_ONE (mem0 : MemoryOperand)
  -- SHR_MEMv_CL: MEM0:rw:v REG0=XED_REG_CL:r:IMPL
  | SHR_MEMv_CL (mem0 : MemoryOperand)
  -- SHR_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | SHR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SHR_MEMv_ONE: MEM0:rw:v IMM0:r:b:IMPL
  | SHR_MEMv_ONE (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.SAL.xedForm : Forms.SAL → XedForm
  | .SAR_GPR8_CL _ => .SAR_GPR8_CL
  | .SAR_GPR8_IMMb _ _ => .SAR_GPR8_IMMb
  | .SAR_GPR8_ONE _ => .SAR_GPR8_ONE
  | .SAR_GPRv_CL _ => .SAR_GPRv_CL
  | .SAR_GPRv_IMMb _ _ => .SAR_GPRv_IMMb
  | .SAR_GPRv_ONE _ => .SAR_GPRv_ONE
  | .SAR_MEMb_CL _ => .SAR_MEMb_CL
  | .SAR_MEMb_IMMb _ _ => .SAR_MEMb_IMMb
  | .SAR_MEMb_ONE _ => .SAR_MEMb_ONE
  | .SAR_MEMv_CL _ => .SAR_MEMv_CL
  | .SAR_MEMv_IMMb _ _ => .SAR_MEMv_IMMb
  | .SAR_MEMv_ONE _ => .SAR_MEMv_ONE
  | .SHL_GPR8_CL_D2r4 _ => .SHL_GPR8_CL_D2r4
  | .SHL_GPR8_CL_D2r6 _ => .SHL_GPR8_CL_D2r6
  | .SHL_GPR8_IMMb_C0r4 _ _ => .SHL_GPR8_IMMb_C0r4
  | .SHL_GPR8_IMMb_C0r6 _ _ => .SHL_GPR8_IMMb_C0r6
  | .SHL_GPR8_ONE_D0r4 _ => .SHL_GPR8_ONE_D0r4
  | .SHL_GPR8_ONE_D0r6 _ => .SHL_GPR8_ONE_D0r6
  | .SHL_GPRv_CL_D3r4 _ => .SHL_GPRv_CL_D3r4
  | .SHL_GPRv_CL_D3r6 _ => .SHL_GPRv_CL_D3r6
  | .SHL_GPRv_IMMb_C1r4 _ _ => .SHL_GPRv_IMMb_C1r4
  | .SHL_GPRv_IMMb_C1r6 _ _ => .SHL_GPRv_IMMb_C1r6
  | .SHL_GPRv_ONE_D1r4 _ => .SHL_GPRv_ONE_D1r4
  | .SHL_GPRv_ONE_D1r6 _ => .SHL_GPRv_ONE_D1r6
  | .SHL_MEMb_CL_D2r4 _ => .SHL_MEMb_CL_D2r4
  | .SHL_MEMb_CL_D2r6 _ => .SHL_MEMb_CL_D2r6
  | .SHL_MEMb_IMMb_C0r4 _ _ => .SHL_MEMb_IMMb_C0r4
  | .SHL_MEMb_IMMb_C0r6 _ _ => .SHL_MEMb_IMMb_C0r6
  | .SHL_MEMb_ONE_D0r4 _ => .SHL_MEMb_ONE_D0r4
  | .SHL_MEMb_ONE_D0r6 _ => .SHL_MEMb_ONE_D0r6
  | .SHL_MEMv_CL_D3r4 _ => .SHL_MEMv_CL_D3r4
  | .SHL_MEMv_CL_D3r6 _ => .SHL_MEMv_CL_D3r6
  | .SHL_MEMv_IMMb_C1r4 _ _ => .SHL_MEMv_IMMb_C1r4
  | .SHL_MEMv_IMMb_C1r6 _ _ => .SHL_MEMv_IMMb_C1r6
  | .SHL_MEMv_ONE_D1r4 _ => .SHL_MEMv_ONE_D1r4
  | .SHL_MEMv_ONE_D1r6 _ => .SHL_MEMv_ONE_D1r6
  | .SHR_GPR8_CL _ => .SHR_GPR8_CL
  | .SHR_GPR8_IMMb _ _ => .SHR_GPR8_IMMb
  | .SHR_GPR8_ONE _ => .SHR_GPR8_ONE
  | .SHR_GPRv_CL _ => .SHR_GPRv_CL
  | .SHR_GPRv_IMMb _ _ => .SHR_GPRv_IMMb
  | .SHR_GPRv_ONE _ => .SHR_GPRv_ONE
  | .SHR_MEMb_CL _ => .SHR_MEMb_CL
  | .SHR_MEMb_IMMb _ _ => .SHR_MEMb_IMMb
  | .SHR_MEMb_ONE _ => .SHR_MEMb_ONE
  | .SHR_MEMv_CL _ => .SHR_MEMv_CL
  | .SHR_MEMv_IMMb _ _ => .SHR_MEMv_IMMb
  | .SHR_MEMv_ONE _ => .SHR_MEMv_ONE

def Forms.SAL.encodingFits : Forms.SAL → Bool
  | .SAR_GPR8_CL _ => true
  | .SAR_GPR8_IMMb _ imm0 => imm0.encodingFits
  | .SAR_GPR8_ONE _ => true
  | .SAR_GPRv_CL _ => true
  | .SAR_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .SAR_GPRv_ONE _ => true
  | .SAR_MEMb_CL mem0 => mem0.encodingFits
  | .SAR_MEMb_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SAR_MEMb_ONE mem0 => mem0.encodingFits
  | .SAR_MEMv_CL mem0 => mem0.encodingFits
  | .SAR_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SAR_MEMv_ONE mem0 => mem0.encodingFits
  | .SHL_GPR8_CL_D2r4 _ => true
  | .SHL_GPR8_CL_D2r6 _ => true
  | .SHL_GPR8_IMMb_C0r4 _ imm0 => imm0.encodingFits
  | .SHL_GPR8_IMMb_C0r6 _ imm0 => imm0.encodingFits
  | .SHL_GPR8_ONE_D0r4 _ => true
  | .SHL_GPR8_ONE_D0r6 _ => true
  | .SHL_GPRv_CL_D3r4 _ => true
  | .SHL_GPRv_CL_D3r6 _ => true
  | .SHL_GPRv_IMMb_C1r4 _ imm0 => imm0.encodingFits
  | .SHL_GPRv_IMMb_C1r6 _ imm0 => imm0.encodingFits
  | .SHL_GPRv_ONE_D1r4 _ => true
  | .SHL_GPRv_ONE_D1r6 _ => true
  | .SHL_MEMb_CL_D2r4 mem0 => mem0.encodingFits
  | .SHL_MEMb_CL_D2r6 mem0 => mem0.encodingFits
  | .SHL_MEMb_IMMb_C0r4 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SHL_MEMb_IMMb_C0r6 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SHL_MEMb_ONE_D0r4 mem0 => mem0.encodingFits
  | .SHL_MEMb_ONE_D0r6 mem0 => mem0.encodingFits
  | .SHL_MEMv_CL_D3r4 mem0 => mem0.encodingFits
  | .SHL_MEMv_CL_D3r6 mem0 => mem0.encodingFits
  | .SHL_MEMv_IMMb_C1r4 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SHL_MEMv_IMMb_C1r6 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SHL_MEMv_ONE_D1r4 mem0 => mem0.encodingFits
  | .SHL_MEMv_ONE_D1r6 mem0 => mem0.encodingFits
  | .SHR_GPR8_CL _ => true
  | .SHR_GPR8_IMMb _ imm0 => imm0.encodingFits
  | .SHR_GPR8_ONE _ => true
  | .SHR_GPRv_CL _ => true
  | .SHR_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .SHR_GPRv_ONE _ => true
  | .SHR_MEMb_CL mem0 => mem0.encodingFits
  | .SHR_MEMb_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SHR_MEMb_ONE mem0 => mem0.encodingFits
  | .SHR_MEMv_CL mem0 => mem0.encodingFits
  | .SHR_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SHR_MEMv_ONE mem0 => mem0.encodingFits

end X86.Syntax
