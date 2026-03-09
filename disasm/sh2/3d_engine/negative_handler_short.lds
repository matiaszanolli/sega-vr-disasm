/* Linker script for func_073 (negative count handler)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x241D8;  /* ROM file offset $0241D8 */
    .text : SUBALIGN(2) { *(.text) }
}
