-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVZX.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVZX where
  -- MOVZX_GPR16_MEMw: REG0=GPR16_R():w MEM0:r:w
  | MOVZX_GPR16_MEMw (reg0 : Registers.GPR16) (mem0 : MemoryOperand)
  -- MOVZX_GPR32_MEMw: REG0=GPR32_R():w MEM0:r:w
  | MOVZX_GPR32_MEMw (reg0 : Registers.GPR32) (mem0 : MemoryOperand)
  -- MOVZX_GPR64_MEMw: REG0=GPR64_R():w MEM0:r:w
  | MOVZX_GPR64_MEMw (reg0 : Registers.GPR64) (mem0 : MemoryOperand)
  -- MOVZX_GPRv_GPR16: REG0=GPRv_R():w REG1=GPR16_B():r
  | MOVZX_GPRv_GPR16 (reg0 : Registers.GPRv) (reg1 : Registers.GPR16)
  -- MOVZX_GPRv_GPR8: REG0=GPRv_R():w REG1=GPR8_B():r
  | MOVZX_GPRv_GPR8 (reg0 : Registers.GPRv) (reg1 : Registers.GPR8)
  -- MOVZX_GPRv_MEMb: REG0=GPRv_R():w MEM0:r:b
  | MOVZX_GPRv_MEMb (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MOVZX.xedForm : Forms.MOVZX → XedForm
  | .MOVZX_GPR16_MEMw _ _ => .MOVZX_GPR16_MEMw
  | .MOVZX_GPR32_MEMw _ _ => .MOVZX_GPR32_MEMw
  | .MOVZX_GPR64_MEMw _ _ => .MOVZX_GPR64_MEMw
  | .MOVZX_GPRv_GPR16 _ _ => .MOVZX_GPRv_GPR16
  | .MOVZX_GPRv_GPR8 _ _ => .MOVZX_GPRv_GPR8
  | .MOVZX_GPRv_MEMb _ _ => .MOVZX_GPRv_MEMb

def Forms.MOVZX.encodingFits : Forms.MOVZX → Bool
  | .MOVZX_GPR16_MEMw _ mem0 => mem0.encodingFits
  | .MOVZX_GPR32_MEMw _ mem0 => mem0.encodingFits
  | .MOVZX_GPR64_MEMw _ mem0 => mem0.encodingFits
  | .MOVZX_GPRv_GPR16 _ _ => true
  | .MOVZX_GPRv_GPR8 _ _ => true
  | .MOVZX_GPRv_MEMb _ mem0 => mem0.encodingFits

end X86.Syntax
