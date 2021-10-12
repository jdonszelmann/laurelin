OUTPUT_ARCH( "riscv" )
ENTRY(entry)

KERNEL_START = 0x80000000;

SECTIONS {
    __KERNEL_STACK_SIZE = DEFINED(__KERNEL_STACK_SIZE) ? __KERNEL_STACK_SIZE : 2K;

    . = KERNEL_START;

    PROVIDE(__KERNEL_START = .);
    PROVIDE(__KERNEL_CODE_START = .);
    PROVIDE(__KERNEL_BOOT_START = .);

    .boot : AT(KERNEL_START) {
         KEEP (*(SORT_NONE(.boot)))
    }

    PROVIDE(__KERNEL_BOOT_END = .);

    .text : {
        *(.text)
    }

    PROVIDE(__KERNEL_CODE_END = .);

    .rodata : {
        *(.rdata)
        *(.rodata .rodata.*)
    }

    . = ALIGN(4);

    PROVIDE(__KERNEL_DATA_START = .);

    .data : {
        *(.data)
        PROVIDE( __global_pointer$ = . + 0x800 );
        *(.sdata .sdata.*)
        *(.gnu.linkonce.s.*)
        . = ALIGN(8);
        *(.srodata.cst16)
        *(.srodata.cst8)
        *(.srodata.cst4)
        *(.srodata.cst2)
        *(.srodata .srodata.*)
    }

    PROVIDE(__KERNEL_DATA_END = .);
    PROVIDE(__KERNEL_BSS_START = .);

    . = ALIGN(4);
    .bss : {
        *(.bss)
        *(COMMON)
        . = ALIGN(4);
    }

    . = ALIGN(8);
    PROVIDE(__KERNEL_BSS_END = .);
    PROVIDE(__KERNEL_END = .);

    PROVIDE(__KERNEL_STACK_START = .);
    .stack : {
        . += __KERNEL_STACK_SIZE;
        PROVIDE( __KERNEL_STACK_POINTER = . );
    }
    PROVIDE(__KERNEL_STACK_END = .);
}