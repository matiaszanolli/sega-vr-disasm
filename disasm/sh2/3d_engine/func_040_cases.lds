/* Linker script for func_040_cases (jump table case handlers)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x238D8;  /* ROM file offset $0238D8 */
    .text : SUBALIGN(2) { *(.text) }
}
