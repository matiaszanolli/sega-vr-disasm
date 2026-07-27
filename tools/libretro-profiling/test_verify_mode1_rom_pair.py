#!/usr/bin/env python3
"""Focused adversarial tests for the Q-020 static ROM-pair verifier."""

from __future__ import annotations

import tempfile
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
from verify_mode1_rom_pair import (
    CANDIDATE_DEFAULT_ALLOWED_RANGES,
    HANDLER_OFFSET,
    PAIR_SLOT_OFFSET,
    differences_outside_ranges,
    literal_users_in_handler_allocation,
    verify_pair,
)

ROOT = Path(__file__).resolve().parents[2]
ACTIVE = ROOT / "build/vr60_mode1_active.32x"
CONTROL = ROOT / "build/vr60_mode1_stage_control.32x"
DEFAULT = ROOT / "build/vr_rebuild.32x"


class Mode1VerifierTests(unittest.TestCase):
    def test_repository_candidate_is_static_only(self) -> None:
        payload = verify_pair(ACTIVE, CONTROL, DEFAULT)
        self.assertTrue(payload["static_eligible"], payload["findings"])
        self.assertFalse(payload["eligible"])
        self.assertFalse(payload["promotable"])

    def test_pair_arms_cannot_be_swapped(self) -> None:
        payload = verify_pair(CONTROL, ACTIVE, DEFAULT)
        self.assertFalse(payload["static_eligible"])

    def test_handler_and_outside_delta_tampering_fail(self) -> None:
        for offset in (HANDLER_OFFSET, PAIR_SLOT_OFFSET - 1):
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                candidate = Path(temp) / "active.32x"
                image = bytearray(ACTIVE.read_bytes())
                image[offset] ^= 1
                candidate.write_bytes(image)
                payload = verify_pair(candidate, CONTROL, DEFAULT)
                self.assertFalse(payload["static_eligible"])

    def test_allowed_range_policy_is_independent_of_full_hashes(self) -> None:
        reference = bytearray(0x400000)
        candidate = bytearray(reference)
        candidate[CANDIDATE_DEFAULT_ALLOWED_RANGES[0][0]] = 1
        self.assertEqual(differences_outside_ranges(candidate, reference), [])
        candidate[0x100] = 1
        self.assertEqual(differences_outside_ranges(candidate, reference), [0x100])

    def test_external_movl_pc_user_is_detected_without_hash_policy(self) -> None:
        image = bytearray(ACTIVE.read_bytes())
        before = literal_users_in_handler_allocation(image)
        # At file $303A00, D003 resolves to file $303A10, the allocation start.
        image[0x303A00 : 0x303A02] = bytes.fromhex("d003")
        after = literal_users_in_handler_allocation(image)
        self.assertEqual(after[:1], [(0x303A00, HANDLER_OFFSET)])
        self.assertEqual(after[1:], before)


if __name__ == "__main__":
    unittest.main()
