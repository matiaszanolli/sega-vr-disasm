/* Linker script for func_005 - places code at correct SH2 address */
SECTIONS
{
    . = 0x230E8;  /* ROM file offset 0x230E8 */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment */
}
