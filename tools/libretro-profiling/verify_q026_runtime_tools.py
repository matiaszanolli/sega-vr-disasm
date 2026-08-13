#!/usr/bin/env python3
"""Pin the isolated Q-026 runtime frontend, passive core, and source overlay."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path


FRONTEND_SHA256 = "626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50"
CORE_SHA256 = "17d16aa506cef1bc215b290b20248b458b22b54374ae342a72eb2f3c2033e906"
FRONTEND_SOURCE_SHA256 = "655c00560835d7d38d7608b20e2614cc42585537574bfec3d08ec01af81e89de"
PREPARE_SHA256 = "0101522755d4543041fe5b08c51b2eb88dabf28dd02065f814c4ebc042861626"
RUNTIME_SHA256 = "3f877ae94506706050192f7edb6b7ccc81f07b215f4bbebfd66a84a1f39518c1"
SOURCE_SHA256 = {
    "platform/libretro/libretro.c":
        "6ff1affcd76b40fe098b8e289a4c5bc205248d64dd50a42f86bd9abee5dda4df",
    "pico/32x/memory.c":
        "cf1a4f429358f2bc3fb9c1a098d4a9faae2a791f3de1468d2eb18b84e07ffa72",
    "pico/32x/sh2soc.c":
        "17f3db8229a4290c37dfc1bfcbf21fcd84bb7fe68d6f1ff527c0acf110718deb",
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
    require_hash(tool_root / "prepare_q026_picodrive.py", PREPARE_SHA256,
                 "preparation script")
    require_hash(tool_root / "q026_player_runtime.py", RUNTIME_SHA256,
                 "capture/validation script")
    for relative, expected in SOURCE_SHA256.items():
        require_hash(source_root / relative, expected,
                     f"PicoDrive source {relative}")

    libretro = (source_root / "platform/libretro/libretro.c").read_text()
    memory = (source_root / "pico/32x/memory.c").read_text()
    required_libretro = (
        "VRD_MMIO_TRACE_Q026_PC_ALLOWLIST",
        "VRD_MMIO_TRACE_MODE must be exactly mode1 or q026",
        "# FILTER q026_direct=1",
        "master_sdram=all_writes master_framebuffer=all_writes",
        "q026_edge_snapshots=%d q026_comm_pre=%04X/%04X/%04X",
        "vrd_mmio_trace_q026_comm_pre[0] = Pico32x.regs[0x22 / 2];",
        "vrd_mmio_trace_q026_comm_post[2] = Pico32x.regs[0x2e / 2];",
        "pc == 0x0001c8f4 && op == VRD_MMIO_OP_WRITE",
        "address == 0x20004000 && width == 2",
    )
    if any(fragment not in libretro for fragment in required_libretro):
        raise ValueError("Q-026 recorder libretro source policy")
    required_memory = (
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xff, 1, 1);",
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xffff, 1, 2);",
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, trace_d, 1, 4);",
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, d, 1, 4);",
    )
    if any(fragment not in memory for fragment in required_memory):
        raise ValueError("Q-026 direct SDRAM/framebuffer source policy")
    if memory.count("vrd_mmio_trace_master_event(sh2_pc(sh2), a,") != 8:
        raise ValueError("Q-026 direct Master callback coverage")


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
        print(f"Q-026 runtime tools verification FAILED: {error}")
        return 1
    print("Q-026 runtime tools verification PASS: "
          f"frontend={FRONTEND_SHA256} core={CORE_SHA256}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
