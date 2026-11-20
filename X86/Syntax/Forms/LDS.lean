-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LDS-LES-LFS-LGS-LSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LDS where
  -- LFS_GPRv_MEMp2: REG0=GPRv_R():w MEM0:r:p2 REG1=XED_REG_FS:w:SUPP
  | LFS_GPRv_MEMp2 (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- LGS_GPRv_MEMp2: REG0=GPRv_R():w MEM0:r:p2 REG1=XED_REG_GS:w:SUPP
  | LGS_GPRv_MEMp2 (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- LSS_GPRv_MEMp2: REG0=GPRv_R():w MEM0:r:p2 REG1=XED_REG_SS:w:SUPP
  | LSS_GPRv_MEMp2 (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LDS.xedForm : Forms.LDS → XedForm
  | .LFS_GPRv_MEMp2 _ _ => .LFS_GPRv_MEMp2
  | .LGS_GPRv_MEMp2 _ _ => .LGS_GPRv_MEMp2
  | .LSS_GPRv_MEMp2 _ _ => .LSS_GPRv_MEMp2

def Forms.LDS.encodingFits : Forms.LDS → Bool
  | .LFS_GPRv_MEMp2 _ mem0 => mem0.encodingFits
  | .LGS_GPRv_MEMp2 _ mem0 => mem0.encodingFits
  | .LSS_GPRv_MEMp2 _ mem0 => mem0.encodingFits

end X86.Syntax
