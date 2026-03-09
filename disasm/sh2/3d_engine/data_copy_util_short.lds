/* Linker script for func_042 (VDP data copy helper)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23A52;  /* ROM file offset $023A52 */
    .text : SUBALIGN(2) { *(.text) }
}
