-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/VERR-VERW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.VERR where
  -- VERR_GPR16: REG0=GPR16_B():r
  | VERR_GPR16 (reg0 : Registers.GPR16)
  -- VERR_MEMw: MEM0:r:w
  | VERR_MEMw (mem0 : MemoryOperand)
  -- VERW_GPR16: REG0=GPR16_B():r
  | VERW_GPR16 (reg0 : Registers.GPR16)
  -- VERW_MEMw: MEM0:r:w
  | VERW_MEMw (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.VERR.xedForm : Forms.VERR → XedForm
  | .VERR_GPR16 _ => .VERR_GPR16
  | .VERR_MEMw _ => .VERR_MEMw
  | .VERW_GPR16 _ => .VERW_GPR16
  | .VERW_MEMw _ => .VERW_MEMw

def Forms.VERR.encodingFits : Forms.VERR → Bool
  | .VERR_GPR16 _ => true
  | .VERR_MEMw mem0 => mem0.encodingFits
  | .VERW_GPR16 _ => true
  | .VERW_MEMw mem0 => mem0.encodingFits

end X86.Syntax
