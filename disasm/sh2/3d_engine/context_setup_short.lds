/* Linker script for func_071 (context setup)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24084;  /* ROM file offset $024084 */
    .text : SUBALIGN(2) { *(.text) }
}
