-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SLDT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SLDT where
  -- SLDT_GPRv: REG0=GPRv_B():w REG1=XED_REG_LDTR:r:SUPP
  | SLDT_GPRv (reg0 : Registers.GPRv)
  -- SLDT_MEMw: MEM0:w:w REG0=XED_REG_LDTR:r:SUPP
  | SLDT_MEMw (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.SLDT.xedForm : Forms.SLDT → XedForm
  | .SLDT_GPRv _ => .SLDT_GPRv
  | .SLDT_MEMw _ => .SLDT_MEMw

def Forms.SLDT.encodingFits : Forms.SLDT → Bool
  | .SLDT_GPRv _ => true
  | .SLDT_MEMw mem0 => mem0.encodingFits

end X86.Syntax
