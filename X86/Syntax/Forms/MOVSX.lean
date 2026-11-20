-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVSX-MOVSXD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVSX where
  -- MOVSXD_GPR64_MEMd: REG0=GPR64_R():w MEM0:r:d
  | MOVSXD_GPR64_MEMd (reg0 : Registers.GPR64) (mem0 : MemoryOperand)
  -- MOVSXD_GPRv_GPRz: REG0=GPRv_R():w REG1=GPRz_B():r
  | MOVSXD_GPRv_GPRz (reg0 : Registers.GPRv) (reg1 : Registers.GPRz)
  -- MOVSXD_GPRz_MEMz: REG0=GPRz_R():w MEM0:r:z
  | MOVSXD_GPRz_MEMz (reg0 : Registers.GPRz) (mem0 : MemoryOperand)
  -- MOVSX_GPR16_MEMw: REG0=GPR16_R():w MEM0:r:w
  | MOVSX_GPR16_MEMw (reg0 : Registers.GPR16) (mem0 : MemoryOperand)
  -- MOVSX_GPR32_MEMw: REG0=GPR32_R():w MEM0:r:w
  | MOVSX_GPR32_MEMw (reg0 : Registers.GPR32) (mem0 : MemoryOperand)
  -- MOVSX_GPR64_MEMw: REG0=GPR64_R():w MEM0:r:w
  | MOVSX_GPR64_MEMw (reg0 : Registers.GPR64) (mem0 : MemoryOperand)
  -- MOVSX_GPRv_GPR16: REG0=GPRv_R():w REG1=GPR16_B():r
  | MOVSX_GPRv_GPR16 (reg0 : Registers.GPRv) (reg1 : Registers.GPR16)
  -- MOVSX_GPRv_GPR8: REG0=GPRv_R():w REG1=GPR8_B():r
  | MOVSX_GPRv_GPR8 (reg0 : Registers.GPRv) (reg1 : Registers.GPR8)
  -- MOVSX_GPRv_MEMb: REG0=GPRv_R():w MEM0:r:b
  | MOVSX_GPRv_MEMb (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MOVSX.xedForm : Forms.MOVSX → XedForm
  | .MOVSXD_GPR64_MEMd _ _ => .MOVSXD_GPR64_MEMd
  | .MOVSXD_GPRv_GPRz _ _ => .MOVSXD_GPRv_GPRz
  | .MOVSXD_GPRz_MEMz _ _ => .MOVSXD_GPRz_MEMz
  | .MOVSX_GPR16_MEMw _ _ => .MOVSX_GPR16_MEMw
  | .MOVSX_GPR32_MEMw _ _ => .MOVSX_GPR32_MEMw
  | .MOVSX_GPR64_MEMw _ _ => .MOVSX_GPR64_MEMw
  | .MOVSX_GPRv_GPR16 _ _ => .MOVSX_GPRv_GPR16
  | .MOVSX_GPRv_GPR8 _ _ => .MOVSX_GPRv_GPR8
  | .MOVSX_GPRv_MEMb _ _ => .MOVSX_GPRv_MEMb

def Forms.MOVSX.encodingFits : Forms.MOVSX → Bool
  | .MOVSXD_GPR64_MEMd _ mem0 => mem0.encodingFits
  | .MOVSXD_GPRv_GPRz _ _ => true
  | .MOVSXD_GPRz_MEMz _ mem0 => mem0.encodingFits
  | .MOVSX_GPR16_MEMw _ mem0 => mem0.encodingFits
  | .MOVSX_GPR32_MEMw _ mem0 => mem0.encodingFits
  | .MOVSX_GPR64_MEMw _ mem0 => mem0.encodingFits
  | .MOVSX_GPRv_GPR16 _ _ => true
  | .MOVSX_GPRv_GPR8 _ _ => true
  | .MOVSX_GPRv_MEMb _ mem0 => mem0.encodingFits

end X86.Syntax
