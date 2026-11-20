-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/UD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.UD where
  -- UD0_GPR32_GPR32: REG0=GPR32_R():r REG1=GPR32_B():r
  | UD0_GPR32_GPR32 (reg0 : Registers.GPR32) (reg1 : Registers.GPR32)
  -- UD0_GPR32_MEMd: REG0=GPR32_R():r MEM0:r:d
  | UD0_GPR32_MEMd (reg0 : Registers.GPR32) (mem0 : MemoryOperand)
  -- UD1_GPR32_GPR32: REG0=GPR32_R():r REG1=GPR32_B():r
  | UD1_GPR32_GPR32 (reg0 : Registers.GPR32) (reg1 : Registers.GPR32)
  -- UD1_GPR32_MEMd: REG0=GPR32_R():r MEM0:r:d
  | UD1_GPR32_MEMd (reg0 : Registers.GPR32) (mem0 : MemoryOperand)
  -- UD2
  | UD2
  -- UDB
  | UDB
  deriving Repr, BEq, Inhabited

def Forms.UD.xedForm : Forms.UD → XedForm
  | .UD0_GPR32_GPR32 _ _ => .UD0_GPR32_GPR32
  | .UD0_GPR32_MEMd _ _ => .UD0_GPR32_MEMd
  | .UD1_GPR32_GPR32 _ _ => .UD1_GPR32_GPR32
  | .UD1_GPR32_MEMd _ _ => .UD1_GPR32_MEMd
  | .UD2 => .UD2
  | .UDB => .UDB

def Forms.UD.encodingFits : Forms.UD → Bool
  | .UD0_GPR32_GPR32 _ _ => true
  | .UD0_GPR32_MEMd _ mem0 => mem0.encodingFits
  | .UD1_GPR32_GPR32 _ _ => true
  | .UD1_GPR32_MEMd _ mem0 => mem0.encodingFits
  | .UD2  => true
  | .UDB  => true

end X86.Syntax
