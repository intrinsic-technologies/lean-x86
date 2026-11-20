-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVAPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVAPS where
  -- MOVAPS_MEMps_XMMps: MEM0:w:ps REG0=XMM_R():r:ps
  | MOVAPS_MEMps_XMMps (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVAPS_XMMps_MEMps: REG0=XMM_R():w:ps MEM0:r:ps
  | MOVAPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVAPS_XMMps_XMMps_0F28: REG0=XMM_R():w:ps REG1=XMM_B():r:ps
  | MOVAPS_XMMps_XMMps_0F28 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVAPS_XMMps_XMMps_0F29: REG0=XMM_B():w:ps REG1=XMM_R():r:ps
  | MOVAPS_XMMps_XMMps_0F29 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVAPS.xedForm : Forms.MOVAPS → XedForm
  | .MOVAPS_MEMps_XMMps _ _ => .MOVAPS_MEMps_XMMps
  | .MOVAPS_XMMps_MEMps _ _ => .MOVAPS_XMMps_MEMps
  | .MOVAPS_XMMps_XMMps_0F28 _ _ => .MOVAPS_XMMps_XMMps_0F28
  | .MOVAPS_XMMps_XMMps_0F29 _ _ => .MOVAPS_XMMps_XMMps_0F29

def Forms.MOVAPS.encodingFits : Forms.MOVAPS → Bool
  | .MOVAPS_MEMps_XMMps mem0 _ => mem0.encodingFits
  | .MOVAPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .MOVAPS_XMMps_XMMps_0F28 _ _ => true
  | .MOVAPS_XMMps_XMMps_0F29 _ _ => true

end X86.Syntax
