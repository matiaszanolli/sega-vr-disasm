/* Linker script for func_014 and func_015 (VDP data copy utilities)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23330;  /* ROM file offset 0x23330 */
    .text : SUBALIGN(2) { *(.text) }
}
