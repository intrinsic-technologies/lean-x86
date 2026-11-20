-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LSL.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LSL where
  -- LSL_GPRv_GPRz: REG0=GPRv_R():rw REG1=GPRz_B():r
  | LSL_GPRv_GPRz (reg0 : Registers.GPRv) (reg1 : Registers.GPRz)
  -- LSL_GPRv_MEMw: REG0=GPRv_R():rw MEM0:r:w
  | LSL_GPRv_MEMw (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LSL.xedForm : Forms.LSL → XedForm
  | .LSL_GPRv_GPRz _ _ => .LSL_GPRv_GPRz
  | .LSL_GPRv_MEMw _ _ => .LSL_GPRv_MEMw

def Forms.LSL.encodingFits : Forms.LSL → Bool
  | .LSL_GPRv_GPRz _ _ => true
  | .LSL_GPRv_MEMw _ mem0 => mem0.encodingFits

end X86.Syntax
