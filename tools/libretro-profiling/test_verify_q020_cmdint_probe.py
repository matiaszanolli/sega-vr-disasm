#!/usr/bin/env python3
"""Focused adversarial tests for the Q-020 CMDINT probe ROM verifier."""

from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parent.parent
sys.path.insert(0, str(SCRIPT_DIR))

from verify_q020_cmdint_probe import (
    EXPECTED_ISR_LITERAL_USERS,
    ISR_END,
    ISR_LITERAL_START,
    ISR_OFFSET,
    literal_users_in_isr_allocation,
    verify,
)


class Q020CmdintProbeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.probe = REPO_ROOT / "build/vr60_q020_cmdint_probe.32x"
        cls.default = REPO_ROOT / "build/vr_rebuild.32x"
        cls.isr_bin = REPO_ROOT / "build/sh2/q020_cmdint_probe_isr.bin"
        for path in (cls.probe, cls.default, cls.isr_bin):
            if not path.is_file():
                raise RuntimeError(f"required build artifact is missing: {path}")

    def test_repository_probe_passes(self) -> None:
        payload = verify(self.probe, self.default, self.isr_bin, REPO_ROOT)
        self.assertEqual(payload["status"], "verified")
        self.assertTrue(payload["non_promotable"])
        self.assertEqual(payload["changed_bytes"], 494)

    def test_literal_users_are_exactly_private(self) -> None:
        users = literal_users_in_isr_allocation(self.probe.read_bytes())
        self.assertEqual(len(users), EXPECTED_ISR_LITERAL_USERS)
        self.assertTrue(all(ISR_OFFSET <= user < ISR_END for user, _ in users))
        self.assertTrue(
            all(ISR_LITERAL_START <= target < ISR_END for _, target in users)
        )

    def test_difference_outside_allocations_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            candidate = Path(temp) / "probe.32x"
            image = bytearray(self.probe.read_bytes())
            image[0x100] ^= 1
            candidate.write_bytes(image)
            with self.assertRaisesRegex(ValueError, "difference_outside_allowed_ranges"):
                verify(candidate, self.default, self.isr_bin, REPO_ROOT)

    def test_vector_tamper_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            candidate = Path(temp) / "probe.32x"
            image = bytearray(self.probe.read_bytes())
            image[0x020100] ^= 1
            candidate.write_bytes(image)
            with self.assertRaisesRegex(ValueError, "probe_external_vectors"):
                verify(candidate, self.default, self.isr_bin, REPO_ROOT)

    def test_standalone_isr_tamper_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            candidate = Path(temp) / "q020_cmdint_probe_isr.bin"
            image = bytearray(self.isr_bin.read_bytes())
            image[-1] ^= 1
            candidate.write_bytes(image)
            with self.assertRaisesRegex(ValueError, "isr_bin_sha256"):
                verify(self.probe, self.default, candidate, REPO_ROOT)

    def test_default_identity_tamper_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            candidate = Path(temp) / "default.32x"
            image = bytearray(self.default.read_bytes())
            image[0x100] ^= 1
            candidate.write_bytes(image)
            with self.assertRaisesRegex(ValueError, "default_sha256"):
                verify(self.probe, candidate, self.isr_bin, REPO_ROOT)


if __name__ == "__main__":
    unittest.main()
