-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTSI2SD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTSI2SD where
  -- CVTSI2SD_XMMsd_GPR32d: REG0=XMM_R():rw:sd:f64 REG1=GPR32_B():r:d:i32
  | CVTSI2SD_XMMsd_GPR32d (reg0 : Registers.XMM) (reg1 : Registers.GPR32)
  -- CVTSI2SD_XMMsd_GPR64q: REG0=XMM_R():rw:sd:f64 REG1=GPR64_B():r:q:i64
  | CVTSI2SD_XMMsd_GPR64q (reg0 : Registers.XMM) (reg1 : Registers.GPR64)
  -- CVTSI2SD_XMMsd_MEMd: REG0=XMM_R():rw:sd:f64 MEM0:r:d:i32
  | CVTSI2SD_XMMsd_MEMd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTSI2SD_XMMsd_MEMq: REG0=XMM_R():rw:sd:f64 MEM0:r:q:i64
  | CVTSI2SD_XMMsd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.CVTSI2SD.xedForm : Forms.CVTSI2SD → XedForm
  | .CVTSI2SD_XMMsd_GPR32d _ _ => .CVTSI2SD_XMMsd_GPR32d
  | .CVTSI2SD_XMMsd_GPR64q _ _ => .CVTSI2SD_XMMsd_GPR64q
  | .CVTSI2SD_XMMsd_MEMd _ _ => .CVTSI2SD_XMMsd_MEMd
  | .CVTSI2SD_XMMsd_MEMq _ _ => .CVTSI2SD_XMMsd_MEMq

def Forms.CVTSI2SD.encodingFits : Forms.CVTSI2SD → Bool
  | .CVTSI2SD_XMMsd_GPR32d _ _ => true
  | .CVTSI2SD_XMMsd_GPR64q _ _ => true
  | .CVTSI2SD_XMMsd_MEMd _ mem0 => mem0.encodingFits
  | .CVTSI2SD_XMMsd_MEMq _ mem0 => mem0.encodingFits

end X86.Syntax
