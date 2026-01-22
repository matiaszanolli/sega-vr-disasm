/*
 * Phase 11: Slave SH2 Hook Injector
 *
 * Injects the Slave expansion hook into SDRAM at runtime using pdcore.
 *
 * Usage:
 *   ./phase11_hook_injector <rom_file> [options]
 *
 * Options:
 *   -a, --address ADDR     Override hook injection address (default: 0x06000596)
 *   -v, --verbose          Enable verbose output
 *   -V, --verify           Verify hook after injection (default: on)
 *   --no-boot              Don't wait for boot sequence (for testing)
 *   --test-frames N        Run N frames after injection (default: 60)
 *
 * Exit codes:
 *   0 = Success
 *   1 = Hook injection failed
 *   2 = Hook verification failed
 *   3 = ROM loading failed
 *   4 = Invalid arguments
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>
#include <stdbool.h>
#include <time.h>

#include "pdcore.h"

/* ============================================================================
 * PHASE 11 SLAVE HOOK BYTECODE
 * ============================================================================
 */

/* Hook bytecode (52 bytes total)
 * See PHASE11_HOOK_BYTECODE.md for detailed encoding
 */
static const uint8_t SLAVE_HOOK_CODE[] = {
    // mov.l #$2000402C, R0 + literal (8 bytes)
    0xD0, 0x02, 0x00, 0x00, 0x20, 0x00, 0x40, 0x2C,
    // mov.l @R0, R1 (2 bytes)
    0x60, 0x04,
    // mov #$0012, R2 (2 bytes)
    0xE2, 0x12,
    // cmp/eq R2, R1 (2 bytes)
    0x32, 0x10,
    // bf hook_exit (2 bytes)
    0x8F, 0x06,
    // mov.l #$02300027, R0 + literal (8 bytes)
    0xD0, 0x02, 0x00, 0x00, 0x02, 0x30, 0x00, 0x27,
    // jsr @R0 (2 bytes)
    0x40, 0x00,
    // nop (2 bytes)
    0x00, 0x09,
    // mov.l #$2000402C, R0 + literal (8 bytes)
    0xD0, 0x02, 0x00, 0x00, 0x20, 0x00, 0x40, 0x2C,
    // mov #$0000, R1 (2 bytes)
    0xE2, 0x10,
    // mov.l R1, @R0 (2 bytes)
    0x21, 0x03,
    // rts (2 bytes)
    0x00, 0x0B,
    // nop (2 bytes)
    0x00, 0x09,
};

#define SLAVE_HOOK_SIZE sizeof(SLAVE_HOOK_CODE)
#define SLAVE_HOOK_DEFAULT_ADDR 0x06000596
#define SLAVE_HOOK_TIMEOUT_FRAMES 60
#define SLAVE_BOOT_FRAMES 50

/* ============================================================================
 * CONFIGURATION
 * ============================================================================
 */

typedef struct {
    const char *rom_path;
    uint32_t hook_address;
    uint32_t boot_frames;
    uint32_t test_frames;
    bool verify_after_inject;
    bool verbose;
    bool no_boot;
} injector_config_t;

/* ============================================================================
 * HELPER FUNCTIONS
 * ============================================================================
 */

static void print_usage(const char *program)
{
    printf("Phase 11: Slave SH2 Hook Injector\n\n");
    printf("Usage: %s <rom_file> [options]\n\n", program);
    printf("Options:\n");
    printf("  -a, --address ADDR     Hook injection address (default: 0x06000596)\n");
    printf("  -v, --verbose          Verbose output\n");
    printf("  -V, --verify           Verify hook after injection (default: yes)\n");
    printf("  --no-verify            Skip verification (faster)\n");
    printf("  --no-boot              Skip boot sequence\n");
    printf("  --test-frames N        Run N frames after injection (default: 60)\n");
    printf("  -h, --help             Show this help\n");
    printf("\nExit codes:\n");
    printf("  0 = Success\n");
    printf("  1 = Hook injection failed\n");
    printf("  2 = Hook verification failed\n");
    printf("  3 = ROM loading failed\n");
    printf("  4 = Invalid arguments\n");
}

static void log_verbose(injector_config_t *cfg, const char *fmt, ...)
{
    if (!cfg->verbose) return;

    va_list args;
    va_start(args, fmt);
    vprintf(fmt, args);
    va_end(args);
}

