#!/usr/bin/env python3

import csv
from contextlib import redirect_stderr
import io
from pathlib import Path
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parent))

from validate_1p_control import (
    CANONICAL_CORE,
    CANONICAL_FRONTEND,
    DEFAULT_MANIFEST,
    Finding,
    Thresholds,
    analyze_artifacts,
    control_rom_policy,
    fixture_policy,
    main,
    parse_cli,
    reviewed_tool_policy,
    validate_input_script,
)


FRAME_FIELDS = [
    "frame", "m68k_cycles", "msh2_cycles", "ssh2_cycles", "m68k_useful",
    "msh2_useful", "ssh2_useful", "active", "fb_crc", "scene", "state", "is_32x",
]
WATCH_FIELDS = [
    "frame", "0xFF0002", "0x20004020", "0x20004023", "0x20004024", "0x2000402E",
]


class ControlValidationTests(unittest.TestCase):
    def write_artifacts(
        self,
        directory: Path,
        *,
        freeze_at: int | None = None,
        comm7_stuck_at: int | None = None,
    ) -> None:
        frames = 360
        with (directory / "frames.csv").open("w", newline="") as stream:
            writer = csv.DictWriter(stream, fieldnames=FRAME_FIELDS)
            writer.writeheader()
            for frame in range(frames):
                frozen = freeze_at is not None and frame >= freeze_at
                state = 0 if frozen else (0, 4, 8, 12)[frame % 4]
                fb_crc = 0x12345678 if frozen else 0x10000000 + frame
                writer.writerow(
                    {
                        "frame": frame, "m68k_cycles": 127000,
                        "msh2_cycles": 0 if frozen else 1000,
                        "ssh2_cycles": 0 if frozen else 2000,
                        "m68k_useful": 1,
                        "msh2_useful": 0 if frozen else 1,
                        "ssh2_useful": 0 if frozen else 1,
                        "active": 1, "fb_crc": f"0x{fb_crc:X}", "scene": "0x4CBC",
                        "state": f"0x{state:X}", "is_32x": 1,
                    }
                )
        with (directory / "watch.csv").open("w", newline="") as stream:
            writer = csv.DictWriter(stream, fieldnames=WATCH_FIELDS)
            writer.writeheader()
            for frame in range(frames):
                frozen = freeze_at is not None and frame >= freeze_at
                writer.writerow(
                    {
                        "frame": frame, "0xFF0002": "0x884CBC",
                        "0x20004020": "0x1" if frozen else "0x0",
                        "0x20004023": "0x0" if frozen else "0x1",
                        "0x20004024": "0x0",
                        "0x2000402E": "0x27" if comm7_stuck_at is not None and frame >= comm7_stuck_at else "0x0",
                    }
                )
        hook_limit = freeze_at if freeze_at is not None else frames
        hook_rows = list(range(2, hook_limit, 4))
        with (directory / "caller.csv").open("w") as stream:
            stream.write("# VRD_CALLER_TRACE addr=0x884D1A pc_enabled=1 max_hits=0\n")
            stream.write("frame,sp,return_addr\n")
            for frame in hook_rows:
                stream.write(f"{frame},0xFFF000,0xFF0006\n")
            stream.write(
                f"# COMPLETE frames={frames} hits={len(hook_rows)} "
                f"logged={len(hook_rows)} dropped=0\n"
            )

    def test_healthy_artifacts_pass(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            self.write_artifacts(directory)
            report = analyze_artifacts(
                directory,
                validation_frames=360,
                thresholds=Thresholds(window_frames=180),
                minimum_control_frames=0,
            )
            self.assertTrue(report.passed, report.findings)

    def test_freeze_has_attributable_failures(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            self.write_artifacts(directory, freeze_at=180)
            report = analyze_artifacts(
                directory,
                validation_frames=360,
                thresholds=Thresholds(window_frames=180),
                minimum_control_frames=0,
            )
            codes = {finding.code for finding in report.findings}
            self.assertTrue(
                {"state_stall", "hook_gap", "framebuffer_stall", "comm0_busy"}.issubset(codes),
                codes,
            )

    def test_short_synthetic_run_cannot_be_a_control(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            self.write_artifacts(directory)
            report = analyze_artifacts(
                directory,
                validation_frames=360,
                thresholds=Thresholds(window_frames=180),
            )
            self.assertIn("short_control_window", {item.code for item in report.findings})

    def test_incomplete_trace_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            self.write_artifacts(directory)
            caller = directory / "caller.csv"
            lines = caller.read_text().splitlines()
            caller.write_text("\n".join(lines[:-1]) + "\n")
            report = analyze_artifacts(
                directory,
                validation_frames=360,
                thresholds=Thresholds(window_frames=180),
                minimum_control_frames=0,
            )
            self.assertIn("caller_trace_incomplete", {item.code for item in report.findings})

    def test_stuck_comm7_word_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            self.write_artifacts(directory, comm7_stuck_at=180)
            report = analyze_artifacts(
                directory,
                validation_frames=360,
                thresholds=Thresholds(window_frames=180),
                minimum_control_frames=0,
            )
            self.assertIn("comm7_stuck", {item.code for item in report.findings})

    def test_forced_invalid_fixture_can_never_pass(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            self.write_artifacts(directory)
            report = analyze_artifacts(
                directory,
                validation_frames=360,
                thresholds=Thresholds(window_frames=180),
                forced_findings=[Finding("invalid_control_fixture", "known bad")],
                minimum_control_frames=0,
            )
            self.assertFalse(report.passed)

    def test_known_fixture_hash_is_manifest_invalid(self) -> None:
        fixture = Path(__file__).resolve().parent / "savestate_1p_gp_racing.bin"
        entry, digest = fixture_policy(fixture, DEFAULT_MANIFEST)
        self.assertEqual(
            digest, "67f715cdc48559b2be718bc580a7889d43005d70a4184f701815a77e425d69bb"
        )
        self.assertIsNotNone(entry)
        self.assertEqual(entry["status"], "invalid_control")

    def test_control_rom_requires_exact_live_reference_pair(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            candidate = Path(temp) / "candidate.32x"
            reference = Path(temp) / "reference.32x"
            image = bytearray(0x4D6A)
            image[0x4D62:0x4D6A] = bytes.fromhex("4EF90001C8B04E71")
            reference.write_bytes(image)
            image[0x4D62:0x4D6A] = bytes.fromhex("4EBA69764EBA691C")
            candidate.write_bytes(image)

            comparison = control_rom_policy(candidate, reference)
            self.assertTrue(comparison.eligible, comparison)
            self.assertEqual(comparison.outside_hook_difference_count, 0)

            image[0x100] ^= 0x01
            candidate.write_bytes(image)
            comparison = control_rom_policy(candidate, reference)
            self.assertFalse(comparison.eligible)
            self.assertEqual(comparison.outside_hook_difference_count, 1)
            self.assertEqual(comparison.first_outside_hook_difference, "0x100")

    def test_stock_candidate_cannot_be_its_own_reference(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            rom = Path(temp) / "stock.32x"
            image = bytearray(0x4D6A)
            image[0x4D62:0x4D6A] = bytes.fromhex("4EBA69764EBA691C")
            rom.write_bytes(image)
            comparison = control_rom_policy(rom, rom)
            self.assertFalse(comparison.eligible)
            self.assertIn("reference ROM", comparison.reason)

    def test_input_script_requires_every_frame_in_order(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            script = Path(temp) / "input.csv"
            script.write_text("frame,mask\n0,0x100\n1,0x140\n")
            digest = validate_input_script(script, 2)
            self.assertEqual(len(digest), 64)
            with self.assertRaisesRegex(ValueError, "expected exactly 3"):
                validate_input_script(script, 3)

    def test_live_run_rejects_preexisting_stale_output(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            output_dir = Path(temp) / "existing"
            output_dir.mkdir()
            stale = output_dir / "frames.csv"
            stale.write_text("stale artifacts must not be reused\n")
            errors = io.StringIO()
            with redirect_stderr(errors):
                status = main(
                    [
                        str(Path(temp) / "candidate.32x"),
                        "--reference-rom", str(Path(temp) / "reference.32x"),
                        "--output-dir", str(output_dir),
                    ]
                )
            self.assertEqual(status, 2)
            self.assertIn("[output_exists]", errors.getvalue())
            self.assertEqual(stale.read_text(), "stale artifacts must not be reused\n")

    def test_only_pinned_canonical_profiler_tools_are_eligible(self) -> None:
        canonical = reviewed_tool_policy(CANONICAL_FRONTEND, CANONICAL_CORE)
        self.assertTrue(canonical.eligible, canonical.reason)
        with tempfile.TemporaryDirectory() as temp:
            frontend = Path(temp) / "profiling_frontend"
            core = Path(temp) / "picodrive_libretro.so"
            frontend.write_bytes(CANONICAL_FRONTEND.read_bytes())
            core.write_bytes(CANONICAL_CORE.read_bytes())
            copied = reviewed_tool_policy(frontend, core)
            self.assertFalse(copied.eligible)
            self.assertIn("path is not canonical", copied.reason)

    def test_frontend_override_is_not_a_cli_option(self) -> None:
        errors = io.StringIO()
        with redirect_stderr(errors), self.assertRaises(SystemExit):
            parse_cli(
                [
                    "candidate.32x",
                    "--reference-rom", "reference.32x",
                    "--output-dir", "artifacts",
                    "--frontend", "/tmp/unreviewed-profiler",
                ]
            )
        self.assertIn("unrecognized arguments: --frontend", errors.getvalue())


if __name__ == "__main__":
    unittest.main()
