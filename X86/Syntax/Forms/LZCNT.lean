-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LZCNT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LZCNT where
  -- LZCNT_GPRv_GPRv: REG0=GPRv_R():w:v     REG1=GPRv_B():r:v
  | LZCNT_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- LZCNT_GPRv_MEMv: REG0=GPRv_R():w:v     MEM0:r:v
  | LZCNT_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LZCNT.xedForm : Forms.LZCNT → XedForm
  | .LZCNT_GPRv_GPRv _ _ => .LZCNT_GPRv_GPRv
  | .LZCNT_GPRv_MEMv _ _ => .LZCNT_GPRv_MEMv

def Forms.LZCNT.encodingFits : Forms.LZCNT → Bool
  | .LZCNT_GPRv_GPRv _ _ => true
  | .LZCNT_GPRv_MEMv _ mem0 => mem0.encodingFits

end X86.Syntax
