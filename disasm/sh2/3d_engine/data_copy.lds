/* Linker script for func_000 - places code at correct SH2 address */
SECTIONS
{
    . = 0x2300A;  /* ROM file offset 0x2300A (SH2 maps ROM at 0x02000000) */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment, not 4-byte */
}
