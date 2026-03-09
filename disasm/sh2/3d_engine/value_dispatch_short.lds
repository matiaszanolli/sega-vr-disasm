/* Linker script for func_077 (value dispatch)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24274;  /* ROM file offset $024274 */
    .text : SUBALIGN(2) { *(.text) }
}
