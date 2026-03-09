/* Linker script for func_033 (quad rendering / edge walking)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x236FA;  /* ROM file offset 0x236FA */
    .text : SUBALIGN(2) { *(.text) }
}
