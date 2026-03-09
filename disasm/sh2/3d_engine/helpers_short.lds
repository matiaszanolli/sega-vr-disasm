/* Linker script for func_037_038_039 (visibility helpers)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x2381E;  /* ROM file offset 0x2381E */
    .text : SUBALIGN(2) { *(.text) }
}
