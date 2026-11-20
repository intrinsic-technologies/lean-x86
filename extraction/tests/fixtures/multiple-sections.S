.section .text
.global entry
entry:
    ret

.global second
second:
    xor %eax, %eax
    ret

.section .rodata
.byte 1, 2, 3, 4

.section .text.extra,"ax"
.global extra
extra:
    ret
