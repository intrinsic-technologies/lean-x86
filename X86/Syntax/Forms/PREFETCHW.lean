-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PREFETCHW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PREFETCHW where
  -- PREFETCHW_0F0Dr1: MEM0:r:mprefetch
  | PREFETCHW_0F0Dr1 (mem0 : MemoryOperand)
  -- PREFETCHW_0F0Dr3: MEM0:r:mprefetch
  | PREFETCHW_0F0Dr3 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.PREFETCHW.xedForm : Forms.PREFETCHW → XedForm
  | .PREFETCHW_0F0Dr1 _ => .PREFETCHW_0F0Dr1
  | .PREFETCHW_0F0Dr3 _ => .PREFETCHW_0F0Dr3

def Forms.PREFETCHW.encodingFits : Forms.PREFETCHW → Bool
  | .PREFETCHW_0F0Dr1 mem0 => mem0.encodingFits
  | .PREFETCHW_0F0Dr3 mem0 => mem0.encodingFits

end X86.Syntax
