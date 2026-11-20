-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SIDT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SIDT where
  -- SIDT_MEMs64: MEM0:w:s64 REG0=XED_REG_IDTR:r:SUPP
  | SIDT_MEMs64 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.SIDT.xedForm : Forms.SIDT → XedForm
  | .SIDT_MEMs64 _ => .SIDT_MEMs64

def Forms.SIDT.encodingFits : Forms.SIDT → Bool
  | .SIDT_MEMs64 mem0 => mem0.encodingFits

end X86.Syntax
