.section .text
.global entry
entry:
    .byte 0xc5, 0xf8, 0x58, 0xc1
    ret

.global second
second:
    xor %eax, %eax
    ret

.section .rodata
.byte 1, 2, 3, 4
