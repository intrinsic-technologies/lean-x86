# A position-dependent executable with a nonempty `__rela_iplt_start`..`__rela_iplt_end` range,
# whose IRELATIVE relocations glibc's static startup applies, whatever the section headers say.
.section .text
.global entry
entry:
    ret

.global second
second:
    ret

.section .rodata
.global __rela_iplt_start
__rela_iplt_start:
.quad 0, 0, 0
.global __rela_iplt_end
__rela_iplt_end:
.byte 1
