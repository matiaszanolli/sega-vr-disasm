#!/usr/bin/env python3
"""Adversarial tests for the archived Q-020 mode-1 runtime evidence."""

from __future__ import annotations

import hashlib
import json
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from mode1_cmdint_runtime import validate


ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "analysis/evidence/vr60-q020-mode1-cmdint-gate/runtime"


def sha256_path(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


class Mode1RuntimeTests(unittest.TestCase):
    def copy_evidence(self, temp: str) -> Path:
        root = Path(temp) / "runtime"
        shutil.copytree(EVIDENCE, root)
        return root

    def update_artifact(self, root: Path, name: str) -> None:
        run_path = root / "run.json"
        payload = json.loads(run_path.read_text())
        path = root / name
        payload["artifacts"][name] = {
            "path": name, "size": path.stat().st_size, "sha256": sha256_path(path),
        }
        run_path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")

    def rewrite_text(self, root: Path, name: str, old: str, new: str) -> None:
        path = root / name
        text = path.read_text()
        self.assertIn(old, text)
        path.write_text(text.replace(old, new, 1))
        self.update_artifact(root, name)

    def test_repository_archive_passes_as_validation_only(self) -> None:
        result = validate(EVIDENCE / "run.json")
        self.assertEqual(result["status"], "VALIDATION_STAGE_PASS")
        self.assertFalse(result["promotable"])
        self.assertFalse(result["organic_gameplay"])
        self.assertEqual(result["active_transactions_per_normal_run"], 6)

    def test_raw_artifact_tamper_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            with (root / "active-normal-1.mmio.trace").open("a") as stream:
                stream.write("tamper\n")
            with self.assertRaisesRegex(ValueError, "artifact identity"):
                validate(root / "run.json")

    def test_exact_artifact_set_is_required(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            run_path = root / "run.json"
            payload = json.loads(run_path.read_text())
            del payload["artifacts"]["active-normal-1.write.trace"]
            run_path.write_text(json.dumps(payload))
            with self.assertRaisesRegex(ValueError, "artifact set"):
                validate(run_path)

    def test_scope_and_organic_claims_are_fail_closed(self) -> None:
        for key, value in (("organic_gameplay", True), ("non_promotable", False)):
            with self.subTest(key=key), tempfile.TemporaryDirectory() as temp:
                root = self.copy_evidence(temp)
                run_path = root / "run.json"
                payload = json.loads(run_path.read_text())
                payload[key] = value
                run_path.write_text(json.dumps(payload))
                with self.assertRaisesRegex(ValueError, "runtime scope policy"):
                    validate(run_path)

    def test_seeded_fixture_transformation_tamper_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            path = root / "name-route-seeded.mds"
            image = bytearray(path.read_bytes())
            image[-1] ^= 1
            path.write_bytes(image)
            self.update_artifact(root, path.name)
            with self.assertRaisesRegex(ValueError, "name fixture transformation"):
                validate(root / "run.json")

    def test_unmatched_fatal_and_reset_warning_text_are_rejected(self) -> None:
        cases = (
            ("active-normal-1.debug.txt", "32X shutdown", "illegal opcode\n32X shutdown", "fatal runtime"),
            (
                "active-vres.debug.txt", "ssh2 drc: unhandled op 4778 @ 0600063a",
                "ssh2 drc: unhandled op DEAD @ 0600063a", "scoped reset warning",
            ),
        )
        for name, old, new, error in cases:
            with self.subTest(name=name), tempfile.TemporaryDirectory() as temp:
                root = self.copy_evidence(temp)
                self.rewrite_text(root, name, old, new)
                with self.assertRaisesRegex(ValueError, error):
                    validate(root / "run.json")

    def test_gate_b_order_full_dmaor_and_te_tampering_are_rejected(self) -> None:
        cases = (
            (",write,0xFFFFFF84,4,0x600F30C", ",write,0xFFFFFF88,4,0x600F30C"),
            (",read,0x00A15107,1,0x4", ",read,0x00A15107,1,0x84"),
            (",read,0xFFFFFFB0,4,0x1", ",read,0xFFFFFFB0,4,0x0"),
            (",write,0xFFFFFF8C,4,0x44E0", ",write,0xFFFFFF8C,4,0x44E2"),
        )
        for old, new in cases:
            with self.subTest(old=old), tempfile.TemporaryDirectory() as temp:
                root = self.copy_evidence(temp)
                self.rewrite_text(root, "active-normal-1.mmio.trace", old, new)
                with self.assertRaises(ValueError):
                    validate(root / "run.json")

    def test_payload_or_transaction_count_tamper_is_rejected(self) -> None:
        cases = (
            (
                "active-normal-1.mmio.trace",
                ",write,0x00A15112,2,0x1E", ",write,0x00A15112,2,0x1F",
            ),
            (
                "active-normal-2.debug.txt",
                "00 00 00 0C 00 00 00 06", "00 00 00 0A 00 00 00 05",
            ),
        )
        for name, old, new in cases:
            with self.subTest(name=name), tempfile.TemporaryDirectory() as temp:
                root = self.copy_evidence(temp)
                self.rewrite_text(root, name, old, new)
                with self.assertRaises(ValueError):
                    validate(root / "run.json")

    def test_setup_and_completion_spc_contract_is_rejected_on_tamper(self) -> None:
        cases = (
            ("06 00 44 3A 06 00 3D 04", "06 00 44 34 06 00 3D 04"),
            ("06 00 44 3A 06 00 3D 04", "06 00 44 3A 00 00 00 00"),
        )
        for old, new in cases:
            with self.subTest(new=new), tempfile.TemporaryDirectory() as temp:
                root = self.copy_evidence(temp)
                self.rewrite_text(root, "active-normal-1.debug.txt", old, new)
                with self.assertRaisesRegex(ValueError, "SPC policy"):
                    validate(root / "run.json")

    def test_caller_must_follow_final_pointer_write(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite_text(
                root, "active-normal-1.caller.trace",
                "1256,0x00884CBC", "1200,0x00884CBC",
            )
            with self.assertRaisesRegex(ValueError, "caller hit precedes"):
                validate(root / "run.json")

    def test_name_route_transport_or_racing_hook_claim_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite_text(
                root, "active-name-1.mmio.trace",
                "# COMPLETE frames=190 events=0 recorded=0",
                "# COMPLETE frames=190 events=1 recorded=0",
            )
            with self.assertRaisesRegex(ValueError, "MMIO trace coverage"):
                validate(root / "run.json")
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            path = root / "active-name-1.write.trace"
            lines = path.read_text().splitlines()
            footer = lines[-1].replace("events=207", "events=208")
            lines[-1:] = [
                "190,0x1C8CA,0xFF7B40,1,0xFF7B40,1,0x00,0x01", footer,
            ]
            path.write_text("\n".join(lines) + "\n")
            self.update_artifact(root, path.name)
            with self.assertRaisesRegex(ValueError, "name route reached racing hook"):
                validate(root / "run.json")

    def test_reset_trace_count_and_completion_fields_are_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = self.copy_evidence(temp)
            self.rewrite_text(
                root, "active-vres.debug.txt",
                "00 00 00 04 00 00 00 02", "00 00 00 04 00 00 00 03",
            )
            with self.assertRaisesRegex(ValueError, "Q21I sequence"):
                validate(root / "run.json")


if __name__ == "__main__":
    unittest.main()
