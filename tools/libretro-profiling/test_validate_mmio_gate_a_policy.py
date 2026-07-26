#!/usr/bin/env python3
"""Focused tests for the manifest-bound Gate-A MMIO PC policy."""

from __future__ import annotations

import copy
import json
import shutil
import tempfile
import unittest
from pathlib import Path

from validate_mmio_gate_a_policy import (
    DEFAULT_POLICY,
    PolicyValidationError,
    validate_policy,
)

TOOL_DIR = Path(__file__).resolve().parent


class MmioGateAPolicyTests(unittest.TestCase):
    def setUp(self) -> None:
        self.payload = json.loads(DEFAULT_POLICY.read_text(encoding="utf-8"))

    def write_policy(self, payload: dict[str, object]) -> Path:
        directory = Path(tempfile.mkdtemp())
        shutil.copy2(
            TOOL_DIR / "mode0_rom_pair.json",
            directory / "mode0_rom_pair.json",
        )
        path = directory / "mmio_gate_a_policy.json"
        path.write_text(
            json.dumps(payload, indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )
        return path

    def test_production_policy_passes(self) -> None:
        validate_policy()

    def test_broadened_range_fails(self) -> None:
        payload = copy.deepcopy(self.payload)
        payload["pc_allowlist"]["m68k"][0]["start"] = "0x0001C6FC"
        with self.assertRaisesRegex(
            PolicyValidationError, "offsets/sizes"
        ):
            validate_policy(self.write_policy(payload))

    def test_wrong_source_manifest_hash_fails(self) -> None:
        payload = copy.deepcopy(self.payload)
        payload["source_manifest"]["sha256"] = "0" * 64
        with self.assertRaisesRegex(PolicyValidationError, "hash mismatch"):
            validate_policy(self.write_policy(payload))

    def test_gate_b_cannot_be_marked_ready_without_built_pcs(self) -> None:
        payload = copy.deepcopy(self.payload)
        payload["gate_b_manifest_dependency"]["status"] = "READY"
        with self.assertRaisesRegex(PolicyValidationError, "fail-closed"):
            validate_policy(self.write_policy(payload))

    def test_witness_pc_mismatch_fails(self) -> None:
        payload = copy.deepcopy(self.payload)
        payload["gate_a_mode0_witness"]["fifo_tail_writer_pc"] = "0x0001C762"
        with self.assertRaisesRegex(PolicyValidationError, "parser policy"):
            validate_policy(self.write_policy(payload))


if __name__ == "__main__":
    unittest.main()
