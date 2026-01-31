/* Linker script for func_053 (offset small BSR handler)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23E64;  /* ROM file offset $023E64 */
    .text : SUBALIGN(2) { *(.text) }
}
