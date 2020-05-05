OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(Reset_Handler)

MEMORY
{
    FLASH(RX)  : ORIGIN = 0x11000000, LENGTH = 0x1F000
    SRAM(RWX)  : ORIGIN = 0x18000000, LENGTH = 0x1800
}

STACK_SIZE = 512;

SECTIONS
{
    .text :
    {
        KEEP(*(.vectors .vectors.*))
        *(.text .text.*)
        *(.rodata .rodata.*)
        _etext = .;
    } > FLASH

    /* .bss section for ZI and uninitialized data */
    .bss (NOLOAD) :
    {
        _sbss = . ;
        *(.bss*)
        *(COMMON)
        _ebss = . ;
    } > SRAM

    .data : AT(ORIGIN(FLASH))
    {
        _sdata = .;
        *(.data*);
        _edata = .;
    } > SRAM

    /* stack section */
    /* ALIGN(8) per ARM Procedure Call Standards */
    .stack (NOLOAD) :
    {
        . = ALIGN(8);
        _sstack = .;
        . = . + STACK_SIZE;
        . = ALIGN(8);
        _estack = .;
    } > SRAM
}