/* Linker script for func_007 - places code at correct SH2 address */
SECTIONS
{
    . = 0x23178;  /* ROM file offset 0x23178 */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment */
}
