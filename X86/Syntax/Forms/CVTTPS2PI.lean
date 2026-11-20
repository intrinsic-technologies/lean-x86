-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTTPS2PI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTTPS2PI where
  -- CVTTPS2PI_MMXq_MEMq: REG0=MMX_R():w:q:i32 MEM0:r:q:f32
  | CVTTPS2PI_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- CVTTPS2PI_MMXq_XMMq: REG0=MMX_R():w:q:i32 REG1=XMM_B():r:q:f32
  | CVTTPS2PI_MMXq_XMMq (reg0 : Registers.MMX) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTTPS2PI.xedForm : Forms.CVTTPS2PI → XedForm
  | .CVTTPS2PI_MMXq_MEMq _ _ => .CVTTPS2PI_MMXq_MEMq
  | .CVTTPS2PI_MMXq_XMMq _ _ => .CVTTPS2PI_MMXq_XMMq

def Forms.CVTTPS2PI.encodingFits : Forms.CVTTPS2PI → Bool
  | .CVTTPS2PI_MMXq_MEMq _ mem0 => mem0.encodingFits
  | .CVTTPS2PI_MMXq_XMMq _ _ => true

end X86.Syntax
