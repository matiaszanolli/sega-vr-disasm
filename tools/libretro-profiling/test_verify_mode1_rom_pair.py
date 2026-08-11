#!/usr/bin/env python3
"""Focused adversarial tests for the Q-020 mode-1 static pair verifier."""

from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from verify_mode1_rom_pair import (  # noqa: E402
    ALLOWED_DIFF_RANGES,
    CMD3F_JUMP_OFFSET,
    EXTERNAL_LITERAL_USER,
    ISR_END,
    ISR_OFFSET,
    ISR_PROTOCOL_SLICE_SHA256,
    M68K_OFFSET,
    PAIR_SLOT_OFFSET,
    STARTUP_LITERAL_OFFSET,
    differences_outside_ranges,
    movl_pc_users_in_range,
    verify_pair,
)

ROOT = Path(__file__).resolve().parents[2]
ACTIVE = ROOT / "build/vr60_mode1_active.32x"
CONTROL = ROOT / "build/vr60_mode1_stage_control.32x"
DEFAULT = ROOT / "build/vr_rebuild.32x"
ISR_BIN = ROOT / "build/sh2/cmd3e_mode1_validation.bin"
ISR_ELF = ROOT / "build/sh2/cmd3e_mode1_validation.elf"


def verify(active: Path = ACTIVE, control: Path = CONTROL):
    return verify_pair(active, control, DEFAULT, ISR_BIN, ISR_ELF, ROOT)


class Mode1VerifierTests(unittest.TestCase):
    def tampered_active(self, temp: str, offset: int, mask: int = 1) -> Path:
        path = Path(temp) / "active.32x"
        image = bytearray(ACTIVE.read_bytes())
        image[offset] ^= mask
        path.write_bytes(image)
        return path

    def test_repository_candidate_is_static_only(self) -> None:
        payload = verify()
        self.assertTrue(payload["static_eligible"], payload["findings"])
        self.assertFalse(payload["eligible"])
        self.assertFalse(payload["promotable"])
        self.assertEqual(
            payload["runtime_evidence"], "COMPOSED_BY_MODE1_GATE_MANIFEST"
        )
        self.assertEqual(payload["status"], "STATIC_VALIDATION_PASS_NON_PROMOTABLE")

    def test_pair_arms_cannot_be_swapped(self) -> None:
        self.assertFalse(verify_pair(CONTROL, ACTIVE, DEFAULT, ISR_BIN, ISR_ELF, ROOT)["static_eligible"])

    def test_pair_slot_and_outside_delta_tampering_fail(self) -> None:
        for offset in (PAIR_SLOT_OFFSET, 0x100):
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                payload = verify(self.tampered_active(temp, offset))
                self.assertFalse(payload["static_eligible"])

    def test_allowed_delta_policy_is_independent_of_hash(self) -> None:
        reference = bytearray(0x400000)
        candidate = bytearray(reference)
        candidate[ALLOWED_DIFF_RANGES[0][0]] = 1
        self.assertEqual(differences_outside_ranges(candidate, reference), [])
        candidate[0x100] = 1
        self.assertEqual(differences_outside_ranges(candidate, reference), [0x100])

    def test_isr_and_bridge_literal_tampering_fail(self) -> None:
        for offset in (ISR_OFFSET, EXTERNAL_LITERAL_USER[1]):
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                payload = verify(self.tampered_active(temp, offset))
                self.assertFalse(payload["static_eligible"])

    def test_external_movl_user_is_detected_without_hash_policy(self) -> None:
        image = bytearray(ACTIVE.read_bytes())
        before = movl_pc_users_in_range(image, ISR_OFFSET, ISR_END)
        image[0x303A00 : 0x303A02] = bytes.fromhex("d03f")
        after = movl_pc_users_in_range(image, ISR_OFFSET, ISR_END)
        self.assertEqual(after[:1], before[:1])
        self.assertEqual(after[2:], before[1:])
        self.assertIn((0x303A00, ISR_OFFSET), after)

    def test_startup_literal_new_user_is_detected(self) -> None:
        image = bytearray(ACTIVE.read_bytes())
        before = movl_pc_users_in_range(image, STARTUP_LITERAL_OFFSET, STARTUP_LITERAL_OFFSET + 4)
        image[0x020400 : 0x020402] = bytes.fromhex("d01f")
        after = movl_pc_users_in_range(image, STARTUP_LITERAL_OFFSET, STARTUP_LITERAL_OFFSET + 4)
        self.assertEqual(before, [(0x020438, STARTUP_LITERAL_OFFSET)])
        self.assertEqual(after, [(0x020400, STARTUP_LITERAL_OFFSET), *before])

    def test_rte_delay_slot_must_be_explicit_nop(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            payload = verify(self.tampered_active(temp, ISR_OFFSET + 0x348))
            self.assertFalse(payload["static_eligible"])
            self.assertIn("isr_rte_explicit_nop_delay", payload["findings"])

    def test_all_external_vectors_are_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            payload = verify(self.tampered_active(temp, 0x020120))
            self.assertFalse(payload["static_eligible"])
            self.assertIn("active_vectors", payload["findings"])

    def test_producer_trigger_or_dreq_order_tampering_fail(self) -> None:
        for offset in (M68K_OFFSET + 0x4E, M68K_OFFSET + 0xA0):
            with self.subTest(offset=offset), tempfile.TemporaryDirectory() as temp:
                payload = verify(self.tampered_active(temp, offset))
                self.assertFalse(payload["static_eligible"])

    def test_mode1_producer_has_zero_comm_accesses(self) -> None:
        helper = ACTIVE.read_bytes()[M68K_OFFSET : M68K_OFFSET + 0xB8]
        for suffix in range(0x20, 0x30):
            self.assertNotIn(bytes.fromhex(f"00a151{suffix:02x}"), helper)

    def test_setup_and_completion_ownership_slices_fail_closed(self) -> None:
        for name in (
            "setup_arm", "completion_terminal", "completion_identity", "setup_ownership",
        ):
            start, _end, _digest = ISR_PROTOCOL_SLICE_SHA256[name]
            with self.subTest(name=name), tempfile.TemporaryDirectory() as temp:
                payload = verify(self.tampered_active(temp, ISR_OFFSET + start))
                self.assertFalse(payload["static_eligible"])
                self.assertIn(f"isr_protocol_slice:{name}", payload["findings"])

    def test_cmd3f_remains_pinned_disabled(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            payload = verify(self.tampered_active(temp, CMD3F_JUMP_OFFSET))
            self.assertFalse(payload["static_eligible"])
            self.assertIn("active_cmd3f_jump", payload["findings"])

    def test_isr_binary_and_elf_are_required_exact_inputs(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            bad_bin = Path(temp) / "isr.bin"
            image = bytearray(ISR_BIN.read_bytes())
            image[0] ^= 1
            bad_bin.write_bytes(image)
            payload = verify_pair(ACTIVE, CONTROL, DEFAULT, bad_bin, ISR_ELF, ROOT)
            self.assertFalse(payload["static_eligible"])
            self.assertTrue(any("isr_bin" in item for item in payload["findings"]))


if __name__ == "__main__":
    unittest.main()
