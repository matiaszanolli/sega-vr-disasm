#!/usr/bin/env python3
"""Focused tests for the fail-closed RetroArch replay converter."""

from __future__ import annotations

import hashlib
import json
import os
import struct
import tempfile
import unittest
import zlib
from pathlib import Path

from retroarch_replay_to_csv import (
    HEADER,
    INPUT_EVENT,
    MAGIC,
    VERSION,
    ReplayFormatError,
    convert_replay,
    parse_replay,
)

SMOKE_SHA256 = "665d710f5cf47a97e3a8bf130919d4ed20d3c3bf6f35b2e55118a6cdad0f1724"
SYNTHETIC_ROM = b"synthetic-hook-bypass-control-rom"
SYNTHETIC_STATE = b"synthetic-raw-core-state"


def replay_bytes(
    masks: list[int],
    *,
    magic: int = MAGIC,
    version: int = VERSION,
    declared_frames: int | None = None,
    state: bytes = b"\x00\x01synthetic-state",
    event_overrides: dict[int, list[tuple[int, int, int, int, int, int]]] | None = None,
    key_counts: dict[int, int] | None = None,
    tokens: dict[int, int] | None = None,
    back_references: dict[int, int] | None = None,
    trailing: bytes = b"",
    content_crc32: int | None = None,
) -> bytes:
    header = HEADER.pack(
        magic,
        version,
        zlib.crc32(SYNTHETIC_ROM) & 0xFFFFFFFF
        if content_crc32 is None
        else content_crc32,
        len(state),
        0x6A63D299,
        0,
        len(masks) if declared_frames is None else declared_frames,
        128,
        16,
        0x04020000,
    )
    frames: list[bytes] = []
    previous_size = 0
    for frame, mask in enumerate(masks):
        events = [
            (0, 1, 0, 0, 256, mask if mask < 0x8000 else mask - 0x10000),
            (1, 1, 0, 0, 256, 0),
        ]
        if event_overrides and frame in event_overrides:
            events = event_overrides[frame]
        back_reference = 0 if frame == 0 else previous_size
        if back_references and frame in back_references:
            back_reference = back_references[frame]
        key_count = key_counts.get(frame, 0) if key_counts else 0
        token = tokens.get(frame, ord("f")) if tokens else ord("f")
        payload = bytearray(struct.pack("<IBH", back_reference, key_count, len(events)))
        for event in events:
            payload.extend(INPUT_EVENT.pack(*event))
        payload.append(token)
        frames.append(bytes(payload))
        previous_size = len(payload)
    return header + state + b"".join(frames) + trailing


