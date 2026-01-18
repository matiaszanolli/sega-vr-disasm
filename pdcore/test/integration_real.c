/*
 * PicoDrive Debugger Core - Real Integration Test
 *
 * Tests pdcore with the actual PicoDrive emulator (not stubs)
 * Requires: Built PicoDrive with debug hooks
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../include/pdcore.h"

/* Test counter */
static int tests_passed = 0;
static int tests_failed = 0;

#define TEST(name) do { printf("  Testing: %s... ", name); } while(0)
#define PASS() do { printf("PASS\n"); tests_passed++; } while(0)
#define FAIL(msg) do { printf("FAIL: %s\n", msg); tests_failed++; } while(0)

/* ============================================================================
 * BASIC TESTS
 * ============================================================================
 */

void test_create_destroy(void)
{
    printf("\n=== Test: Create/Destroy ===\n");

    TEST("pd_create with NULL config");
    pd_t *emu = pd_create(NULL);
    if (emu != NULL) {
        PASS();
        pd_destroy(emu);
    } else {
        FAIL("pd_create returned NULL");
    }

    TEST("pd_create with config");
    pd_config_t config = {0};
    config.deterministic = 1;
    emu = pd_create(&config);
    if (emu != NULL) {
        PASS();
        pd_destroy(emu);
    } else {
        FAIL("pd_create with config returned NULL");
    }
}

void test_memory_bus_info(void)
{
    printf("\n=== Test: Memory Bus Info ===\n");

    pd_t *emu = pd_create(NULL);
    if (!emu) {
        FAIL("Could not create emulator");
        return;
    }

    pd_bus_info_t info;

    TEST("Get SH2 ROM bus info");
    int ret = pd_get_bus_info(emu, PD_BUS_SH2_ROM, &info);
    if (ret == 0 && info.size > 0) {
        printf("(start=0x%08x, size=%u KB) ", info.start, info.size/1024);
        PASS();
    } else {
        FAIL("Could not get bus info");
    }

    TEST("Get SH2 SDRAM bus info");
    ret = pd_get_bus_info(emu, PD_BUS_SH2_SDRAM, &info);
    if (ret == 0 && info.size > 0) {
        printf("(start=0x%08x, size=%u KB) ", info.start, info.size/1024);
        PASS();
    } else {
        FAIL("Could not get bus info");
    }

    TEST("Get SH2 FB bus info");
    ret = pd_get_bus_info(emu, PD_BUS_SH2_FB, &info);
    if (ret == 0 && info.size > 0) {
        printf("(start=0x%08x, size=%u KB) ", info.start, info.size/1024);
        PASS();
    } else {
        FAIL("Could not get bus info");
    }

    pd_destroy(emu);
}

void test_cpu_registers(void)
{
    printf("\n=== Test: CPU Registers ===\n");

    pd_t *emu = pd_create(NULL);
    if (!emu) {
        FAIL("Could not create emulator");
        return;
    }

    pd_sh2_regs_t regs;

    TEST("Read Master SH2 registers");
    int ret = pd_get_sh2_regs(emu, PD_CPU_MASTER, &regs);
    if (ret == 0) {
        printf("(PC=0x%08x) ", regs.pc);
        PASS();
    } else {
        FAIL("Could not read registers");
    }

    TEST("Read Slave SH2 registers");
    ret = pd_get_sh2_regs(emu, PD_CPU_SLAVE, &regs);
    if (ret == 0) {
        printf("(PC=0x%08x) ", regs.pc);
        PASS();
    } else {
        FAIL("Could not read registers");
    }

    TEST("Write and verify Master R0");
    regs.r[0] = 0xDEADBEEF;
    ret = pd_set_sh2_regs(emu, PD_CPU_MASTER, &regs);
    if (ret == 0) {
        pd_sh2_regs_t verify;
        pd_get_sh2_regs(emu, PD_CPU_MASTER, &verify);
        if (verify.r[0] == 0xDEADBEEF) {
            PASS();
        } else {
            FAIL("Register value not preserved");
        }
    } else {
        FAIL("Could not write registers");
    }

    pd_destroy(emu);
}

/* Simple breakpoint handler for testing */
static pd_breakpoint_action_t test_bp_handler(pd_t *emu, pd_cpu_t cpu, uint32_t pc, void *user_data)
{
    (void)emu; (void)cpu; (void)pc; (void)user_data;
    return PD_BP_HALT;
}

void test_breakpoints(void)
{
    printf("\n=== Test: Breakpoints ===\n");

    pd_t *emu = pd_create(NULL);
    if (!emu) {
        FAIL("Could not create emulator");
        return;
    }

    TEST("Add breakpoint at 0x06001000");
    int ret = pd_bp_exec_add(emu, PD_CPU_MASTER, 0x06001000, test_bp_handler, NULL);
    if (ret >= 0) {
        PASS();
    } else {
        FAIL("Could not add breakpoint");
    }

    TEST("Check breakpoint exists");
    ret = pd_bp_exec_exists(emu, PD_CPU_MASTER, 0x06001000);
    if (ret == 1) {
        PASS();
    } else {
        FAIL("Breakpoint not found");
    }

    TEST("Delete breakpoint");
    ret = pd_bp_exec_del(emu, PD_CPU_MASTER, 0x06001000);
    if (ret == 0) {
        PASS();
    } else {
        FAIL("Could not delete breakpoint");
    }

    TEST("Verify breakpoint deleted");
    ret = pd_bp_exec_exists(emu, PD_CPU_MASTER, 0x06001000);
    if (ret == 0) {
        PASS();
    } else {
        FAIL("Breakpoint still exists");
    }

    pd_destroy(emu);
}

/* ============================================================================
 * ROM TESTS (require actual ROM file)
 * ============================================================================
 */

void test_with_rom(const char *rom_path)
{
    printf("\n=== Test: ROM Loading (%s) ===\n", rom_path);
    printf("[NOTE: ROM loading not yet implemented in pdcore API]\n");

    /* ROM loading requires implementing pd_load_rom() function
     * For now, pdcore can only test basic functionality without ROM
     */
    (void)rom_path;  /* Suppress unused warning */

    printf("  Skipping ROM tests - not yet implemented\n");
}

/* ============================================================================
 * MAIN
 * ============================================================================
 */

int main(int argc, char **argv)
{
    printf("============================================\n");
    printf("pdcore Real Integration Test\n");
    printf("============================================\n");

    /* Basic tests (no ROM needed) */
    test_create_destroy();
    test_memory_bus_info();
    test_cpu_registers();
    test_breakpoints();

    /* ROM tests (if ROM provided) */
    if (argc > 1) {
        test_with_rom(argv[1]);
    } else {
        printf("\n[NOTE: Provide ROM path as argument for full tests]\n");
    }

    /* Summary */
    printf("\n============================================\n");
    printf("Results: %d passed, %d failed\n", tests_passed, tests_failed);
    printf("============================================\n");

    return tests_failed > 0 ? 1 : 0;
}
