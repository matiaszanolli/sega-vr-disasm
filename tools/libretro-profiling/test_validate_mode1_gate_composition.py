#!/usr/bin/env python3
"""Adversarial tests for the complete mode-1 Gate B composition."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from validate_mode1_gate_composition import (
    CompositionValidationError,
    validate_composition,
)


ROOT = Path(__file__).resolve().parents[2]
COMPOSITION = (
    ROOT / "analysis/evidence/vr60-q020-mode1-cmdint-gate/composition.json"
)


class Mode1GateCompositionTests(unittest.TestCase):
    def altered(self, mutate) -> tuple[tempfile.TemporaryDirectory[str], Path]:
        temp = tempfile.TemporaryDirectory()
        payload = json.loads(COMPOSITION.read_text())
        mutate(payload)
        path = Path(temp.name) / "composition.json"
        path.write_text(json.dumps(payload))
        return temp, path

    def test_repository_composition_passes(self) -> None:
        result = validate_composition(COMPOSITION, ROOT)
        self.assertEqual(result["status"], "VALIDATION_STAGE_PASS")
        self.assertTrue(result["non_promotable"])

    def test_stale_static_hash_fails(self) -> None:
        temp, path = self.altered(
            lambda p: p["components"]["static_pair"].update(sha256="0" * 64)
        )
        with temp, self.assertRaisesRegex(CompositionValidationError, "static_pair hash"):
            validate_composition(path, ROOT)

    def test_missing_component_fails(self) -> None:
        temp, path = self.altered(
            lambda p: p["components"].pop("runtime_result")
        )
        with temp, self.assertRaisesRegex(CompositionValidationError, "keys mismatch"):
            validate_composition(path, ROOT)

    def test_capture_result_cross_version_mismatch_fails(self) -> None:
        temp, path = self.altered(
            lambda p: p["components"]["runtime_capture"].update(
                sha256=p["components"]["runtime_result"]["sha256"]
            )
        )
        with temp, self.assertRaisesRegex(CompositionValidationError, "runtime_capture hash"):
            validate_composition(path, ROOT)

    def test_promotion_overclaim_fails(self) -> None:
        temp, path = self.altered(lambda p: p["claims"].update(promoted=True))
        with temp, self.assertRaisesRegex(CompositionValidationError, "scope/promotion"):
            validate_composition(path, ROOT)


if __name__ == "__main__":
    unittest.main()
