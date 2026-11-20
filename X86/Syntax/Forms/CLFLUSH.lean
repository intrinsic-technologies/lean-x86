-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CLFLUSH.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CLFLUSH where
  -- CLFLUSH_MEMmprefetch: MEM0:r:mprefetch
  | CLFLUSH_MEMmprefetch (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.CLFLUSH.xedForm : Forms.CLFLUSH → XedForm
  | .CLFLUSH_MEMmprefetch _ => .CLFLUSH_MEMmprefetch

def Forms.CLFLUSH.encodingFits : Forms.CLFLUSH → Bool
  | .CLFLUSH_MEMmprefetch mem0 => mem0.encodingFits

end X86.Syntax
