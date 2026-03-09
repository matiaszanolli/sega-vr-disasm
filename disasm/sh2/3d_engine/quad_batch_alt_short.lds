/* Linker script for func_019 (quad batch alternate + alternate entry)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23414;  /* ROM file offset 0x23414 */
    .text : SUBALIGN(2) { *(.text) }
}
