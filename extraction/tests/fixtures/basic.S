.section .text
.global entry
entry:
    mov $42, %eax
    ret

.global second
second:
    xor %eax, %eax
    ret

.section .rodata
.byte 1, 2, 3, 4
