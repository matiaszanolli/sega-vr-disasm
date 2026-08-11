#!/usr/bin/env python3
"""Reproduce the isolated mode-1 direct-MMIO PicoDrive overlay fail closed."""

from __future__ import annotations

import argparse
import hashlib
import subprocess
from pathlib import Path

from prepare_q020_picodrive import prepare as prepare_q020_parity


PATCH_SHA256 = {
    "libretro_vrd_profiling_v4.patch":
        "b18ffc2bb490f5cc9a0fd3529d8d341e19e461a69cc7b64779b7419248a9faee",
    "libretro_vrd_mode1_mmio_overlay.patch":
        "76363ab8b336631dfc4082e9923f6fe8bf002d17a86a011d8038eb77a1b4a78a",
    "libretro_q020_cmdint_irq_parity.patch":
        "3ddbb6bc7736d5209bbe17c25b4244a225b9f684c1bc2ab156d49b5821490011",
}
SOURCE_SHA256 = {
    "platform/libretro/libretro.c":
        "1a0dd9d22bef0f807c32c2d28cbdae4d308c2276b747235f822a5305f69a3350",
    "pico/32x/memory.c":
        "2f5ca8195a3540161035f09ff48e54050154fb637cf20a852cedafa663e58425",
    "pico/32x/sh2soc.c":
        "17f3db8229a4290c37dfc1bfcbf21fcd84bb7fe68d6f1ff527c0acf110718deb",
}


