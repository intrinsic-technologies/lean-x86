-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CMOVcc.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CMOVcc where
  -- CMOVBE_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVBE_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVBE_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVBE_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVB_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVB_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVB_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVB_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVLE_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVLE_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVLE_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVLE_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVL_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVL_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVL_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVL_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVNBE_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVNBE_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVNBE_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVNBE_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVNB_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVNB_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVNB_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVNB_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVNLE_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVNLE_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVNLE_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVNLE_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVNL_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVNL_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVNL_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVNL_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVNO_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVNO_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVNO_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVNO_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVNP_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVNP_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVNP_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVNP_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVNS_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVNS_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVNS_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVNS_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVNZ_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVNZ_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVNZ_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVNZ_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVO_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVO_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVO_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVO_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVP_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVP_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVP_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVP_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVS_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVS_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVS_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVS_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMOVZ_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | CMOVZ_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMOVZ_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | CMOVZ_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.CMOVcc.xedForm : Forms.CMOVcc → XedForm
  | .CMOVBE_GPRv_GPRv _ _ => .CMOVBE_GPRv_GPRv
  | .CMOVBE_GPRv_MEMv _ _ => .CMOVBE_GPRv_MEMv
  | .CMOVB_GPRv_GPRv _ _ => .CMOVB_GPRv_GPRv
  | .CMOVB_GPRv_MEMv _ _ => .CMOVB_GPRv_MEMv
  | .CMOVLE_GPRv_GPRv _ _ => .CMOVLE_GPRv_GPRv
  | .CMOVLE_GPRv_MEMv _ _ => .CMOVLE_GPRv_MEMv
  | .CMOVL_GPRv_GPRv _ _ => .CMOVL_GPRv_GPRv
  | .CMOVL_GPRv_MEMv _ _ => .CMOVL_GPRv_MEMv
  | .CMOVNBE_GPRv_GPRv _ _ => .CMOVNBE_GPRv_GPRv
  | .CMOVNBE_GPRv_MEMv _ _ => .CMOVNBE_GPRv_MEMv
  | .CMOVNB_GPRv_GPRv _ _ => .CMOVNB_GPRv_GPRv
  | .CMOVNB_GPRv_MEMv _ _ => .CMOVNB_GPRv_MEMv
  | .CMOVNLE_GPRv_GPRv _ _ => .CMOVNLE_GPRv_GPRv
  | .CMOVNLE_GPRv_MEMv _ _ => .CMOVNLE_GPRv_MEMv
  | .CMOVNL_GPRv_GPRv _ _ => .CMOVNL_GPRv_GPRv
  | .CMOVNL_GPRv_MEMv _ _ => .CMOVNL_GPRv_MEMv
  | .CMOVNO_GPRv_GPRv _ _ => .CMOVNO_GPRv_GPRv
  | .CMOVNO_GPRv_MEMv _ _ => .CMOVNO_GPRv_MEMv
  | .CMOVNP_GPRv_GPRv _ _ => .CMOVNP_GPRv_GPRv
  | .CMOVNP_GPRv_MEMv _ _ => .CMOVNP_GPRv_MEMv
  | .CMOVNS_GPRv_GPRv _ _ => .CMOVNS_GPRv_GPRv
  | .CMOVNS_GPRv_MEMv _ _ => .CMOVNS_GPRv_MEMv
  | .CMOVNZ_GPRv_GPRv _ _ => .CMOVNZ_GPRv_GPRv
  | .CMOVNZ_GPRv_MEMv _ _ => .CMOVNZ_GPRv_MEMv
  | .CMOVO_GPRv_GPRv _ _ => .CMOVO_GPRv_GPRv
  | .CMOVO_GPRv_MEMv _ _ => .CMOVO_GPRv_MEMv
  | .CMOVP_GPRv_GPRv _ _ => .CMOVP_GPRv_GPRv
  | .CMOVP_GPRv_MEMv _ _ => .CMOVP_GPRv_MEMv
  | .CMOVS_GPRv_GPRv _ _ => .CMOVS_GPRv_GPRv
  | .CMOVS_GPRv_MEMv _ _ => .CMOVS_GPRv_MEMv
  | .CMOVZ_GPRv_GPRv _ _ => .CMOVZ_GPRv_GPRv
  | .CMOVZ_GPRv_MEMv _ _ => .CMOVZ_GPRv_MEMv

def Forms.CMOVcc.encodingFits : Forms.CMOVcc → Bool
  | .CMOVBE_GPRv_GPRv _ _ => true
  | .CMOVBE_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVB_GPRv_GPRv _ _ => true
  | .CMOVB_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVLE_GPRv_GPRv _ _ => true
  | .CMOVLE_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVL_GPRv_GPRv _ _ => true
  | .CMOVL_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVNBE_GPRv_GPRv _ _ => true
  | .CMOVNBE_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVNB_GPRv_GPRv _ _ => true
  | .CMOVNB_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVNLE_GPRv_GPRv _ _ => true
  | .CMOVNLE_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVNL_GPRv_GPRv _ _ => true
  | .CMOVNL_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVNO_GPRv_GPRv _ _ => true
  | .CMOVNO_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVNP_GPRv_GPRv _ _ => true
  | .CMOVNP_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVNS_GPRv_GPRv _ _ => true
  | .CMOVNS_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVNZ_GPRv_GPRv _ _ => true
  | .CMOVNZ_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVO_GPRv_GPRv _ _ => true
  | .CMOVO_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVP_GPRv_GPRv _ _ => true
  | .CMOVP_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVS_GPRv_GPRv _ _ => true
  | .CMOVS_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMOVZ_GPRv_GPRv _ _ => true
  | .CMOVZ_GPRv_MEMv _ mem0 => mem0.encodingFits

end X86.Syntax
