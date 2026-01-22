/*
 * pdcore CLI Tool - Command-line debugger interface
 *
 * Simple CLI for controlling pdcore debugger:
 * - Load ROM
 * - Boot emulator
 * - Read/write memory
 * - Inspect CPU state
 * - Inject hooks
 *
 * Compile:
 *   gcc -o pdcore_cli tools/pdcore_cli.c pdcore/src/pdcore.c \\
 *       pdcore/src/pdcore_bp.c pdcore/src/pdcore_exec.c \\
 *       pdcore/tests/pdcore_bridge_stubs.c \\
 *       -Ipdcore/include -O2
 *
 * Usage:
 *   ./pdcore_cli <rom_file> [commands...]
 *
 * Commands:
 *   boot [frames]           Boot ROM and optionally run N frames
 *   read <addr> [size]      Read memory (default: 16 bytes)
 *   write <addr> <hex>      Write hex bytes to memory
 *   regs [cpu]              Read CPU registers (default: master)
 *   help                    Show this help
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <ctype.h>

#include "pdcore.h"

/* ============================================================================
 * UTILITY FUNCTIONS
 * ============================================================================
 */

static void print_help(const char *prog)
{
    printf("pdcore CLI - PicoDrive 32X Debugger\n\n");
    printf("Usage: %s <rom_file> [commands]\n\n", prog);
    printf("Commands:\n");
    printf("  boot [N]          Boot ROM, optionally run N frames\n");
    printf("  read <addr> [sz]  Read memory at addr (default: 16 bytes)\n");
    printf("  write <addr> <xx> Write hex bytes to memory\n");
    printf("  regs [cpu]        Read CPU registers (master/slave)\n");
    printf("  help              Show this help\n\n");
    printf("Examples:\n");
    printf("  %s rom.32x boot 50\n", prog);
    printf("  %s rom.32x read 0x06000000 32\n", prog);
    printf("  %s rom.32x write 0x06000596 d00200002000402c\n", prog);
}

static uint32_t parse_hex32(const char *str)
{
    return (uint32_t)strtoul(str, NULL, 16);
}

static uint8_t hex_byte(const char *str, int pos)
{
    char buf[3];
    buf[0] = str[pos * 2];
    buf[1] = str[pos * 2 + 1];
    buf[2] = '\0';
    return (uint8_t)strtoul(buf, NULL, 16);
}

static void print_hex_dump(const uint8_t *data, size_t size, uint32_t addr)
{
    printf("Address: 0x%08X\n", addr);
    for (size_t i = 0; i < size; i += 16) {
        printf("  %08X: ", (unsigned)(addr + i));
        for (size_t j = i; j < i + 16 && j < size; j++) {
            printf("%02X%s", data[j], (j + 1) % 8 == 0 ? "  " : " ");
        }
        printf("\n");
    }
}

/* ============================================================================
 * COMMAND HANDLERS
 * ============================================================================
 */

static int cmd_boot(pd_t *emu, int argc, char **argv)
{
    uint32_t frames = 50;  /* Default: 50 frames */

    if (argc > 0) {
        frames = (uint32_t)strtoul(argv[0], NULL, 10);
    }

    printf("Booting ROM (%u frames)...\n", frames);
    pd_reset(emu);

    for (uint32_t i = 0; i < frames; i++) {
        pd_stop_info_t stop;
        int ret = pd_run_frames(emu, 1, &stop);
        if (ret != 0) {
            fprintf(stderr, "Error running frame %u\n", i);
            return 1;
        }

        if ((i % 10) == 0) {
            printf("  Frame %u/%u\n", i, frames);
        }
    }

    printf("✓ Boot complete (%u frames executed)\n", frames);
    return 0;
}

static int cmd_read(pd_t *emu, int argc, char **argv)
{
    if (argc < 1) {
        fprintf(stderr, "Usage: read <address> [size]\n");
        return 1;
    }

    uint32_t addr = parse_hex32(argv[0]);
    size_t size = 16;  /* Default: 16 bytes */

    if (argc > 1) {
        size = (size_t)strtoul(argv[1], NULL, 10);
    }

    uint8_t *buf = malloc(size);
    if (!buf) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    printf("Reading %zu bytes from 0x%08X...\n", size, addr);
    int ret = pd_mem_read(emu, PD_BUS_SH2_SDRAM, addr, buf, size);
    if (ret < 0) {
        fprintf(stderr, "Error reading memory: %s\n", pd_get_error(emu));
        free(buf);
        return 1;
    }

    print_hex_dump(buf, ret, addr);
    free(buf);
    return 0;
}

