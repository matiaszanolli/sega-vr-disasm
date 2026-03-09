/* Linker script for func_012 - places code at correct SH2 address */
SECTIONS
{
    . = 0x23278;  /* ROM file offset 0x23278 */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment */
}
