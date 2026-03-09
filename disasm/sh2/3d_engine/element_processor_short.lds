/* Linker script for func_072 (element processor)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x241A4;  /* ROM file offset $0241A4 */
    .text : SUBALIGN(2) { *(.text) }
}
