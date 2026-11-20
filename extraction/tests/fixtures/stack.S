.section .text
.global entry
.type entry,@function
entry:
    push %rbp
    push %r15
    push %r14
    push %r13
    push %r12
    push %rbx
    sub $472, %rsp
    call permutation
    call *slot(%rip)
    lea permutation(%rip), %r13
    call *%r13
    add $472, %rsp
    pop %rbx
    pop %r12
    pop %r13
    pop %r14
    pop %r15
    pop %rbp
    ret

.global permutation
.type permutation,@function
permutation:
    push %rbp
    push %r15
    push %r14
    push %r13
    push %r12
    push %rbx
    sub $96, %rsp
    mov %rax, -128(%rsp)
    add $96, %rsp
    pop %rbx
    pop %r12
    pop %r13
    pop %r14
    pop %r15
    pop %rbp
    ret

.global second
.type second,@function
second:
    ret

.global tail
.type tail,@function
tail:
    sub $16, %rsp
    add $16, %rsp
    jmp second

.global recursive
.type recursive,@function
recursive:
    call recursive
    ret

.global dynamic
.type dynamic,@function
dynamic:
    sub %rax, %rsp
    ret

.global growing_loop
.type growing_loop,@function
growing_loop:
    push %rax
    jmp growing_loop

.global unresolved
.type unresolved,@function
unresolved:
    call *%rax
    ret

.global unreadable_slot
.type unreadable_slot,@function
unreadable_slot:
    call *short_slot(%rip)
    ret

.global aligned
.type aligned,@function
aligned:
    and $-32, %rsp
    ret

.global panic_stub
.global _ZN4core9panicking9panic_fmt17h0123456789abcdefE
.global _RNvNtCs9L9tuJX2du2_4core9panicking9panic_fmt
.type panic_stub,@function
panic_stub:
_ZN4core9panicking9panic_fmt17h0123456789abcdefE:
_RNvNtCs9L9tuJX2du2_4core9panicking9panic_fmt:
    jmp panic_stub
    nop

.global _ZN4core5slice5index16slice_index_fail17h0123456789abcdefE
.type _ZN4core5slice5index16slice_index_fail17h0123456789abcdefE,@function
_ZN4core5slice5index16slice_index_fail17h0123456789abcdefE:
    push %rbp
    call panic_stub
    nop

.global user_panic
.type user_panic,@function
user_panic:
    ret
    nop

.global panic_indirect
.type panic_indirect,@function
panic_indirect:
    call *panic_slot(%rip)

.global panic_caller
.type panic_caller,@function
panic_caller:
    sub $16, %rsp
    call _ZN4core5slice5index16slice_index_fail17h0123456789abcdefE

.global padded_branch
.type padded_branch,@function
padded_branch:
    jne .Lpadding
    ret
.Lpadding:
    nop

.global fallthrough_call
.type fallthrough_call,@function
fallthrough_call:
    call second

.global fallthrough_conditional
.type fallthrough_conditional,@function
fallthrough_conditional:
    jne second

.global fallthrough_frame
.type fallthrough_frame,@function
fallthrough_frame:
    sub $32, %rsp

.global shared_entry
.type shared_entry,@function
shared_entry:
    nop

.global shared_tail
.type shared_tail,@function
shared_tail:
    sub $4096, %rsp
    mov %rax, (%rsp)
    add $4096, %rsp
    ret

.global boundary_call
.type boundary_call,@function
boundary_call:
    call boundary_tail

.global boundary_tail
.type boundary_tail,@function
boundary_tail:
    sub $64, %rsp
    add $64, %rsp
    ret

.global mixed_panic_call
.type mixed_panic_call,@function
mixed_panic_call:
    lea panic_stub(%rip), %rax
    test %edi, %edi
    jz .Lmixed_call
    lea user_panic(%rip), %rax
.Lmixed_call:
    call *%rax
    call shared_tail
    ret

.global panic_bypass
.type panic_bypass,@function
panic_bypass:
    test %edi, %edi
    jz .Lafter_panic
    call panic_stub
.Lafter_panic:
    call shared_tail
    ret

.global fallthrough_cycle
.type fallthrough_cycle,@function
fallthrough_cycle:
    push %rax

.global cycle_tail
.type cycle_tail,@function
cycle_tail:
    jmp fallthrough_cycle

.global fallthrough_missing
.type fallthrough_missing,@function
fallthrough_missing:
    nop

.section .rodata
slot:
    .quad second
panic_slot:
    .quad _ZN4core5slice5index16slice_index_fail17h0123456789abcdefE
// A matching name outside code must not become a panic entry.
.global _ZN4core9panicking18panic_bounds_check17h0123456789abcdefE
_ZN4core9panicking18panic_bounds_check17h0123456789abcdefE:
    .quad 0
short_slot:
    .byte 0
