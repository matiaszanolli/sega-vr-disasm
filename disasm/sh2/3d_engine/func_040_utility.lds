/* Linker script for func_040_utility (data copy + GBR setup)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x239B0;  /* ROM file offset $0239B0 */
    .text : SUBALIGN(2) { *(.text) }
}
