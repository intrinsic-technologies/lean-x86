.section .text
.global entry
entry:
    mov $60, %eax
    mov $42, %edi
    syscall
.global second
second:
    ret

.section .rodata
.byte 1, 2, 3, 4
