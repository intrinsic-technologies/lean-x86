# A program without data sections.
.section .text
.global entry
entry:
    mov $60, %eax
    xor %edi, %edi
    syscall
