-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CALL.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CALL where
  -- CALL_FAR_MEMp2: MEM0:r:p2 REG0=XED_REG_STACKPUSH:rw:spw2:SUPP REG1=rIP():w:SUPP
  | CALL_FAR_MEMp2 (mem0 : MemoryOperand)
  -- CALL_NEAR_GPRv: REG0=GPRv_B():r REG1=XED_REG_STACKPUSH:rw:spw:SUPP REG2=rIP():rw:SUPP
  | CALL_NEAR_GPRv (reg0 : Registers.GPRv)
  -- CALL_NEAR_MEMv: MEM0:r:v REG0=XED_REG_STACKPUSH:rw:spw:SUPP REG1=rIP():rw:SUPP
  | CALL_NEAR_MEMv (mem0 : MemoryOperand)
  -- CALL_NEAR_RELBRd: RELBR:r:d REG0=XED_REG_STACKPUSH:rw:spw:SUPP REG1=XED_REG_RIP:rw:SUPP
  | CALL_NEAR_RELBRd (relbr : RelativeOperand)
  deriving Repr, BEq, Inhabited

def Forms.CALL.xedForm : Forms.CALL → XedForm
  | .CALL_FAR_MEMp2 _ => .CALL_FAR_MEMp2
  | .CALL_NEAR_GPRv _ => .CALL_NEAR_GPRv
  | .CALL_NEAR_MEMv _ => .CALL_NEAR_MEMv
  | .CALL_NEAR_RELBRd _ => .CALL_NEAR_RELBRd

def Forms.CALL.encodingFits : Forms.CALL → Bool
  | .CALL_FAR_MEMp2 mem0 => mem0.encodingFits
  | .CALL_NEAR_GPRv _ => true
  | .CALL_NEAR_MEMv mem0 => mem0.encodingFits
  | .CALL_NEAR_RELBRd relbr => relbr.encodingFits

end X86.Syntax
