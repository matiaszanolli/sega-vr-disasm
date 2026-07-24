#!/usr/bin/env python3
"""Convert one narrowly qualified RetroArch replay into the VRD input CSV.

The accepted container contract is pinned to RetroArch 1.22.2 commit
4c3793f36c:

* input/bsv/bsvmovie.c
* input/bsv/bsvmovie.h
* input/input_driver.h

This is intentionally not a general BSV/replay reader.  VR60 fixture capture
uses a checkpoint-free v2 replay with one P1 joypad-mask sample and one neutral
P2 joypad-mask sample per frame.  Anything outside that shape is rejected.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import struct
import sys
import tempfile
import zlib
from pathlib import Path
from typing import NoReturn

RETROARCH_VERSION = "1.22.2"
RETROARCH_COMMIT = "4c3793f36c"
SOURCE_URLS = (
    "https://github.com/libretro/RetroArch/blob/4c3793f36c/input/bsv/bsvmovie.c",
    "https://github.com/libretro/RetroArch/blob/4c3793f36c/input/bsv/bsvmovie.h",
    "https://github.com/libretro/RetroArch/blob/4c3793f36c/input/input_driver.h",
)

HEADER = struct.Struct("<10I")
INPUT_EVENT = struct.Struct("<BBBBHh")
MAGIC = 0x42535632
VERSION = 2
REGULAR_FRAME_TOKEN = ord("f")
RETRO_DEVICE_JOYPAD = 1
RETRO_DEVICE_ID_JOYPAD_MASK = 256


class ReplayFormatError(ValueError):
    """The replay is not the exact fail-closed capture shape."""


class ReplayReader:
    def __init__(self, data: bytes) -> None:
        self.data = data
        self.offset = 0

    def take(self, size: int, description: str) -> bytes:
        end = self.offset + size
        if end > len(self.data):
            raise ReplayFormatError(
                f"truncated {description} at byte {self.offset}: "
                f"need {size} bytes, have {len(self.data) - self.offset}"
            )
        value = self.data[self.offset:end]
        self.offset = end
        return value

    def unpack(self, layout: struct.Struct, description: str) -> tuple[int, ...]:
        return layout.unpack(self.take(layout.size, description))

    def u8(self, description: str) -> int:
        return self.take(1, description)[0]

    def u16(self, description: str) -> int:
        return struct.unpack("<H", self.take(2, description))[0]

    def u32(self, description: str) -> int:
        return struct.unpack("<I", self.take(4, description))[0]


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def fail(message: str) -> NoReturn:
    raise ReplayFormatError(message)


def parse_replay(data: bytes, expected_frames: int) -> tuple[list[int], dict[str, int]]:
    if expected_frames <= 0:
        fail("expected frame count must be positive")

    reader = ReplayReader(data)
    (
        magic,
        version,
        content_crc32,
        state_size,
        identifier_low,
        identifier_high,
        frame_count,
        frame_block_size,
        superblock_frames,
        checkpoint_config,
    ) = reader.unpack(HEADER, "v2 header")

    if magic != MAGIC:
        fail(f"unexpected replay magic 0x{magic:08X}; expected 0x{MAGIC:08X}")
    if version != VERSION:
        fail(f"unsupported replay version {version}; expected {VERSION}")
    if frame_count != expected_frames:
        fail(
            f"header declares {frame_count} frames; expected exactly {expected_frames}"
        )

    reader.take(state_size, "initial savestate payload")

    masks: list[int] = []
    previous_frame_size = 0
    for frame in range(frame_count):
        frame_start = reader.offset
        back_reference = reader.u32(f"frame {frame} back-reference")
        expected_back_reference = 0 if frame == 0 else previous_frame_size
        if back_reference != expected_back_reference:
            fail(
                f"frame {frame} back-reference is {back_reference}; "
                f"expected {expected_back_reference}"
            )

        key_count = reader.u8(f"frame {frame} key count")
        if key_count != 0:
            fail(f"frame {frame} contains {key_count} keyboard events")

        input_count = reader.u16(f"frame {frame} input-event count")
        if input_count != 2:
            fail(
                f"frame {frame} contains {input_count} input events; "
                "expected exactly P1 and neutral P2 joypad-mask samples"
            )

        events = [
            reader.unpack(INPUT_EVENT, f"frame {frame} input event {event}")
            for event in range(input_count)
        ]
        p1 = events[0]
        p2 = events[1]
        expected_p1 = (
            0,
            RETRO_DEVICE_JOYPAD,
            0,
            0,
            RETRO_DEVICE_ID_JOYPAD_MASK,
        )
        expected_p2 = (
            1,
            RETRO_DEVICE_JOYPAD,
            0,
            0,
            RETRO_DEVICE_ID_JOYPAD_MASK,
        )
        if p1[:5] != expected_p1:
            fail(
                f"frame {frame} first event is {p1[:5]}; "
                f"expected P1 joypad-mask event {expected_p1}"
            )
        if p2[:5] != expected_p2:
            fail(
                f"frame {frame} second event is {p2[:5]}; "
                f"expected P2 joypad-mask event {expected_p2}"
            )
        if p2[5] != 0:
            fail(f"frame {frame} P2 joypad mask is non-zero: 0x{p2[5] & 0xFFFF:04X}")

        token = reader.u8(f"frame {frame} token")
        if token != REGULAR_FRAME_TOKEN:
            fail(
                f"frame {frame} has unsupported token 0x{token:02X}; "
                "checkpoint and non-frame tokens are forbidden"
            )

        masks.append(p1[5] & 0xFFFF)
        previous_frame_size = reader.offset - frame_start

    if reader.offset != len(data):
        fail(f"replay has {len(data) - reader.offset} trailing bytes")

    header = {
        "content_crc32": content_crc32,
        "state_size": state_size,
        "identifier": identifier_low | (identifier_high << 32),
        "frame_count": frame_count,
        "frame_block_size": frame_block_size,
        "superblock_frames": superblock_frames,
        "checkpoint_config": checkpoint_config,
    }
    return masks, header


def render_csv(masks: list[int]) -> bytes:
    rows = ["frame,mask\n"]
    rows.extend(
        f"{frame},0x{mask:04X}\n" for frame, mask in enumerate(masks)
    )
    return "".join(rows).encode("ascii")


def write_temporary(path: Path, data: bytes) -> Path:
    temporary_path: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            "wb",
            dir=path.parent,
            prefix=f".{path.name}.",
            delete=False,
        ) as stream:
            temporary_path = Path(stream.name)
            stream.write(data)
            stream.flush()
            os.fsync(stream.fileno())
        return temporary_path
    except BaseException:
        if temporary_path is not None and temporary_path.exists():
            temporary_path.unlink()
        raise


def publish_new_file(temporary_path: Path, destination: Path) -> None:
    """Atomically publish without replacing an existing path."""
    os.link(temporary_path, destination)


def unlink_if_same_file(path: Path, reference: Path) -> None:
    try:
        if path.stat().st_ino == reference.stat().st_ino:
            path.unlink()
    except FileNotFoundError:
        pass


def fsync_directory(path: Path) -> None:
    descriptor = os.open(path, os.O_RDONLY)
    try:
        os.fsync(descriptor)
    finally:
        os.close(descriptor)


def convert_replay(
    replay_path: Path,
    output_path: Path,
    *,
    expected_frames: int,
    control_rom_path: Path,
    raw_state_path: Path,
) -> dict[str, object]:
    manifest_path = output_path.with_name(f"{output_path.name}.manifest.json")
    if output_path == manifest_path:
        raise ValueError("output and manifest paths must be distinct")
    if not output_path.parent.is_dir():
        raise FileNotFoundError(f"output directory is missing: {output_path.parent}")
    if output_path.exists():
        raise FileExistsError(f"refusing to overwrite output: {output_path}")
    if manifest_path.exists():
        raise FileExistsError(f"refusing to overwrite manifest: {manifest_path}")

    replay_data = replay_path.read_bytes()
    control_rom_data = control_rom_path.read_bytes()
    raw_state_data = raw_state_path.read_bytes()
    masks, header = parse_replay(replay_data, expected_frames)
    control_rom_crc32 = zlib.crc32(control_rom_data) & 0xFFFFFFFF
    if header["content_crc32"] != control_rom_crc32:
        fail(
            f"replay content CRC32 is 0x{header['content_crc32']:08X}; "
            f"control ROM CRC32 is 0x{control_rom_crc32:08X}"
        )
    csv_data = render_csv(masks)
    manifest: dict[str, object] = {
        "format": {
            "magic": f"0x{MAGIC:08X}",
            "version": VERSION,
            "retroarch_version": RETROARCH_VERSION,
            "retroarch_commit": RETROARCH_COMMIT,
            "sources": list(SOURCE_URLS),
        },
        "replay": {
            "path": str(replay_path.resolve()),
            "bytes": len(replay_data),
            "sha256": sha256_bytes(replay_data),
            **header,
        },
        "control_rom": {
            "path": str(control_rom_path.resolve()),
            "bytes": len(control_rom_data),
            "sha256": sha256_bytes(control_rom_data),
            "crc32": f"0x{control_rom_crc32:08X}",
        },
        "raw_state": {
            "path": str(raw_state_path.resolve()),
            "bytes": len(raw_state_data),
            "sha256": sha256_bytes(raw_state_data),
        },
        "csv": {
            "path": str(output_path.resolve()),
            "bytes": len(csv_data),
            "sha256": sha256_bytes(csv_data),
            "frames": len(masks),
        },
    }
    manifest_data = (
        json.dumps(manifest, indent=2, sort_keys=True) + "\n"
    ).encode("utf-8")

    csv_temporary = write_temporary(output_path, csv_data)
    manifest_temporary = write_temporary(manifest_path, manifest_data)
    output_published = False
    try:
        publish_new_file(csv_temporary, output_path)
        output_published = True
        try:
            publish_new_file(manifest_temporary, manifest_path)
        except BaseException:
            if output_published:
                unlink_if_same_file(output_path, csv_temporary)
            raise
        fsync_directory(output_path.parent)
    finally:
        if csv_temporary.exists():
            csv_temporary.unlink()
        if manifest_temporary.exists():
            manifest_temporary.unlink()

    return manifest


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Convert a qualified RetroArch v2 replay to VRD frame/mask CSV"
    )
    parser.add_argument("replay", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument(
        "--expected-frames",
        type=int,
        required=True,
        help="exact frame count required in both the replay header and parsed stream",
    )
    parser.add_argument(
        "--control-rom",
        type=Path,
        required=True,
        help="exact hook-bypass control ROM named in the evidence manifest",
    )
    parser.add_argument(
        "--raw-state",
        type=Path,
        required=True,
        help="exact raw core savestate to bind into the evidence manifest",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        manifest = convert_replay(
            args.replay,
            args.output,
            expected_frames=args.expected_frames,
            control_rom_path=args.control_rom,
            raw_state_path=args.raw_state,
        )
    except (OSError, ReplayFormatError, ValueError) as error:
        print(f"replay conversion failed: {error}", file=sys.stderr)
        return 1
    print(json.dumps(manifest, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
