/* Linker script for func_068 (RLE entry point alternative 2)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24002;  /* ROM file offset $024002 */
    .text : SUBALIGN(2) { *(.text) }
}
