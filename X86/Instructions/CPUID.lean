-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 33e8410dcfb6a0e2b69d830f572ad55cffb05e2f3cc5bde8a469061cc09eb4a6
-- The ID flag (bit 21) in the EFLAGS register indicates support for the CPUID instruction.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CPUID)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.EAX
import X86.Helpers.ECX
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.Helpers.Write_RAX
import X86.Helpers.Write_RBX
import X86.Helpers.Write_RCX
import X86.Helpers.Write_RDX
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]

def Instructions.Operations.CPUID  : Runtime.SpecM Exception (State σ) Unit := do

  if ((← get).PLATFORM_INFO.CPUID_FAULTING_EN == 1 and (← get).FEATURE_ENABLES.CPUID_GP_ON_CPL_GT_0 == 1 and (← get).CPL != 0 and not (← get).«SMM::In_SMM») then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let mut eax_in : Bits 32 ← EAX

  if ((← get).IA32_MISC_ENABLE.LIMIT_CPUID_MAXVAL == 1 and (← Runtime.CheckedSlice.read (← EAX) 31 1) == 0 and decide (Unsigned (← EAX) > 2)) then
    -- any basic leaf above 0x2 is not visible, return the value of leaf 0x2
    eax_in := 2

  let mut (eax, ebx, ecx, edx) ← Runtime.liftNoSourceException (Get_CPUID_Value eax_in (← ECX))

  if ((← get).IA32_MISC_ENABLE.LIMIT_CPUID_MAXVAL == 1 and eax_in == 0 and decide (Unsigned eax > 2)) then
    -- CPUID.00H: keep the visible maximum capped when the legacy limit is enabled.
    eax := 2

  -- Get_CPUID_Value supplies leaf 0xD results from processor inputs and XCR0/XSS.
  -- Local completion: SDM Vol. 1 section 13.2, Vol. 2 CPUID.

  Write_RAX (size := 32) eax
  Write_RBX (size := 32) ebx
  Write_RCX (size := 32) ecx
  Write_RDX (size := 32) edx

-- CPUID: 0F A2
def Instructions.CPUID
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    VM_Exit VMX_EXIT_CPUID

  modify ({ · with Next_IP := ip })

  Instructions.Operations.CPUID

end X86
