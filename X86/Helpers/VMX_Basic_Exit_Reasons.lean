-- Generated from data/definitions.xml.gz: VMX Basic Exit Reasons; do not edit.
-- Source SHA256: f034e8daf1975bf00468bce233b1f3496dfecf6c7d54e3bdb7ac2a5c2f3d3cf0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%20Basic%20Exit%20Reasons)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def VMX_EXIT_EXCEPTION_NMI : Bits 16 := (0 : Bits 16)

def VMX_EXIT_EXTERNAL_INTERRUPT : Bits 16 := (1 : Bits 16)

def VMX_EXIT_CPUID : Bits 16 := (10 : Bits 16)

def VMX_EXIT_HLT : Bits 16 := (12 : Bits 16)

def VMX_EXIT_INVD : Bits 16 := (13 : Bits 16)

def VMX_EXIT_INVLPG : Bits 16 := (14 : Bits 16)

def VMX_EXIT_RDTSC : Bits 16 := (16 : Bits 16)

def VMX_EXIT_CR_ACCESS : Bits 16 := (28 : Bits 16)

def VMX_EXIT_DR_ACCESS : Bits 16 := (29 : Bits 16)

def VMX_EXIT_IO_INSTRUCTION : Bits 16 := (30 : Bits 16)

def VMX_EXIT_MSR_READ : Bits 16 := (31 : Bits 16)

def VMX_EXIT_MSR_WRITE : Bits 16 := (32 : Bits 16)

def VMX_EXIT_GDTR_IDTR : Bits 16 := (46 : Bits 16)

def VMX_EXIT_LDTR_TR : Bits 16 := (47 : Bits 16)

def VMX_EXIT_EPT_VIOLATION : Bits 16 := (48 : Bits 16)

def VMX_EXIT_EPT_MISCONFIG : Bits 16 := (49 : Bits 16)

def VMX_EXIT_WBINVD : Bits 16 := (54 : Bits 16)

def VMX_EXIT_RDMSR_IMM : Bits 16 := (84 : Bits 16)

end X86.Helpers
