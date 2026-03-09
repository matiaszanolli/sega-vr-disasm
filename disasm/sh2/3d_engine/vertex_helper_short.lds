/* Linker script for func_020 (vertex processor helper)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x234A0;  /* ROM file offset 0x234A0 */
    .text : SUBALIGN(2) { *(.text) }
}
