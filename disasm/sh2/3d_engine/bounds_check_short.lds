/* Linker script for func_047 (bounds check handler type 10)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23D24;  /* ROM file offset $023D24 */
    .text : SUBALIGN(2) { *(.text) }
}
