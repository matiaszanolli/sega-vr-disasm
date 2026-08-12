#!/usr/bin/env python3
"""Focused adversarial tests for the Q-021 mode-2 static pair verifier."""

from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from verify_mode2_rom_pair import (  # noqa: E402
    CMD3F_JUMP_OFFSET,
    ISR_OFFSET,
    ISR_PROTOCOL_SLICE_SHA256,
    M68K_OFFSET,
    PAIR_SLOT_OFFSET,
    verify_pair,
)


ROOT = Path(__file__).resolve().parents[2]
ACTIVE = ROOT / "build/vr60_mode2_active.32x"
CONTROL = ROOT / "build/vr60_mode2_stage_control.32x"
DEFAULT = ROOT / "build/vr_rebuild.32x"
MODE1_ACTIVE = ROOT / "build/vr60_mode1_active.32x"
MODE1_CONTROL = ROOT / "build/vr60_mode1_stage_control.32x"
ISR_BIN = ROOT / "build/sh2/cmd3e_mode2_validation.bin"
ISR_ELF = ROOT / "build/sh2/cmd3e_mode2_validation.elf"


def verify(active: Path = ACTIVE, control: Path = CONTROL,
           mode1_active: Path = MODE1_ACTIVE):
    return verify_pair(
        active, control, DEFAULT, mode1_active, MODE1_CONTROL,
        ISR_BIN, ISR_ELF, ROOT,
    )


class Mode2VerifierTests(unittest.TestCase):
    def tamper(self, source: Path, temp: str, offset: int) -> Path:
        path = Path(temp) / source.name
        image = bytearray(source.read_bytes())
        image[offset] ^= 1
        path.write_bytes(image)
        return path

    def test_repository_candidate_is_static_only(self) -> None:
        result = verify()
        self.assertTrue(result["static_eligible"], result["findings"])
        self.assertFalse(result["eligible"])
        self.assertFalse(result["promotable"])
        self.assertEqual(result["runtime_evidence"], "MISSING_FAIL_CLOSED")
        self.assertEqual(result["payload_bytes"], 3840)
        self.assertEqual(result["fifo_words"], 1920)
        self.assertEqual(result["full_checked_groups"], 480)
        self.assertEqual(result["fifo_words_per_group"], 4)
        self.assertTrue(result["mode1_evidence_unchanged"])

    def test_pair_arms_and_six_byte_slot_fail_closed(self) -> None:
        self.assertFalse(verify_pair(
            CONTROL, ACTIVE, DEFAULT, MODE1_ACTIVE, MODE1_CONTROL,
            ISR_BIN, ISR_ELF, ROOT,
        )["static_eligible"])
        with tempfile.TemporaryDirectory() as temp:
            result = verify(active=self.tamper(ACTIVE, temp, PAIR_SLOT_OFFSET))
            self.assertFalse(result["static_eligible"])

    def test_word_count_and_group_loop_tampering_fail(self) -> None:
        for offset in (M68K_OFFSET + 0x40, M68K_OFFSET + 0x70):
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                result = verify(active=self.tamper(ACTIVE, temp, offset))
                self.assertFalse(result["static_eligible"])

    def test_every_protocol_slice_fails_closed(self) -> None:
        for name, (start, _end, _digest) in ISR_PROTOCOL_SLICE_SHA256.items():
            with self.subTest(name=name), tempfile.TemporaryDirectory() as temp:
                result = verify(active=self.tamper(ACTIVE, temp, ISR_OFFSET + start))
                self.assertFalse(result["static_eligible"])
                self.assertIn(f"isr_protocol_slice:{name}", result["findings"])

    def test_cmd3f_remains_pinned_disabled(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            result = verify(active=self.tamper(ACTIVE, temp, CMD3F_JUMP_OFFSET))
            self.assertFalse(result["static_eligible"])
            self.assertIn("active_cmd3f_jump", result["findings"])

    def test_any_frozen_mode1_drift_blocks_mode2(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            result = verify(mode1_active=self.tamper(MODE1_ACTIVE, temp, 0x100))
            self.assertFalse(result["static_eligible"])
            self.assertFalse(result["mode1_evidence_unchanged"])


if __name__ == "__main__":
    unittest.main()
