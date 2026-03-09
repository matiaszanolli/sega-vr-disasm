/* Linker script for func_049 (bounds check entry handler type 8)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23D54;  /* ROM file offset $023D54 */
    .text : SUBALIGN(2) { *(.text) }
}
