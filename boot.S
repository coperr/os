    /* minimal multiboot header and entry */
    .section .multiboot
    .align 4
    /* Multiboot magic, flags, checksum (classic Multiboot v1) */
    .long 0x1BADB002
    .long 0x00000000
    .long -(0x1BADB002 + 0x00000000)

    .section .text
    .global start
    .type start, @function

start:
    cli                         /* disable interrupts */
    /* initialize a small stack (stack is in .bss) */
    movl $stack + 4096, %esp
    /* call C kernel entry */
    call kernel_main

.halt_loop:
    hlt
    jmp .halt_loop

    .section .bss
    .comm stack, 4096  /* 4KB stack */
