#!/usr/bin/env python3
"""Idempotently apply the pinned Q-020 PicoDrive parity patch."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path
import subprocess


PATCH_SHA256 = "3ddbb6bc7736d5209bbe17c25b4244a225b9f684c1bc2ab156d49b5821490011"


def sha256_path(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def hunk_images(patch: str) -> list[tuple[str, str]]:
    """Return the exact old/new source images encoded by each unified hunk."""
    images: list[tuple[str, str]] = []
    old: list[str] | None = None
    new: list[str] | None = None
    for line in patch.splitlines(keepends=True):
        if line.startswith("@@ "):
            if old is not None and new is not None:
                images.append(("".join(old), "".join(new)))
            old, new = [], []
        elif old is not None and new is not None:
            if line.startswith(" "):
                old.append(line[1:])
                new.append(line[1:])
            elif line.startswith("-"):
                old.append(line[1:])
            elif line.startswith("+"):
                new.append(line[1:])
            elif line.startswith("\\"):
                continue
            else:
                raise ValueError("unexpected unified-patch hunk line")
    if old is not None and new is not None:
        images.append(("".join(old), "".join(new)))
    if not images or any(not old_image or not new_image for old_image, new_image in images):
        raise ValueError("parity patch has no complete hunks")
    return images


def prepare(source_root: Path, patch_path: Path) -> str:
    if sha256_path(patch_path) != PATCH_SHA256:
        raise ValueError("parity patch identity")
    patch = patch_path.read_bytes()
    source_path = source_root / "pico/32x/memory.c"
    source = source_path.read_text()
    images = hunk_images(patch.decode())
    old_counts = [source.count(old) for old, _ in images]
    new_counts = [source.count(new) for _, new in images]
    if old_counts == [1] * len(images) and new_counts == [0] * len(images):
        applied = subprocess.run(
            ["patch", "--batch", "--forward", "-p1"],
            cwd=source_root,
            input=patch,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        if applied.returncode != 0:
            raise ValueError("parity patch application failed")
        updated = source_path.read_text()
        if any(updated.count(new) != 1 for _, new in images):
            raise ValueError("parity patch postimage mismatch")
        return "applied"
    if new_counts == [1] * len(images) and old_counts == [0] * len(images):
        return "already-applied"
    raise ValueError(
        "parity patch precondition is ambiguous or mismatched: "
        f"old_counts={old_counts} new_counts={new_counts}"
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", type=Path, required=True)
    parser.add_argument("--patch", type=Path, required=True)
    args = parser.parse_args()
    try:
        status = prepare(args.source_root.resolve(), args.patch.resolve())
    except (OSError, ValueError) as error:
        print(f"Q-020 PicoDrive preparation FAILED: {error}")
        return 1
    print(f"Q-020 PicoDrive parity patch: {status}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
