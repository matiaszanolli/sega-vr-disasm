"""Focused artifact tests for the separate VR60-011 lifecycle policy."""

from __future__ import annotations

import copy
import csv
import io
import json
import sys
import tempfile
import unittest
from contextlib import redirect_stderr
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parent))

from validate_1p_control import (
    CANONICAL_CORE,
    CANONICAL_CORE_SHA256,
    CANONICAL_FRONTEND,
    CANONICAL_FRONTEND_SHA256,
    DEFAULT_HOOK_ADDRESS,
    DEFAULT_HOOK_RETURN,
    DEFAULT_MANIFEST,
    DEFAULT_SCENE_POINTER,
    HOOK_SITE_LIVE_BYTES,
    HOOK_SITE_OFFSET,
    HOOK_SITE_STOCK_BYTES,
    fixture_policy,
    sha256_file,
)
from validate_1p_lifecycle_suite import (
    LIFECYCLE_WATCH_SPEC,
    MIN_AGGREGATE_ACTIVE_FRAMES,
    POLICY_ID,
    RESULTS_SCENE_POINTER,
    RESULTS_SCENE_WRITER_PC,
    SCHEMA_VERSION,
    STATE_WRITE_CYCLE,
    TIMEOUT_DISPLAY_SEQUENCE,
    TIMEOUT_DISPLAY_WRITE_SIGNATURE,
    TIMEOUT_ENTRY_PC,
    WARMUP_FRAMES,
    WRITE_TRACE_SPEC,
    analyze_suite,
    capture_fixture,
    expected_run_provenance,
    load_lifecycle_caller_trace,
    load_write_trace,
    run_lifecycle_capture,
)

FRAME_FIELDS = [
    "frame", "m68k_cycles", "msh2_cycles", "ssh2_cycles", "m68k_useful",
    "msh2_useful", "ssh2_useful", "active", "fb_crc", "scene", "state", "is_32x",
]
WATCH_FIELDS = [
    "frame", "0xFF0002", "0x20004020", "0x20004023", "0x20004024",
    "0x2000402E", "0xFFC050", "0xFFC07C", "0xFFEF07", "0xFFFEB7", "0xFFFDA8",
]


