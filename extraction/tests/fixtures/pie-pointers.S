# A static PIE with two relocated pointers, at consecutive slots.
.section .text
.global entry
entry:
    lea table(%rip), %rax
    mov (%rax), %rax
    ret

second:
    ret

.section .rodata
.byte 1, 2, 3, 4

.section .data
table:
    .quad entry
    .quad second
