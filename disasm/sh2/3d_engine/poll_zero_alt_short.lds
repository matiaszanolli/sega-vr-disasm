/* Linker script for func_087 (poll until zero alternate)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24438;  /* ROM file offset $024438 */
    .text : SUBALIGN(2) { *(.text) }
}
