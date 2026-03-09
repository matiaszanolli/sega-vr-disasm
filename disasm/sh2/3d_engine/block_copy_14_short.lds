/* Linker script for func_074 (14-block copy routine)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x241E8;  /* ROM file offset $0241E8 */
    .text : SUBALIGN(2) { *(.text) }
}
