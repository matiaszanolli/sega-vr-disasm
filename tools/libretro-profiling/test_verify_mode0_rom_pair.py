#!/usr/bin/env python3
"""Focused adversarial tests for the VR60 mode-0 ROM-pair verifier."""

from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(SCRIPT_DIR))

from verify_mode0_rom_pair import (
    ACTIVE_HOOK_BYTES,
    ACTIVE_TRANSFER_CALL,
    CMD3E_HANDLER_BYTES,
    CMD3E_HANDLER_OFFSET,
    CONTROL_HOOK_BYTES,
    CONTROL_TRANSFER_CALL,
    DEFAULT_HOOK_BYTES,
    ENTITY_STAGE_BYTES,
    ENTITY_STAGE_OFFSET,
    ENTITY_TRANSFER_BYTES,
    ENTITY_TRANSFER_OFFSET,
    EXPECTED_ROM_SIZE,
    GLOBALS_STAGE_BYTES,
    GLOBALS_STAGE_OFFSET,
    HOOK_OFFSET,
    HOOK_SITE_BYTES,
    HOOK_SITE_OFFSET,
    MASTER_CMD3E_JUMP_BYTES,
    MASTER_CMD3E_JUMP_OFFSET,
    TRANSFER_CALL_OFFSET,
    verify_pair,
)


