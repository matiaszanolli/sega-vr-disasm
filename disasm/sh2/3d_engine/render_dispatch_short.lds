/* Linker script for func_036 (render dispatch D)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x237D6;  /* ROM file offset 0x237D6 */
    .text : SUBALIGN(2) { *(.text) }
}
