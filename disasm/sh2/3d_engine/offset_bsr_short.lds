/* Linker script for func_051 (offset multi-BSR processing handler)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23DD8;  /* ROM file offset $023DD8 */
    .text : SUBALIGN(2) { *(.text) }
}
