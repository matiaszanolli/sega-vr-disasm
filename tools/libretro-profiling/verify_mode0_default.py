#!/usr/bin/env python3
"""Verify that the ordinary default is the exact validated mode-0 ACTIVE ROM."""

from __future__ import annotations

import argparse
import json
import os
import tempfile
from collections.abc import Sequence
from pathlib import Path

from validate_1p_control import sha256_file
from verify_mode0_rom_pair import EXPECTED_ACTIVE_SHA256, EXPECTED_ROM_SIZE

SCHEMA = "vrd-vr60-mode0-default-v1"
SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_MANIFEST = SCRIPT_DIR / "mode0_default.json"


def verify_default(default_path: Path, validated_active_path: Path) -> dict[str, object]:
    default = default_path.read_bytes()
    validated = validated_active_path.read_bytes()
    default_sha256 = sha256_file(default_path)
    active_sha256 = sha256_file(validated_active_path)
    findings: list[str] = []
    if len(default) != EXPECTED_ROM_SIZE:
        findings.append(f"default_size:{len(default)}")
    if len(validated) != EXPECTED_ROM_SIZE:
        findings.append(f"validated_active_size:{len(validated)}")
    if default_sha256 != EXPECTED_ACTIVE_SHA256:
        findings.append(f"default_sha256:{default_sha256}")
    if active_sha256 != EXPECTED_ACTIVE_SHA256:
        findings.append(f"validated_active_sha256:{active_sha256}")
    if default != validated:
        differences = [
            offset
            for offset, (left, right) in enumerate(
                zip(default, validated, strict=False)
            )
            if left != right
        ]
        findings.append(
            "default_not_validated_active:"
            + (f"0x{differences[0]:X}" if differences else "size")
        )
    return {
        "schema": SCHEMA,
        "eligible": not findings,
        "findings": findings,
        "default_path": str(default_path),
        "validated_active_path": str(validated_active_path),
        "default_sha256": default_sha256,
        "validated_active_sha256": active_sha256,
        "rom_size": len(default),
        "whole_image_equal": default == validated,
    }


def write_manifest(path: Path, payload: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            "w",
            encoding="utf-8",
            dir=path.parent,
            prefix=f".{path.name}.",
            delete=False,
        ) as stream:
            temporary = Path(stream.name)
            json.dump(payload, stream, indent=2, sort_keys=True)
            stream.write("\n")
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temporary, path)
    finally:
        if temporary is not None and temporary.exists():
            temporary.unlink()


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--default", required=True, type=Path)
    parser.add_argument("--validated-active", required=True, type=Path)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    try:
        payload = verify_default(args.default, args.validated_active)
        write_manifest(args.manifest, payload)
    except OSError as error:
        print(f"FAIL [mode0_default] {error}")
        return 1
    verdict = "PASS" if payload["eligible"] else "FAIL"
    print(f"{verdict} [mode0_default]")
    for finding in payload["findings"]:
        print(f"  finding={finding}")
    print(f"  default_sha256={payload['default_sha256']}")
    print(f"  validated_active_sha256={payload['validated_active_sha256']}")
    print(f"  manifest={args.manifest}")
    return 0 if payload["eligible"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