class LifecycleSuiteTests(unittest.TestCase):
    def write_rom_pair(self, root: Path) -> tuple[Path, Path]:
        candidate = root / "control.32x"
        reference = root / "live.32x"
        image = bytearray(HOOK_SITE_OFFSET + len(HOOK_SITE_STOCK_BYTES))
        image[HOOK_SITE_OFFSET:] = HOOK_SITE_STOCK_BYTES
        candidate.write_bytes(image)
        image[HOOK_SITE_OFFSET:] = HOOK_SITE_LIVE_BYTES
        reference.write_bytes(image)
        return candidate, reference

    def write_fixture(
        self,
        root: Path,
        fixture_id: str,
        rom: Path,
        reference: Path,
        *,
        boundary: int = WARMUP_FRAMES + 3961,
    ) -> dict[str, object]:
        scene_frame = boundary + len(TIMEOUT_DISPLAY_SEQUENCE)
        total_frames = scene_frame + 2
        artifact_dir = root / f"{fixture_id}-artifacts"
        artifact_dir.mkdir()
        savestate = root / f"{fixture_id}.mds"
        savestate.write_bytes(f"state:{fixture_id}".encode())
        source_capture = root / f"{fixture_id}-source.replay"
        source_capture.write_bytes(f"source:{fixture_id}".encode())
        input_script = root / f"{fixture_id}-input.csv"
        input_mask = 0x100 + int(fixture_id.removeprefix("fixture"))
        with input_script.open("w", newline="") as stream:
            writer = csv.writer(stream)
            writer.writerow(("frame", "mask"))
            for frame in range(total_frames):
                writer.writerow((frame, f"0x{input_mask:X}"))

        with (artifact_dir / "frames.csv").open("w", newline="") as stream:
            writer = csv.DictWriter(stream, fieldnames=FRAME_FIELDS)
            writer.writeheader()
            for frame in range(total_frames):
                scene = (
                    DEFAULT_SCENE_POINTER
                    if frame < scene_frame
                    else RESULTS_SCENE_POINTER
                )
                writer.writerow(
                    {
                        "frame": frame,
                        "m68k_cycles": 127000,
                        "msh2_cycles": 1000,
                        "ssh2_cycles": 2000,
                        "m68k_useful": 1,
                        "msh2_useful": 1,
                        "ssh2_useful": 1,
                        "active": 1,
                        "fb_crc": f"0x{0x10000000 + frame:X}",
                        "scene": f"0x{scene & 0xFFFF:X}",
                        "state": f"0x{(0, 4, 8, 12)[frame % 4]:X}",
                        "is_32x": 1,
                    }
                )

        with (artifact_dir / "watch.csv").open("w", newline="") as stream:
            writer = csv.DictWriter(stream, fieldnames=WATCH_FIELDS)
            writer.writeheader()
            for frame in range(total_frames):
                scene = (
                    DEFAULT_SCENE_POINTER
                    if frame < scene_frame
                    else RESULTS_SCENE_POINTER
                )
                if frame < boundary:
                    display_state = 0x00
                elif frame < scene_frame:
                    display_state = TIMEOUT_DISPLAY_SEQUENCE[frame - boundary]
                else:
                    display_state = TIMEOUT_DISPLAY_SEQUENCE[-1]
                writer.writerow(
                    {
                        "frame": frame,
                        "0xFF0002": f"0x{scene:X}",
                        "0x20004020": "0x0",
                        "0x20004023": "0x1",
                        "0x20004024": "0x0",
                        "0x2000402E": "0x0",
                        "0xFFC050": (
                            "0xFFFF" if frame == boundary - 1
                            else "0x0" if frame >= boundary
                            else "0x4B"
                        ),
                        "0xFFC07C": f"0x{display_state:X}",
                        "0xFFEF07": "0x0",
                        "0xFFFEB7": "0x0",
                        "0xFFFDA8": "0x0",
                    }
                )

        hook_frames = list(range(2, total_frames, 4))
        with (artifact_dir / "caller.csv").open("w") as stream:
            stream.write(
                f"# VRD_CALLER_TRACE version=2 addr=0x{DEFAULT_HOOK_ADDRESS:08X} "
                "sh2_drc=1 profile_pc=0 profile_pc_env=0 m68k_batching=normal "
                "instruction_start_hook=1 composed=1 max_hits=0\n"
            )
            stream.write("frame,pc,sp,return_addr\n")
            for frame in hook_frames:
                stream.write(
                    f"{frame},0x{DEFAULT_HOOK_ADDRESS:08X},0xFFF000,"
                    f"0x{DEFAULT_HOOK_RETURN:X}\n"
                )
            stream.write(
                f"# COMPLETE frames={total_frames} hits={len(hook_frames)} "
                f"logged={len(hook_frames)} dropped=0 errors=0\n"
            )

        write_rows = [
            (
                f"{frame},0x{pc:08X},0xFFC87E,2,0xFFC87E,2,"
                f"0x{previous:04X},0x{new_value:04X}"
            )
            for frame in range(boundary)
            for pc, previous, new_value in (STATE_WRITE_CYCLE[frame % len(STATE_WRITE_CYCLE)],)
        ]
        for offset, (pc, previous, new_value) in enumerate(
            TIMEOUT_DISPLAY_WRITE_SIGNATURE
        ):
            frame = boundary + offset
            write_rows.append(
                f"{frame},0x{pc:08X},0xFFC07C,2,0xFFC07C,2,"
                f"0x{previous:04X},0x{new_value:04X}"
            )
            previous = new_value
        write_rows.append(
            f"{scene_frame},0x{RESULTS_SCENE_WRITER_PC:08X},0xFF0002,4,"
            f"0xFF0002,4,0x{DEFAULT_SCENE_POINTER:08X},0x{RESULTS_SCENE_POINTER:08X}"
        )
        with (artifact_dir / "write.csv").open("w") as stream:
            stream.write(
                "# VRD_WRITE_TRACE version=3 sh2_drc=1 profile_pc=0 "
                "profile_pc_env=0 m68k_batching=normal instruction_start_hook=1 "
                f"composed=1 caller_addr=0x{DEFAULT_HOOK_ADDRESS:08X} "
                "caller_max=0 targets=3\n"
                "# TARGET index=0 addr=0xFFC87E size=2\n"
                "# TARGET index=1 addr=0xFFC07C size=2\n"
                "# TARGET index=2 addr=0xFF0002 size=4\n"
                "frame,pc,target_addr,target_size,access_addr,access_size,old_value,new_value\n"
            )
            stream.write("\n".join(write_rows) + "\n")
            stream.write(
                f"# COMPLETE frames={total_frames} events={len(write_rows)} errors=0\n"
            )
        (artifact_dir / "frontend.log").write_text("synthetic reviewed capture\n")

        run = expected_run_provenance(
            rom_path=rom,
            rom_sha256=sha256_file(rom),
            reference_path=reference,
            reference_sha256=sha256_file(reference),
            savestate_path=savestate,
            savestate_sha256=sha256_file(savestate),
            input_path=input_script,
            input_sha256=sha256_file(input_script),
            source_capture_path=source_capture,
            source_capture_sha256=sha256_file(source_capture),
            total_frames=total_frames,
            expected_terminal_entry_frame=boundary,
            expected_results_scene_frame=scene_frame,
            frontend_exit_code=0,
        )
        (artifact_dir / "run.json").write_text(json.dumps(run, indent=2) + "\n")
        artifact_hashes = {
            name: sha256_file(artifact_dir / name)
            for name in (
                "run.json", "frames.csv", "watch.csv", "caller.csv",
                "write.csv", "frontend.log",
            )
        }
        return {
            "id": fixture_id,
            "artifact_dir": str(artifact_dir),
            "savestate": {
                "path": str(savestate),
                "sha256": sha256_file(savestate),
            },
            "input_script": {
                "path": str(input_script),
                "sha256": sha256_file(input_script),
            },
            "source_capture": {
                "path": str(source_capture),
                "sha256": sha256_file(source_capture),
            },
            "total_frames": total_frames,
            "expected_terminal_entry_frame": boundary,
            "expected_results_scene_frame": scene_frame,
            "artifacts": artifact_hashes,
        }

    def write_suite(
        self,
        root: Path,
        *,
        fixture_count: int = 5,
        boundary: int | None = None,
        final_boundary: int | None = None,
    ) -> tuple[Path, dict[str, object]]:
        rom, reference = self.write_rom_pair(root)
        fixtures = []
        for index in range(fixture_count):
            fixture_boundary = (
                final_boundary
                if final_boundary is not None and index == fixture_count - 1
                else boundary if boundary is not None
                else WARMUP_FRAMES + 3961
            )
            fixtures.append(
                self.write_fixture(
                    root, f"fixture{index}", rom, reference, boundary=fixture_boundary
                )
            )
        manifest = {
            "schema": SCHEMA_VERSION,
            "policy_id": POLICY_ID,
            "diagnostic": False,
            "rom": {"path": str(rom), "sha256": sha256_file(rom)},
            "reference_rom": {
                "path": str(reference),
                "sha256": sha256_file(reference),
            },
            "frontend": {
                "path": str(CANONICAL_FRONTEND.resolve()),
                "sha256": CANONICAL_FRONTEND_SHA256,
            },
            "core": {
                "path": str(CANONICAL_CORE.resolve()),
                "sha256": CANONICAL_CORE_SHA256,
            },
            "fixtures": fixtures,
        }
        manifest_path = root / "suite.json"
        manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")
        return manifest_path, manifest

    def rewrite_manifest(self, path: Path, manifest: dict[str, object]) -> None:
        path.write_text(json.dumps(manifest, indent=2) + "\n")

    def refresh_artifact_hash(
        self,
        manifest: dict[str, object],
        fixture_index: int,
        name: str,
    ) -> None:
        fixture = manifest["fixtures"][fixture_index]
        artifact = Path(fixture["artifact_dir"]) / name
        fixture["artifacts"][name] = sha256_file(artifact)

    def insert_scene_write(
        self,
        manifest: dict[str, object],
        fixture_index: int,
        row: str,
        *,
        after_terminal: bool = False,
    ) -> None:
        fixture = manifest["fixtures"][fixture_index]
        write_path = Path(fixture["artifact_dir"]) / "write.csv"
        lines = write_path.read_text().splitlines()
        terminal_index = next(
            index
            for index, line in enumerate(lines)
            if f",0x{RESULTS_SCENE_WRITER_PC:08X},0xFF0002,4," in line
        )
        lines.insert(terminal_index + int(after_terminal), row)
        complete = lines[-1].split()
        event_field = next(
            index for index, field in enumerate(complete) if field.startswith("events=")
        )
        event_count = int(complete[event_field].removeprefix("events=")) + 1
        complete[event_field] = f"events={event_count}"
        lines[-1] = " ".join(complete)
        write_path.write_text("\n".join(lines) + "\n")
        self.refresh_artifact_hash(manifest, fixture_index, "write.csv")

    def rewrite_write_rows(
        self,
        manifest: dict[str, object],
        fixture_index: int,
        transform,
    ) -> None:
        fixture = manifest["fixtures"][fixture_index]
        write_path = Path(fixture["artifact_dir"]) / "write.csv"
        lines = write_path.read_text().splitlines()
        prefix = lines[:5]
        rows = lines[5:-1]
        rewritten = transform(rows)
        footer = lines[-1].split()
        event_field = next(
            index for index, field in enumerate(footer) if field.startswith("events=")
        )
        footer[event_field] = f"events={len(rewritten)}"
        write_path.write_text("\n".join([*prefix, *rewritten, " ".join(footer)]) + "\n")
        self.refresh_artifact_hash(manifest, fixture_index, "write.csv")

    def fixture_codes(self, report, index: int) -> set[str]:
        return {finding.code for finding in report.fixtures[index].findings}

    def rewrite_caller(
        self,
        manifest: dict[str, object],
        fixture_index: int,
        transform,
    ) -> None:
        fixture = manifest["fixtures"][fixture_index]
        caller_path = Path(fixture["artifact_dir"]) / "caller.csv"
        caller_path.write_text(transform(caller_path.read_text()))
        self.refresh_artifact_hash(manifest, fixture_index, "caller.csv")

    def test_valid_aggregate_passes_and_checks_one_frame_tail(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, _manifest = self.write_suite(Path(temp))
            report = analyze_suite(manifest_path)
            self.assertTrue(report.passed, report.to_json())
            self.assertGreaterEqual(
                report.metrics["aggregate_eligible_active_frames"],
                MIN_AGGREGATE_ACTIVE_FRAMES,
            )
            self.assertTrue(
                all(
                    fixture.metrics["final_partial_window_frames"] == 1
                    for fixture in report.fixtures
                )
            )

    def test_json_schema_matches_v2_policy_and_no_pc_artifact(self) -> None:
        schema_path = (
            Path(__file__).resolve().parent / "vr60_lifecycle_suite.schema.json"
        )
        schema = json.loads(schema_path.read_text())
        self.assertEqual(schema["properties"]["schema"]["const"], SCHEMA_VERSION)
        self.assertEqual(schema["properties"]["policy_id"]["const"], POLICY_ID)
        artifacts = schema["$defs"]["artifacts"]
        self.assertNotIn("pc.csv", artifacts["required"])
        self.assertNotIn("pc.csv", artifacts["properties"])

    def test_bad_window_splice_cannot_be_averaged_away(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            self.rewrite_write_rows(
                manifest,
                0,
                lambda rows: [
                    row
                    for row in rows
                    if not (
                        row.split(",")[2] == "0xFFC87E"
                        and 900 <= int(row.split(",")[0]) < 1100
                    )
                ],
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertFalse(report.passed)
            self.assertTrue(
                {"state_write_stall", "state_write_window"} & self.fixture_codes(report, 0),
                report.to_json(),
            )
            self.assertEqual(report.metrics["eligible_distinct_lifecycles"], 4)

    def test_duplicate_fixture_and_source_capture_do_not_inflate_coverage(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp), fixture_count=4)
            duplicate = copy.deepcopy(manifest["fixtures"][0])
            duplicate["id"] = "fixture-duplicate"
            manifest["fixtures"].append(duplicate)
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 4)
            self.assertIn("duplicate_fixture_identity", codes)
            self.assertIn("duplicate_source_capture", codes)
            self.assertEqual(report.metrics["eligible_distinct_lifecycles"], 4)
            self.assertIn(
                "insufficient_aggregate_coverage",
                {finding.code for finding in report.findings},
            )

    def test_unknown_terminal_scene_writer_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            write_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "write.csv"
            write_path.write_text(
                write_path.read_text().replace(
                    f"0x{RESULTS_SCENE_WRITER_PC:08X}",
                    f"0x{RESULTS_SCENE_WRITER_PC + 2:08X}",
                )
            )
            self.refresh_artifact_hash(manifest, 0, "write.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("terminal_scene_signature", self.fixture_codes(report, 0))

    def test_same_value_scene_write_before_exit_is_allowed(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            fixture = manifest["fixtures"][0]
            frame = fixture["expected_results_scene_frame"] - 1
            self.insert_scene_write(
                manifest,
                0,
                f"{frame},0x001234,0xFF0002,4,0xFF0002,4,"
                f"0x{DEFAULT_SCENE_POINTER:08X},0x{DEFAULT_SCENE_POINTER:08X}",
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertTrue(report.fixtures[0].passed, report.to_json())

    def test_different_scene_transition_before_exit_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            fixture = manifest["fixtures"][0]
            frame = fixture["expected_results_scene_frame"] - 1
            self.insert_scene_write(
                manifest,
                0,
                f"{frame},0x001234,0xFF0002,4,0xFF0002,4,"
                f"0x{DEFAULT_SCENE_POINTER:08X},0x00890000",
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("preterminal_scene_transition", self.fixture_codes(report, 0))

    def test_duplicate_reviewed_scene_transition_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            fixture = manifest["fixtures"][0]
            frame = fixture["expected_results_scene_frame"]
            self.insert_scene_write(
                manifest,
                0,
                f"{frame},0x{RESULTS_SCENE_WRITER_PC:08X},0xFF0002,4,"
                f"0xFF0002,4,0x{DEFAULT_SCENE_POINTER:08X},"
                f"0x{RESULTS_SCENE_POINTER:08X}",
                after_terminal=True,
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("terminal_scene_signature", self.fixture_codes(report, 0))

    def test_early_exit_fails_minimum_active_span(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, _manifest = self.write_suite(
                Path(temp), fixture_count=5, final_boundary=1000
            )
            report = analyze_suite(manifest_path)
            self.assertIn("lifecycle_active_span", self.fixture_codes(report, 4))

    def test_predeclared_terminal_boundary_must_match_trace(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            manifest["fixtures"][0]["expected_terminal_entry_frame"] -= 1
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("terminal_boundary_mismatch", self.fixture_codes(report, 0))

    def test_incomplete_write_trace_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            write_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "write.csv"
            lines = write_path.read_text().splitlines()
            lines[-1] = "# INCOMPLETE frames=4330 events=9 errors=0 reason=core_deinit"
            write_path.write_text("\n".join(lines) + "\n")
            self.refresh_artifact_hash(manifest, 0, "write.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("artifact_parse", self.fixture_codes(report, 0))

    def test_write_trace_parser_rejects_duplicate_and_trailing_records(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            _manifest_path, manifest = self.write_suite(root)
            source = Path(manifest["fixtures"][0]["artifact_dir"]) / "write.csv"
            lines = source.read_text().splitlines()
            variants = {
                "duplicate_init": lines[:1] + lines,
                "duplicate_target": lines[:2] + [lines[1]] + lines[2:],
                "reordered_targets": [lines[0], lines[2], lines[1], *lines[3:]],
                "remapped_target": [
                    lines[0],
                    lines[1].replace("0xFFC87E", "0xFFC07C"),
                    *lines[2:],
                ],
                "duplicate_header": lines[:5] + [lines[4]] + lines[5:],
                "duplicate_footer": lines + [lines[-1]],
                "trailing_data": lines + [lines[5]],
                "unknown_comment": lines[:5] + ["# UNREVIEWED note"] + lines[5:],
            }
            for name, variant in variants.items():
                with self.subTest(name=name):
                    trace = root / f"{name}.csv"
                    trace.write_text("\n".join(variant) + "\n")
                    with self.assertRaises(ValueError):
                        load_write_trace(trace)

    def test_caller_parser_rejects_malformed_duplicate_reordered_incomplete_and_trailing(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            _manifest_path, manifest = self.write_suite(root, fixture_count=1)
            source = Path(manifest["fixtures"][0]["artifact_dir"]) / "caller.csv"
            lines = source.read_text().splitlines()
            variants = {
                "malformed": [*lines[:2], "2,0x884D1A", *lines[3:]],
                "duplicate_init": [lines[0], *lines],
                "duplicate_header": [*lines[:2], lines[1], *lines[2:]],
                "reordered_rows": [*lines[:2], lines[3], lines[2], *lines[4:]],
                "incomplete": lines[:-1],
                "incomplete_footer": [
                    *lines[:-1],
                    "# INCOMPLETE frames=10 hits=2 logged=2 dropped=0 errors=0 reason=core_deinit",
                ],
                "trailing": [*lines, lines[2]],
                "duplicate_footer": [*lines, lines[-1]],
            }
            for name, variant in variants.items():
                with self.subTest(name=name):
                    trace = root / f"caller-{name}.csv"
                    trace.write_text("\n".join(variant) + "\n")
                    with self.assertRaises(ValueError):
                        load_lifecycle_caller_trace(trace)

    def test_caller_requires_exact_return_and_zero_drops(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            self.rewrite_caller(
                manifest,
                0,
                lambda text: text.replace(
                    f"0x{DEFAULT_HOOK_RETURN:X}",
                    f"0x{DEFAULT_HOOK_RETURN + 2:X}",
                ).replace("dropped=0 errors=0", "dropped=1 errors=0"),
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 0)
            self.assertIn("wrong_hook_caller", codes)
            self.assertIn("caller_trace_incomplete", codes)

    def test_composed_hook_requires_exact_caller_and_write_pcs(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            self.rewrite_caller(
                manifest,
                0,
                lambda text: text.replace(
                    f"{WARMUP_FRAMES + 2},0x{DEFAULT_HOOK_ADDRESS:08X}",
                    f"{WARMUP_FRAMES + 2},0x{DEFAULT_HOOK_ADDRESS + 2:08X}",
                ),
            )
            self.rewrite_write_rows(
                manifest,
                0,
                lambda rows: [
                    (
                        row.replace("0x00884CF2", "0x00884CF4")
                        if row.startswith(f"{WARMUP_FRAMES},")
                        else row
                    )
                    for row in rows
                ],
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 0)
            self.assertIn("wrong_hook_pc", codes)
            self.assertIn("state_write_unknown", codes)

    def test_caller_pc_and_return_are_exact_before_warmup(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            self.rewrite_caller(
                manifest,
                0,
                lambda text: text.replace(
                    (
                        f"2,0x{DEFAULT_HOOK_ADDRESS:08X},0xFFF000,"
                        f"0x{DEFAULT_HOOK_RETURN:X}"
                    ),
                    (
                        f"2,0x{DEFAULT_HOOK_ADDRESS + 2:08X},0xFFF000,"
                        f"0x{DEFAULT_HOOK_RETURN + 2:X}"
                    ),
                ),
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 0)
            self.assertIn("wrong_hook_pc", codes)
            self.assertIn("wrong_hook_caller", codes)

    def test_caller_capped_and_mode_mismatch_fail(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            self.rewrite_caller(
                manifest,
                0,
                lambda text: text.replace(
                    "sh2_drc=1 profile_pc=0 profile_pc_env=0 "
                    "m68k_batching=normal instruction_start_hook=1 composed=1 max_hits=0",
                    "sh2_drc=0 profile_pc=1 profile_pc_env=1 "
                    "m68k_batching=chunked instruction_start_hook=1 composed=1 max_hits=8",
                ),
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 0)
            self.assertIn("caller_trace_mode", codes)
            self.assertIn("caller_trace_capped", codes)

    def test_write_trace_mode_tamper_drc0_pc1_and_chunked_fail(self) -> None:
        replacements = {
            "drc0": ("sh2_drc=1", "sh2_drc=0"),
            "pc1": ("profile_pc=0", "profile_pc=1"),
            "pc_env": ("profile_pc_env=0", "profile_pc_env=1"),
            "chunked": ("m68k_batching=normal", "m68k_batching=chunked"),
            "not_composed": ("composed=1", "composed=0"),
        }
        for name, (old, new) in replacements.items():
            with self.subTest(name=name), tempfile.TemporaryDirectory() as temp:
                manifest_path, manifest = self.write_suite(Path(temp))
                write_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "write.csv"
                write_path.write_text(write_path.read_text().replace(old, new, 1))
                self.refresh_artifact_hash(manifest, 0, "write.csv")
                self.rewrite_manifest(manifest_path, manifest)
                report = analyze_suite(manifest_path)
                self.assertIn("write_trace_mode", self.fixture_codes(report, 0))

    def test_run_provenance_mode_tamper_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            run_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "run.json"
            run = json.loads(run_path.read_text())
            run["sh2_drc"] = 0
            run["profile_pc"] = 1
            run["profile_pc_env_present"] = 1
            run["m68k_batching"] = "chunked"
            run_path.write_text(json.dumps(run, indent=2) + "\n")
            self.refresh_artifact_hash(manifest, 0, "run.json")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("run_provenance_mismatch", self.fixture_codes(report, 0))

    def test_zero_master_and_slave_executed_cycles_fail(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            frames_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "frames.csv"
            with frames_path.open(newline="") as stream:
                rows = list(csv.DictReader(stream))
                fieldnames = list(rows[0])
            for row in rows:
                if WARMUP_FRAMES <= int(row["frame"]) < WARMUP_FRAMES + 180:
                    row["msh2_cycles"] = "0"
                    row["ssh2_cycles"] = "0"
            with frames_path.open("w", newline="") as stream:
                writer = csv.DictWriter(stream, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerows(rows)
            self.refresh_artifact_hash(manifest, 0, "frames.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 0)
            self.assertIn("master_sh2_no_executed_cycles", codes)
            self.assertIn("slave_sh2_no_executed_cycles", codes)

    def test_isolated_master_zero_with_continuing_state_cycle_passes(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            frames_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "frames.csv"
            with frames_path.open(newline="") as stream:
                rows = list(csv.DictReader(stream))
                fieldnames = list(rows[0])
            master_idle_frame = WARMUP_FRAMES + 2
            for row in rows:
                if int(row["frame"]) == master_idle_frame:
                    row["msh2_cycles"] = "0"
            with frames_path.open("w", newline="") as stream:
                writer = csv.DictWriter(stream, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerows(rows)
            self.refresh_artifact_hash(manifest, 0, "frames.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertTrue(report.passed, report.to_json())

    def test_single_zero_slave_executed_cycle_frame_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            frames_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "frames.csv"
            with frames_path.open(newline="") as stream:
                rows = list(csv.DictReader(stream))
                fieldnames = list(rows[0])
            bad_frame = WARMUP_FRAMES + 90
            for row in rows:
                if int(row["frame"]) == bad_frame:
                    row["ssh2_cycles"] = "0"
            with frames_path.open("w", newline="") as stream:
                writer = csv.DictWriter(stream, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerows(rows)
            self.refresh_artifact_hash(manifest, 0, "frames.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 0)
            self.assertIn("slave_sh2_no_executed_cycles", codes)
            finding = next(
                finding
                for finding in report.fixtures[0].findings
                if finding.code == "slave_sh2_no_executed_cycles"
            )
            self.assertEqual(
                finding.message,
                f"Slave SH2 executed zero cycles at frame {bad_frame}; "
                "every active frame must be nonzero",
            )

    def test_missing_exact_master_completion_write_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            removed = False

            def remove_one_completion(rows: list[str]) -> list[str]:
                nonlocal removed
                result = []
                for row in rows:
                    if (
                        not removed
                        and row.startswith(f"{WARMUP_FRAMES + 3},0x0089C414,")
                    ):
                        removed = True
                        continue
                    result.append(row)
                return result

            self.rewrite_write_rows(manifest, 0, remove_one_completion)
            self.assertTrue(removed)
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("state_write_order", self.fixture_codes(report, 0))

    def test_master_zero_interval_with_state_cycle_stall_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            frames_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "frames.csv"
            with frames_path.open(newline="") as stream:
                rows = list(csv.DictReader(stream))
                fieldnames = list(rows[0])
            stall_start = WARMUP_FRAMES + 40
            stall_end = stall_start + 3 * len(STATE_WRITE_CYCLE)
            for row in rows:
                if stall_start <= int(row["frame"]) < stall_end:
                    row["msh2_cycles"] = "0"
            with frames_path.open("w", newline="") as stream:
                writer = csv.DictWriter(stream, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerows(rows)
            self.refresh_artifact_hash(manifest, 0, "frames.csv")
            self.rewrite_write_rows(
                manifest,
                0,
                lambda rows: [
                    row
                    for row in rows
                    if not stall_start <= int(row.split(",", 1)[0]) < stall_end
                ],
            )
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 0)
            self.assertIn("state_write_stall", codes)
            self.assertNotIn("master_sh2_no_executed_cycles", codes)

    def test_state_cycle_missing_reordered_and_unknown_writes_fail(self) -> None:
        transforms = {
            "missing": lambda rows: [
                row for row in rows if row.split(",")[2] != "0xFFC87E"
            ],
            "reordered": lambda rows: [
                (
                    row.replace(
                        "0x00884D0C,0xFFC87E,2,0xFFC87E,2,0x0004,0x0008",
                        "0x00884CF2,0xFFC87E,2,0xFFC87E,2,0x0000,0x0004",
                    )
                    if row.startswith(f"{WARMUP_FRAMES + 1},")
                    else row
                )
                for row in rows
            ],
            "unknown": lambda rows: [
                (
                    row.replace("0x00884CF2", "0x00884CF4")
                    if row.startswith(f"{WARMUP_FRAMES},")
                    else row
                )
                for row in rows
            ],
        }
        expected = {
            "missing": "state_write_missing",
            "reordered": "state_write_order",
            "unknown": "state_write_unknown",
        }
        for name, transform in transforms.items():
            with self.subTest(name=name), tempfile.TemporaryDirectory() as temp:
                manifest_path, manifest = self.write_suite(Path(temp))
                self.rewrite_write_rows(manifest, 0, transform)
                self.rewrite_manifest(manifest_path, manifest)
                report = analyze_suite(manifest_path)
                self.assertIn(expected[name], self.fixture_codes(report, 0), report.to_json())

    def test_insufficient_aggregate_coverage_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, _manifest = self.write_suite(Path(temp), fixture_count=4)
            report = analyze_suite(manifest_path)
            self.assertFalse(report.passed)
            self.assertIn(
                "insufficient_aggregate_coverage",
                {finding.code for finding in report.findings},
            )

    def test_dead_final_179_frame_sh2_tail_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(
                Path(temp), boundary=WARMUP_FRAMES + 4139
            )
            fixture = manifest["fixtures"][0]
            active_end = fixture["expected_terminal_entry_frame"]
            frames_path = Path(fixture["artifact_dir"]) / "frames.csv"
            with frames_path.open(newline="") as stream:
                rows = list(csv.DictReader(stream))
                fieldnames = list(rows[0])
            for row in rows:
                if active_end - 179 <= int(row["frame"]) < active_end:
                    row["msh2_cycles"] = "0"
            with frames_path.open("w", newline="") as stream:
                writer = csv.DictWriter(stream, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerows(rows)
            self.refresh_artifact_hash(manifest, 0, "frames.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn(
                "master_sh2_no_tail_cycles",
                self.fixture_codes(report, 0),
            )

    def test_insufficient_lifecycle_count_is_independent(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, _manifest = self.write_suite(
                Path(temp), fixture_count=2, boundary=WARMUP_FRAMES + 9000
            )
            report = analyze_suite(manifest_path)
            codes = {finding.code for finding in report.findings}
            self.assertIn("insufficient_lifecycle_count", codes)
            self.assertNotIn("insufficient_aggregate_coverage", codes)
            self.assertNotIn("insufficient_longest_span", codes)

    def test_insufficient_longest_span_is_independent(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, _manifest = self.write_suite(
                Path(temp), fixture_count=5, boundary=WARMUP_FRAMES + 3600
            )
            report = analyze_suite(manifest_path)
            codes = {finding.code for finding in report.findings}
            self.assertIn("insufficient_longest_span", codes)
            self.assertNotIn("insufficient_lifecycle_count", codes)
            self.assertNotIn("insufficient_aggregate_coverage", codes)

    def test_unknown_c07c_entry_writer_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            write_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "write.csv"
            write_path.write_text(
                write_path.read_text().replace(
                    f"0x{TIMEOUT_ENTRY_PC:08X}",
                    f"0x{TIMEOUT_ENTRY_PC + 2:08X}",
                    1,
                )
            )
            self.refresh_artifact_hash(manifest, 0, "write.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("terminal_display_writer", self.fixture_codes(report, 0))

    def test_unknown_later_c07c_writer_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            write_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "write.csv"
            expected_pc = TIMEOUT_DISPLAY_WRITE_SIGNATURE[5][0]
            write_path.write_text(
                write_path.read_text().replace(
                    f"0x{expected_pc:08X}",
                    f"0x{expected_pc + 2:08X}",
                    1,
                )
            )
            self.refresh_artifact_hash(manifest, 0, "write.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("terminal_display_writer", self.fixture_codes(report, 0))

    def test_broken_c07c_old_value_chain_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            write_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "write.csv"
            lines = write_path.read_text().splitlines()
            row_index = next(
                index for index, line in enumerate(lines) if ",0xFFC07C,2," in line
            )
            fields = lines[row_index].split(",")
            fields[6] = "0x0015"
            lines[row_index] = ",".join(fields)
            write_path.write_text("\n".join(lines) + "\n")
            self.refresh_artifact_hash(manifest, 0, "write.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("terminal_display_chain", self.fixture_codes(report, 0))

    def test_out_of_order_c07c_sequence_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            write_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "write.csv"
            lines = write_path.read_text().splitlines()
            c07c_rows = [
                index for index, line in enumerate(lines) if ",0xFFC07C,2," in line
            ]
            lines[c07c_rows[1]], lines[c07c_rows[2]] = (
                lines[c07c_rows[2]],
                lines[c07c_rows[1]],
            )
            write_path.write_text("\n".join(lines) + "\n")
            self.refresh_artifact_hash(manifest, 0, "write.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            codes = self.fixture_codes(report, 0)
            self.assertTrue({"write_trace_order", "terminal_display_sequence"} & codes)

    def test_run_json_requires_exact_key_set(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            run_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "run.json"
            run = json.loads(run_path.read_text())
            run["self_asserted_summary"] = {"passed": True}
            run_path.write_text(json.dumps(run, indent=2) + "\n")
            self.refresh_artifact_hash(manifest, 0, "run.json")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("run_provenance_mismatch", self.fixture_codes(report, 0))

    def test_run_json_binds_exact_control_fixture_manifest(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            run_path = Path(manifest["fixtures"][0]["artifact_dir"]) / "run.json"
            run = json.loads(run_path.read_text())
            self.assertEqual(run["fixture_manifest"], str(DEFAULT_MANIFEST.resolve()))
            self.assertEqual(
                run["fixture_manifest_sha256"], sha256_file(DEFAULT_MANIFEST)
            )
            self.assertIsNone(run["fixture_manifest_entry"])
            run["fixture_manifest_sha256"] = "0" * 64
            run_path.write_text(json.dumps(run, indent=2) + "\n")
            self.refresh_artifact_hash(manifest, 0, "run.json")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("run_provenance_mismatch", self.fixture_codes(report, 0))

    def test_offline_suite_rejects_blacklisted_control_fixture(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            fixture = manifest["fixtures"][0]
            blacklisted = Path(__file__).resolve().parent / "savestate_1p_gp_racing.bin"
            fixture["savestate"] = {
                "path": str(blacklisted),
                "sha256": sha256_file(blacklisted),
            }
            policy_entry, policy_digest = fixture_policy(blacklisted, DEFAULT_MANIFEST)
            self.assertEqual(policy_digest, fixture["savestate"]["sha256"])
            self.assertEqual(policy_entry["status"], "invalid_control")
            run_path = Path(fixture["artifact_dir"]) / "run.json"
            run = json.loads(run_path.read_text())
            run.update(
                {
                    "savestate": str(blacklisted),
                    "savestate_sha256": policy_digest,
                    "fixture_manifest_entry": policy_entry,
                }
            )
            run_path.write_text(json.dumps(run, indent=2) + "\n")
            self.refresh_artifact_hash(manifest, 0, "run.json")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("invalid_control_fixture", self.fixture_codes(report, 0))

    def test_capture_rejects_blacklisted_control_fixture_before_frontend(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            _manifest_path, manifest = self.write_suite(root, fixture_count=1)
            fixture = manifest["fixtures"][0]
            blacklisted = Path(__file__).resolve().parent / "savestate_1p_gp_racing.bin"
            args = SimpleNamespace(
                rom=manifest["rom"]["path"],
                reference_rom=manifest["reference_rom"]["path"],
                savestate=str(blacklisted),
                input_script=fixture["input_script"]["path"],
                source_capture=fixture["source_capture"]["path"],
                output_dir=str(root / "must-not-exist"),
                frames=fixture["total_frames"],
                expected_terminal_entry_frame=fixture["expected_terminal_entry_frame"],
                expected_results_scene_frame=fixture["expected_results_scene_frame"],
                fixture_id="blacklisted",
            )
            errors = io.StringIO()
            with (
                patch("validate_1p_lifecycle_suite.run_lifecycle_capture") as runner,
                redirect_stderr(errors),
            ):
                status = capture_fixture(args)
            self.assertEqual(status, 2)
            runner.assert_not_called()
            self.assertIn("[invalid_control_fixture]", errors.getvalue())
            self.assertFalse(Path(args.output_dir).exists())

    def test_manifest_rejects_unknown_policy_key(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            manifest["allow_short_lifecycles"] = True
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertFalse(report.passed)
            self.assertIn("manifest_schema", {item.code for item in report.findings})

    def test_manifest_rejects_unknown_pinned_file_key(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            manifest["fixtures"][0]["source_capture"]["reviewed"] = True
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertFalse(report.passed)
            self.assertIn("manifest_schema", self.fixture_codes(report, 0))

    def test_predeclared_results_scene_frame_must_match(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            manifest["fixtures"][0]["expected_results_scene_frame"] -= 1
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("results_scene_frame_mismatch", self.fixture_codes(report, 0))

    def test_c07c_watch_must_correspond_to_exact_write(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, manifest = self.write_suite(Path(temp))
            fixture = manifest["fixtures"][0]
            boundary = fixture["expected_terminal_entry_frame"]
            watch_path = Path(fixture["artifact_dir"]) / "watch.csv"
            with watch_path.open(newline="") as stream:
                rows = list(csv.DictReader(stream))
                fieldnames = list(rows[0])
            rows[boundary + 1]["0xFFC07C"] = "0x14"
            with watch_path.open("w", newline="") as stream:
                writer = csv.DictWriter(stream, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerows(rows)
            self.refresh_artifact_hash(manifest, 0, "watch.csv")
            self.rewrite_manifest(manifest_path, manifest)
            report = analyze_suite(manifest_path)
            self.assertIn("terminal_display_watch_mismatch", self.fixture_codes(report, 0))

    def test_diagnostic_override_can_never_pass(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, _manifest = self.write_suite(Path(temp))
            report = analyze_suite(manifest_path, diagnostic=True)
            self.assertFalse(report.passed)
            self.assertIn("diagnostic_override", {item.code for item in report.findings})

    def test_capture_runner_uses_sterile_exact_environment(self) -> None:
        class FakeProcess:
            stdout = iter(["Running synthetic capture\n"])

            def wait(self) -> int:
                return 0

        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            output = root / "fresh"
            output.mkdir()
            rom = root / "control.32x"
            savestate = root / "state.mds"
            replay = root / "input.csv"
            rom.write_bytes(b"rom")
            savestate.write_bytes(b"state")
            replay.write_text("frame,mask\n0,0x100\n")
            captured: dict[str, object] = {}

            def fake_popen(command, **kwargs):
                captured["command"] = command
                captured.update(kwargs)
                return FakeProcess()

            with patch("validate_1p_lifecycle_suite.subprocess.Popen", fake_popen):
                status = run_lifecycle_capture(
                    rom=rom,
                    savestate=savestate,
                    input_script=replay,
                    output_dir=output,
                    total_frames=1,
                )
            self.assertEqual(status, 0)
            environment = captured["env"]
            self.assertEqual(environment["VRD_WATCH"], LIFECYCLE_WATCH_SPEC)
            self.assertEqual(environment["VRD_WRITE_TRACE"], WRITE_TRACE_SPEC)
            self.assertEqual(environment["VRD_CALLER_TRACE_MAX"], "0")
            self.assertNotIn("HOME", environment)
            self.assertNotIn("VRD_PROFILE_PC", environment)
            self.assertNotIn("VRD_PROFILE_PC_LOG", environment)
            self.assertEqual(
                set(environment) - {"PATH"},
                {
                    "VRD_PROFILE_LOG", "VRD_PROFILE_FRAMES", "VRD_FB_CRC", "VRD_SCENE_ADDR",
                    "VRD_WATCH", "VRD_WATCH_LOG", "VRD_CALLER_TRACE",
                    "VRD_CALLER_TRACE_LOG", "VRD_CALLER_TRACE_MAX",
                    "VRD_WRITE_TRACE", "VRD_WRITE_TRACE_LOG", "VRD_LOAD_STATE",
                    "VRD_INPUT_SCRIPT",
                },
            )


if __name__ == "__main__":
    unittest.main()
