/* Linker script for func_089 (poll and branch with loop)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24480;  /* ROM file offset $024480 */
    .text : SUBALIGN(2) { *(.text) }
}