static void print_hex_dump(const uint8_t *data, size_t size, const char *label)
{
    printf("%s (%zu bytes):\n", label, size);
    for (size_t i = 0; i < size; i += 16) {
        printf("  ");
        for (size_t j = i; j < i + 16 && j < size; j++) {
            printf("%02X ", data[j]);
        }
        printf("\n");
    }
}

/* ============================================================================
 * MAIN INJECTION LOGIC
 * ============================================================================
 */

static int parse_args(int argc, char **argv, injector_config_t *cfg)
{
    if (argc < 2) {
        print_usage(argv[0]);
        return -1;
    }

    /* Initialize defaults */
    memset(cfg, 0, sizeof(*cfg));
    cfg->rom_path = NULL;
    cfg->hook_address = SLAVE_HOOK_DEFAULT_ADDR;
    cfg->boot_frames = SLAVE_BOOT_FRAMES;
    cfg->test_frames = SLAVE_HOOK_TIMEOUT_FRAMES;
    cfg->verify_after_inject = true;
    cfg->verbose = false;
    cfg->no_boot = false;

    /* Parse arguments */
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-h") == 0 || strcmp(argv[i], "--help") == 0) {
            print_usage(argv[0]);
            return -1;
        } else if (strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "--verbose") == 0) {
            cfg->verbose = true;
        } else if (strcmp(argv[i], "-V") == 0 || strcmp(argv[i], "--verify") == 0) {
            cfg->verify_after_inject = true;
        } else if (strcmp(argv[i], "--no-verify") == 0) {
            cfg->verify_after_inject = false;
        } else if (strcmp(argv[i], "--no-boot") == 0) {
            cfg->no_boot = true;
        } else if (strcmp(argv[i], "-a") == 0 || strcmp(argv[i], "--address") == 0) {
            if (i + 1 >= argc) {
                fprintf(stderr, "Error: --address requires an argument\n");
                return -1;
            }
            cfg->hook_address = strtoul(argv[++i], NULL, 16);
        } else if (strcmp(argv[i], "--test-frames") == 0) {
            if (i + 1 >= argc) {
                fprintf(stderr, "Error: --test-frames requires an argument\n");
                return -1;
            }
            cfg->test_frames = strtoul(argv[++i], NULL, 10);
        } else if (argv[i][0] == '-') {
            fprintf(stderr, "Error: Unknown option: %s\n", argv[i]);
            return -1;
        } else if (cfg->rom_path == NULL) {
            cfg->rom_path = argv[i];
        }
    }

    if (cfg->rom_path == NULL) {
        fprintf(stderr, "Error: ROM file not specified\n");
        return -1;
    }

    return 0;
}

