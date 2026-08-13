#!/usr/bin/env python3
"""Reproduce the Q-026 passive direct-write PicoDrive overlay fail closed."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path

from prepare_mode1_picodrive import prepare as prepare_mode1


SOURCE_SHA256 = {
    "platform/libretro/libretro.c":
        "6ff1affcd76b40fe098b8e289a4c5bc205248d64dd50a42f86bd9abee5dda4df",
    "pico/32x/memory.c":
        "cf1a4f429358f2bc3fb9c1a098d4a9faae2a791f3de1468d2eb18b84e07ffa72",
    "pico/32x/sh2soc.c":
        "17f3db8229a4290c37dfc1bfcbf21fcd84bb7fe68d6f1ff527c0acf110718deb",
}


def sha256_path(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def replace_exact(source: str, old: str, new: str, name: str,
                  count: int = 1) -> str:
    old_count, new_count = source.count(old), source.count(new)
    if old_count == count and new_count == 0:
        return source.replace(old, new, count)
    if old_count == 0 and new_count == count:
        return source
    raise ValueError(
        f"Q-026 overlay precondition {name}: "
        f"old_count={old_count} new_count={new_count} expected={count}"
    )


def transform_libretro(path: Path) -> None:
    source = path.read_text()
    transforms: tuple[tuple[str, str, str, int], ...] = (
        (
            "allowlist-define",
            '''#define VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST \\
    "m68k:0x0001C922-0x0001C9CC;master:0x02303B00-0x02303F1C"''',
            '''#define VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST \\
    "m68k:0x0001C922-0x0001C9CC;master:0x02303B00-0x02303F1C"
#define VRD_MMIO_TRACE_Q026_PC_ALLOWLIST \\
    "m68k:0x0001C6FE-0x0001C76C|0x0001C8B0-0x0001C930;" \\
    "master:0x02301500-0x023025E0|0x02304000-0x02304290|0x02304600-0x02304654"''',
            1,
        ),
        (
            "state",
            """static int vrd_mmio_trace_mode1 = 0;
static unsigned int (*vrd_mmio_trace_orig_read_byte)(unsigned int) = NULL;""",
            """static int vrd_mmio_trace_mode1 = 0;
