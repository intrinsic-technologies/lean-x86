-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SGDT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SGDT where
  -- SGDT_MEMs64: MEM0:w:s64 REG0=XED_REG_GDTR:r:SUPP
  | SGDT_MEMs64 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.SGDT.xedForm : Forms.SGDT → XedForm
  | .SGDT_MEMs64 _ => .SGDT_MEMs64

def Forms.SGDT.encodingFits : Forms.SGDT → Bool
  | .SGDT_MEMs64 mem0 => mem0.encodingFits

end X86.Syntax
