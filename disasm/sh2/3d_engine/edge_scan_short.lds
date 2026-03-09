/* Linker script for func_044 (edge/scan processor)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23BA8;  /* ROM file offset $023BA8 */
    .text : SUBALIGN(2) { *(.text) }
}