static int vrd_mmio_trace_q026 = 0;
static int vrd_mmio_trace_q026_pre_valid = 0;
static int vrd_mmio_trace_q026_post_valid = 0;
static unsigned int vrd_mmio_trace_q026_comm_pre[3];
static unsigned int vrd_mmio_trace_q026_comm_post[3];
static unsigned int (*vrd_mmio_trace_orig_read_byte)(unsigned int) = NULL;""",
            1,
        ),
        (
            "pc-policy",
            """    int pc_allowed = vrd_mmio_trace_mode1 ?
        ((cpu == VRD_MMIO_CPU_M68K &&
          pc >= VRD_MMIO_TRACE_MODE1_M68K_PC_START &&
          pc < VRD_MMIO_TRACE_MODE1_M68K_PC_END) ||
         (cpu == VRD_MMIO_CPU_MASTER &&
          pc >= VRD_MMIO_TRACE_MODE1_MASTER_PC_START &&
          pc < VRD_MMIO_TRACE_MODE1_MASTER_PC_END)) :""",
            """    int pc_allowed = vrd_mmio_trace_q026 ?
        ((cpu == VRD_MMIO_CPU_M68K &&
          ((pc >= 0x0001c6fe && pc < 0x0001c76c) ||
           (pc >= 0x0001c8b0 && pc < 0x0001c930))) ||
         (cpu == VRD_MMIO_CPU_MASTER &&
          ((pc >= 0x02301500 && pc < 0x023025e0) ||
           (pc >= 0x02304000 && pc < 0x02304290) ||
           (pc >= 0x02304600 && pc < 0x02304654)))) :
        vrd_mmio_trace_mode1 ?
        ((cpu == VRD_MMIO_CPU_M68K &&
          pc >= VRD_MMIO_TRACE_MODE1_M68K_PC_START &&
          pc < VRD_MMIO_TRACE_MODE1_M68K_PC_END) ||
         (cpu == VRD_MMIO_CPU_MASTER &&
          pc >= VRD_MMIO_TRACE_MODE1_MASTER_PC_START &&
          pc < VRD_MMIO_TRACE_MODE1_MASTER_PC_END)) :""",
            1,
        ),
        (
            "m68k-admission-snapshot",
            """    if (!vrd_mmio_trace_log || !vrd_mmio_trace_mode1)
        return;
    if (effective_address == 0x00a15103 ||""",
            """    if (!vrd_mmio_trace_log || (!vrd_mmio_trace_mode1 && !vrd_mmio_trace_q026))
        return;
    if (vrd_mmio_trace_q026 && pc == 0x0001c8f4 && op == VRD_MMIO_OP_WRITE &&
        effective_address == 0x00a15103 && width == 1 && value == 1) {
        vrd_mmio_trace_q026_comm_pre[0] = Pico32x.regs[0x22 / 2];
        vrd_mmio_trace_q026_comm_pre[1] = Pico32x.regs[0x24 / 2];
        vrd_mmio_trace_q026_comm_pre[2] = Pico32x.regs[0x2e / 2];
        vrd_mmio_trace_q026_pre_valid = 1;
    }
    if (effective_address == 0x00a15103 ||""",
            1,
        ),
        (
            "master-post-snapshot",
            """    if (!vrd_mmio_trace_mode1 && address == 0x20004021)
        return;
    vrd_mmio_trace_append(VRD_MMIO_CPU_MASTER, pc,""",
            """    if (!vrd_mmio_trace_mode1 && !vrd_mmio_trace_q026 && address == 0x20004021)
        return;
    if (vrd_mmio_trace_q026 && vrd_mmio_trace_q026_pre_valid &&
        op == VRD_MMIO_OP_WRITE && address == 0x20004000 && width == 2 &&
        (value & 2) != 0) {
        vrd_mmio_trace_q026_comm_post[0] = Pico32x.regs[0x22 / 2];
        vrd_mmio_trace_q026_comm_post[1] = Pico32x.regs[0x24 / 2];
        vrd_mmio_trace_q026_comm_post[2] = Pico32x.regs[0x2e / 2];
        vrd_mmio_trace_q026_post_valid = 1;
    }
    vrd_mmio_trace_append(VRD_MMIO_CPU_MASTER, pc,""",
            1,
        ),
        (
            "footer-format",
            """            "direct_m68k=1 direct_master=1 observer_detached=%d "
            "pc_allowlist=%s\n",""",
            """            "direct_m68k=1 direct_master=1 observer_detached=%d "
            "q026_edge_snapshots=%d q026_comm_pre=%04X/%04X/%04X "
            "q026_comm_post=%04X/%04X/%04X "
            "pc_allowlist=%s\n",""",
            1,
        ),
        (
            "footer-arguments",
            """            !vrd_mmio_trace_master_installed,
            vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                VRD_MMIO_TRACE_PC_ALLOWLIST);""",
            """            !vrd_mmio_trace_master_installed,
            vrd_mmio_trace_q026 ?
                (vrd_mmio_trace_q026_pre_valid && vrd_mmio_trace_q026_post_valid) : 0,
            vrd_mmio_trace_q026_comm_pre[0], vrd_mmio_trace_q026_comm_pre[1],
            vrd_mmio_trace_q026_comm_pre[2], vrd_mmio_trace_q026_comm_post[0],
            vrd_mmio_trace_q026_comm_post[1], vrd_mmio_trace_q026_comm_post[2],
            vrd_mmio_trace_q026 ? VRD_MMIO_TRACE_Q026_PC_ALLOWLIST :
                (vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                    VRD_MMIO_TRACE_PC_ALLOWLIST));""",
            1,
        ),
        (
            "allowlist-selectors",
            """            vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                VRD_MMIO_TRACE_PC_ALLOWLIST""",
            """            vrd_mmio_trace_q026 ? VRD_MMIO_TRACE_Q026_PC_ALLOWLIST :
                (vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                    VRD_MMIO_TRACE_PC_ALLOWLIST)""",
            2,
        ),
        (
            "mode-parse",
            """    if (mode && strcmp(mode, "mode1") != 0) {
        vrd_mmio_trace_error("VRD_MMIO_TRACE_MODE must be exactly mode1");
        return;
    }
    vrd_mmio_trace_mode1 = mode && strcmp(mode, "mode1") == 0;
    if (filestream_exists(path)) {""",
            """    if (mode && strcmp(mode, "mode1") != 0 && strcmp(mode, "q026") != 0) {
        vrd_mmio_trace_error("VRD_MMIO_TRACE_MODE must be exactly mode1 or q026");
        return;
    }
    vrd_mmio_trace_mode1 = mode && strcmp(mode, "mode1") == 0;
    vrd_mmio_trace_q026 = mode && strcmp(mode, "q026") == 0;
    vrd_mmio_trace_q026_pre_valid = 0;
    vrd_mmio_trace_q026_post_valid = 0;
    memset(vrd_mmio_trace_q026_comm_pre, 0,
        sizeof(vrd_mmio_trace_q026_comm_pre));
    memset(vrd_mmio_trace_q026_comm_post, 0,
        sizeof(vrd_mmio_trace_q026_comm_post));
    if (filestream_exists(path)) {""",
            1,
        ),
        (
            "filter",
            '''            vrd_mmio_trace_mode1 ?
                "# FILTER mode1_direct=1 "''',
            '''            vrd_mmio_trace_q026 ?
                "# FILTER q026_direct=1 m68k_system=0x00A15100-0x00A1513F "
                "master_system=0x20004000-0x2000403F "
                "master_peripheral=0xFFFFFE00-0xFFFFFFFF "
                "master_sdram=all_writes master_framebuffer=all_writes" :
            vrd_mmio_trace_mode1 ?
                "# FILTER mode1_direct=1 "''',
            1,
        ),
    )
    for name, old, new, count in transforms:
        source = replace_exact(source, old, new, name, count)
    path.write_text(source)


def transform_memory(path: Path) -> None:
    source = path.read_text()
    transforms = (
        (
            "write8-dram",
            """  sh2_write8_dramN(sh2->p_dram, a, d);
}""",
            """  sh2_write8_dramN(sh2->p_dram, a, d);
#ifdef __LIBRETRO__
  if (!sh2->is_slave)
    vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xff, 1, 1);
#endif
}""",
        ),
        (
            "write8-sdram",
            """  ((u8 *)sh2->p_sdram)[a1] = d;
#ifdef DRC_SH2""",
            """  ((u8 *)sh2->p_sdram)[a1] = d;
#ifdef __LIBRETRO__
  if (!sh2->is_slave)
    vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xff, 1, 1);
#endif
#ifdef DRC_SH2""",
        ),
        (
            "write16-dram",
            """  sh2_write16_dramN(sh2->p_dram, a, d);
}""",
            """  sh2_write16_dramN(sh2->p_dram, a, d);
#ifdef __LIBRETRO__
  if (!sh2->is_slave)
    vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xffff, 1, 2);
#endif
}""",
        ),
        (
            "write16-sdram",
            """  ((u16 *)sh2->p_sdram)[a1 / 2] = d;
#ifdef DRC_SH2""",
            """  ((u16 *)sh2->p_sdram)[a1 / 2] = d;
#ifdef __LIBRETRO__
  if (!sh2->is_slave)
    vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xffff, 1, 2);
#endif
#ifdef DRC_SH2""",
        ),
        (
            "write32-dram",
            """{
  sh2_write32_dramN(sh2->p_dram, a, d);
}""",
            """{
  u32 trace_d = d;
  sh2_write32_dramN(sh2->p_dram, a, d);
#ifdef __LIBRETRO__
  if (!sh2->is_slave)
    vrd_mmio_trace_master_event(sh2_pc(sh2), a, trace_d, 1, 4);
#endif
}""",
        ),
        (
            "write32-sdram",
            """  *(u32 *)((char*)sh2->p_sdram + a1) = CPU_BE2(d);
#ifdef DRC_SH2""",
            """  *(u32 *)((char*)sh2->p_sdram + a1) = CPU_BE2(d);
#ifdef __LIBRETRO__
  if (!sh2->is_slave)
    vrd_mmio_trace_master_event(sh2_pc(sh2), a, d, 1, 4);
#endif
#ifdef DRC_SH2""",
        ),
    )
    for name, old, new in transforms:
        source = replace_exact(source, old, new, name)
    path.write_text(source)


def verify_sources(source_root: Path) -> bool:
    return all(sha256_path(source_root / relative) == expected
               for relative, expected in SOURCE_SHA256.items())


def prepare(source_root: Path, tool_root: Path) -> str:
    if verify_sources(source_root):
        return "already-applied"
    prepare_mode1(source_root, tool_root)
    transform_libretro(source_root / "platform/libretro/libretro.c")
    transform_memory(source_root / "pico/32x/memory.c")
    if not verify_sources(source_root):
        actual = {relative: sha256_path(source_root / relative)
                  for relative in SOURCE_SHA256}
        raise ValueError(f"Q-026 overlay postimage mismatch: {actual}")
    return "applied"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", type=Path, required=True)
    parser.add_argument("--tool-root", type=Path,
                        default=Path(__file__).resolve().parent)
    args = parser.parse_args()
    try:
        status = prepare(args.source_root.resolve(), args.tool_root.resolve())
    except (OSError, ValueError) as error:
        print(f"Q-026 PicoDrive preparation FAILED: {error}")
        return 1
    print(f"Q-026 PicoDrive passive direct-write overlay: {status}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
