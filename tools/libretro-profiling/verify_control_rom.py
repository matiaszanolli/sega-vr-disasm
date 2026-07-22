#!/usr/bin/env python3
"""Verify and record the assembly-built VR60 hook-bypass ROM pair."""

from __future__ import annotations

import argparse
from dataclasses import asdict
import json
import os
from pathlib import Path
import tempfile
from typing import Sequence

from validate_1p_control import (
    HOOK_SITE_OFFSET,
    HOOK_SITE_STOCK_BYTES,
    control_rom_policy,
)


SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_MANIFEST = SCRIPT_DIR / "control_rom_pair.json"


def write_manifest(path: Path, payload: dict[str, object]) -> None:
    """Atomically replace the evidence file so a partial JSON cannot survive."""
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary_path: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            "w",
            encoding="utf-8",
            dir=path.parent,
            prefix=f".{path.name}.",
            delete=False,
        ) as stream:
            temporary_path = Path(stream.name)
            json.dump(payload, stream, indent=2, sort_keys=True)
            stream.write("\n")
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temporary_path, path)
    finally:
        if temporary_path is not None and temporary_path.exists():
            temporary_path.unlink()


def verify_pair(candidate: Path, reference: Path) -> dict[str, object]:
    comparison = control_rom_policy(candidate, reference)
    return {
        "schema": "vrd-vr60-control-rom-pair-v1",
        "candidate_path": str(candidate),
        "reference_path": str(reference),
        "hook_site_offset": f"0x{HOOK_SITE_OFFSET:X}",
        "hook_size": len(HOOK_SITE_STOCK_BYTES),
        **asdict(comparison),
    }


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Require the stock two-JSR hook in the candidate, the live VR60 jump "
            "in the reference, and byte equality everywhere else."
        )
    )
    parser.add_argument("--candidate", required=True, type=Path)
    parser.add_argument("--reference", required=True, type=Path)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    try:
        payload = verify_pair(args.candidate, args.reference)
        write_manifest(args.manifest, payload)
    except (OSError, ValueError) as error:
        print(f"FAIL [control_rom_pair] {error}")
        return 1

    verdict = "PASS" if payload["eligible"] else "FAIL"
    print(f"{verdict} [control_rom_pair] {payload['reason']}")
    print(f"  candidate_sha256={payload['candidate_sha256']}")
    print(f"  reference_sha256={payload['reference_sha256']}")
    print(f"  manifest={args.manifest}")
    return 0 if payload["eligible"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
