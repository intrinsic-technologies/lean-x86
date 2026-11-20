-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVUPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVUPS where
  -- MOVUPS_MEMps_XMMps: MEM0:w:ps REG0=XMM_R():r:ps
  | MOVUPS_MEMps_XMMps (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVUPS_XMMps_MEMps: REG0=XMM_R():w:ps MEM0:r:ps
  | MOVUPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVUPS_XMMps_XMMps_0F10: REG0=XMM_R():w:ps REG1=XMM_B():r:ps
  | MOVUPS_XMMps_XMMps_0F10 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVUPS_XMMps_XMMps_0F11: REG0=XMM_B():w:ps REG1=XMM_R():r:ps
  | MOVUPS_XMMps_XMMps_0F11 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVUPS.xedForm : Forms.MOVUPS → XedForm
  | .MOVUPS_MEMps_XMMps _ _ => .MOVUPS_MEMps_XMMps
  | .MOVUPS_XMMps_MEMps _ _ => .MOVUPS_XMMps_MEMps
  | .MOVUPS_XMMps_XMMps_0F10 _ _ => .MOVUPS_XMMps_XMMps_0F10
  | .MOVUPS_XMMps_XMMps_0F11 _ _ => .MOVUPS_XMMps_XMMps_0F11

def Forms.MOVUPS.encodingFits : Forms.MOVUPS → Bool
  | .MOVUPS_MEMps_XMMps mem0 _ => mem0.encodingFits
  | .MOVUPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .MOVUPS_XMMps_XMMps_0F10 _ _ => true
  | .MOVUPS_XMMps_XMMps_0F11 _ _ => true

end X86.Syntax
