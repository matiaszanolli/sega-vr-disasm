/* Linker script for func_081 (multi-JSR coordinator)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24334;  /* ROM file offset $024334 */
    .text : SUBALIGN(2) { *(.text) }
}
