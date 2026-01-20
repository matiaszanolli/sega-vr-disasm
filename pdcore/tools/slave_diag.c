/*
 * Slave SH2 Diagnostic Tool
 * Check where the Slave is executing and memory state
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "../include/pdcore.h"

int main(int argc, char **argv)
{
    const char *rom_path = "../build/vr_rebuild.32x";
    int frames_to_run = 120;  /* ~2 seconds */

    if (argc > 1) {
        rom_path = argv[1];
    }
    if (argc > 2) {
        frames_to_run = atoi(argv[2]);
    }

    printf("=== Slave SH2 Diagnostic ===\n");
    printf("ROM: %s\n", rom_path);
    printf("Running for %d frames...\n\n", frames_to_run);

    /* Load ROM */
    pd_config_t config = {0};
    config.deterministic = 1;
    pd_t *emu = pd_create(&config);

    if (!emu) {
        fprintf(stderr, "Failed to create emulator\n");
        return 1;
    }

    if (pd_load_rom_file(emu, rom_path) < 0) {
        fprintf(stderr, "Failed to load ROM: %s\n", pd_get_error(emu));
        pd_destroy(emu);
        return 1;
    }

    /* Run for specified frames */
    pd_stop_info_t stop_info;
    pd_run_frames(emu, frames_to_run, &stop_info);

    printf("After %d frames (cycles: %lu):\n\n",
           stop_info.frame_number, (unsigned long)stop_info.master_cycles);

    /* Get Master state */
    pd_sh2_regs_t master_regs;
    if (pd_get_sh2_regs(emu, PD_CPU_MASTER, &master_regs) == 0) {
        printf("=== Master SH2 ===\n");
        printf("  PC  = 0x%08x\n", master_regs.pc);
        printf("  R0  = 0x%08x  R1  = 0x%08x  R2  = 0x%08x  R3  = 0x%08x\n",
               master_regs.r[0], master_regs.r[1], master_regs.r[2], master_regs.r[3]);
        printf("  SP  = 0x%08x  PR  = 0x%08x\n", master_regs.r[15], master_regs.pr);
        printf("  Instructions: %u\n\n", master_regs.instruction_count);
    }

    /* Get Slave state */
    pd_sh2_regs_t slave_regs;
    if (pd_get_sh2_regs(emu, PD_CPU_SLAVE, &slave_regs) == 0) {
        printf("=== Slave SH2 ===\n");
        printf("  PC  = 0x%08x", slave_regs.pc);

        /* Interpret PC based on code sections */
        uint32_t rom_offset = slave_regs.pc & 0x00FFFFFF;
        if (rom_offset >= 0x20544 && rom_offset <= 0x20700) {
            if (rom_offset >= 0x20544 && rom_offset < 0x20588)
                printf(" (in init code)");
            else if (rom_offset >= 0x20588 && rom_offset < 0x20592)
                printf(" (in WAIT LOOP - STUCK!)");
            else if (rom_offset >= 0x20592 && rom_offset < 0x20608)
                printf(" (in command dispatch)");
            else if (rom_offset >= 0x20608 && rom_offset < 0x20650)
                printf(" (in idle loop)");
            else if (rom_offset >= 0x20650 && rom_offset < 0x20688)
                printf(" (in WORK dispatch)");
            else if (rom_offset >= 0x20688)
                printf(" (in work function)");
        }
        printf("\n");

        printf("  R0  = 0x%08x  R1  = 0x%08x  R2  = 0x%08x  R3  = 0x%08x\n",
               slave_regs.r[0], slave_regs.r[1], slave_regs.r[2], slave_regs.r[3]);
        printf("  SP  = 0x%08x  PR  = 0x%08x\n", slave_regs.r[15], slave_regs.pr);
        printf("  Instructions: %u\n\n", slave_regs.instruction_count);
    }

    /* Check COMM registers (from SH2 view at 0x20004020-0x2000402F) */
    printf("=== COMM Registers (SH2 view) ===\n");
    for (int i = 0; i < 8; i++) {
        uint32_t addr = 0x20004020 + i * 2;
        uint8_t buf[2];
        if (pd_mem_read(emu, PD_BUS_SH2_ROM, addr, buf, 2) >= 0) {
            uint16_t val = (buf[0] << 8) | buf[1];
            printf("  COMM%d (0x%08x) = 0x%04x", i, addr, val);
            if (i == 0 && val == 0x534F) printf(" ('SO' - Slave handshake?)");
            if (i == 0 && val == 0x4D4F) printf(" ('MO' - Master handshake?)");
            printf("\n");
        }
    }

    /* Check the wait loop target address contents */
    printf("\n=== Wait Loop Memory Check ===\n");

    /* The wait loop at 0x20588 reads from an address via R1 */
    /* Let's check what the Slave's R1 points to */
    uint32_t r1_addr = slave_regs.r[1];
    printf("  Slave R1 = 0x%08x\n", r1_addr);

    if (r1_addr != 0) {
        uint8_t val;
        /* Try to read what R1 points to */
        if (pd_mem_read(emu, PD_BUS_SH2_SDRAM, r1_addr & 0x00FFFFFF, &val, 1) >= 0) {
            printf("  Value at R1: 0x%02x (loop waits for 0)\n", val);
        }
    }

    /* Sample the Slave PC multiple times to see if it's changing */
    printf("\n=== PC Sampling (10 samples over 10 frames) ===\n");
    for (int i = 0; i < 10; i++) {
        pd_run_frames(emu, 1, &stop_info);
        pd_get_sh2_regs(emu, PD_CPU_SLAVE, &slave_regs);
        printf("  Frame %d: Slave PC = 0x%08x  Instr: %u\n",
               stop_info.frame_number, slave_regs.pc, slave_regs.instruction_count);
    }

    pd_destroy(emu);
    return 0;
}
