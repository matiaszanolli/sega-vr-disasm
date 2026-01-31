/* Linker script for func_011 - places code at correct SH2 address */
SECTIONS
{
    . = 0x23220;  /* ROM file offset 0x23220 */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment */
}
