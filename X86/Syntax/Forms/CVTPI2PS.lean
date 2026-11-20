-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTPI2PS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTPI2PS where
  -- CVTPI2PS_XMMq_MEMq: REG0=XMM_R():rw:q:f32 MEM0:r:q:i32
  | CVTPI2PS_XMMq_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTPI2PS_XMMq_MMXq: REG0=XMM_R():rw:q:f32 REG1=MMX_B():r:q:i32
  | CVTPI2PS_XMMq_MMXq (reg0 : Registers.XMM) (reg1 : Registers.MMX)
  deriving Repr, BEq, Inhabited

def Forms.CVTPI2PS.xedForm : Forms.CVTPI2PS → XedForm
  | .CVTPI2PS_XMMq_MEMq _ _ => .CVTPI2PS_XMMq_MEMq
  | .CVTPI2PS_XMMq_MMXq _ _ => .CVTPI2PS_XMMq_MMXq

def Forms.CVTPI2PS.encodingFits : Forms.CVTPI2PS → Bool
  | .CVTPI2PS_XMMq_MEMq _ mem0 => mem0.encodingFits
  | .CVTPI2PS_XMMq_MMXq _ _ => true

end X86.Syntax
