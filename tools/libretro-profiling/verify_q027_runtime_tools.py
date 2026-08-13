#!/usr/bin/env python3
"""Pin the Q-027 v5 runtime frontend, passive core, source, and capture tool."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path


FRONTEND_SHA256 = "626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50"
CORE_SHA256 = "08a791db331a2df426cb80c12299cb3882b037d2735692f3077e855a52109871"
FRONTEND_SOURCE_SHA256 = "655c00560835d7d38d7608b20e2614cc42585537574bfec3d08ec01af81e89de"
PREPARE_SHA256 = "2f51bd21ab899de82316c32f7c24b5f8c5bdf800f3e5d1724059cfdc52c8e2b4"
RUNTIME_SHA256 = "c26e52fb43464a8b5ebf88888864be9d38843d2c89670999f4c22248f06545f9"
SOURCE_SHA256 = {
    "platform/libretro/libretro.c":
        "59974942ac2eeaf7348db177a1ebc6a645a849a5e73223614db0a42d64b5db12",
    "pico/32x/memory.c":
        "e8c8a1e8ba4fbfa10c43368fdb0745ea36a2661116dedd9af3eb671f21f4a2d7",
    "pico/32x/sh2soc.c":
        "17f3db8229a4290c37dfc1bfcbf21fcd84bb7fe68d6f1ff527c0acf110718deb",
    "cpu/sh2/mame/sh2pico.c":
        "95caea269e742d1a76a5f3005f05f37c46886bfd194011f9d2b6e3e7a50313a3",
}


def sha256_path(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def require_hash(path: Path, expected: str, label: str) -> None:
    if not path.is_file() or sha256_path(path) != expected:
        raise ValueError(f"{label} identity: {path}")


def verify(frontend: Path, core: Path, repo_root: Path) -> None:
    tool_root = repo_root / "tools/libretro-profiling"
    source_root = repo_root / "third_party/picodrive"
    require_hash(frontend, FRONTEND_SHA256, "frontend")
    require_hash(core, CORE_SHA256, "core")
    require_hash(tool_root / "profiling_frontend.c", FRONTEND_SOURCE_SHA256,
                 "frontend source")
    require_hash(tool_root / "prepare_q027_picodrive.py", PREPARE_SHA256,
                 "preparation script")
    require_hash(tool_root / "q027_cmd3f_runtime.py", RUNTIME_SHA256,
                 "capture/validation script")
    for relative, expected in SOURCE_SHA256.items():
        require_hash(source_root / relative, expected, f"PicoDrive source {relative}")

    libretro = (source_root / "platform/libretro/libretro.c").read_text()
    memory = (source_root / "pico/32x/memory.c").read_text()
    interpreter = (source_root / "cpu/sh2/mame/sh2pico.c").read_text()
    required_libretro = (
        "VRD_MMIO_TRACE_Q027_PC_ALLOWLIST",
        "VRD_MMIO_TRACE_MODE must be exactly mode1, q026, or q027",
        "# FILTER q027_passive=1",
        "master_sdram=all_writes master_framebuffer=all_writes",
        "q027_edge_snapshots=%d q027_regs=%u q027_regs_errors=%u",
        "vrd_mmio_trace_q027_comm_pre[i] = Pico32x.regs[(0x20 + i * 2) / 2];",
        "vrd_mmio_trace_q027_comm_post[i] = Pico32x.regs[(0x20 + i * 2) / 2];",
        "vrd_mmio_trace_q027_regs_log",
        "vrd_mmio_trace_q027_dispatch_mask",
        "VRD_Q027_REG_TRACE",
    )
    if any(fragment not in libretro for fragment in required_libretro):
        raise ValueError("Q-027 recorder libretro source policy")
    required_memory = (
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xff, 1, 1);",
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xffff, 1, 2);",
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, trace_d, 1, 4);",
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, d, 1, 4);",
    )
    if any(fragment not in memory for fragment in required_memory) \
            or memory.count("vrd_mmio_trace_master_event(sh2_pc(sh2), a,") != 9:
        raise ValueError("Q-027 direct Master callback coverage")
    required_interpreter = (
        "extern void vrd_q027_sh2_instruction(SH2 *sh2, unsigned int pc);",
        "vrd_q027_sh2_instruction(sh2, sh2->ppc);",
    )
    if any(fragment not in interpreter for fragment in required_interpreter):
        raise ValueError("Q-027 exact-register interpreter source policy")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--frontend", type=Path, required=True)
    parser.add_argument("--core", type=Path, required=True)
    parser.add_argument("--repo-root", type=Path,
                        default=Path(__file__).resolve().parents[2])
    args = parser.parse_args()
    try:
        verify(args.frontend, args.core, args.repo_root.resolve())
    except (OSError, ValueError) as error:
        print(f"Q-027 runtime tools verification FAILED: {error}")
        return 1
    print("Q-027 runtime tools verification PASS: "
          f"frontend={FRONTEND_SHA256} core={CORE_SHA256}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