class Mode0RomPairTests(unittest.TestCase):
    def write_pair(self, root: Path) -> tuple[Path, Path, Path]:
        default = bytearray(EXPECTED_ROM_SIZE)
        default[HOOK_SITE_OFFSET : HOOK_SITE_OFFSET + len(HOOK_SITE_BYTES)] = HOOK_SITE_BYTES
        default[ENTITY_STAGE_OFFSET : ENTITY_STAGE_OFFSET + len(ENTITY_STAGE_BYTES)] = (
            ENTITY_STAGE_BYTES
        )
        default[GLOBALS_STAGE_OFFSET : GLOBALS_STAGE_OFFSET + len(GLOBALS_STAGE_BYTES)] = (
            GLOBALS_STAGE_BYTES
        )
        default[
            ENTITY_TRANSFER_OFFSET : ENTITY_TRANSFER_OFFSET + len(ENTITY_TRANSFER_BYTES)
        ] = ENTITY_TRANSFER_BYTES
        default[
            MASTER_CMD3E_JUMP_OFFSET : MASTER_CMD3E_JUMP_OFFSET
            + len(MASTER_CMD3E_JUMP_BYTES)
        ] = MASTER_CMD3E_JUMP_BYTES
        default[
            CMD3E_HANDLER_OFFSET : CMD3E_HANDLER_OFFSET + len(CMD3E_HANDLER_BYTES)
        ] = CMD3E_HANDLER_BYTES
        default[HOOK_OFFSET : HOOK_OFFSET + len(DEFAULT_HOOK_BYTES)] = DEFAULT_HOOK_BYTES
        active = bytearray(default)
        control = bytearray(default)
        active[HOOK_OFFSET : HOOK_OFFSET + len(ACTIVE_HOOK_BYTES)] = ACTIVE_HOOK_BYTES
        control[HOOK_OFFSET : HOOK_OFFSET + len(CONTROL_HOOK_BYTES)] = CONTROL_HOOK_BYTES
        paths = (root / "active.32x", root / "control.32x", root / "default.32x")
        for path, image in zip(paths, (active, control, default), strict=True):
            path.write_bytes(image)
        return paths

    def test_repository_pair_is_eligible(self) -> None:
        root = SCRIPT_DIR.parent.parent
        payload = verify_pair(
            root / "build/vr60_mode0_active.32x",
            root / "build/vr60_mode0_stage_control.32x",
            root / "build/vr60_mode0_default_reference.32x",
        )
        self.assertTrue(payload["eligible"], payload["findings"])
        self.assertEqual(payload["pair_delta"]["active_bytes"], ACTIVE_TRANSFER_CALL.hex())
        self.assertEqual(payload["pair_delta"]["control_bytes"], CONTROL_TRANSFER_CALL.hex())

    def test_swapped_arms_fail(self) -> None:
        root = SCRIPT_DIR.parent.parent
        payload = verify_pair(
            root / "build/vr60_mode0_stage_control.32x",
            root / "build/vr60_mode0_active.32x",
            root / "build/vr60_mode0_default_reference.32x",
        )
        self.assertFalse(payload["eligible"])
        self.assertIn("active_complete_hook_body", payload["findings"])

    def test_outside_pair_delta_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            active, control, default = self.write_pair(Path(temp))
            image = bytearray(active.read_bytes())
            image[0x100] ^= 1
            active.write_bytes(image)
            payload = verify_pair(active, control, default)
            self.assertFalse(payload["eligible"])
            self.assertIn("pair_difference_outside_transfer_slot", payload["findings"])

    def test_disabled_active_transfer_fails(self) -> None:
        root = SCRIPT_DIR.parent.parent
        with tempfile.TemporaryDirectory() as temp:
            active = Path(temp) / "active.32x"
            active.write_bytes((root / "build/vr60_mode0_active.32x").read_bytes())
            image = bytearray(active.read_bytes())
            image[TRANSFER_CALL_OFFSET : TRANSFER_CALL_OFFSET + 6] = CONTROL_TRANSFER_CALL
            active.write_bytes(image)
            payload = verify_pair(
                active,
                root / "build/vr60_mode0_stage_control.32x",
                root / "build/vr60_mode0_default_reference.32x",
            )
            self.assertFalse(payload["eligible"])
            self.assertIn("active_transfer_call", payload["findings"])

    def test_mode_or_dar_tcr_tamper_fails(self) -> None:
        root = SCRIPT_DIR.parent.parent
        for offset in (HOOK_OFFSET + 38, CMD3E_HANDLER_OFFSET + 0x80):
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                active = Path(temp) / "active.32x"
                active.write_bytes((root / "build/vr60_mode0_active.32x").read_bytes())
                image = bytearray(active.read_bytes())
                image[offset] ^= 1
                active.write_bytes(image)
                payload = verify_pair(
                    active,
                    root / "build/vr60_mode0_stage_control.32x",
                    root / "build/vr60_mode0_default_reference.32x",
                )
                self.assertFalse(payload["eligible"])

    def test_mode1_call_or_relay_edge_tamper_fails(self) -> None:
        root = SCRIPT_DIR.parent.parent
        mutations = (
            (TRANSFER_CALL_OFFSET, bytes.fromhex("4eb90001c7e0")),
            (HOOK_OFFSET + 35, bytes.fromhex("0c")),
        )
        for offset, replacement in mutations:
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                active = Path(temp) / "active.32x"
                active.write_bytes((root / "build/vr60_mode0_active.32x").read_bytes())
                image = bytearray(active.read_bytes())
                image[offset : offset + len(replacement)] = replacement
                active.write_bytes(image)
                payload = verify_pair(
                    active,
                    root / "build/vr60_mode0_stage_control.32x",
                    root / "build/vr60_mode0_default_reference.32x",
                )
                self.assertFalse(payload["eligible"])

    def test_low_tail_alias_fails(self) -> None:
        root = SCRIPT_DIR.parent.parent
        for source_name in ("vr60_mode0_active.32x", "vr60_mode0_stage_control.32x"):
            with self.subTest(source_name=source_name), tempfile.TemporaryDirectory() as temp:
                active = Path(temp) / "active.32x"
                control = Path(temp) / "control.32x"
                active.write_bytes((root / "build/vr60_mode0_active.32x").read_bytes())
                control.write_bytes(
                    (root / "build/vr60_mode0_stage_control.32x").read_bytes()
                )
                target = active if source_name.endswith("active.32x") else control
                image = bytearray(target.read_bytes())
                image[HOOK_OFFSET + 96 : HOOK_OFFSET + 100] = bytes.fromhex("00004d6a")
                target.write_bytes(image)
                payload = verify_pair(
                    active,
                    control,
                    root / "build/vr60_mode0_default_reference.32x",
                )
                self.assertFalse(payload["eligible"])
                self.assertTrue(
                    any("complete_hook_body" in finding for finding in payload["findings"])
                )

    def test_handler_and_source_stage_tamper_fail(self) -> None:
        root = SCRIPT_DIR.parent.parent
        for offset in (MASTER_CMD3E_JUMP_OFFSET, ENTITY_STAGE_OFFSET):
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                active = Path(temp) / "active.32x"
                active.write_bytes((root / "build/vr60_mode0_active.32x").read_bytes())
                image = bytearray(active.read_bytes())
                image[offset] ^= 1
                active.write_bytes(image)
                payload = verify_pair(
                    active,
                    root / "build/vr60_mode0_stage_control.32x",
                    root / "build/vr60_mode0_default_reference.32x",
                )
                self.assertFalse(payload["eligible"])


if __name__ == "__main__":
    unittest.main()
