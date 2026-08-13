#!/usr/bin/env python3
"""Adversarial tests for the archived Q-026 bounded-CMDINT runtime gate."""

from __future__ import annotations

import json
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from q026_player_runtime import sha256_path, validate  # noqa: E402


ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "analysis/evidence/vr60-q026-player-cmdint-gate/runtime"


class Q026PlayerRuntimeTests(unittest.TestCase):
    def copy_evidence(self, temp: str) -> Path:
        root = Path(temp) / "runtime"
        shutil.copytree(EVIDENCE, root)
        return root

    def update_artifact(self, root: Path, name: str) -> None:
        run_path = root / "run.json"
        payload = json.loads(run_path.read_text())
        path = root / name
        payload["artifacts"][name] = {
            "size": path.stat().st_size, "sha256": sha256_path(path),
        }
        run_path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")

    def rewrite(self, root: Path, name: str, old: str, new: str) -> None:
        path = root / name
        text = path.read_text()
        self.assertEqual(text.count(old), 1)
        path.write_text(text.replace(old, new, 1))
        self.update_artifact(root, name)

    def test_repository_archive_passes_bounded_precursor_contract(self) -> None:
        result = validate(EVIDENCE / "run.json")
        self.assertEqual(result["status"], "PASS")
        self.assertFalse(result["promotable"])
        for repeat in (1, 2):
            active = result["repeats"][f"active-{repeat}"]
            control = result["repeats"][f"control-{repeat}"]
            self.assertEqual(active["edge_events"], 1)
            self.assertEqual(control["edge_events"], 0)
            self.assertEqual(active["comm_pre"], active["comm_post"])
            self.assertEqual(active["comm_pre"][1] >> 8, 0)

    def test_unrehased_artifact_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            path = root / "active-1.debug.txt"
            path.write_text(path.read_text() + "tamper\n")
            with self.assertRaisesRegex(ValueError, "artifact identity"):
                validate(root / "run.json")

    def test_comm_snapshot_mismatch_is_rejected_after_rehash(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite(
                root, "active-1.mmio.trace",
                "q026_comm_post=0101/003A/0000",
                "q026_comm_post=0101/013A/0000",
            )
            with self.assertRaisesRegex(ValueError, "COMM1/2/7 preservation"):
                validate(root / "run.json")

    def test_out_of_range_direct_write_is_rejected_after_rehash(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite(
                root, "active-1.mmio.trace",
                "master,0x02304000,write,0x2600BC08,4,0x1",
                "master,0x02304000,write,0x26010000,4,0x1",
            )
            with self.assertRaisesRegex(ValueError, "out-of-range direct write"):
                validate(root / "run.json")

    def test_canary_corruption_is_rejected_after_rehash(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite(
                root, "active-1.mmio.trace",
                "master,0x02304000,write,0x2600FB90,4,0x5132534B",
                "master,0x02304000,write,0x2600FB90,4,0x5132534A",
            )
            with self.assertRaisesRegex(ValueError, "ordered markers"):
                validate(root / "run.json")

    def test_control_direct_work_is_rejected_after_rehash(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite(
                root, "control-1.mmio.trace",
                "q026_edge_snapshots=0", "q026_edge_snapshots=1",
            )
            with self.assertRaisesRegex(ValueError, "CONTROL direct work"):
                validate(root / "run.json")


if __name__ == "__main__":
    unittest.main()