def sha256_path(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def apply_patch(source_root: Path, patch: Path) -> None:
    result = subprocess.run(
        ["patch", "--batch", "--forward", "-p1"], cwd=source_root,
        input=patch.read_bytes(), stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, check=False,
    )
    if result.returncode != 0:
        raise ValueError(
            f"patch application failed: {patch.name}: "
            f"{result.stdout.decode(errors='replace').strip()}"
        )


def replace_once(source: str, old: str, new: str, name: str) -> str:
    old_count = source.count(old)
    new_count = source.count(new)
    if old_count == 1 and new_count == 0:
        return source.replace(old, new, 1)
    if old_count == 0 and new_count == 1:
        return source
    raise ValueError(
        f"direct overlay precondition {name}: "
        f"old_count={old_count} new_count={new_count}"
    )


def transform_libretro(path: Path) -> None:
    source = path.read_text()
    transforms = (
        (
            "comment",
            """/* VR60 Phase 1 / Gate A passive MMIO trace.  This logger deliberately wraps
 * only callbacks that the emulated CPUs already invoke.  Each wrapper calls
 * its saved callback exactly once and records the returned/input value in a
 * bounded in-memory buffer; it never performs a second MMIO read. */""",
            """/* VR60 Phase 1 / Gate A passive MMIO trace.  Mode 1 observes the canonical
 * 32X handlers directly, after each real read/write, and never performs a
 * second MMIO access.  The bounded buffer and explicit raw/rejected counters
 * make missing coverage, logger failure, and overflow fail closed. */""",
        ),
        (
            "ranges",
            """#define VRD_MMIO_TRACE_MODE1_M68K_PC_START 0x0001c922
#define VRD_MMIO_TRACE_MODE1_M68K_PC_END   0x0001c990
#define VRD_MMIO_TRACE_MODE1_MASTER_PC_START 0x02303a10
#define VRD_MMIO_TRACE_MODE1_MASTER_PC_END   0x02303aa8
#define VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST \\
    "m68k:0x0001C922-0x0001C990;master:0x02303A10-0x02303AA8\"""",
            """#define VRD_MMIO_TRACE_MODE1_M68K_PC_START 0x0001c922
#define VRD_MMIO_TRACE_MODE1_M68K_PC_END   0x0001c9cc
#define VRD_MMIO_TRACE_MODE1_MASTER_PC_START 0x02303b00
#define VRD_MMIO_TRACE_MODE1_MASTER_PC_END   0x02303f1c
#define VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST \\
    "m68k:0x0001C922-0x0001C9CC;master:0x02303B00-0x02303F1C\"""",
        ),
        (
            "counters",
            """static unsigned long long vrd_mmio_trace_dropped = 0;
static unsigned int vrd_mmio_trace_errors = 0;""",
            """static unsigned long long vrd_mmio_trace_dropped = 0;
static unsigned long long vrd_mmio_trace_raw_m68k = 0;
static unsigned long long vrd_mmio_trace_raw_master = 0;
static unsigned long long vrd_mmio_trace_pc_rejected_m68k = 0;
static unsigned long long vrd_mmio_trace_pc_rejected_master = 0;
static unsigned int vrd_mmio_trace_errors = 0;""",
        ),
        (
            "coverage",
            """    if (!pc_allowed)
        return;
    if (vrd_mmio_trace_count >= VRD_MMIO_TRACE_MAX_EVENTS) {""",
            """    if (cpu == VRD_MMIO_CPU_M68K)
        vrd_mmio_trace_raw_m68k++;
    else
        vrd_mmio_trace_raw_master++;
    if (!pc_allowed) {
        if (cpu == VRD_MMIO_CPU_M68K)
            vrd_mmio_trace_pc_rejected_m68k++;
        else
            vrd_mmio_trace_pc_rejected_master++;
        return;
    }
    if (vrd_mmio_trace_count >= VRD_MMIO_TRACE_MAX_EVENTS) {""",
        ),
        (
            "direct-entry",
            """void vrd_mmio_trace_master_event(
    unsigned int pc, unsigned int address, unsigned int value,
    unsigned int op, unsigned int width)
{
    vrd_mmio_trace_append(VRD_MMIO_CPU_MASTER, pc,
        op, address, width, value);
}""",
            """void vrd_mmio_trace_m68k_event(
    unsigned int pc, unsigned int address, unsigned int value,
    unsigned int op, unsigned int width)
{
    unsigned int effective_address = address & 0x00ffffff;

    if (!vrd_mmio_trace_log || !vrd_mmio_trace_mode1)
        return;
    if (effective_address == 0x00a15103 ||
        effective_address == 0x00a15107 ||
        effective_address == 0x00a1510c ||
        effective_address == 0x00a1510e ||
        effective_address == 0x00a15110 ||
        effective_address == 0x00a15112 ||
        (effective_address >= 0x00a15120 &&
         effective_address <= 0x00a1512f))
        vrd_mmio_trace_append(VRD_MMIO_CPU_M68K, pc, op,
            effective_address, width, value);
}

void vrd_mmio_trace_master_event(
    unsigned int pc, unsigned int address, unsigned int value,
    unsigned int op, unsigned int width)
{
    if (!vrd_mmio_trace_log)
        return;
    if (!vrd_mmio_trace_mode1 && address == 0x20004021)
        return;
    vrd_mmio_trace_append(VRD_MMIO_CPU_MASTER, pc,
        op, address, width, value);
}""",
        ),
        (
            "uninstall",
            """    if (vrd_mmio_trace_m68k_installed) {
        PicoCpuFM68k.read_byte = vrd_mmio_trace_orig_read_byte;
        PicoCpuFM68k.read_word = vrd_mmio_trace_orig_read_word;
        PicoCpuFM68k.write_byte = vrd_mmio_trace_orig_write_byte;
        PicoCpuFM68k.write_word = vrd_mmio_trace_orig_write_word;
        vrd_mmio_trace_m68k_installed = 0;
    }""",
            """    vrd_mmio_trace_m68k_installed = 0;""",
        ),
        (
            "finish",
            """        fprintf(vrd_mmio_trace_log,
            "# COMPLETE frames=%d events=%llu recorded=%u dropped=%llu "
            "errors=%u overflow=%d pc_allowlist=%s\\n",
            frames, total, vrd_mmio_trace_count, vrd_mmio_trace_dropped,
            vrd_mmio_trace_errors, vrd_mmio_trace_overflow,
            vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                VRD_MMIO_TRACE_PC_ALLOWLIST);""",
            """        fprintf(vrd_mmio_trace_log,
            "# COMPLETE frames=%d events=%llu recorded=%u dropped=%llu "
            "errors=%u overflow=%d raw_m68k=%llu raw_master=%llu "
            "pc_rejected_m68k=%llu pc_rejected_master=%llu "
            "direct_m68k=1 direct_master=1 observer_detached=%d "
            "pc_allowlist=%s\\n",
            frames, total, vrd_mmio_trace_count, vrd_mmio_trace_dropped,
            vrd_mmio_trace_errors, vrd_mmio_trace_overflow,
            vrd_mmio_trace_raw_m68k, vrd_mmio_trace_raw_master,
            vrd_mmio_trace_pc_rejected_m68k,
            vrd_mmio_trace_pc_rejected_master,
            !vrd_mmio_trace_master_installed,
            vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                VRD_MMIO_TRACE_PC_ALLOWLIST);""",
        ),
        (
            "init-counters",
            """    vrd_mmio_trace_dropped = 0;
    vrd_mmio_trace_errors = 0;""",
            """    vrd_mmio_trace_dropped = 0;
    vrd_mmio_trace_raw_m68k = 0;
    vrd_mmio_trace_raw_master = 0;
    vrd_mmio_trace_pc_rejected_m68k = 0;
    vrd_mmio_trace_pc_rejected_master = 0;
    vrd_mmio_trace_errors = 0;""",
        ),
        (
            "init-direct",
            """    vrd_mmio_trace_orig_read_byte = PicoCpuFM68k.read_byte;
    vrd_mmio_trace_orig_read_word = PicoCpuFM68k.read_word;
    vrd_mmio_trace_orig_write_byte = PicoCpuFM68k.write_byte;
    vrd_mmio_trace_orig_write_word = PicoCpuFM68k.write_word;
    if (!vrd_mmio_trace_orig_read_byte || !vrd_mmio_trace_orig_read_word ||
        !vrd_mmio_trace_orig_write_byte || !vrd_mmio_trace_orig_write_word) {
        vrd_mmio_trace_error("68K memory callbacks are not initialized");
        vrd_mmio_trace_finish(0, 0, "m68k_callbacks_unavailable");
        return;
    }
    PicoCpuFM68k.read_byte = vrd_mmio_trace_read_byte;
    PicoCpuFM68k.read_word = vrd_mmio_trace_read_word;
    PicoCpuFM68k.write_byte = vrd_mmio_trace_write_byte;
    PicoCpuFM68k.write_word = vrd_mmio_trace_write_word;
    vrd_mmio_trace_m68k_installed = 1;""",
            """    /* Observation is compiled into the canonical 32X handlers.  Root memory
     * callbacks and SH2 maps are rebuilt during startup, so wrapping either
     * one here would silently lose coverage before the validation route. */
    vrd_mmio_trace_m68k_installed = 1;""",
        ),
        (
            "header",
            """            "# VRD_MMIO_TRACE version=2 capacity=%u sh2_drc=%d "
            "profile_pc=%d profile_pc_env=%d m68k_batching=%s "
            "instruction_start_hook=%d m68k_wrapped=%d "
            "master_wrapped=%d coverage_from_start=%d pc_allowlist=%s\\n",""",
            """            "# VRD_MMIO_TRACE version=3 capacity=%u sh2_drc=%d "
            "profile_pc=%d profile_pc_env=%d m68k_batching=%s "
            "instruction_start_hook=%d m68k_direct=%d "
            "master_direct=%d coverage_from_start=%d pc_allowlist=%s\\n",""",
        ),
        (
            "filter",
            """                "# FILTER m68k_read8=0x00A15107|0x00A15121|0x00A15123 "
                "m68k_read16=0x00A15110 "
                "m68k_write16=0x00A15112 "
                "m68k_write8=0x00A15120|0x00A15121|0x00A15123 "
                "master_read8=0x20004020|0x20004021|0x20004023 "
                "master_read16=0x20004010 "
                "master_write8=0x20004020|0x20004021|0x20004023" :""",
            """                "# FILTER mode1_direct=1 "
                "m68k=0x00A15103|0x00A15107|0x00A1510C|0x00A1510E|0x00A15110|0x00A15112|0x00A15120-0x00A1512F "
                "master_system=0x20004000-0x2000403F "
                "master_peripheral=0xFFFFFE00-0xFFFFFFFF" :""",
        ),
        (
            "caller-finish",
            """         vrd_caller_trace_finish(1, vrd_profile_max_frames, NULL);
      }
   }
   if (vrd_mmio_trace_log &&""",
            """      }
   }
   if (vrd_caller_trace_log &&
       vrd_profile_frame == vrd_profile_max_frames - 1)
      vrd_caller_trace_finish(1, vrd_profile_max_frames, NULL);
   if (vrd_mmio_trace_log &&""",
        ),
    )
    for name, old, new in transforms:
        source = replace_once(source, old, new, name)
    path.write_text(source)


def transform_memory(path: Path, v4_patch: Path) -> None:
    source = path.read_text()
    transforms = (
        (
            "externs",
            """#include <cpu/sh2/compiler.h>
DRC_DECLARE_SR;

static const char str_mars[] = "MARS";""",
            """#include <cpu/sh2/compiler.h>
DRC_DECLARE_SR;

#ifdef __LIBRETRO__
extern void vrd_mmio_trace_m68k_event(unsigned int pc,
  unsigned int address, unsigned int value, unsigned int op,
  unsigned int width);
extern void vrd_mmio_trace_master_event(unsigned int pc,
  unsigned int address, unsigned int value, unsigned int op,
  unsigned int width);
#endif

static const char str_mars[] = "MARS";""",
        ),
        (
            "m68k-read8",
            """out:
  elprintf(EL_32X, "m68k 32x r8  [%06x]   %02x @%06x", a, d, SekPc);
  return d;""",
            """out:
  elprintf(EL_32X, "m68k 32x r8  [%06x]   %02x @%06x", a, d, SekPc);
#ifdef __LIBRETRO__
  vrd_mmio_trace_m68k_event(SekPc, a, d & 0xff, 0, 1);
#endif
  return d;""",
        ),
        (
            "m68k-read16",
            """out:
  elprintf(EL_32X, "m68k 32x r16 [%06x] %04x @%06x", a, d, SekPc);
  return d;""",
            """out:
  elprintf(EL_32X, "m68k 32x r16 [%06x] %04x @%06x", a, d, SekPc);
#ifdef __LIBRETRO__
  vrd_mmio_trace_m68k_event(SekPc, a, d & 0xffff, 0, 2);
#endif
  return d;""",
        ),
        (
            "m68k-write8",
            """  if ((a & 0xffc0) == 0x5100) { // a15100
    p32x_reg_write8(a, d);
    return;
  }""",
            """  if ((a & 0xffc0) == 0x5100) { // a15100
    p32x_reg_write8(a, d);
#ifdef __LIBRETRO__
    vrd_mmio_trace_m68k_event(SekPc, a, d & 0xff, 1, 1);
#endif
    return;
  }""",
        ),
        (
            "m68k-write16",
            """  if ((a & 0xffc0) == 0x5100) { // a15100
    p32x_reg_write16(a, d);
    return;
  }""",
            """  if ((a & 0xffc0) == 0x5100) { // a15100
    p32x_reg_write16(a, d);
#ifdef __LIBRETRO__
    vrd_mmio_trace_m68k_event(SekPc, a, d & 0xffff, 1, 2);
#endif
    return;
  }""",
        ),
        (
            "master-read16",
            """  if ((a & 0x3ffc0) == 0x4000) {
    d = p32x_sh2reg_read16(a, sh2);
    if (!(EL_LOGMASK & EL_PWM) && (a & 0x30) == 0x30) // hide PWM""",
            """  if ((a & 0x3ffc0) == 0x4000) {
    d = p32x_sh2reg_read16(a, sh2);
#ifdef __LIBRETRO__
    if (!sh2->is_slave)
      vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xffff, 0, 2);
#endif
    if (!(EL_LOGMASK & EL_PWM) && (a & 0x30) == 0x30) // hide PWM""",
        ),
        (
            "master-write16",
            """  if ((a & 0x3ffc0) == 0x4000) {
    p32x_sh2reg_write16(a, d, sh2);
    goto out;
  }""",
            """  if ((a & 0x3ffc0) == 0x4000) {
    p32x_sh2reg_write16(a, d, sh2);
#ifdef __LIBRETRO__
    if (!sh2->is_slave)
      vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xffff, 1, 2);
#endif
    goto out;
  }""",
        ),
    )
    for name, old, new in transforms:
        source = replace_once(source, old, new, name)

    patch_lines = v4_patch.read_text().splitlines()
    start = next(
        i for i, line in enumerate(patch_lines)
        if line == "+typedef void (vrd_mmio_trace_master_observer_t)("
    )
    end = next(
        i for i in range(start, len(patch_lines)) if patch_lines[i] == "+#endif"
    ) + 1
    old_block = "\n".join(line[1:] for line in patch_lines[start:end]) + "\n"
    old_block = old_block.replace(
        "(address == 0x20004020 || address == 0x20004023)",
        "(address == 0x20004020 || address == 0x20004021 ||\n"
        "       address == 0x20004023)",
    )
    new_block = """typedef void (vrd_mmio_trace_master_observer_t)(
    unsigned int pc, unsigned int address, unsigned int value,
    unsigned int op, unsigned int width);
static vrd_mmio_trace_master_observer_t *vrd_mmio_trace_master_observer;

int Pico32xVrdMmioTraceMasterInstall(
    vrd_mmio_trace_master_observer_t *observer)
{
  if (!observer)
    return 0;
  /* Canonical 32X handlers call the observer directly.  SH2 map tables are
   * rebuilt at startup and must never be patched for acceptance tracing. */
  vrd_mmio_trace_master_observer = observer;
  return 1;
}

void Pico32xVrdMmioTraceMasterUninstall(void)
{
  vrd_mmio_trace_master_observer = NULL;
}
#endif
"""
    source = replace_once(source, old_block, new_block, "master-map-removal")
    path.write_text(source)


def transform_sh2soc(path: Path) -> None:
    source = path.read_text()
    source = replace_once(
        source,
        """#include "../pico_int.h"
#include "../memory.h\"""",
        """#include "../pico_int.h"

#ifdef __LIBRETRO__
extern void vrd_mmio_trace_master_event(unsigned int pc,
  unsigned int address, unsigned int value, unsigned int op,
  unsigned int width);
#endif
#include "../memory.h\"""",
        "sh2soc-extern",
    )
    read_fragments = (
        ("d = PREG8(r, a);", "d, 0, 1"),
        ("d = r[MEM_BE2(a / 2)];", "d, 0, 2"),
        ("d = sh2->peri_regs[a / 4];", "d, 0, 4"),
    )
    for index, (line, args) in enumerate(read_fragments):
        source = replace_once(
            source, line,
            line + "\n#ifdef __LIBRETRO__\n"
            "  if (!sh2->is_slave)\n"
            "    vrd_mmio_trace_master_event(sh2_pc(sh2), a | ~0x1ff,\n"
            f"      {args});\n#endif",
            f"sh2soc-read{index}",
        )
    write_fragments = (
        ("PREG8(r, a) = d;", "d & 0xff, 1, 1"),
        ("r[MEM_BE2(a / 2)] = d;", "d & 0xffff, 1, 2"),
        ("r[a / 4] = d;", "d, 1, 4"),
    )
    for index, (line, args) in enumerate(write_fragments):
        source = replace_once(
            source, line,
            line + "\n#ifdef __LIBRETRO__\n"
            "  if (!sh2->is_slave)\n"
            "    vrd_mmio_trace_master_event(sh2_pc(sh2), a | ~0x1ff,\n"
            f"      {args});\n#endif",
            f"sh2soc-write{index}",
        )
    path.write_text(source)


def verify_sources(source_root: Path) -> bool:
    return all(
        sha256_path(source_root / relative) == expected
        for relative, expected in SOURCE_SHA256.items()
    )


def prepare(source_root: Path, tool_root: Path) -> str:
    patches = {name: tool_root / name for name in PATCH_SHA256}
    for name, path in patches.items():
        if sha256_path(path) != PATCH_SHA256[name]:
            raise ValueError(f"patch identity: {name}")
    if verify_sources(source_root):
        return "already-applied"

    libretro = source_root / "platform/libretro/libretro.c"
    if "VRD Profiling instrumentation" not in libretro.read_text():
        apply_patch(source_root, patches["libretro_vrd_profiling_v4.patch"])
    if "0x02303a90" in libretro.read_text():
        apply_patch(source_root, patches["libretro_vrd_mode1_mmio_overlay.patch"])
    elif "0x02303aa8" not in libretro.read_text():
        raise ValueError("mode-1 base-overlay precondition")

    prepare_q020_parity(
        source_root, patches["libretro_q020_cmdint_irq_parity.patch"]
    )
    transform_libretro(libretro)
    transform_memory(
        source_root / "pico/32x/memory.c",
        patches["libretro_vrd_profiling_v4.patch"],
    )
    transform_sh2soc(source_root / "pico/32x/sh2soc.c")
    if not verify_sources(source_root):
        actual = {
            relative: sha256_path(source_root / relative)
            for relative in SOURCE_SHA256
        }
        raise ValueError(f"direct overlay postimage mismatch: {actual}")
    return "applied"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", type=Path, required=True)
    parser.add_argument(
        "--tool-root", type=Path, default=Path(__file__).resolve().parent
    )
    args = parser.parse_args()
    try:
        status = prepare(args.source_root.resolve(), args.tool_root.resolve())
    except (OSError, StopIteration, ValueError) as error:
        print(f"mode-1 PicoDrive preparation FAILED: {error}")
        return 1
    print(f"mode-1 PicoDrive direct-MMIO overlay: {status}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
