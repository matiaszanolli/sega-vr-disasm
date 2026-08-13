#!/usr/bin/env python3
"""Adversarial policy tests for the Q-028 static ROM verifier."""

from __future__ import annotations

import importlib.util
import unittest
from pathlib import Path


MODULE_PATH = Path(__file__).with_name("verify_q028_renderer_probe_roms.py")
SPEC = importlib.util.spec_from_file_location("q028_static", MODULE_PATH)
q028 = importlib.util.module_from_spec(SPEC)
assert SPEC.loader is not None
SPEC.loader.exec_module(q028)
REPO = MODULE_PATH.parents[2]


class Q028StaticPolicyTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.default = (REPO / "build/vr_rebuild.32x").read_bytes()

    def test_complete_verifier_accepts_pinned_build(self) -> None:
        result = q028.verify(REPO)
        self.assertEqual(result["ordinary_identity"], q028.DEFAULT_SHA256)
        self.assertEqual(result["approved_capture_delta_sha256"],
                         q028.APPROVED_CAPTURE_DELTA_SHA256)

    def test_new_aligned_interval_owner_is_detected(self) -> None:
        mutated = bytearray(self.default)
        mutated[0x200000:0x200004] = bytes.fromhex("0600bbc0")
        owners = q028.pointer_occurrences(bytes(mutated))
        self.assertIn((0x200000, 0x0600BBC0, "sdram"), owners["aligned2"])
        self.assertNotEqual(owners["all"],
                            [(0x2018A5, 0x0202BC35, "sh2_rom")])

    def test_zero_run_drift_is_detected(self) -> None:
        mutated = bytearray(self.default)
        mutated[0x02BA80] = 1
        self.assertNotEqual(q028.zero_runs(bytes(mutated), 0x020000, 0x02C000),
                            q028.ZERO_RUNS)

    def test_literal_user_drift_is_detected(self) -> None:
        mutated = bytearray(self.default)
        mutated[0x020FEE:0x020FF0] = bytes.fromhex("0009")
        self.assertNotEqual(
            q028.movl_pc_users(bytes(mutated), q028.STOCK_LITERAL,
                               q028.STOCK_LITERAL + 4),
            q028.EXPECTED_LITERAL_USERS)

    def test_active_control_pair_rejects_extra_delta(self) -> None:
        control = (REPO / "build/vr60_q028_family_a_control.32x").read_bytes()
        active = bytearray(
            (REPO / "build/vr60_q028_family_a_active.32x").read_bytes())
        self.assertEqual(q028.diffs(control, bytes(active)),
                         [q028.PAIR_EDGE, q028.PAIR_EDGE + 1])
        active[0x0303A10] ^= 1
        self.assertNotEqual(q028.diffs(control, bytes(active)),
                            [q028.PAIR_EDGE, q028.PAIR_EDGE + 1])

    def test_sparse_c_map_excludes_stride_holes(self) -> None:
        descriptors = [0x0600C254 + group * 0x78 + item * 0x14
                       for group in range(7) for item in range(3)]
        self.assertEqual(len(descriptors), 21)
        self.assertEqual(descriptors[-1], 0x0600C54C)
        self.assertNotIn(0x0600C290, descriptors)


if __name__ == "__main__":
    unittest.main()
