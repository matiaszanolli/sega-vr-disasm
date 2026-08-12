#!/usr/bin/env python3
"""Adversarial tests for the archived Q-021 mode-2 runtime evidence."""

from __future__ import annotations

import json
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from mode2_cmdint_runtime import validate  # noqa: E402
from mode1_cmdint_runtime import sha256_path  # noqa: E402


ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "analysis/evidence/vr60-q021-mode2-cmdint-gate/runtime"


class Mode2RuntimeTests(unittest.TestCase):
    def copy_evidence(self, temp: str) -> Path:
        root = Path(temp) / "runtime"
        shutil.copytree(EVIDENCE, root)
        return root

    def update_artifact(self, root: Path, name: str) -> None:
        run_path = root / "run.json"
        payload = json.loads(run_path.read_text())
        path = root / name
        payload["artifacts"][name] = {
            "path": name, "size": path.stat().st_size,
            "sha256": sha256_path(path),
        }
        run_path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")

    def rewrite(self, root: Path, name: str, old: str, new: str) -> None:
        path = root / name
        text = path.read_text()
        self.assertIn(old, text)
        path.write_text(text.replace(old, new, 1))
        self.update_artifact(root, name)

    def test_repository_archive_passes_exact_transfer_contract(self) -> None:
        result = validate(EVIDENCE / "run.json")
        self.assertEqual(result["status"], "VALIDATION_STAGE_PASS")
        self.assertEqual(result["active_transactions_per_normal_run"], 1)
        self.assertEqual(result["payload_bytes"], 3840)
        self.assertEqual(result["fifo_words"], 1920)
        self.assertEqual(result["full_checked_groups"], 480)
        self.assertEqual(result["fifo_words_per_group"], 4)
        self.assertTrue(result["source_fifo_destination_full_equality"])
        self.assertEqual(result["stage_control_transport_events"], 0)
        self.assertFalse(result["promotable"])

    def test_off_by_half_arithmetic_claim_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            run_path = root / "run.json"
            payload = json.loads(run_path.read_text())
            payload["transfer_contract"]["payload_bytes"] = 1920
            run_path.write_text(json.dumps(payload))
            with self.assertRaisesRegex(ValueError, "transfer arithmetic policy"):
                validate(run_path)

    def test_missing_fifo_word_is_rejected_after_rehash(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            path = root / "active-normal-1.mmio.trace"
            lines = path.read_text().splitlines()
            fifo = [index for index, line in enumerate(lines) if
                    ",write,0x00A15112,2," in line]
            self.assertEqual(len(fifo), 1920)
            del lines[fifo[-1]]
            for index in range(fifo[-1], len(lines) - 1):
                fields = lines[index].split(",")
                if fields and fields[0].isdigit():
                    fields[0] = str(int(fields[0]) - 1)
                    lines[index] = ",".join(fields)
            old_footer = lines[-1]
            lines[-1] = lines[-1].replace(
                "events=2472 recorded=2472", "events=2471 recorded=2471"
            )
            self.assertNotEqual(lines[-1], old_footer)
            path.write_text("\n".join(lines) + "\n")
            self.update_artifact(root, path.name)
            with self.assertRaises(ValueError):
                validate(root / "run.json")

    def test_full_destination_tamper_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite(
                root, "active-normal-1.debug.txt",
                "06010EF0: 00 00", "06010EF0: 00 01",
            )
            with self.assertRaisesRegex(ValueError, "full source/FIFO/destination"):
                validate(root / "run.json")

    def test_control_transport_and_stack_intrusion_are_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite(
                root, "control-normal-1.mmio.trace",
                "events=0 recorded=0", "events=1 recorded=0",
            )
            with self.assertRaises(ValueError):
                validate(root / "run.json")
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite(
                root, "active-normal-1.debug.txt",
                "R15=06010000", "R15=06010004",
            )
            with self.assertRaisesRegex(ValueError, "stack intrudes upward AI range"):
                validate(root / "run.json")


if __name__ == "__main__":
    unittest.main()
