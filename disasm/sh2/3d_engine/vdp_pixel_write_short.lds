/* Linker script for func_076 (VDP pixel write)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24228;  /* ROM file offset $024228 */
    .text : SUBALIGN(2) { *(.text) }
}
