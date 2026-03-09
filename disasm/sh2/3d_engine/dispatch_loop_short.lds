/* Linker script for func_045 (dispatch loop processor)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23CB4;  /* ROM file offset $023CB4 */
    .text : SUBALIGN(2) { *(.text) }
}
