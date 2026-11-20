# A position-dependent executable that references another section, so that `--emit-relocs`
# keeps a non-allocated `.rela.text`.
.section .text
.global entry
entry:
    lea data(%rip), %rax
    ret

.global second
second:
    ret

.section .rodata
data:
.byte 1, 2, 3, 4
