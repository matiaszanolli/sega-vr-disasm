#!/usr/bin/env python3
"""Reproduce the Q-027 passive MMIO/register PicoDrive overlay fail closed."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path

from prepare_q026_picodrive import prepare as prepare_q026


PREIMAGE_SHA256 = {
    "platform/libretro/libretro.c":
        "6ff1affcd76b40fe098b8e289a4c5bc205248d64dd50a42f86bd9abee5dda4df",
    "pico/32x/memory.c":
        "cf1a4f429358f2bc3fb9c1a098d4a9faae2a791f3de1468d2eb18b84e07ffa72",
    "pico/32x/sh2soc.c":
        "17f3db8229a4290c37dfc1bfcbf21fcd84bb7fe68d6f1ff527c0acf110718deb",
    "cpu/sh2/mame/sh2pico.c":
        "5ffb2eed4c9d263bee8eae11fbf12bc277f85ff8b3948ca55e3ba68d22b340ef",
}

# Filled only with reviewed postimages.  The preparer refuses any other state.
SOURCE_SHA256 = {
    "platform/libretro/libretro.c":
        "59974942ac2eeaf7348db177a1ebc6a645a849a5e73223614db0a42d64b5db12",
    "pico/32x/memory.c":
        "e8c8a1e8ba4fbfa10c43368fdb0745ea36a2661116dedd9af3eb671f21f4a2d7",
    "pico/32x/sh2soc.c": PREIMAGE_SHA256["pico/32x/sh2soc.c"],
    "cpu/sh2/mame/sh2pico.c":
        "95caea269e742d1a76a5f3005f05f37c46886bfd194011f9d2b6e3e7a50313a3",
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
        f"Q-027 overlay precondition {name}: "
        f"old_count={old_count} new_count={new_count} expected={count}"
    )


def transform_libretro(path: Path) -> None:
    source = path.read_text()
    transforms: tuple[tuple[str, str, str, int], ...] = (
        (
            "allowlist",
            '''#define VRD_MMIO_TRACE_Q026_PC_ALLOWLIST \\
    "m68k:0x0001C6FE-0x0001C76C|0x0001C8B0-0x0001C930;" \\
    "master:0x02301500-0x023025E0|0x02304000-0x02304290|0x02304600-0x02304654"''',
            '''#define VRD_MMIO_TRACE_Q026_PC_ALLOWLIST \\
    "m68k:0x0001C6FE-0x0001C76C|0x0001C8B0-0x0001C930;" \\
    "master:0x02301500-0x023025E0|0x02304000-0x02304290|0x02304600-0x02304654"
#define VRD_MMIO_TRACE_Q027_PC_ALLOWLIST \\
    "m68k:0x0001C6FE-0x0001C76C|0x0001C8B0-0x0001C930|0x0001C930-0x0001CB0E;" \\
    "master:0x06000460-0x06000478|0x02301500-0x023025E0|" \\
    "0x02304000-0x02304314|0x02304500-0x02304504|0x02304600-0x0230466C"''',
            1,
        ),
        (
            "state",
            """static int vrd_mmio_trace_q026 = 0;
static int vrd_mmio_trace_q026_pre_valid = 0;""",
            """static int vrd_mmio_trace_q026 = 0;
