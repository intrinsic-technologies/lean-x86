-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LLDT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LLDT where
  -- LLDT_GPR16: REG0=GPR16_B():r REG1=XED_REG_LDTR:w:SUPP
  | LLDT_GPR16 (reg0 : Registers.GPR16)
  -- LLDT_MEMw: MEM0:r:w REG0=XED_REG_LDTR:w:SUPP
  | LLDT_MEMw (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LLDT.xedForm : Forms.LLDT → XedForm
  | .LLDT_GPR16 _ => .LLDT_GPR16
  | .LLDT_MEMw _ => .LLDT_MEMw

def Forms.LLDT.encodingFits : Forms.LLDT → Bool
  | .LLDT_GPR16 _ => true
  | .LLDT_MEMw mem0 => mem0.encodingFits

end X86.Syntax