static int cmd_write(pd_t *emu, int argc, char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "Usage: write <address> <hexbytes>\n");
        return 1;
    }

    uint32_t addr = parse_hex32(argv[0]);
    const char *hex_str = argv[1];

    if (strlen(hex_str) % 2 != 0) {
        fprintf(stderr, "Error: hex string must have even number of digits\n");
        return 1;
    }

    size_t size = strlen(hex_str) / 2;
    uint8_t *buf = malloc(size);
    if (!buf) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    for (size_t i = 0; i < size; i++) {
        buf[i] = hex_byte(hex_str, i);
    }

    printf("Writing %zu bytes to 0x%08X...\n", size, addr);
    int ret = pd_mem_write(emu, PD_BUS_SH2_SDRAM, addr, buf, size);
    if (ret < 0) {
        fprintf(stderr, "Error writing memory: %s\n", pd_get_error(emu));
        free(buf);
        return 1;
    }

    printf("✓ Wrote %d bytes\n", ret);

    /* Verify */
    uint8_t *verify = malloc(size);
    ret = pd_mem_read(emu, PD_BUS_SH2_SDRAM, addr, verify, size);
    if (ret == (int)size && memcmp(buf, verify, size) == 0) {
        printf("✓ Verified: bytes match\n");
        free(verify);
        free(buf);
        return 0;
    } else {
        fprintf(stderr, "✗ Verification failed\n");
        free(verify);
        free(buf);
        return 1;
    }
}

static int cmd_regs(pd_t *emu, int argc, char **argv)
{
    pd_cpu_t cpu = PD_CPU_MASTER;

    if (argc > 0) {
        if (strcmp(argv[0], "slave") == 0) {
            cpu = PD_CPU_SLAVE;
        } else if (strcmp(argv[0], "master") != 0) {
            fprintf(stderr, "Usage: regs [master|slave]\n");
            return 1;
        }
    }

    const char *cpu_name = (cpu == PD_CPU_MASTER) ? "Master" : "Slave";
    printf("Reading %s SH2 registers...\n", cpu_name);

    pd_sh2_regs_t regs;
    memset(&regs, 0, sizeof(regs));

    int ret = pd_get_sh2_regs(emu, cpu, &regs);
    if (ret != 0) {
        fprintf(stderr, "Error reading registers: %s\n", pd_get_error(emu));
        return 1;
    }

    printf("\n%s SH2 Registers:\n", cpu_name);
    printf("  PC  = 0x%08X\n", regs.pc);
    printf("  PR  = 0x%08X\n", regs.pr);
    printf("  SR  = 0x%08X\n", regs.sr);
    printf("\n");
    printf("  General Purpose Registers:\n");
    for (int i = 0; i < 16; i++) {
        printf("    R%-2d = 0x%08X", i, regs.r[i]);
        if ((i + 1) % 2 == 0) printf("\n");
        else printf("  ");
    }

    return 0;
}

/* ============================================================================
 * MAIN
 * ============================================================================
 */

int main(int argc, char **argv)
{
    if (argc < 2) {
        print_help(argv[0]);
        return 1;
    }

    const char *rom_path = argv[1];

    printf("=== pdcore CLI - PicoDrive 32X Debugger ===\n\n");
    printf("Loading ROM: %s\n", rom_path);

    pd_t *emu = pd_create(NULL);
    if (!emu) {
        fprintf(stderr, "ERROR: Failed to create emulator\n");
        return 1;
    }

    int ret = pd_load_rom_file(emu, rom_path);
    if (ret != 0) {
        fprintf(stderr, "ERROR: Failed to load ROM: %s\n", pd_get_error(emu));
        pd_destroy(emu);
        return 1;
    }
    printf("✓ ROM loaded\n\n");

    /* Process commands */
    if (argc <= 2) {
        /* No commands, just boot */
        cmd_boot(emu, 0, NULL);
    } else {
        /* Execute commands */
        for (int i = 2; i < argc; i++) {
            const char *cmd = argv[i];
            int cmd_argc = argc - i - 1;
            char **cmd_argv = argv + i + 1;
            int cmd_ret = 0;

            printf("Command: %s\n", cmd);

            if (strcmp(cmd, "boot") == 0) {
                cmd_ret = cmd_boot(emu, cmd_argc, cmd_argv);
                i += (cmd_argc > 0 ? 1 : 0);
            } else if (strcmp(cmd, "read") == 0) {
                cmd_ret = cmd_read(emu, cmd_argc, cmd_argv);
                i += (cmd_argc > 0 ? cmd_argc - 1 : 0);
            } else if (strcmp(cmd, "write") == 0) {
                cmd_ret = cmd_write(emu, cmd_argc, cmd_argv);
                i += (cmd_argc > 0 ? cmd_argc - 1 : 0);
            } else if (strcmp(cmd, "regs") == 0) {
                cmd_ret = cmd_regs(emu, cmd_argc, cmd_argv);
                i += (cmd_argc > 0 ? cmd_argc - 1 : 0);
            } else if (strcmp(cmd, "help") == 0) {
                print_help(argv[0]);
            } else {
                fprintf(stderr, "Unknown command: %s\n", cmd);
                cmd_ret = 1;
            }

            if (cmd_ret != 0) {
                pd_destroy(emu);
                return cmd_ret;
            }
            printf("\n");
        }
    }

    pd_destroy(emu);
    printf("✓ Done\n");
    return 0;
}
