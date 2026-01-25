/*
 * VR Deluxe FPS Profiler
 * Uses pdcore to measure frame rate difference between original and optimized ROMs
 *
 * Usage: ./vr_profiler <original.32x> <optimized.32x>
 */

#include "pdcore.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Frame counter is at SDRAM 0x22000100 (injected by inject_fps_counter.py) */
#define FRAME_COUNTER_ADDR 0x22000100
#define TEST_FRAMES 600  /* 10 seconds of V-INT frames (60 Hz) */

/* Read 32-bit value from SDRAM cache-through address */
static uint32_t read_frame_counter(pd_t *emu) {
    uint8_t buf[4];
    if (pd_mem_read(emu, PD_BUS_SH2_SDRAM_WT, FRAME_COUNTER_ADDR, buf, 4) != 0) {
        return 0;
    }
    /* Big-endian to host */
    return ((uint32_t)buf[0] << 24) | ((uint32_t)buf[1] << 16) |
           ((uint32_t)buf[2] << 8)  | (uint32_t)buf[3];
}

/* Run ROM for specified frames and return rendered frame count */
static int profile_rom(const char *rom_path, uint32_t vint_frames, uint32_t *out_sh2_frames) {
    pd_t *emu = pd_create(NULL);
    if (!emu) {
        fprintf(stderr, "Failed to create emulator instance\n");
        return -1;
    }

    if (pd_load_rom_file(emu, rom_path) != 0) {
        fprintf(stderr, "Failed to load ROM: %s\n", rom_path);
        pd_destroy(emu);
        return -1;
    }

    printf("  Loaded: %s\n", rom_path);
    printf("  Running for %u V-INT frames (%.1f seconds)...\n",
           vint_frames, vint_frames / 60.0);

    /* Reset emulation to clear any state */
    pd_reset(emu);

    /* Let game boot up - run 300 frames (5 seconds) to get to menu/gameplay */
    pd_stop_info_t stop;
    pd_run_frames(emu, 300, &stop);

    /* Read initial frame counter */
    uint32_t start_count = read_frame_counter(emu);
    printf("  Frame counter at start: %u\n", start_count);

    /* Run for test duration */
    pd_run_frames(emu, vint_frames, &stop);

    /* Read final frame counter */
    uint32_t end_count = read_frame_counter(emu);
    printf("  Frame counter at end: %u\n", end_count);

    *out_sh2_frames = end_count - start_count;
    printf("  SH2 frames rendered: %u\n", *out_sh2_frames);
    printf("  Effective FPS: %.2f\n", (*out_sh2_frames * 60.0) / vint_frames);

    pd_destroy(emu);
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("VR Deluxe FPS Profiler\n");
        printf("Usage: %s <original.32x> <optimized.32x>\n\n", argv[0]);
        printf("Both ROMs must have frame counter injected (use inject_fps_counter.py)\n");
        printf("Frame counter reads from SDRAM 0x%08X\n", FRAME_COUNTER_ADDR);
        return 1;
    }

    printf("======================================================================\n");
    printf("VR Deluxe FPS Profiler (pdcore)\n");
    printf("======================================================================\n\n");

    uint32_t original_frames = 0;
    uint32_t optimized_frames = 0;

    printf("Testing ORIGINAL ROM:\n");
    if (profile_rom(argv[1], TEST_FRAMES, &original_frames) != 0) {
        fprintf(stderr, "Failed to profile original ROM\n");
        return 1;
    }

    printf("\nTesting OPTIMIZED ROM:\n");
    if (profile_rom(argv[2], TEST_FRAMES, &optimized_frames) != 0) {
        fprintf(stderr, "Failed to profile optimized ROM\n");
        return 1;
    }

    /* Calculate results */
    printf("\n======================================================================\n");
    printf("RESULTS\n");
    printf("======================================================================\n");
    printf("Test duration: %u V-INT frames (%.1f seconds)\n", TEST_FRAMES, TEST_FRAMES / 60.0);
    printf("\n");
    printf("Original ROM:  %u SH2 frames (%.2f FPS)\n",
           original_frames, (original_frames * 60.0) / TEST_FRAMES);
    printf("Optimized ROM: %u SH2 frames (%.2f FPS)\n",
           optimized_frames, (optimized_frames * 60.0) / TEST_FRAMES);
    printf("\n");

    if (original_frames > 0) {
        float improvement = ((float)optimized_frames - original_frames) / original_frames * 100.0f;
        printf("Improvement: %.2f%%\n", improvement);
        printf("Speedup factor: %.3fx\n", (float)optimized_frames / original_frames);
    }

    printf("\n");

    return 0;
}
