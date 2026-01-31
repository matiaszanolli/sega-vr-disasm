/* Linker script for func_024 (screen coordinate calculator)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x235F6;  /* ROM file offset 0x235F6 */
    .text : SUBALIGN(2) { *(.text) }
}
