#!/usr/bin/env python3
"""Focused tests for exact full-ROM mode-0 default promotion."""

from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(SCRIPT_DIR))

from verify_mode0_default import verify_default


class Mode0DefaultTests(unittest.TestCase):
    def test_repository_default_is_exact_validated_active(self) -> None:
        root = SCRIPT_DIR.parent.parent
        payload = verify_default(
            root / "build/vr_rebuild.32x",
            root / "build/vr60_mode0_active.32x",
        )
        self.assertTrue(payload["eligible"], payload["findings"])
        self.assertTrue(payload["whole_image_equal"])

    def test_default_promotion_mismatch_fails(self) -> None:
        root = SCRIPT_DIR.parent.parent
        with tempfile.TemporaryDirectory() as temp:
            default = Path(temp) / "default.32x"
            default.write_bytes((root / "build/vr_rebuild.32x").read_bytes())
            image = bytearray(default.read_bytes())
            image[0x100] ^= 1
            default.write_bytes(image)
            payload = verify_default(
                default,
                root / "build/vr60_mode0_active.32x",
            )
            self.assertFalse(payload["eligible"])
            self.assertIn(
                "default_not_validated_active:0x100",
                payload["findings"],
            )


if __name__ == "__main__":
    unittest.main()
