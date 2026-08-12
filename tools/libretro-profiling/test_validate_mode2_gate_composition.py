#!/usr/bin/env python3
"""Adversarial tests for Q-021 mode-2 gate composition."""

from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from validate_mode2_gate_composition import (  # noqa: E402
    CompositionValidationError,
    validate_composition,
)


ROOT = Path(__file__).resolve().parents[2]
COMPOSITION = ROOT / "analysis/evidence/vr60-q021-mode2-cmdint-gate/composition.json"


class Mode2CompositionTests(unittest.TestCase):
    def altered_manifest(self, temp: str, mutator) -> Path:
        payload = json.loads(COMPOSITION.read_text())
        mutator(payload)
        path = Path(temp) / "composition.json"
        path.write_text(json.dumps(payload))
        return path

    def test_repository_composition_passes_non_promotable(self) -> None:
        result = validate_composition(COMPOSITION, ROOT)
        self.assertEqual(result["status"], "VALIDATION_STAGE_PASS")
        self.assertEqual(result["payload_bytes"], 3840)
        self.assertEqual(result["fifo_words"], 1920)
        self.assertEqual(result["fifo_groups"], 480)
        self.assertFalse(result["authority_transferred"])

    def test_promotion_or_authority_overclaim_is_rejected(self) -> None:
        for key in ("promoted", "ordinary_default", "authority_transferred"):
            with self.subTest(key=key), tempfile.TemporaryDirectory() as temp:
                path = self.altered_manifest(
                    temp, lambda payload, key=key: payload["claims"].__setitem__(key, True)
                )
                with self.assertRaisesRegex(CompositionValidationError, "scope/promotion"):
                    validate_composition(path, ROOT)

    def test_component_hash_or_frozen_mode1_identity_is_rejected(self) -> None:
        cases = (
            lambda payload: payload["components"]["runtime_capture"].__setitem__(
                "sha256", "0" * 64
            ),
            lambda payload: payload["identities"].__setitem__("mode1_isr", "0" * 64),
        )
        for mutator in cases:
            with tempfile.TemporaryDirectory() as temp:
                path = self.altered_manifest(temp, mutator)
                with self.assertRaises(CompositionValidationError):
                    validate_composition(path, ROOT)


if __name__ == "__main__":
    unittest.main()
