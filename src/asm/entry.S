.section .boot, "ax"
.global entry
entry:
#    UNIMP

    # disable all harts with id > 0
    csrr t0, mhartid
    bnez t0, wfi

    # supervisor access translation and protect register
    # should be zero (disables virtual memory and more)
    #csrr t0, satp
    #csrw satp, zero

    .option push
    .option norelax
    	la gp, __global_pointer$
    .option pop

    la sp, __KERNEL_STACK_POINTER
    mv fp, sp

    # load the position
    ## la t0, exception
    # and it to mask with ~0b00000011 = ~0x0003 = -0x4
    ## andi t0, t0, -4
    # or it with the exception mode (0)
    ## ori t0, t0, 0x0

    ## csrw mtvec, t0

    la a0, __KERNEL_START
    la a1, __KERNEL_END

    jal zero, kernel_main

.global wfi
wfi:
    wfi
    j wfi