static int vrd_mmio_trace_q027 = 0;
static int vrd_mmio_trace_q027_pre_valid = 0;
static int vrd_mmio_trace_q027_post_valid = 0;
static unsigned int vrd_mmio_trace_q027_comm_pre[8];
static unsigned int vrd_mmio_trace_q027_comm_post[8];
static FILE *vrd_mmio_trace_q027_regs_log = NULL;
static unsigned int vrd_mmio_trace_q027_regs_sequence = 0;
static unsigned int vrd_mmio_trace_q027_regs_errors = 0;
static unsigned int vrd_mmio_trace_q027_dispatch_armed = 0;
static unsigned int vrd_mmio_trace_q027_dispatch_mask = 0;
static unsigned int vrd_mmio_trace_q027_handler_entry = 0;
static unsigned int vrd_mmio_trace_q027_handler_exit = 0;
static int vrd_mmio_trace_q026_pre_valid = 0;""",
            1,
        ),
        (
            "pc-policy",
            """    int pc_allowed = vrd_mmio_trace_q026 ?
        ((cpu == VRD_MMIO_CPU_M68K &&""",
            """    int pc_allowed = vrd_mmio_trace_q027 ?
        ((cpu == VRD_MMIO_CPU_M68K &&
          ((pc >= 0x0001c6fe && pc < 0x0001c76c) ||
           (pc >= 0x0001c8b0 && pc < 0x0001cb0e))) ||
         (cpu == VRD_MMIO_CPU_MASTER &&
          ((pc >= 0x06000460 && pc < 0x06000478) ||
           (pc >= 0x02301500 && pc < 0x023025e0) ||
           (pc >= 0x02304000 && pc < 0x02304314) ||
           (pc >= 0x02304500 && pc < 0x02304504) ||
           (pc >= 0x02304600 && pc < 0x0230466c)))) :
        vrd_mmio_trace_q026 ?
        ((cpu == VRD_MMIO_CPU_M68K &&""",
            1,
        ),
        (
            "m68k-enable",
            """    if (!vrd_mmio_trace_log || (!vrd_mmio_trace_mode1 && !vrd_mmio_trace_q026))
        return;
    if (vrd_mmio_trace_q026 && pc == 0x0001c8f4""",
            """    if (!vrd_mmio_trace_log ||
        (!vrd_mmio_trace_mode1 && !vrd_mmio_trace_q026 && !vrd_mmio_trace_q027))
        return;
    if (vrd_mmio_trace_q027 && !vrd_mmio_trace_q027_pre_valid &&
        op == VRD_MMIO_OP_WRITE && effective_address == 0x00a15103 &&
        width == 1 && value == 1) {
        unsigned int i;
        for (i = 0; i < 8; i++)
            vrd_mmio_trace_q027_comm_pre[i] = Pico32x.regs[(0x20 + i * 2) / 2];
        vrd_mmio_trace_q027_pre_valid = 1;
    }
    if (vrd_mmio_trace_q026 && pc == 0x0001c8f4""",
            1,
        ),
        (
            "master-enable-and-snapshots",
            """    if (!vrd_mmio_trace_mode1 && !vrd_mmio_trace_q026 && address == 0x20004021)
        return;
    if (vrd_mmio_trace_q026 && vrd_mmio_trace_q026_pre_valid &&""",
            """    if (!vrd_mmio_trace_mode1 && !vrd_mmio_trace_q026 &&
        !vrd_mmio_trace_q027 && address == 0x20004021)
        return;
    if (vrd_mmio_trace_q027 && op == VRD_MMIO_OP_WRITE && width == 4 &&
        pc == 0x023041aa && address == 0x2600bc64 && value == 2)
        vrd_mmio_trace_q027_dispatch_armed = 1;
    if (vrd_mmio_trace_q027 && vrd_mmio_trace_q027_pre_valid &&
        !vrd_mmio_trace_q027_post_valid && op == VRD_MMIO_OP_WRITE &&
        address == 0x20004000 && width == 2 && (value & 2) != 0 &&
        ((pc >= 0x02301500 && pc < 0x023016b0) ||
         (pc >= 0x023041b4 && pc < 0x023041ec))) {
        unsigned int i;
        for (i = 0; i < 8; i++)
            vrd_mmio_trace_q027_comm_post[i] = Pico32x.regs[(0x20 + i * 2) / 2];
        vrd_mmio_trace_q027_post_valid = 1;
    }
    if (vrd_mmio_trace_q026 && vrd_mmio_trace_q026_pre_valid &&""",
            1,
        ),
        (
            "footer-format",
            """            "q026_edge_snapshots=%d q026_comm_pre=%04X/%04X/%04X "
            "q026_comm_post=%04X/%04X/%04X "
            "pc_allowlist=%s\\n",""",
            """            "q026_edge_snapshots=%d q026_comm_pre=%04X/%04X/%04X "
            "q026_comm_post=%04X/%04X/%04X "
            "q027_edge_snapshots=%d q027_regs=%u q027_regs_errors=%u "
            "q027_dispatch_mask=%04X q027_handler_entry=%u q027_handler_exit=%u "
            "q027_comm_pre=%04X/%04X/%04X/%04X/%04X/%04X/%04X/%04X "
            "q027_comm_post=%04X/%04X/%04X/%04X/%04X/%04X/%04X/%04X "
            "pc_allowlist=%s\\n",""",
            1,
        ),
        (
            "footer-arguments",
            """            vrd_mmio_trace_q026_comm_pre[2], vrd_mmio_trace_q026_comm_post[0],
            vrd_mmio_trace_q026_comm_post[1], vrd_mmio_trace_q026_comm_post[2],
            vrd_mmio_trace_q026 ? VRD_MMIO_TRACE_Q026_PC_ALLOWLIST :
                (vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                    VRD_MMIO_TRACE_PC_ALLOWLIST));""",
            """            vrd_mmio_trace_q026_comm_pre[2], vrd_mmio_trace_q026_comm_post[0],
            vrd_mmio_trace_q026_comm_post[1], vrd_mmio_trace_q026_comm_post[2],
            vrd_mmio_trace_q027 ?
                (vrd_mmio_trace_q027_pre_valid && vrd_mmio_trace_q027_post_valid) : 0,
            vrd_mmio_trace_q027_regs_sequence, vrd_mmio_trace_q027_regs_errors,
            vrd_mmio_trace_q027_dispatch_mask,
            vrd_mmio_trace_q027_handler_entry, vrd_mmio_trace_q027_handler_exit,
            vrd_mmio_trace_q027_comm_pre[0], vrd_mmio_trace_q027_comm_pre[1],
            vrd_mmio_trace_q027_comm_pre[2], vrd_mmio_trace_q027_comm_pre[3],
            vrd_mmio_trace_q027_comm_pre[4], vrd_mmio_trace_q027_comm_pre[5],
            vrd_mmio_trace_q027_comm_pre[6], vrd_mmio_trace_q027_comm_pre[7],
            vrd_mmio_trace_q027_comm_post[0], vrd_mmio_trace_q027_comm_post[1],
            vrd_mmio_trace_q027_comm_post[2], vrd_mmio_trace_q027_comm_post[3],
            vrd_mmio_trace_q027_comm_post[4], vrd_mmio_trace_q027_comm_post[5],
            vrd_mmio_trace_q027_comm_post[6], vrd_mmio_trace_q027_comm_post[7],
            vrd_mmio_trace_q027 ? VRD_MMIO_TRACE_Q027_PC_ALLOWLIST :
                (vrd_mmio_trace_q026 ? VRD_MMIO_TRACE_Q026_PC_ALLOWLIST :
                    (vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                        VRD_MMIO_TRACE_PC_ALLOWLIST)));""",
            1,
        ),
        (
            "allowlist-selectors",
            """            vrd_mmio_trace_q026 ? VRD_MMIO_TRACE_Q026_PC_ALLOWLIST :
                (vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                    VRD_MMIO_TRACE_PC_ALLOWLIST)""",
            """            vrd_mmio_trace_q027 ? VRD_MMIO_TRACE_Q027_PC_ALLOWLIST :
                (vrd_mmio_trace_q026 ? VRD_MMIO_TRACE_Q026_PC_ALLOWLIST :
                    (vrd_mmio_trace_mode1 ? VRD_MMIO_TRACE_MODE1_PC_ALLOWLIST :
                        VRD_MMIO_TRACE_PC_ALLOWLIST))""",
            2,
        ),
        (
            "mode-parse",
            """    if (mode && strcmp(mode, "mode1") != 0 && strcmp(mode, "q026") != 0) {
        vrd_mmio_trace_error("VRD_MMIO_TRACE_MODE must be exactly mode1 or q026");
        return;
    }
    vrd_mmio_trace_mode1 = mode && strcmp(mode, "mode1") == 0;
    vrd_mmio_trace_q026 = mode && strcmp(mode, "q026") == 0;
    vrd_mmio_trace_q026_pre_valid = 0;""",
            """    if (mode && strcmp(mode, "mode1") != 0 && strcmp(mode, "q026") != 0 &&
        strcmp(mode, "q027") != 0) {
        vrd_mmio_trace_error("VRD_MMIO_TRACE_MODE must be exactly mode1, q026, or q027");
        return;
    }
    vrd_mmio_trace_mode1 = mode && strcmp(mode, "mode1") == 0;
    vrd_mmio_trace_q026 = mode && strcmp(mode, "q026") == 0;
    vrd_mmio_trace_q027 = mode && strcmp(mode, "q027") == 0;
    vrd_mmio_trace_q027_pre_valid = 0;
    vrd_mmio_trace_q027_post_valid = 0;
    vrd_mmio_trace_q027_regs_sequence = 0;
    vrd_mmio_trace_q027_regs_errors = 0;
    vrd_mmio_trace_q027_dispatch_armed = 0;
    vrd_mmio_trace_q027_dispatch_mask = 0;
    vrd_mmio_trace_q027_handler_entry = 0;
    vrd_mmio_trace_q027_handler_exit = 0;
    memset(vrd_mmio_trace_q027_comm_pre, 0,
        sizeof(vrd_mmio_trace_q027_comm_pre));
    memset(vrd_mmio_trace_q027_comm_post, 0,
        sizeof(vrd_mmio_trace_q027_comm_post));
    vrd_mmio_trace_q026_pre_valid = 0;""",
            1,
        ),
        (
            "filter",
            '''            vrd_mmio_trace_q026 ?
                "# FILTER q026_direct=1 m68k_system=0x00A15100-0x00A1513F "''',
            '''            vrd_mmio_trace_q027 ?
                "# FILTER q027_passive=1 m68k_system=0x00A15100-0x00A1513F "
                "master_system=0x20004000-0x2000403F "
                "master_peripheral=0xFFFFFE00-0xFFFFFFFF "
                "master_sdram=all_writes master_framebuffer=all_writes "
                "master_regs=exact_instruction_pc" :
            vrd_mmio_trace_q026 ?
                "# FILTER q026_direct=1 m68k_system=0x00A15100-0x00A1513F "''',
            1,
        ),
        (
            "force-interpreter",
            '''   if (getenv("VRD_PROFILE_PC"))   /* VRD: SH2 interpreter required for PC sampling */
      PicoIn.opt &= ~POPT_EN_DRC;''',
            '''   if (getenv("VRD_PROFILE_PC") ||
       (getenv("VRD_MMIO_TRACE_MODE") &&
        strcmp(getenv("VRD_MMIO_TRACE_MODE"), "q027") == 0))
      PicoIn.opt &= ~POPT_EN_DRC; /* Q-027 exact-PC passive register snapshots */''',
            1,
        ),
        (
            "register-callback",
            """void vrd_mmio_trace_master_event(
    unsigned int pc, unsigned int address, unsigned int value,
    unsigned int op, unsigned int width)
{""",
            """void vrd_q027_sh2_instruction(SH2 *sh2, unsigned int pc)
{
    static const unsigned int dispatcher_pc[] = {
        0x06000460, 0x06000462, 0x06000464, 0x06000466,
        0x06000468, 0x0600046a, 0x0600046c, 0x0600046e,
        0x06000470, 0x06000472, 0x06000474
    };
    unsigned int i, bit = 0;
    const char *path;
    if (!vrd_mmio_trace_q027 || !sh2 || sh2->is_slave)
        return;
    if (!vrd_mmio_trace_q027_regs_log) {
        path = getenv("VRD_Q027_REG_TRACE");
        if (!path || !*path || filestream_exists(path)) {
            vrd_mmio_trace_q027_regs_errors++;
            return;
        }
        vrd_mmio_trace_q027_regs_log = fopen(path, "w");
        if (!vrd_mmio_trace_q027_regs_log) {
            vrd_mmio_trace_q027_regs_errors++;
            return;
        }
        if (fprintf(vrd_mmio_trace_q027_regs_log,
                "sequence,frame,pc,pr,sr,gbr,mach,macl,r8,r9,r10,r11,r12,r13,r14,r15\\n") < 0)
            vrd_mmio_trace_q027_regs_errors++;
    }
    if (vrd_mmio_trace_q027_dispatch_armed) {
        for (i = 0; i < sizeof(dispatcher_pc) / sizeof(dispatcher_pc[0]); i++)
            if (pc == dispatcher_pc[i]) { bit = 1u << i; break; }
    }
    if (pc == 0x02301500 && !vrd_mmio_trace_q027_handler_entry) {
        bit = 1u << 11;
        vrd_mmio_trace_q027_handler_entry = 1;
    }
    if (pc == 0x0230160a && !vrd_mmio_trace_q027_handler_exit) {
        bit = 1u << 12;
        vrd_mmio_trace_q027_handler_exit = 1;
    }
    if (!bit || (vrd_mmio_trace_q027_dispatch_mask & bit))
        return;
    vrd_mmio_trace_q027_dispatch_mask |= bit;
    if (fprintf(vrd_mmio_trace_q027_regs_log,
            "%u,%d,0x%08X,0x%08X,0x%08X,0x%08X,0x%08X,0x%08X,"
            "0x%08X,0x%08X,0x%08X,0x%08X,0x%08X,0x%08X,0x%08X,0x%08X\\n",
            vrd_mmio_trace_q027_regs_sequence, vrd_profile_frame, pc,
            sh2->pr, sh2->sr, sh2->gbr, sh2->mach, sh2->macl,
            sh2->r[8], sh2->r[9], sh2->r[10], sh2->r[11],
            sh2->r[12], sh2->r[13], sh2->r[14], sh2->r[15]) < 0)
        vrd_mmio_trace_q027_regs_errors++;
    if (fflush(vrd_mmio_trace_q027_regs_log) != 0)
        vrd_mmio_trace_q027_regs_errors++;
    vrd_mmio_trace_q027_regs_sequence++;
}

void vrd_mmio_trace_master_event(
    unsigned int pc, unsigned int address, unsigned int value,
    unsigned int op, unsigned int width)
{""",
            1,
        ),
        (
            "close-register-log",
            """    vrd_mmio_trace_log = NULL;
}

static void vrd_mmio_trace_init""",
            """    vrd_mmio_trace_log = NULL;
    if (vrd_mmio_trace_q027_regs_log) {
        if (fprintf(vrd_mmio_trace_q027_regs_log,
                "# COMPLETE rows=%u errors=%u mask=%04X\\n",
                vrd_mmio_trace_q027_regs_sequence,
                vrd_mmio_trace_q027_regs_errors,
                vrd_mmio_trace_q027_dispatch_mask) < 0 ||
            fflush(vrd_mmio_trace_q027_regs_log) != 0)
            vrd_mmio_trace_q027_regs_errors++;
        fclose(vrd_mmio_trace_q027_regs_log);
        vrd_mmio_trace_q027_regs_log = NULL;
    }
}

static void vrd_mmio_trace_init""",
            1,
        ),
    )
    for name, old, new, count in transforms:
        if name == "allowlist-selectors":
            if source.count(old) == count:
                source = source.replace(old, new, count)
            elif source.count(old) != 0 or source.count(new) != count + 1:
                raise ValueError(
                    f"Q-027 overlay precondition {name}: "
                    f"old_count={source.count(old)} new_count={source.count(new)}"
                )
        else:
            source = replace_exact(source, old, new, name, count)
    path.write_text(source)


def transform_interpreter(path: Path) -> None:
    source = path.read_text()
    source = replace_exact(
        source,
        """#include "sh2.c"

#ifndef DRC_CMP""",
        """#include "sh2.c"

#ifdef __LIBRETRO__
extern void vrd_q027_sh2_instruction(SH2 *sh2, unsigned int pc);
#endif

#ifndef DRC_CMP""",
        "interpreter-declaration",
    )
    old = """\t\tsh2->delay = 0;
\t\tsh2->pc += 2;

\t\tswitch (opcode & ( 15 << 12))"""
    new = """#ifdef __LIBRETRO__
\t\tif (!sh2->is_slave)
\t\t\tvrd_q027_sh2_instruction(sh2, sh2->ppc);
#endif
\t\tsh2->delay = 0;
\t\tsh2->pc += 2;

\t\tswitch (opcode & ( 15 << 12))"""
    if source.count(new) == 0 and source.count(old) == 2:
        source = source.replace(old, new, 1)
    elif source.count(new) != 1:
        raise ValueError(
            "Q-027 overlay precondition interpreter-callback: "
            f"old_count={source.count(old)} new_count={source.count(new)}"
        )
    path.write_text(source)


def transform_memory(path: Path) -> None:
    source = path.read_text()
    source = replace_exact(
        source,
        """  // 0x3ffc0 is verified
  if ((a & 0x3ffc0) == 0x4000) {
    d = p32x_sh2reg_read16(a, sh2);
    goto out_16to8;
  }""",
        """  // 0x3ffc0 is verified
  if ((a & 0x3ffc0) == 0x4000) {
    d = p32x_sh2reg_read16(a, sh2);
#ifdef __LIBRETRO__
    if (!sh2->is_slave)
      vrd_mmio_trace_master_event(sh2_pc(sh2), a,
        (a & 1) ? d & 0xff : (d >> 8) & 0xff, 0, 1);
#endif
    goto out_16to8;
  }""",
        "master-byte-read-callback",
    )
    path.write_text(source)


def verify_sources(source_root: Path) -> bool:
    return all(expected != "PENDING" and sha256_path(source_root / relative) == expected
               for relative, expected in SOURCE_SHA256.items())


def prepare(source_root: Path, tool_root: Path) -> str:
    if verify_sources(source_root):
        return "already-applied"
    actual = {relative: sha256_path(source_root / relative)
              for relative in PREIMAGE_SHA256}
    if actual != PREIMAGE_SHA256:
        libretro = (source_root / "platform/libretro/libretro.c").read_text()
        interpreter = (source_root / "cpu/sh2/mame/sh2pico.c").read_text()
        partial = "VRD_MMIO_TRACE_Q027_PC_ALLOWLIST" in libretro \
            and "vrd_q027_sh2_instruction" not in interpreter \
            and actual["cpu/sh2/mame/sh2pico.c"] == PREIMAGE_SHA256["cpu/sh2/mame/sh2pico.c"] \
            and actual["pico/32x/memory.c"] == PREIMAGE_SHA256["pico/32x/memory.c"] \
            and actual["pico/32x/sh2soc.c"] == PREIMAGE_SHA256["pico/32x/sh2soc.c"]
        if not partial:
            prepare_q026(source_root, tool_root)
            actual = {relative: sha256_path(source_root / relative)
                      for relative in PREIMAGE_SHA256}
            if actual != PREIMAGE_SHA256:
                raise ValueError(f"Q-027 overlay preimage mismatch: {actual}")
    libretro_path = source_root / "platform/libretro/libretro.c"
    if "vrd_q027_sh2_instruction" not in libretro_path.read_text():
        transform_libretro(libretro_path)
    transform_memory(source_root / "pico/32x/memory.c")
    transform_interpreter(source_root / "cpu/sh2/mame/sh2pico.c")
    actual = {relative: sha256_path(source_root / relative)
              for relative in SOURCE_SHA256}
    if any(expected == "PENDING" for expected in SOURCE_SHA256.values()):
        raise ValueError(f"Q-027 overlay postimages require pinning: {actual}")
    if actual != SOURCE_SHA256:
        raise ValueError(f"Q-027 overlay postimage mismatch: {actual}")
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
        print(f"Q-027 PicoDrive preparation FAILED: {error}")
        return 1
    print(f"Q-027 PicoDrive passive MMIO/register overlay: {status}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
