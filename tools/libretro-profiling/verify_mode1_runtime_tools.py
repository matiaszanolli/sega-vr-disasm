#!/usr/bin/env python3
"""Pin the isolated mode-1 runtime frontend, core, overlays, and sources."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path


FRONTEND_SHA256 = "626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50"
CORE_SHA256 = "aaaa57f0190759e581ca116ab35ab7e1e090fcd93ccadd046242d7532ebbff79"
FRONTEND_SOURCE_SHA256 = "655c00560835d7d38d7608b20e2614cc42585537574bfec3d08ec01af81e89de"
PREPARE_SHA256 = "732095b32ab0cc5237e490a05942fef37e78718ad041c84040a48a70bdbbf33e"
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
    require_hash(
        tool_root / "profiling_frontend.c", FRONTEND_SOURCE_SHA256,
        "frontend source",
    )
    require_hash(
        tool_root / "prepare_mode1_picodrive.py", PREPARE_SHA256,
        "preparation script",
    )
    for name, expected in PATCH_SHA256.items():
        require_hash(tool_root / name, expected, f"patch {name}")
    for relative, expected in SOURCE_SHA256.items():
        require_hash(source_root / relative, expected, f"PicoDrive source {relative}")

    libretro = (source_root / "platform/libretro/libretro.c").read_text()
    memory = (source_root / "pico/32x/memory.c").read_text()
    sh2soc = (source_root / "pico/32x/sh2soc.c").read_text()
    required_libretro = (
        "VRD_MMIO_TRACE version=3",
        "m68k_direct=%d",
        "master_direct=%d",
        "raw_m68k=%llu raw_master=%llu",
        "pc_rejected_m68k=%llu pc_rejected_master=%llu",
        "direct_m68k=1 direct_master=1 observer_detached=%d",
        "0x00a15120 &&",
        "effective_address <= 0x00a1512f",
        "VRD_MMIO_TRACE_MODE1_MASTER_PC_END   0x02303f1c",
        "if (vrd_caller_trace_log &&\n       vrd_profile_frame == vrd_profile_max_frames - 1)",
    )
    if any(fragment not in libretro for fragment in required_libretro):
        raise ValueError("direct recorder libretro source policy")
    required_memory = (
        "vrd_mmio_trace_m68k_event(SekPc, a, d & 0xff, 0, 1);",
        "vrd_mmio_trace_m68k_event(SekPc, a, d & 0xffff, 1, 2);",
        "vrd_mmio_trace_master_event(sh2_pc(sh2), a, d & 0xffff, 0, 2);",
        "Canonical 32X handlers call the observer directly.",
    )
    if any(fragment not in memory for fragment in required_memory):
        raise ValueError("direct recorder memory source policy")
    if "read8_map[0x20 / 2].addr =" in memory:
        raise ValueError("mode-1 recorder still patches SH2 map ownership")
    if sh2soc.count("vrd_mmio_trace_master_event(sh2_pc(sh2)") != 6:
        raise ValueError("direct recorder peripheral coverage")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--frontend", type=Path, required=True)
    parser.add_argument("--core", type=Path, required=True)
    parser.add_argument(
        "--repo-root", type=Path, default=Path(__file__).resolve().parents[2]
    )
    args = parser.parse_args()
    try:
        verify(args.frontend, args.core, args.repo_root.resolve())
    except (OSError, ValueError) as error:
        print(f"mode-1 runtime tools verification FAILED: {error}")
        return 1
    print(
        "mode-1 runtime tools verification PASS: "
        f"frontend={FRONTEND_SHA256} core={CORE_SHA256}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
