-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTDQ2PS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTDQ2PS where
  -- CVTDQ2PS_XMMps_MEMdq: REG0=XMM_R():w:ps:f32 MEM0:r:dq:i32
  | CVTDQ2PS_XMMps_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTDQ2PS_XMMps_XMMdq: REG0=XMM_R():w:ps:f32 REG1=XMM_B():r:dq:i32
  | CVTDQ2PS_XMMps_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTDQ2PS.xedForm : Forms.CVTDQ2PS → XedForm
  | .CVTDQ2PS_XMMps_MEMdq _ _ => .CVTDQ2PS_XMMps_MEMdq
  | .CVTDQ2PS_XMMps_XMMdq _ _ => .CVTDQ2PS_XMMps_XMMdq

def Forms.CVTDQ2PS.encodingFits : Forms.CVTDQ2PS → Bool
  | .CVTDQ2PS_XMMps_MEMdq _ mem0 => mem0.encodingFits
  | .CVTDQ2PS_XMMps_XMMdq _ _ => true

end X86.Syntax
