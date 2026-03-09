/* Linker script for func_054 (conditional BSR handler)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23E90;  /* ROM file offset $023E90 */
    .text : SUBALIGN(2) { *(.text) }
}
