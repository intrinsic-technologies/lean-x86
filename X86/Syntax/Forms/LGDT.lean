-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LGDT-LIDT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LGDT where
  -- LGDT_MEMs64: MEM0:r:s64 REG0=XED_REG_GDTR:w:SUPP
  | LGDT_MEMs64 (mem0 : MemoryOperand)
  -- LIDT_MEMs64: MEM0:r:s64 REG0=XED_REG_IDTR:w:SUPP
  | LIDT_MEMs64 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LGDT.xedForm : Forms.LGDT → XedForm
  | .LGDT_MEMs64 _ => .LGDT_MEMs64
  | .LIDT_MEMs64 _ => .LIDT_MEMs64

def Forms.LGDT.encodingFits : Forms.LGDT → Bool
  | .LGDT_MEMs64 mem0 => mem0.encodingFits
  | .LIDT_MEMs64 mem0 => mem0.encodingFits

end X86.Syntax
