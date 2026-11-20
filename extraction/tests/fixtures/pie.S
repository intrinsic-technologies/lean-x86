.section .text
.global entry
entry:
    lea table(%rip), %rax
    mov (%rax), %rax
    ret

.section .rodata
.byte 1, 2, 3, 4

.section .data
table:
    .quad entry

.section .bss
    .zero 64
