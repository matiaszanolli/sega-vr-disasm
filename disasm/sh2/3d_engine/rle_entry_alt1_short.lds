/* Linker script for func_067 (RLE entry point alternative 1)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23FF4;  /* ROM file offset $023FF4 */
    .text : SUBALIGN(2) { *(.text) }
}
