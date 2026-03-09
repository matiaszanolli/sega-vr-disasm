/* Linker script for func_013 - places code at correct SH2 address */
SECTIONS
{
    . = 0x232D4;  /* ROM file offset 0x232D4 */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment */
}
