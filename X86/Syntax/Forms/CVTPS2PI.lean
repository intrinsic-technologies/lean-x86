-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTPS2PI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTPS2PI where
  -- CVTPS2PI_MMXq_MEMq: REG0=MMX_R():w:q:i32 MEM0:r:q:f32
  | CVTPS2PI_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- CVTPS2PI_MMXq_XMMq: REG0=MMX_R():w:q:i32 REG1=XMM_B():r:q:f32
  | CVTPS2PI_MMXq_XMMq (reg0 : Registers.MMX) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTPS2PI.xedForm : Forms.CVTPS2PI → XedForm
  | .CVTPS2PI_MMXq_MEMq _ _ => .CVTPS2PI_MMXq_MEMq
  | .CVTPS2PI_MMXq_XMMq _ _ => .CVTPS2PI_MMXq_XMMq

def Forms.CVTPS2PI.encodingFits : Forms.CVTPS2PI → Bool
  | .CVTPS2PI_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .CVTPS2PI_MMXq_XMMq _ _ => true

end X86.Syntax
