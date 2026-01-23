/*
 * Cycle Count Reader - Phase 17.1/17.2 Memory Inspector
 *
 * Reads cycle measurement results from Phase 17 ROMs.
 *
 * Memory Map:
 *   Slave Results (Phase 17.1):
 *     0x22000300: Slave cycle count
 *     0x22000304: Slave FRT start
 *     0x22000308: Slave FRT end
 *     0x2200030C: Slave wrap flag
 *
 *   Master Results (Phase 17.2):
 *     0x22000320: Master cycle count
 *     0x22000324: Master FRT start
 *     0x22000328: Master FRT end
 *     0x2200032C: Master wrap flag
 *
 * Compile:
 *   gcc -o read_cycle_counts tools/read_cycle_counts.c \
 *       pdcore/src/*.c pdcore/tests/pdcore_bridge_stubs.c \
 *       -Ipdcore/include -O2
 *
 * Usage:
 *   ./read_cycle_counts build/vr_phase17_1.32x 180
 *   ./read_cycle_counts build/vr_phase17_2.32x 180
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "pdcore.h"

#define SLAVE_CYCLE_ADDR  0x22000300
#define SLAVE_FRT_START   0x22000304
#define SLAVE_FRT_END     0x22000308
#define SLAVE_WRAP_FLAG   0x2200030C

#define MASTER_CYCLE_ADDR 0x22000320
#define MASTER_FRT_START  0x22000324
#define MASTER_FRT_END    0x22000328
#define MASTER_WRAP_FLAG  0x2200032C

#define DONE_FLAG_ADDR    0x220002FC

static uint32_t read_u32_be(const uint8_t *buf)
{
    return ((uint32_t)buf[0] << 24) |
           ((uint32_t)buf[1] << 16) |
           ((uint32_t)buf[2] << 8) |
           ((uint32_t)buf[3]);
}

static int read_memory_u32(pd_t *emu, uint32_t addr, uint32_t *value)
{
    uint8_t buf[4];
    int ret = pd_mem_read(emu, PD_BUS_SH2_SDRAM, addr, buf, 4);
    if (ret < 0) {
        fprintf(stderr, "Error reading 0x%08X: %s\n", addr, pd_get_error(emu));
        return -1;
    }
    *value = read_u32_be(buf);
    return 0;
}

static void print_results(pd_t *emu, const char *label, uint32_t cycle_addr,
                         uint32_t frt_start_addr, uint32_t frt_end_addr,
                         uint32_t wrap_flag_addr)
{
    uint32_t cycles, frt_start, frt_end, wrap_flag;

    printf("\n=== %s Results ===\n", label);

    if (read_memory_u32(emu, cycle_addr, &cycles) < 0) return;
    if (read_memory_u32(emu, frt_start_addr, &frt_start) < 0) return;
    if (read_memory_u32(emu, frt_end_addr, &frt_end) < 0) return;
    if (read_memory_u32(emu, wrap_flag_addr, &wrap_flag) < 0) return;

    printf("  Cycle count:  %u cycles\n", cycles);
    printf("  FRT start:    0x%04X\n", frt_start & 0xFFFF);
    printf("  FRT end:      0x%04X\n", frt_end & 0xFFFF);
    printf("  Wrapped:      %s\n", wrap_flag ? "YES" : "NO");

    if (cycles > 0) {
        printf("  Per-vertex:   ~%u cycles/vertex (4 vertices)\n", cycles / 4);
        printf("  Expected:     ~94-110 cycles/vertex\n");
    } else {
        printf("  ⚠ Cycle count is zero - handler may not have run\n");
    }
}

int main(int argc, char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <rom_file> [frames]\n", argv[0]);
        fprintf(stderr, "\nExample:\n");
        fprintf(stderr, "  %s build/vr_phase17_1.32x 180\n", argv[0]);
        return 1;
    }

    const char *rom_path = argv[1];
    uint32_t frames = 180;  // Default: 180 frames (~3 seconds at 60 FPS)

    if (argc > 2) {
        frames = (uint32_t)strtoul(argv[2], NULL, 10);
    }

    printf("=== Phase 17 Cycle Count Reader ===\n");
    printf("ROM: %s\n", rom_path);
    printf("Frames: %u\n", frames);

    // Create emulator
    pd_t *emu = pd_create(NULL);
    if (!emu) {
        fprintf(stderr, "ERROR: Failed to create emulator\n");
        return 1;
    }

    // Load ROM
    int ret = pd_load_rom_file(emu, rom_path);
    if (ret != 0) {
        fprintf(stderr, "ERROR: Failed to load ROM: %s\n", pd_get_error(emu));
        pd_destroy(emu);
        return 1;
    }

    // Reset and run
    printf("\nBooting ROM...\n");
    pd_reset(emu);

    for (uint32_t i = 0; i < frames; i++) {
        pd_stop_info_t stop;
        int ret = pd_run_frames(emu, 1, &stop);
        if (ret != 0) {
            fprintf(stderr, "Error running frame %u\n", i);
            pd_destroy(emu);
            return 1;
        }

        if ((i % 60) == 0 && i > 0) {
            printf("  Frame %u/%u (%.1fs)\n", i, frames, i / 60.0);
        }
    }

    printf("✓ Emulation complete\n");

    // Read done flag
    uint32_t done_flag;
    if (read_memory_u32(emu, DONE_FLAG_ADDR, &done_flag) == 0) {
        printf("\nDone flag: 0x%08X %s\n", done_flag,
               done_flag == 0x00010001 ? "(OK)" : "(NOT SET)");
    }

    // Detect ROM type and print appropriate results
    if (strstr(rom_path, "phase17_1") || strstr(rom_path, "17_1")) {
        print_results(emu, "Slave CPU", SLAVE_CYCLE_ADDR, SLAVE_FRT_START,
                     SLAVE_FRT_END, SLAVE_WRAP_FLAG);
    } else if (strstr(rom_path, "phase17_2") || strstr(rom_path, "17_2")) {
        print_results(emu, "Master CPU", MASTER_CYCLE_ADDR, MASTER_FRT_START,
                     MASTER_FRT_END, MASTER_WRAP_FLAG);
    } else {
        // Unknown ROM - try reading both
        print_results(emu, "Slave CPU", SLAVE_CYCLE_ADDR, SLAVE_FRT_START,
                     SLAVE_FRT_END, SLAVE_WRAP_FLAG);
        print_results(emu, "Master CPU", MASTER_CYCLE_ADDR, MASTER_FRT_START,
                     MASTER_FRT_END, MASTER_WRAP_FLAG);
    }

    pd_destroy(emu);
    return 0;
}
