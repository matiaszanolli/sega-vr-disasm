#!/usr/bin/env python3
"""Adversarial tests for the mode-1 lifecycle/reset reference."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from validate_mode1_reset_fixtures import FixtureValidationError, validate_manifest


ROOT = Path(__file__).resolve().parents[2]
MANIFEST = ROOT / "tools/libretro-profiling/mode1_reset_fixtures.json"


class Mode1LifecycleReferenceTests(unittest.TestCase):
    def altered(self, mutate) -> tuple[tempfile.TemporaryDirectory[str], Path]:
        temp = tempfile.TemporaryDirectory()
        payload = json.loads(MANIFEST.read_text())
        mutate(payload)
        path = Path(temp.name) / "manifest.json"
        path.write_text(json.dumps(payload))
        return temp, path

    def test_repository_reference_passes(self) -> None:
        self.assertEqual(validate_manifest(MANIFEST, ROOT), 8)

    def test_stale_rom_identity_fails(self) -> None:
        temp, path = self.altered(lambda p: p["roms"].update(active="0" * 64))
        with temp, self.assertRaisesRegex(FixtureValidationError, "ROM identity"):
            validate_manifest(path, ROOT)

    def test_runtime_result_hash_mismatch_fails(self) -> None:
        temp, path = self.altered(
            lambda p: p["runtime_result"].update(sha256="0" * 64)
        )
        with temp, self.assertRaisesRegex(FixtureValidationError, "sha256 mismatch"):
            validate_manifest(path, ROOT)

    def test_seeded_name_cannot_be_claimed_organic(self) -> None:
        temp, path = self.altered(lambda p: p.update(organic_gameplay=True))
        with temp, self.assertRaisesRegex(FixtureValidationError, "status/scope"):
            validate_manifest(path, ROOT)

    def test_busy_reset_cannot_enter_acceptance(self) -> None:
        temp, path = self.altered(
            lambda p: p["busy_slave_vres"].update(accepted=True)
        )
        with temp, self.assertRaisesRegex(FixtureValidationError, "busy-Slave"):
            validate_manifest(path, ROOT)


if __name__ == "__main__":
    unittest.main()
