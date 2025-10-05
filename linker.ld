/* linker.ld */
OUTPUT_FORMAT(elf32-i386)
ENTRY(start)

SECTIONS
{
    . = 0x00100000; /* link at 1MB (typical for kernels) */

    .multiboot :
    {
        *(.multiboot)
    }

    .text :
    {
        *(.text)
        *(.text.*)
    }

    .rodata :
    {
        *(.rodata)
    }

    .data : { *(.data) *(.data.*) }

    .bss :
    {
        __bss_start = .;
        *(.bss)
        *(.bss.*)
        . = ALIGN(4);
        __bss_end = .;
    }
}
