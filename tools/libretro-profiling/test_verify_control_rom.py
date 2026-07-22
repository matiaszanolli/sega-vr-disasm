#!/usr/bin/env python3
"""Focused tests for the VR60 control-ROM evidence writer."""

from __future__ import annotations

import json
from pathlib import Path
import sys
import tempfile
import unittest


SCRIPT_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(SCRIPT_DIR))

from validate_1p_control import HOOK_SITE_LIVE_BYTES, HOOK_SITE_OFFSET, HOOK_SITE_STOCK_BYTES
from verify_control_rom import main


class VerifyControlRomTests(unittest.TestCase):
    def write_pair(self, directory: Path) -> tuple[Path, Path]:
        candidate = directory / "candidate.32x"
        reference = directory / "reference.32x"
        image = bytearray(HOOK_SITE_OFFSET + len(HOOK_SITE_STOCK_BYTES))
        image[HOOK_SITE_OFFSET:] = HOOK_SITE_LIVE_BYTES
        reference.write_bytes(image)
        image[HOOK_SITE_OFFSET:] = HOOK_SITE_STOCK_BYTES
        candidate.write_bytes(image)
        return candidate, reference

    def test_eligible_pair_records_both_hashes_and_exact_delta(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            candidate, reference = self.write_pair(directory)
            manifest = directory / "pair.json"
            status = main([
                "--candidate", str(candidate),
                "--reference", str(reference),
                "--manifest", str(manifest),
            ])
            self.assertEqual(status, 0)
            payload = json.loads(manifest.read_text())
            self.assertTrue(payload["eligible"])
            self.assertEqual(payload["outside_hook_difference_count"], 0)
            self.assertEqual(payload["candidate_hook_bytes"], HOOK_SITE_STOCK_BYTES.hex())
            self.assertEqual(payload["reference_hook_bytes"], HOOK_SITE_LIVE_BYTES.hex())
            self.assertEqual(len(payload["candidate_sha256"]), 64)
            self.assertEqual(len(payload["reference_sha256"]), 64)

    def test_unrelated_difference_records_failure_and_returns_nonzero(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            candidate, reference = self.write_pair(directory)
            image = bytearray(candidate.read_bytes())
            image[0x100] ^= 1
            candidate.write_bytes(image)
            manifest = directory / "pair.json"
            status = main([
                "--candidate", str(candidate),
                "--reference", str(reference),
                "--manifest", str(manifest),
            ])
            self.assertEqual(status, 1)
            payload = json.loads(manifest.read_text())
            self.assertFalse(payload["eligible"])
            self.assertEqual(payload["outside_hook_difference_count"], 1)
            self.assertEqual(payload["first_outside_hook_difference"], "0x100")


if __name__ == "__main__":
    unittest.main()
