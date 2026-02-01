/* Linker script for func_088 (structure init)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24448;  /* ROM file offset $024448 */
    .text : SUBALIGN(2) { *(.text) }
}
