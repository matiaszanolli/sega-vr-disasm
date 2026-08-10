#!/usr/bin/env python3
"""Fail closed on Q-020 runtime-tool source and binary identities."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path


FRONTEND_SHA256 = "626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50"
CORE_SHA256 = "b2fe478891e8cb5299fefc22bb908a67b80a804df379f7724ed212c0e1b1a333"
PARITY_PATCH_SHA256 = "3ddbb6bc7736d5209bbe17c25b4244a225b9f684c1bc2ab156d49b5821490011"


def sha256_path(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def verify(frontend: Path, core: Path, repo_root: Path) -> None:
    expected = ((frontend, FRONTEND_SHA256), (core, CORE_SHA256))
    for path, digest in expected:
        if not path.is_file() or sha256_path(path) != digest:
            raise ValueError(f"binary identity: {path}")

    patch = repo_root / "tools/libretro-profiling/libretro_q020_cmdint_irq_parity.patch"
    if sha256_path(patch) != PARITY_PATCH_SHA256:
        raise ValueError("parity patch identity")

    memory = (repo_root / "third_party/picodrive/pico/32x/memory.c").read_text()
    required_memory = (
        "case 0x03:\n        /* Keep the optimized map behavior-identical",
        "p32x_reg_write8(a, d);",
        "case 0x02:\n        /* The high byte is read-only zero",
        "p32x_reg_write8(0x03, d);",
        "CMD IRQ recomputation is an interrupt side effect",
    )
    if any(fragment not in memory for fragment in required_memory):
        raise ValueError("PicoDrive parity source policy")
    if "case 0x03: r8[MEM_BE2(a)] = d &    3; return;" in memory:
        raise ValueError("PicoDrive byte fast path is still unpatched")
    if "case 0x02: r[a / 2] = d &      3; return;" in memory:
        raise ValueError("PicoDrive word fast path is still unpatched")

    frontend_source = (
        repo_root / "tools/libretro-profiling/profiling_frontend.c"
    ).read_text()
    required_frontend = (
        "typedef void (*fn_retro_reset)(void);",
        'strcmp(cmd, "reset") == 0',
        'getenv("VRD_LIBRETRO_CORE")',
    )
    if any(fragment not in frontend_source for fragment in required_frontend):
        raise ValueError("Q-020 frontend source policy")


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
        print(f"Q-020 runtime tools verification FAILED: {error}")
        return 1
    print(
        "Q-020 runtime tools verification PASS: "
        f"frontend={FRONTEND_SHA256} core={CORE_SHA256}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
