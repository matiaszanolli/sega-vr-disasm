#!/usr/bin/env python3
"""Adversarial tests for the fail-closed Q-027 v5 runtime gate."""

from __future__ import annotations

import csv
import json
import os
from pathlib import Path
import shutil
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import q027_cmd3f_runtime as runtime  # noqa: E402
import verify_q027_runtime_tools as tool_verifier  # noqa: E402


ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "analysis/evidence/vr60-q027-cmd3f-transport-gate/runtime"


class Q027RuntimeTests(unittest.TestCase):
    def clone_evidence(self) -> Path:
        temporary = Path(tempfile.mkdtemp(prefix="q027-runtime-test-", dir=ROOT / "build"))
        self.addCleanup(shutil.rmtree, temporary)
        destination = temporary / "runtime"
        shutil.copytree(EVIDENCE, destination, copy_function=os.link)
        return destination

    @staticmethod
    def detached_write(path: Path, data: bytes) -> None:
        path.unlink()
        path.write_bytes(data)

    def load_run(self, root: Path) -> dict[str, object]:
        return json.loads((root / "run.json").read_text())

    def write_run(self, root: Path, run: dict[str, object]) -> None:
        self.detached_write(
            root / "run.json",
            (json.dumps(run, indent=2, sort_keys=True) + "\n").encode(),
        )

    def rehash(self, root: Path, run: dict[str, object], name: str) -> None:
        path = root / name
        run["artifacts"][name] = {
            "size": path.stat().st_size,
            "sha256": runtime.sha256_path(path),
        }

    def mutate_csv(self, root: Path, run: dict[str, object], name: str,
                   frame: int, field: str, value: str) -> None:
        path = root / name
        with path.open() as stream:
            reader = csv.DictReader(stream)
            fields = reader.fieldnames
            rows = list(reader)
        self.assertIsNotNone(fields)
        matched = [row for row in rows if int(row["frame"]) == frame]
        self.assertEqual(len(matched), 1)
        matched[0][field] = value
        path.unlink()
        with path.open("w", newline="") as stream:
            writer = csv.DictWriter(stream, fieldnames=fields)
            writer.writeheader()
            writer.writerows(rows)
        self.rehash(root, run, name)

    def mutate_text(self, root: Path, run: dict[str, object], name: str,
                    old: str, new: str, count: int = 1) -> None:
        path = root / name
        text = path.read_text()
        self.assertEqual(text.count(old), count)
        self.detached_write(path, text.replace(old, new, count).encode())
        self.rehash(root, run, name)

    def assert_rejected(self, mutate) -> None:
        root = self.clone_evidence()
        run = self.load_run(root)
        mutate(root, run)
        self.write_run(root, run)
        with self.assertRaises((OSError, ValueError, json.JSONDecodeError)):
            runtime.validate(root / "run.json")
        self.assertFalse((root / "result.json").exists())

    def test_repository_archive_passes(self) -> None:
        self.assertEqual(runtime.validate(EVIDENCE / "run.json")["status"], "PASS")

    def test_manifest_policy_and_tool_mutations_fail(self) -> None:
        mutations = (
            lambda _r, run: run.__setitem__("frames", 1339),
            lambda _r, run: run["capture_modes"]["interpreter"].__setitem__(
                "schedule", [1262, 59, 19]
            ),
            lambda _r, run: run["capture_modes"]["drc"].__setitem__("sh2_drc", False),
            lambda _r, run: run["toolchain"].__setitem__("core", "0" * 64),
            lambda _r, run: run.__setitem__("promotable", True),
            lambda _r, run: run.__setitem__("authority_transferred", True),
            lambda _r, run: run.__setitem__("bridge_enabled", True),
            lambda _r, run: run.__setitem__("collision_enabled", True),
            lambda _r, run: run.__setitem__("cadence_changed", True),
            lambda _r, run: run.__setitem__("fps_claim", 60),
            lambda _r, run: run.__setitem__("cpu_budget_claim", "1%"),
        )
        for index, mutation in enumerate(mutations):
            with self.subTest(index=index):
                self.assert_rejected(mutation)

    def test_command_and_completion_mutations_fail(self) -> None:
        def command(root, run):
            self.mutate_text(root, run, "interpreter-active-1.commands",
                             "run 60\n", "run 59\n")

        def drc_command(root, run):
            self.mutate_text(root, run, "drc-active-1.commands",
                             "run 1340\n", "run 1339\n")

        def fatal(root, run):
            name = "interpreter-active-1.debug.txt"
            path = root / name
            self.detached_write(path, path.read_bytes() + b"segmentation fault\n")
            self.rehash(root, run, name)

        for mutation in (command, drc_command, fatal):
            with self.subTest(mutation=mutation.__name__):
                self.assert_rejected(mutation)

    def test_profile_coverage_mutations_fail(self) -> None:
        def missing(root, run):
            self.mutate_csv(root, run, "interpreter-active-1.profile.csv",
                            100, "frame", "101")

        def duplicate(root, run):
            self.mutate_csv(root, run, "drc-active-1.profile.csv",
                            101, "frame", "100")

        def reordered(root, run):
            name = "interpreter-active-1.profile.csv"
            path = root / name
            lines = path.read_text().splitlines()
            lines[50], lines[51] = lines[51], lines[50]
            self.detached_write(path, ("\n".join(lines) + "\n").encode())
            self.rehash(root, run, name)

        def watch_missing(root, run):
            self.mutate_csv(root, run, "drc-active-1.watch.csv", 100, "frame", "101")

        for mutation in (missing, duplicate, reordered, watch_missing):
            with self.subTest(mutation=mutation.__name__):
                self.assert_rejected(mutation)

    def paired_profile_mutation(self, root: Path, run: dict[str, object], mode: str,
                                frame: int, field: str, value: str) -> None:
        for repeat in runtime.REPEATS:
            self.mutate_csv(root, run, f"{mode}-active-{repeat}.profile.csv",
                            frame, field, value)

    def test_interpreter_crc_boundary_mutations_fail(self) -> None:
        def removed(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1266,
                                         "fb_crc", "0xD08BAC75")

        def added(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1267,
                                         "fb_crc", "0x00000000")

        def shifted(root, run):
            removed(root, run)
            self.paired_profile_mutation(root, run, "interpreter", 1267,
                                         "fb_crc", "0x344A67A6")

        def changed(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1266,
                                         "fb_crc", "0x344A67A7")

        def late_redivergence(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1339,
                                         "fb_crc", "0x00000000")

        for mutation in (removed, added, shifted, changed, late_redivergence):
            with self.subTest(mutation=mutation.__name__):
                self.assert_rejected(mutation)

    def test_interpreter_cycle_and_common_field_mutations_fail(self) -> None:
        def cycle_value(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1264,
                                         "msh2_cycles", "17730")

        def cycle_position(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1270,
                                         "msh2_cycles", "15567")

        def after_boundary(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1339,
                                         "ssh2_cycles", "306772")

        def m68k(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1266,
                                         "m68k_cycles", "0")

        def state(root, run):
            self.paired_profile_mutation(root, run, "interpreter", 1266,
                                         "state", "0x0000")

        for mutation in (cycle_value, cycle_position, after_boundary, m68k, state):
            with self.subTest(mutation=mutation.__name__):
                self.assert_rejected(mutation)

    def test_drc_exact_table_mutations_fail(self) -> None:
        def crc(root, run):
            self.paired_profile_mutation(root, run, "drc", 1262,
                                         "fb_crc", "0x00000000")

        def second_row(root, run):
            self.paired_profile_mutation(root, run, "drc", 1263,
                                         "msh2_cycles", "1")

        def cycle_value(root, run):
            self.paired_profile_mutation(root, run, "drc", 1262,
                                         "ssh2_cycles", "306555")

        def late(root, run):
            self.paired_profile_mutation(root, run, "drc", 1339,
                                         "ssh2_cycles", "0")

        for mutation in (crc, second_row, cycle_value, late):
            with self.subTest(mutation=mutation.__name__):
                self.assert_rejected(mutation)

    def test_display_write_caller_and_repeat_mutations_fail(self) -> None:
        def watch(root, run):
            for repeat in runtime.REPEATS:
                self.mutate_csv(root, run, f"interpreter-active-{repeat}.watch.csv",
                                1266, "0xFFC80C", "0xFF")

        def fbctl(root, run):
            for repeat in runtime.REPEATS:
                self.mutate_csv(root, run, f"interpreter-active-{repeat}.watch.csv",
                                1266, "0x2000410A", "0xFFFF")

        def write(root, run):
            for repeat in runtime.REPEATS:
                self.mutate_text(root, run, f"interpreter-active-{repeat}.write.trace",
                                 "1264,0x01C95A,0xFF7B40", "1265,0x01C95A,0xFF7B40")

        def caller(root, run):
            for repeat in runtime.REPEATS:
                self.mutate_text(root, run, f"drc-active-{repeat}.caller.trace",
                                 "1262,0x00884CBC", "1262,0x00884CBE")

        def repeat(root, run):
            self.mutate_csv(root, run, "interpreter-active-2.profile.csv",
                            1000, "m68k_cycles", "0")

        for mutation in (watch, fbctl, write, caller, repeat):
            with self.subTest(mutation=mutation.__name__):
                self.assert_rejected(mutation)

    def test_seed_protocol_mailbox_and_diagnostic_mutations_fail(self) -> None:
        def seed(root, run):
            for repeat in runtime.REPEATS:
                name = f"interpreter-active-{repeat}.debug.txt"
                self.mutate_text(root, run, name, "00FF6A00: 00 00",
                                 "00FF6A00: 01 00", 2)

        def protocol(root, run):
            for repeat in runtime.REPEATS:
                name = f"interpreter-active-{repeat}.mmio.trace"
                path = root / name
                lines = path.read_text().splitlines()
                matches = [index for index, line in enumerate(lines)
                           if ",m68k,0x0001C98A,write,0x00A15120,2,0x13F" in line]
                self.assertEqual(len(matches), 1)
                lines[matches[0]] = lines[matches[0]].replace("0x13F", "0x13E")
                self.detached_write(path, ("\n".join(lines) + "\n").encode())
                self.rehash(root, run, name)

        def transaction_frame(root, run):
            for repeat in runtime.REPEATS:
                name = f"interpreter-active-{repeat}.mmio.trace"
                path = root / name
                lines = path.read_text().splitlines()
                matches = [index for index, line in enumerate(lines)
                           if ",1264,m68k,0x0001C96A,write,0x00A15103,1,0x1" in line]
                self.assertEqual(len(matches), 1)
                lines[matches[0]] = lines[matches[0]].replace(
                    ",1264,m68k,", ",1265,m68k,"
                )
                self.detached_write(path, ("\n".join(lines) + "\n").encode())
                self.rehash(root, run, name)

        def drc_transaction_frame(root, run):
            for repeat in runtime.REPEATS:
                name = f"drc-active-{repeat}.write.trace"
                self.mutate_text(root, run, name,
                                 "1262,0x01C95A,0xFF7B40",
                                 "1263,0x01C95A,0xFF7B40")

        def observer_error(root, run):
            for repeat in runtime.REPEATS:
                name = f"interpreter-active-{repeat}.mmio.trace"
                self.mutate_text(root, run, name, "dropped=0", "dropped=1")

        def mailbox(root, run):
            for repeat in runtime.REPEATS:
                name = f"interpreter-active-{repeat}.debug.txt"
                self.mutate_text(root, run, name,
                                 "2600BC00: 51 32 37 4D", "2600BC00: 50 32 37 4D", 2)

        def terminal(root, run):
            for repeat in runtime.REPEATS:
                name = f"interpreter-active-{repeat}.debug.txt"
                self.mutate_text(root, run, name, "PC=0600450A", "PC=0600450C", 2)

        def diagnostic(root, run):
            label = "convergence-diagnostic"
            relative = next(iter(run["diagnostics"][label]["files"]))
            path = root / "diagnostics" / label / relative
            data = path.read_bytes()
            self.detached_write(path, data + b"x")

        for mutation in (
            seed, protocol, transaction_frame, drc_transaction_frame, observer_error,
            mailbox, terminal, diagnostic,
        ):
            with self.subTest(mutation=mutation.__name__):
                self.assert_rejected(mutation)

    def test_runtime_tool_verifier_rejects_source_mutation(self) -> None:
        temporary = Path(tempfile.mkdtemp(prefix="q027-tool-test-"))
        self.addCleanup(shutil.rmtree, temporary)
        tool_root = temporary / "tools/libretro-profiling"
        source_root = temporary / "third_party/picodrive"
        tool_root.mkdir(parents=True)
        for name in ("profiling_frontend.c", "prepare_q027_picodrive.py",
                     "q027_cmd3f_runtime.py"):
            shutil.copy2(ROOT / "tools/libretro-profiling" / name, tool_root / name)
        for relative in tool_verifier.SOURCE_SHA256:
            destination = source_root / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(ROOT / "third_party/picodrive" / relative, destination)
        frontend = temporary / "frontend"
        core = temporary / "core"
        shutil.copy2(ROOT / "tools/libretro-profiling/q027_profiling_frontend", frontend)
        shutil.copy2(ROOT / "tools/libretro-profiling/q027_picodrive_libretro.so", core)
        runtime_source = tool_root / "q027_cmd3f_runtime.py"
        runtime_source.write_bytes(runtime_source.read_bytes() + b"\n")
        with self.assertRaises(ValueError):
            tool_verifier.verify(frontend, core, temporary)


if __name__ == "__main__":
    unittest.main()
