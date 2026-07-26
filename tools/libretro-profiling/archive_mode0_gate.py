#!/usr/bin/env python3
"""Create a deterministic archive of one raw VR60 mode-0 gate capture."""

from __future__ import annotations

import argparse
import gzip
import hashlib
import io
import os
import tarfile
from collections.abc import Sequence
from pathlib import Path


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def normalized_info(name: str, *, directory: bool, size: int = 0) -> tarfile.TarInfo:
    info = tarfile.TarInfo(name)
    info.type = tarfile.DIRTYPE if directory else tarfile.REGTYPE
    info.mode = 0o755 if directory else 0o644
    info.uid = 0
    info.gid = 0
    info.uname = ""
    info.gname = ""
    info.mtime = 0
    info.size = 0 if directory else size
    return info


def archive_capture(source: Path, output: Path) -> dict[str, str]:
    required = {"manifest.json", "result.json", "corrected-result.json"}
    observed = {path.name for path in source.iterdir() if path.is_file()}
    if not required <= observed:
        raise ValueError(f"capture is missing {sorted(required - observed)}")
    files = sorted(
        path for path in source.rglob("*") if path.is_file()
    )
    if any(path.is_symlink() for path in source.rglob("*")):
        raise ValueError("capture archive may not contain symlinks")
    member_hashes = {
        path.relative_to(source).as_posix(): sha256_file(path) for path in files
    }
    checksum_text = "".join(
        f"{digest}  {name}\n" for name, digest in sorted(member_hashes.items())
    ).encode()
    directories = sorted(
        {path.relative_to(source).as_posix() for path in source.rglob("*") if path.is_dir()}
    )

    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_name(f".{output.name}.tmp")
    if temporary.exists():
        raise ValueError(f"refusing stale temporary archive {temporary}")
    try:
        raw = temporary.open("xb")
        try:
            with (
                gzip.GzipFile(
                    filename="", mode="wb", fileobj=raw, mtime=0
                ) as compressed,
                tarfile.open(
                    fileobj=compressed,
                    mode="w",
                    format=tarfile.GNU_FORMAT,
                ) as archive,
            ):
                archive.addfile(normalized_info("./", directory=True))
                for directory in directories:
                    archive.addfile(
                        normalized_info(f"./{directory}/", directory=True)
                    )
                for path in files:
                    relative = path.relative_to(source).as_posix()
                    data = path.read_bytes()
                    archive.addfile(
                        normalized_info(
                            f"./{relative}", directory=False, size=len(data)
                        ),
                        io.BytesIO(data),
                    )
                archive.addfile(
                    normalized_info(
                        "./archive-members.sha256",
                        directory=False,
                        size=len(checksum_text),
                    ),
                    io.BytesIO(checksum_text),
                )
            raw.flush()
            os.fsync(raw.fileno())
        finally:
            raw.close()
        os.replace(temporary, output)
    finally:
        if temporary.exists():
            temporary.unlink()
    return {
        "archive_sha256": sha256_file(output),
        "manifest_sha256": member_hashes["manifest.json"],
        "failed_result_sha256": member_hashes["result.json"],
        "corrected_result_sha256": member_hashes["corrected-result.json"],
    }


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    try:
        hashes = archive_capture(args.source.resolve(), args.output.resolve())
    except (OSError, ValueError) as error:
        print(f"FAIL [mode0_archive] {error}")
        return 1
    print("PASS [mode0_archive]")
    for name, digest in hashes.items():
        print(f"  {name}={digest}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
