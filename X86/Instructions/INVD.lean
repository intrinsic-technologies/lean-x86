-- Generated from data/instruction/INVD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: b60ab9c69dd0f8aed440e6b13077b78166c98f7055e08a92062cce326bd1eae8
-- Description: data/sdm/INVD.docbook
-- Invalidates (flushes) the processor’s internal caches and issues a special-function bus cycle
-- that directs external caches to also flush themselves.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=INVD)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Cache.Invalidate
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Cache.Invalidate.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]

def Instructions.Operations.INVD  : Runtime.SpecM Exception (State σ) Unit := do
  if ((← CPUID_INVD_DISABLE_POST_BIOS_DONE) and (← get).BIOS_DONE.ENABLE_IA_UNTRUSTED == 1 or (← get).PRMRR_PHYS_MASK.VALID == 1) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  Cache.Invalidate

-- INVD: 0F 08
def Instructions.INVD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    VM_Exit VMX_EXIT_INVD

  modify ({ · with Next_IP := ip })

  Instructions.Operations.INVD

end X86
