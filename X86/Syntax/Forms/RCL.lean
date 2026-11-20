-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/RCL-RCR-ROL-ROR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.RCL where
  -- RCL_GPR8_CL: REG0=GPR8_B():rw REG1=XED_REG_CL:r:IMPL
  | RCL_GPR8_CL (reg0 : Registers.GPR8)
  -- RCL_GPR8_IMMb: REG0=GPR8_B():rw IMM0:r:b
  | RCL_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- RCL_GPR8_ONE: REG0=GPR8_B():rw IMM0:r:b:IMPL
  | RCL_GPR8_ONE (reg0 : Registers.GPR8)
  -- RCL_GPRv_CL: REG0=GPRv_B():rw REG1=XED_REG_CL:r:IMPL
  | RCL_GPRv_CL (reg0 : Registers.GPRv)
  -- RCL_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | RCL_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- RCL_GPRv_ONE: REG0=GPRv_B():rw IMM0:r:b:IMPL
  | RCL_GPRv_ONE (reg0 : Registers.GPRv)
  -- RCL_MEMb_CL: MEM0:rw:b REG0=XED_REG_CL:r:IMPL
  | RCL_MEMb_CL (mem0 : MemoryOperand)
  -- RCL_MEMb_IMMb: MEM0:rw:b IMM0:r:b
  | RCL_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- RCL_MEMb_ONE: MEM0:rw:b IMM0:r:b:IMPL
  | RCL_MEMb_ONE (mem0 : MemoryOperand)
  -- RCL_MEMv_CL: MEM0:rw:v REG0=XED_REG_CL:r:IMPL
  | RCL_MEMv_CL (mem0 : MemoryOperand)
  -- RCL_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | RCL_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- RCL_MEMv_ONE: MEM0:rw:v IMM0:r:b:IMPL
  | RCL_MEMv_ONE (mem0 : MemoryOperand)
  -- RCR_GPR8_CL: REG0=GPR8_B():rw REG1=XED_REG_CL:r:IMPL
  | RCR_GPR8_CL (reg0 : Registers.GPR8)
  -- RCR_GPR8_IMMb: REG0=GPR8_B():rw IMM0:r:b
  | RCR_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- RCR_GPR8_ONE: REG0=GPR8_B():rw IMM0:r:b:IMPL
  | RCR_GPR8_ONE (reg0 : Registers.GPR8)
  -- RCR_GPRv_CL: REG0=GPRv_B():rw REG1=XED_REG_CL:r:IMPL
  | RCR_GPRv_CL (reg0 : Registers.GPRv)
  -- RCR_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | RCR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- RCR_GPRv_ONE: REG0=GPRv_B():rw IMM0:r:b:IMPL
  | RCR_GPRv_ONE (reg0 : Registers.GPRv)
  -- RCR_MEMb_CL: MEM0:rw:b REG0=XED_REG_CL:r:IMPL
  | RCR_MEMb_CL (mem0 : MemoryOperand)
  -- RCR_MEMb_IMMb: MEM0:rw:b IMM0:r:b
  | RCR_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- RCR_MEMb_ONE: MEM0:rw:b IMM0:r:b:IMPL
  | RCR_MEMb_ONE (mem0 : MemoryOperand)
  -- RCR_MEMv_CL: MEM0:rw:v REG0=XED_REG_CL:r:IMPL
  | RCR_MEMv_CL (mem0 : MemoryOperand)
  -- RCR_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | RCR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- RCR_MEMv_ONE: MEM0:rw:v IMM0:r:b:IMPL
  | RCR_MEMv_ONE (mem0 : MemoryOperand)
  -- ROL_GPR8_CL: REG0=GPR8_B():rw REG1=XED_REG_CL:r:IMPL
  | ROL_GPR8_CL (reg0 : Registers.GPR8)
  -- ROL_GPR8_IMMb: REG0=GPR8_B():rw IMM0:r:b
  | ROL_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- ROL_GPR8_ONE: REG0=GPR8_B():rw IMM0:r:b:IMPL
  | ROL_GPR8_ONE (reg0 : Registers.GPR8)
  -- ROL_GPRv_CL: REG0=GPRv_B():rw REG1=XED_REG_CL:r:IMPL
  | ROL_GPRv_CL (reg0 : Registers.GPRv)
  -- ROL_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | ROL_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- ROL_GPRv_ONE: REG0=GPRv_B():rw IMM0:r:b:IMPL
  | ROL_GPRv_ONE (reg0 : Registers.GPRv)
  -- ROL_MEMb_CL: MEM0:rw:b REG0=XED_REG_CL:r:IMPL
  | ROL_MEMb_CL (mem0 : MemoryOperand)
  -- ROL_MEMb_IMMb: MEM0:rw:b IMM0:r:b
  | ROL_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ROL_MEMb_ONE: MEM0:rw:b IMM0:r:b:IMPL
  | ROL_MEMb_ONE (mem0 : MemoryOperand)
  -- ROL_MEMv_CL: MEM0:rw:v REG0=XED_REG_CL:r:IMPL
  | ROL_MEMv_CL (mem0 : MemoryOperand)
  -- ROL_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | ROL_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ROL_MEMv_ONE: MEM0:rw:v IMM0:r:b:IMPL
  | ROL_MEMv_ONE (mem0 : MemoryOperand)
  -- ROR_GPR8_CL: REG0=GPR8_B():rw REG1=XED_REG_CL:r:IMPL
  | ROR_GPR8_CL (reg0 : Registers.GPR8)
  -- ROR_GPR8_IMMb: REG0=GPR8_B():rw IMM0:r:b
  | ROR_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- ROR_GPR8_ONE: REG0=GPR8_B():rw IMM0:r:b:IMPL
  | ROR_GPR8_ONE (reg0 : Registers.GPR8)
  -- ROR_GPRv_CL: REG0=GPRv_B():rw REG1=XED_REG_CL:r:IMPL
  | ROR_GPRv_CL (reg0 : Registers.GPRv)
  -- ROR_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b
  | ROR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- ROR_GPRv_ONE: REG0=GPRv_B():rw IMM0:r:b:IMPL
  | ROR_GPRv_ONE (reg0 : Registers.GPRv)
  -- ROR_MEMb_CL: MEM0:rw:b REG0=XED_REG_CL:r:IMPL
  | ROR_MEMb_CL (mem0 : MemoryOperand)
  -- ROR_MEMb_IMMb: MEM0:rw:b IMM0:r:b
  | ROR_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ROR_MEMb_ONE: MEM0:rw:b IMM0:r:b:IMPL
  | ROR_MEMb_ONE (mem0 : MemoryOperand)
  -- ROR_MEMv_CL: MEM0:rw:v REG0=XED_REG_CL:r:IMPL
  | ROR_MEMv_CL (mem0 : MemoryOperand)
  -- ROR_MEMv_IMMb: MEM0:rw:v IMM0:r:b
  | ROR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ROR_MEMv_ONE: MEM0:rw:v IMM0:r:b:IMPL
  | ROR_MEMv_ONE (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.RCL.xedForm : Forms.RCL → XedForm
  | .RCL_GPR8_CL _ => .RCL_GPR8_CL
  | .RCL_GPR8_IMMb _ _ => .RCL_GPR8_IMMb
  | .RCL_GPR8_ONE _ => .RCL_GPR8_ONE
  | .RCL_GPRv_CL _ => .RCL_GPRv_CL
  | .RCL_GPRv_IMMb _ _ => .RCL_GPRv_IMMb
  | .RCL_GPRv_ONE _ => .RCL_GPRv_ONE
  | .RCL_MEMb_CL _ => .RCL_MEMb_CL
  | .RCL_MEMb_IMMb _ _ => .RCL_MEMb_IMMb
  | .RCL_MEMb_ONE _ => .RCL_MEMb_ONE
  | .RCL_MEMv_CL _ => .RCL_MEMv_CL
  | .RCL_MEMv_IMMb _ _ => .RCL_MEMv_IMMb
  | .RCL_MEMv_ONE _ => .RCL_MEMv_ONE
  | .RCR_GPR8_CL _ => .RCR_GPR8_CL
  | .RCR_GPR8_IMMb _ _ => .RCR_GPR8_IMMb
  | .RCR_GPR8_ONE _ => .RCR_GPR8_ONE
  | .RCR_GPRv_CL _ => .RCR_GPRv_CL
  | .RCR_GPRv_IMMb _ _ => .RCR_GPRv_IMMb
  | .RCR_GPRv_ONE _ => .RCR_GPRv_ONE
  | .RCR_MEMb_CL _ => .RCR_MEMb_CL
  | .RCR_MEMb_IMMb _ _ => .RCR_MEMb_IMMb
  | .RCR_MEMb_ONE _ => .RCR_MEMb_ONE
  | .RCR_MEMv_CL _ => .RCR_MEMv_CL
  | .RCR_MEMv_IMMb _ _ => .RCR_MEMv_IMMb
  | .RCR_MEMv_ONE _ => .RCR_MEMv_ONE
  | .ROL_GPR8_CL _ => .ROL_GPR8_CL
  | .ROL_GPR8_IMMb _ _ => .ROL_GPR8_IMMb
  | .ROL_GPR8_ONE _ => .ROL_GPR8_ONE
  | .ROL_GPRv_CL _ => .ROL_GPRv_CL
  | .ROL_GPRv_IMMb _ _ => .ROL_GPRv_IMMb
  | .ROL_GPRv_ONE _ => .ROL_GPRv_ONE
  | .ROL_MEMb_CL _ => .ROL_MEMb_CL
  | .ROL_MEMb_IMMb _ _ => .ROL_MEMb_IMMb
  | .ROL_MEMb_ONE _ => .ROL_MEMb_ONE
  | .ROL_MEMv_CL _ => .ROL_MEMv_CL
  | .ROL_MEMv_IMMb _ _ => .ROL_MEMv_IMMb
  | .ROL_MEMv_ONE _ => .ROL_MEMv_ONE
  | .ROR_GPR8_CL _ => .ROR_GPR8_CL
  | .ROR_GPR8_IMMb _ _ => .ROR_GPR8_IMMb
  | .ROR_GPR8_ONE _ => .ROR_GPR8_ONE
  | .ROR_GPRv_CL _ => .ROR_GPRv_CL
  | .ROR_GPRv_IMMb _ _ => .ROR_GPRv_IMMb
  | .ROR_GPRv_ONE _ => .ROR_GPRv_ONE
  | .ROR_MEMb_CL _ => .ROR_MEMb_CL
  | .ROR_MEMb_IMMb _ _ => .ROR_MEMb_IMMb
  | .ROR_MEMb_ONE _ => .ROR_MEMb_ONE
  | .ROR_MEMv_CL _ => .ROR_MEMv_CL
  | .ROR_MEMv_IMMb _ _ => .ROR_MEMv_IMMb
  | .ROR_MEMv_ONE _ => .ROR_MEMv_ONE

def Forms.RCL.encodingFits : Forms.RCL → Bool
  | .RCL_GPR8_CL _ => true
  | .RCL_GPR8_IMMb _ imm0 => imm0.encodingFits
  | .RCL_GPR8_ONE _ => true
  | .RCL_GPRv_CL _ => true
  | .RCL_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .RCL_GPRv_ONE _ => true
  | .RCL_MEMb_CL mem0 => mem0.encodingFits
  | .RCL_MEMb_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .RCL_MEMb_ONE mem0 => mem0.encodingFits
  | .RCL_MEMv_CL mem0 => mem0.encodingFits
  | .RCL_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .RCL_MEMv_ONE mem0 => mem0.encodingFits
  | .RCR_GPR8_CL _ => true
  | .RCR_GPR8_IMMb _ imm0 => imm0.encodingFits
  | .RCR_GPR8_ONE _ => true
  | .RCR_GPRv_CL _ => true
  | .RCR_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .RCR_GPRv_ONE _ => true
  | .RCR_MEMb_CL mem0 => mem0.encodingFits
  | .RCR_MEMb_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .RCR_MEMb_ONE mem0 => mem0.encodingFits
  | .RCR_MEMv_CL mem0 => mem0.encodingFits
  | .RCR_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .RCR_MEMv_ONE mem0 => mem0.encodingFits
  | .ROL_GPR8_CL _ => true
  | .ROL_GPR8_IMMb _ imm0 => imm0.encodingFits
  | .ROL_GPR8_ONE _ => true
  | .ROL_GPRv_CL _ => true
  | .ROL_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .ROL_GPRv_ONE _ => true
  | .ROL_MEMb_CL mem0 => mem0.encodingFits
  | .ROL_MEMb_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ROL_MEMb_ONE mem0 => mem0.encodingFits
  | .ROL_MEMv_CL mem0 => mem0.encodingFits
  | .ROL_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ROL_MEMv_ONE mem0 => mem0.encodingFits
  | .ROR_GPR8_CL _ => true
  | .ROR_GPR8_IMMb _ imm0 => imm0.encodingFits
  | .ROR_GPR8_ONE _ => true
  | .ROR_GPRv_CL _ => true
  | .ROR_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .ROR_GPRv_ONE _ => true
  | .ROR_MEMb_CL mem0 => mem0.encodingFits
  | .ROR_MEMb_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ROR_MEMb_ONE mem0 => mem0.encodingFits
  | .ROR_MEMv_CL mem0 => mem0.encodingFits
  | .ROR_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ROR_MEMv_ONE mem0 => mem0.encodingFits

end X86.Syntax
