-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PREFETCHh.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PREFETCHh where
  -- PREFETCHNTA_MEMmprefetch: MEM0:r:mprefetch
  | PREFETCHNTA_MEMmprefetch (mem0 : MemoryOperand)
  -- PREFETCHT0_MEMmprefetch: MEM0:r:mprefetch
  | PREFETCHT0_MEMmprefetch (mem0 : MemoryOperand)
  -- PREFETCHT1_MEMmprefetch: MEM0:r:mprefetch
  | PREFETCHT1_MEMmprefetch (mem0 : MemoryOperand)
  -- PREFETCHT2_MEMmprefetch: MEM0:r:mprefetch
  | PREFETCHT2_MEMmprefetch (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.PREFETCHh.xedForm : Forms.PREFETCHh → XedForm
  | .PREFETCHNTA_MEMmprefetch _ => .PREFETCHNTA_MEMmprefetch
  | .PREFETCHT0_MEMmprefetch _ => .PREFETCHT0_MEMmprefetch
  | .PREFETCHT1_MEMmprefetch _ => .PREFETCHT1_MEMmprefetch
  | .PREFETCHT2_MEMmprefetch _ => .PREFETCHT2_MEMmprefetch

def Forms.PREFETCHh.encodingFits : Forms.PREFETCHh → Bool
  | .PREFETCHNTA_MEMmprefetch mem0 => mem0.encodingFits
  | .PREFETCHT0_MEMmprefetch mem0 => mem0.encodingFits
  | .PREFETCHT1_MEMmprefetch mem0 => mem0.encodingFits
  | .PREFETCHT2_MEMmprefetch mem0 => mem0.encodingFits

end X86.Syntax
