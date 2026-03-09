/* Linker script for func_023 (frustum culling / visibility dispatcher)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23508;  /* ROM file offset 0x23508 */
    .text : SUBALIGN(2) { *(.text) }
}
