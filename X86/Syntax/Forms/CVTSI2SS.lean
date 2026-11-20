-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTSI2SS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTSI2SS where
  -- CVTSI2SS_XMMss_GPR32d: REG0=XMM_R():rw:ss:f32 REG1=GPR32_B():r:d:i32
  | CVTSI2SS_XMMss_GPR32d (reg0 : Registers.XMM) (reg1 : Registers.GPR32)
  -- CVTSI2SS_XMMss_GPR64q: REG0=XMM_R():rw:ss:f32 REG1=GPR64_B():r:q:i32
  | CVTSI2SS_XMMss_GPR64q (reg0 : Registers.XMM) (reg1 : Registers.GPR64)
  -- CVTSI2SS_XMMss_MEMd: REG0=XMM_R():rw:ss:f32 MEM0:r:d:i32
  | CVTSI2SS_XMMss_MEMd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTSI2SS_XMMss_MEMq: REG0=XMM_R():rw:ss:f32 MEM0:r:q:i32
  | CVTSI2SS_XMMss_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.CVTSI2SS.xedForm : Forms.CVTSI2SS → XedForm
  | .CVTSI2SS_XMMss_GPR32d _ _ => .CVTSI2SS_XMMss_GPR32d
  | .CVTSI2SS_XMMss_GPR64q _ _ => .CVTSI2SS_XMMss_GPR64q
  | .CVTSI2SS_XMMss_MEMd _ _ => .CVTSI2SS_XMMss_MEMd
  | .CVTSI2SS_XMMss_MEMq _ _ => .CVTSI2SS_XMMss_MEMq

def Forms.CVTSI2SS.encodingFits : Forms.CVTSI2SS → Bool
  | .CVTSI2SS_XMMss_GPR32d _ _ => true
  | .CVTSI2SS_XMMss_GPR64q _ _ => true
  | .CVTSI2SS_XMMss_MEMd _ mem0 => mem0.encodingFits
  | .CVTSI2SS_XMMss_MEMq _ mem0 => mem0.encodingFits

end X86.Syntax