class RetroArchReplayConverterTests(unittest.TestCase):
    def test_valid_replay_writes_canonical_csv_and_manifest(self) -> None:
        data = replay_bytes([0, 1, 0x81, 0xFFFF])
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            replay = directory / "input.replay"
            output = directory / "input.csv"
            control_rom = directory / "control.32x"
            raw_state = directory / "control.raw.state"
            replay.write_bytes(data)
            control_rom.write_bytes(SYNTHETIC_ROM)
            raw_state.write_bytes(SYNTHETIC_STATE)

            manifest = convert_replay(
                replay,
                output,
                expected_frames=4,
                control_rom_path=control_rom,
                raw_state_path=raw_state,
            )

            expected = (
                b"frame,mask\n"
                b"0,0x0000\n"
                b"1,0x0001\n"
                b"2,0x0081\n"
                b"3,0xFFFF\n"
            )
            self.assertEqual(output.read_bytes(), expected)
            self.assertEqual(manifest["csv"]["frames"], 4)
            self.assertEqual(
                manifest["csv"]["sha256"], hashlib.sha256(expected).hexdigest()
            )
            self.assertEqual(
                manifest["control_rom"]["sha256"],
                hashlib.sha256(SYNTHETIC_ROM).hexdigest(),
            )
            self.assertEqual(
                manifest["raw_state"]["sha256"],
                hashlib.sha256(SYNTHETIC_STATE).hexdigest(),
            )
            manifest_path = directory / "input.csv.manifest.json"
            self.assertEqual(json.loads(manifest_path.read_text()), manifest)

    def test_wrong_control_rom_crc_is_rejected_without_output(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            replay = directory / "input.replay"
            output = directory / "input.csv"
            control_rom = directory / "wrong-control.32x"
            raw_state = directory / "control.raw.state"
            replay.write_bytes(replay_bytes([0]))
            control_rom.write_bytes(b"wrong-rom")
            raw_state.write_bytes(SYNTHETIC_STATE)

            with self.assertRaisesRegex(ReplayFormatError, "control ROM CRC32"):
                convert_replay(
                    replay,
                    output,
                    expected_frames=1,
                    control_rom_path=control_rom,
                    raw_state_path=raw_state,
                )
            self.assertFalse(output.exists())
            self.assertFalse((directory / "input.csv.manifest.json").exists())

    def test_rejects_bad_header_and_frame_count(self) -> None:
        cases = {
            "bad-magic": replay_bytes([0], magic=0),
            "bad-version": replay_bytes([0], version=1),
            "wrong-declared-count": replay_bytes([0], declared_frames=2),
        }
        for name, data in cases.items():
            with self.subTest(name=name), self.assertRaises(ReplayFormatError):
                parse_replay(data, 1)

    def test_rejects_truncation_at_each_container_layer(self) -> None:
        data = replay_bytes([0])
        state_end = HEADER.size + len(b"\x00\x01synthetic-state")
        cuts = {
            "header": HEADER.size - 1,
            "state": state_end - 1,
            "frame-header": state_end + 6,
            "event": state_end + 14,
            "token": len(data) - 1,
        }
        for name, cut in cuts.items():
            with self.subTest(name=name), self.assertRaises(ReplayFormatError):
                parse_replay(data[:cut], 1)

    def test_rejects_keyboard_events(self) -> None:
        with self.assertRaisesRegex(ReplayFormatError, "keyboard events"):
            parse_replay(replay_bytes([0], key_counts={0: 1}), 1)

    def test_rejects_missing_duplicate_or_unexpected_events(self) -> None:
        valid_p1 = (0, 1, 0, 0, 256, 1)
        valid_p2 = (1, 1, 0, 0, 256, 0)
        cases = {
            "missing-p2": [valid_p1],
            "duplicate-p1": [valid_p1, valid_p1],
            "reversed": [valid_p2, valid_p1],
            "unexpected-extra": [valid_p1, valid_p2, valid_p2],
        }
        for name, events in cases.items():
            with self.subTest(name=name), self.assertRaises(ReplayFormatError):
                parse_replay(replay_bytes([0], event_overrides={0: events}), 1)

    def test_rejects_event_identity_padding_and_non_neutral_p2(self) -> None:
        valid_p2 = (1, 1, 0, 0, 256, 0)
        cases = {
            "p1-device": [(0, 2, 0, 0, 256, 0), valid_p2],
            "p1-index": [(0, 1, 1, 0, 256, 0), valid_p2],
            "p1-padding": [(0, 1, 0, 1, 256, 0), valid_p2],
            "p1-id": [(0, 1, 0, 0, 15, 0), valid_p2],
            "p2-nonzero": [(0, 1, 0, 0, 256, 0), (1, 1, 0, 0, 256, 1)],
        }
        for name, events in cases.items():
            with self.subTest(name=name), self.assertRaises(ReplayFormatError):
                parse_replay(replay_bytes([0], event_overrides={0: events}), 1)

    def test_rejects_checkpoint_token_bad_back_reference_and_trailing_data(self) -> None:
        cases = {
            "checkpoint": replay_bytes([0], tokens={0: ord("C")}),
            "bad-back-reference": replay_bytes(
                [0, 1], back_references={1: 999}
            ),
            "trailing": replay_bytes([0], trailing=b"x"),
        }
        for name, data in cases.items():
            with self.subTest(name=name), self.assertRaises(ReplayFormatError):
                parse_replay(data, 1 if name != "bad-back-reference" else 2)

    def test_existing_outputs_are_preserved(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            replay = directory / "input.replay"
            control_rom = directory / "control.32x"
            raw_state = directory / "control.raw.state"
            replay.write_bytes(replay_bytes([0]))
            control_rom.write_bytes(SYNTHETIC_ROM)
            raw_state.write_bytes(SYNTHETIC_STATE)

            output = directory / "input.csv"
            output.write_bytes(b"keep-output")
            with self.assertRaises(FileExistsError):
                convert_replay(
                    replay,
                    output,
                    expected_frames=1,
                    control_rom_path=control_rom,
                    raw_state_path=raw_state,
                )
            self.assertEqual(output.read_bytes(), b"keep-output")

            output.unlink()
            manifest = directory / "input.csv.manifest.json"
            manifest.write_bytes(b"keep-manifest")
            with self.assertRaises(FileExistsError):
                convert_replay(
                    replay,
                    output,
                    expected_frames=1,
                    control_rom_path=control_rom,
                    raw_state_path=raw_state,
                )
            self.assertFalse(output.exists())
            self.assertEqual(manifest.read_bytes(), b"keep-manifest")

    def test_real_smoke_replay_when_requested(self) -> None:
        smoke_name = os.environ.get("VRD_RETROARCH_REPLAY_SMOKE")
        if not smoke_name:
            self.skipTest("set VRD_RETROARCH_REPLAY_SMOKE for the captured replay")
        replay = Path(smoke_name)
        data = replay.read_bytes()
        self.assertEqual(hashlib.sha256(data).hexdigest(), SMOKE_SHA256)
        masks, header = parse_replay(data, 899)
        self.assertEqual(header["state_size"], 363380)
        self.assertEqual(len(masks), 899)
        self.assertIn(0, masks)
        self.assertIn(1, masks)
        self.assertIn(0x81, masks)


if __name__ == "__main__":
    unittest.main()
