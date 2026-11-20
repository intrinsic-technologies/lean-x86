-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTSD2SS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTSD2SS where
  -- CVTSD2SS_XMMss_MEMsd: REG0=XMM_R():rw:ss:f32 MEM0:r:sd:f64
  | CVTSD2SS_XMMss_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTSD2SS_XMMss_XMMsd: REG0=XMM_R():rw:ss:f32 REG1=XMM_B():r:sd:f64
  | CVTSD2SS_XMMss_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTSD2SS.xedForm : Forms.CVTSD2SS → XedForm
  | .CVTSD2SS_XMMss_MEMsd _ _ => .CVTSD2SS_XMMss_MEMsd
  | .CVTSD2SS_XMMss_XMMsd _ _ => .CVTSD2SS_XMMss_XMMsd

def Forms.CVTSD2SS.encodingFits : Forms.CVTSD2SS → Bool
  | .CVTSD2SS_XMMss_MEMsd _ mem0 => mem0.encodingFits
  | .CVTSD2SS_XMMss_XMMsd _ _ => true

end X86.Syntax
