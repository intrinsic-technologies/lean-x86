-- Generated from data/definitions.xml.gz: Task_State_Segment; do not edit.
-- Source SHA256: cc3b5daa6d6955c22be45223b04cc4aec03aa364bdb2b680c0d410b021dce5b1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Task_State_Segment)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def TSS_LINK_OFFSET : Bits 64 := (0 : Bits 64)

def TSS_CR3_OFFSET : Bits 64 := (28 : Bits 64)

def TSS_EIP_OFFSET : Bits 64 := (32 : Bits 64)

def TSS_EFLAGS_OFFSET : Bits 64 := (36 : Bits 64)

def TSS_EAX_OFFSET : Bits 64 := (40 : Bits 64)

def TSS_ECX_OFFSET : Bits 64 := (44 : Bits 64)

def TSS_EDX_OFFSET : Bits 64 := (48 : Bits 64)

def TSS_EBX_OFFSET : Bits 64 := (52 : Bits 64)

def TSS_ESP_OFFSET : Bits 64 := (56 : Bits 64)

def TSS_EBP_OFFSET : Bits 64 := (60 : Bits 64)

def TSS_ESI_OFFSET : Bits 64 := (64 : Bits 64)

def TSS_EDI_OFFSET : Bits 64 := (68 : Bits 64)

def TSS_ES_OFFSET : Bits 64 := (72 : Bits 64)

def TSS_CS_OFFSET : Bits 64 := (76 : Bits 64)

def TSS_SS_OFFSET : Bits 64 := (80 : Bits 64)

def TSS_DS_OFFSET : Bits 64 := (84 : Bits 64)

def TSS_FS_OFFSET : Bits 64 := (88 : Bits 64)

def TSS_GS_OFFSET : Bits 64 := (92 : Bits 64)

def TSS_SSP_OFFSET : Bits 64 := (104 : Bits 64)

def TSS_LIMIT : Bits 64 := (103 : Bits 64)

def TSS_IP_OFFSET : Bits 64 := (14 : Bits 64)

def TSS_FLAGS_OFFSET : Bits 64 := (16 : Bits 64)

def TSS_AX_OFFSET : Bits 64 := (18 : Bits 64)

def TSS_CX_OFFSET : Bits 64 := (20 : Bits 64)

def TSS_DX_OFFSET : Bits 64 := (22 : Bits 64)

def TSS_BX_OFFSET : Bits 64 := (24 : Bits 64)

def TSS_SP_OFFSET : Bits 64 := (26 : Bits 64)

def TSS_BP_OFFSET : Bits 64 := (28 : Bits 64)

def TSS_SI_OFFSET : Bits 64 := (30 : Bits 64)

def TSS_DI_OFFSET : Bits 64 := (32 : Bits 64)

def TSS_ES_OFFSET_16 : Bits 64 := (34 : Bits 64)

def TSS_CS_OFFSET_16 : Bits 64 := (36 : Bits 64)

def TSS_SS_OFFSET_16 : Bits 64 := (38 : Bits 64)

def TSS_DS_OFFSET_16 : Bits 64 := (40 : Bits 64)

def TSS_LIMIT_16 : Bits 64 := (43 : Bits 64)

end X86.Helpers
