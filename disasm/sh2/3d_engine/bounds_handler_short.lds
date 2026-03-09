/* Linker script for func_048 (bounds check handler type 7)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23D3E;  /* ROM file offset $023D3E */
    .text : SUBALIGN(2) { *(.text) }
}
