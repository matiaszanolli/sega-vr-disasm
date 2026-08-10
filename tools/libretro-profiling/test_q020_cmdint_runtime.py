#!/usr/bin/env python3
"""Adversarial tests for the Q-020 runtime capture validator."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
import shutil
import sys
import tempfile
import unittest


SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parent.parent
sys.path.insert(0, str(SCRIPT_DIR))

from q020_cmdint_runtime import prepare_name_fixture, require_healthy_log, validate


class Q020CmdintRuntimeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.capture = (
            REPO_ROOT / "analysis/evidence/vr60-q020-cmdint-probe/runtime"
        )
        cls.run_path = cls.capture / "run.json"
        if not cls.run_path.is_file():
            raise RuntimeError(f"required runtime capture is missing: {cls.run_path}")

    @staticmethod
    def _rehash_artifact(directory: Path, payload: dict, name: str) -> None:
        data = (directory / name).read_bytes()
        payload["artifacts"][name]["size"] = len(data)
        payload["artifacts"][name]["sha256"] = hashlib.sha256(data).hexdigest()

    def _copy_capture(self, root: Path) -> tuple[Path, dict]:
        directory = root / "runtime"
        shutil.copytree(self.capture, directory)
        run = directory / "run.json"
        return run, json.loads(run.read_text())

    def test_repository_capture_passes(self) -> None:
        result = validate(self.run_path)
        self.assertEqual(result["status"], "PASS")
        self.assertTrue(result["non_promotable"])
        self.assertFalse(result["organic_gameplay"])
        self.assertTrue(result["default_reset_baseline_compared"])

    def test_seeded_name_fixture_reproduces_exactly(self) -> None:
        payload = json.loads(self.run_path.read_text())
        with tempfile.TemporaryDirectory() as temp:
            output = Path(temp) / "seeded.mds"
            changes = prepare_name_fixture(self.capture / "name-source.mds", output)
            self.assertEqual(changes, payload["name_fixture"]["changes"])
            self.assertEqual(output.read_bytes(), (self.capture / "name-route-seeded.mds").read_bytes())

    def test_artifact_tamper_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            run, _ = self._copy_capture(Path(temp))
            path = run.parent / "name-input.csv"
            path.write_bytes(path.read_bytes() + b"\n")
            with self.assertRaisesRegex(ValueError, "artifact identity"):
                validate(run)

    def test_missing_artifact_metadata_fails_with_file_present(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            run, payload = self._copy_capture(Path(temp))
            self.assertTrue((run.parent / "normal-write.trace").is_file())
            del payload["artifacts"]["normal-write.trace"]
            run.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
            with self.assertRaisesRegex(ValueError, "artifact set: missing"):
                validate(run)

    def test_incomplete_trace_sequence_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            run, payload = self._copy_capture(Path(temp))
            path = run.parent / "cold-normal-vres.txt"
            lines = path.read_text().splitlines(keepends=True)
            starts = [index for index, line in enumerate(lines) if "2600BC20:" in line]
            self.assertEqual(len(starts), 3)
            del lines[starts[2] : starts[2] + 4]
            path.write_text("".join(lines))
            self._rehash_artifact(run.parent, payload, path.name)
            run.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
            with self.assertRaisesRegex(ValueError, "checkpoint count"):
                validate(run)

    def test_scope_claim_tamper_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            run, payload = self._copy_capture(Path(temp))
            payload["organic_gameplay"] = True
            run.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
            with self.assertRaisesRegex(ValueError, "runtime scope flags"):
                validate(run)

    def test_seeded_fixture_transformation_claim_tamper_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            run, payload = self._copy_capture(Path(temp))
            payload["name_fixture"]["changes"][0]["reason"] = "unreviewed change"
            run.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
            with self.assertRaisesRegex(ValueError, "name fixture transformation"):
                validate(run)

    def test_arbitrary_unhandled_opcode_is_fatal(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / "runtime.txt"
            path.write_text(
                "Core reset at session frame: 1241\n"
                "ssh2 drc: unhandled op 1234 @ 06000000\n"
                "00000:000: 32X shutdown\n"
            )
            with self.assertRaisesRegex(ValueError, "scoped reset warning mismatch"):
                require_healthy_log(path, allow_scoped_reset_warning=True)


if __name__ == "__main__":
    unittest.main()
