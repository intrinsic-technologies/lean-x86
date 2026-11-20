-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTSS2SD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTSS2SD where
  -- CVTSS2SD_XMMsd_MEMss: REG0=XMM_R():rw:sd:f64 MEM0:r:ss:f32
  | CVTSS2SD_XMMsd_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTSS2SD_XMMsd_XMMss: REG0=XMM_R():rw:sd:f64 REG1=XMM_B():r:ss:f32
  | CVTSS2SD_XMMsd_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTSS2SD.xedForm : Forms.CVTSS2SD → XedForm
  | .CVTSS2SD_XMMsd_MEMss _ _ => .CVTSS2SD_XMMsd_MEMss
  | .CVTSS2SD_XMMsd_XMMss _ _ => .CVTSS2SD_XMMsd_XMMss

def Forms.CVTSS2SD.encodingFits : Forms.CVTSS2SD → Bool
  | .CVTSS2SD_XMMsd_MEMss _ mem0 => mem0.encodingFits
  | .CVTSS2SD_XMMsd_XMMss _ _ => true

end X86.Syntax