static int run_injector(injector_config_t *cfg)
{
    int ret;
    pd_t *emu = NULL;
    uint8_t verify_buf[SLAVE_HOOK_SIZE];
    pd_stop_info_t stop_info;

    printf("=== Phase 11: Slave Hook Injector ===\n\n");

    /* Step 1: Create emulator */
    printf("[1/6] Creating emulator...\n");
    emu = pd_create(NULL);
    if (!emu) {
        fprintf(stderr, "ERROR: Failed to create emulator\n");
        return 1;
    }
    printf("      ✓ Emulator created\n");

    /* Step 2: Load ROM */
    printf("[2/6] Loading ROM: %s\n", cfg->rom_path);
    ret = pd_load_rom_file(emu, cfg->rom_path);
    if (ret != 0) {
        fprintf(stderr, "ERROR: Failed to load ROM: %s\n", pd_get_error(emu));
        pd_destroy(emu);
        return 3;
    }
    printf("      ✓ ROM loaded\n");

    /* Step 3: Reset and boot */
    printf("[3/6] Resetting emulation...\n");
    pd_reset(emu);
    printf("      ✓ Reset complete\n");

    if (!cfg->no_boot) {
        printf("[4/6] Waiting for boot sequence (%u frames)...\n", cfg->boot_frames);
        for (uint32_t i = 0; i < cfg->boot_frames; i++) {
            ret = pd_run_frames(emu, 1, &stop_info);
            if (ret != 0) {
                fprintf(stderr, "ERROR: Boot sequence failed at frame %u\n", i);
                pd_destroy(emu);
                return 1;
            }

            if (cfg->verbose && (i % 10) == 0) {
                printf("      Frame %u/%u...\n", i, cfg->boot_frames);
            }
        }
        printf("      ✓ Boot complete\n");
    } else {
        printf("[4/6] Skipping boot sequence (--no-boot)\n");
    }

    /* Step 5: Inject hook */
    printf("[5/6] Injecting hook at 0x%08X (%zu bytes)...\n",
           cfg->hook_address, SLAVE_HOOK_SIZE);

    ret = pd_mem_write(emu, PD_BUS_SH2_SDRAM, cfg->hook_address,
                       SLAVE_HOOK_CODE, SLAVE_HOOK_SIZE);
    if (ret < 0 || ret != (int)SLAVE_HOOK_SIZE) {
        fprintf(stderr, "ERROR: Hook injection failed (wrote %d/%zu bytes)\n",
                ret, SLAVE_HOOK_SIZE);
        pd_destroy(emu);
        return 1;
    }
    printf("      ✓ Hook injected (%d bytes)\n", ret);

    if (cfg->verbose) {
        print_hex_dump(SLAVE_HOOK_CODE, SLAVE_HOOK_SIZE, "Hook bytecode");
    }

    /* Step 6: Verify injection */
    if (cfg->verify_after_inject) {
        printf("[6/6] Verifying hook injection...\n");

        ret = pd_mem_read(emu, PD_BUS_SH2_SDRAM, cfg->hook_address,
                          verify_buf, SLAVE_HOOK_SIZE);
        if (ret < 0 || ret != (int)SLAVE_HOOK_SIZE) {
            fprintf(stderr, "ERROR: Hook verification read failed\n");
            pd_destroy(emu);
            return 2;
        }

        if (memcmp(SLAVE_HOOK_CODE, verify_buf, SLAVE_HOOK_SIZE) != 0) {
            fprintf(stderr, "ERROR: Hook verification failed (bytecode mismatch)\n");
            printf("Expected:\n");
            print_hex_dump(SLAVE_HOOK_CODE, SLAVE_HOOK_SIZE, "  ");
            printf("Got:\n");
            print_hex_dump(verify_buf, SLAVE_HOOK_SIZE, "  ");
            pd_destroy(emu);
            return 2;
        }

        printf("      ✓ Hook verified (bytecode matches)\n");
    }

    /* Step 7: Smoke test */
    if (cfg->test_frames > 0) {
        printf("\n[7/7] Running smoke test (%u frames)...\n", cfg->test_frames);

        pd_sh2_regs_t regs;
        uint32_t frame_0_count = 0;

        /* Read initial COMM4 value */
        pd_mem_read(emu, PD_BUS_SH2_SDRAM, 0x22000100,
                    &frame_0_count, 4);
        frame_0_count = frame_0_count;  /* Already in correct endianness */

        printf("      Initial SDRAM[0x22000100] = 0x%08X\n", frame_0_count);

        for (uint32_t i = 0; i < cfg->test_frames; i++) {
            ret = pd_run_frames(emu, 1, &stop_info);
            if (ret != 0) {
                fprintf(stderr, "ERROR: Smoke test failed at frame %u\n", i);
                pd_destroy(emu);
                return 1;
            }

            if (cfg->verbose && (i % 10) == 0) {
                pd_get_sh2_regs(emu, PD_CPU_SLAVE, &regs);
                printf("      Frame %u: Slave PC = 0x%08X\n", i, regs.pc);
            }
        }

        /* Read final COMM4 value */
        uint32_t frame_n_count = 0;
        pd_mem_read(emu, PD_BUS_SH2_SDRAM, 0x22000100,
                    &frame_n_count, 4);

        printf("      Final SDRAM[0x22000100] = 0x%08X\n", frame_n_count);
        printf("      Frames executed: %u\n", cfg->test_frames);

        if (frame_n_count > frame_0_count) {
            printf("      ✓ Smoke test PASSED (counter incremented)\n");
        } else {
            printf("      ⚠ Warning: Counter did not increment\n");
        }
    }

    /* Cleanup */
    pd_destroy(emu);

    printf("\n=== SUCCESS ===\n");
    printf("Phase 11 hook successfully injected at 0x%08X\n", cfg->hook_address);
    printf("\nNext steps:\n");
    printf("  1. Boot test ROM normally to verify hook doesn't crash\n");
    printf("  2. Check counters (COMM4, SDRAM[0x22000100]) incrementing each frame\n");
    printf("  3. Run 60-second validation (step 6 of Phase 11 roadmap)\n");

    return 0;
}

/* ============================================================================
 * MAIN
 * ============================================================================
 */

int main(int argc, char **argv)
{
    injector_config_t cfg;

    if (parse_args(argc, argv, &cfg) != 0) {
        return 4;
    }

    return run_injector(&cfg);
}
