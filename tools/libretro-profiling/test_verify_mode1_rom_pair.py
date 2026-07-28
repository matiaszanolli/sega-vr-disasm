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
    COMPLETION_SEQUENCE,
    DMAC0_ACTIVE_CHCR,
    DMAC0_IDLE_CHCR,
    DMAC0_ACTIVE_LITERAL_OFFSET,
    DMAC0_IDLE_LITERAL_OFFSET,
    HANDLER_OFFSET,
    PAIR_SLOT_OFFSET,
    READINESS_SEQUENCE,
    dmac0_rearm_policy_errors,
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

    def test_dmac0_policy_rearms_cleanly_for_repeated_transactions(self) -> None:
        self.assertEqual(
            dmac0_rearm_policy_errors(
                DMAC0_ACTIVE_CHCR,
                DMAC0_IDLE_CHCR,
                repetitions=2,
            ),
            [],
        )
        self.assertIn(
            "active_dei_enabled",
            dmac0_rearm_policy_errors(0x000044E5, DMAC0_IDLE_CHCR),
        )
        self.assertIn(
            "idle_not_ie0_te0_de0",
            dmac0_rearm_policy_errors(DMAC0_ACTIVE_CHCR, 0x000044E1),
        )
        self.assertIn(
            "idle_not_ie0_te0_de0",
            dmac0_rearm_policy_errors(DMAC0_ACTIVE_CHCR, 0x000044E4),
        )

    def test_te_acknowledge_or_chcr_literal_tampering_is_rejected(self) -> None:
        for offset in (
            HANDLER_OFFSET + 0x54,
            HANDLER_OFFSET + DMAC0_ACTIVE_LITERAL_OFFSET,
            HANDLER_OFFSET + DMAC0_IDLE_LITERAL_OFFSET,
        ):
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                candidate = Path(temp) / "active.32x"
                image = bytearray(ACTIVE.read_bytes())
                image[offset] ^= 1
                candidate.write_bytes(image)
                payload = verify_pair(candidate, CONTROL, DEFAULT)
                self.assertFalse(payload["static_eligible"])
                self.assertTrue(
                    any("dmac0" in finding for finding in payload["findings"]),
                    payload["findings"],
                )

    def test_readiness_and_completion_flush_tampering_is_rejected(self) -> None:
        image = ACTIVE.read_bytes()
        for label, sequence, finding in (
            ("readiness", READINESS_SEQUENCE, "master_readiness_sequence"),
            (
                "completion",
                COMPLETION_SEQUENCE,
                "master_completion_flush_sequence",
            ),
        ):
            offset = image.index(sequence, HANDLER_OFFSET)
            with self.subTest(label=label), tempfile.TemporaryDirectory() as temp:
                candidate = Path(temp) / "active.32x"
                tampered = bytearray(image)
                tampered[offset] ^= 1
                candidate.write_bytes(tampered)
                payload = verify_pair(candidate, CONTROL, DEFAULT)
                self.assertFalse(payload["static_eligible"])
                self.assertTrue(
                    any(finding in item for item in payload["findings"]),
                    payload["findings"],
                )

    def test_idle_ie_bit_tampering_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            candidate = Path(temp) / "active.32x"
            image = bytearray(ACTIVE.read_bytes())
            image[HANDLER_OFFSET + DMAC0_IDLE_LITERAL_OFFSET + 3] ^= 0x04
            candidate.write_bytes(image)
            payload = verify_pair(candidate, CONTROL, DEFAULT)
            self.assertFalse(payload["static_eligible"])
            self.assertTrue(
                any(
                    "idle_not_ie0_te0_de0" in finding
                    for finding in payload["findings"]
                ),
                payload["findings"],
            )


if __name__ == "__main__":
    unittest.main()
