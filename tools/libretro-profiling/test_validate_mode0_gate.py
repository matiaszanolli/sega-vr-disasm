#!/usr/bin/env python3
"""Focused adversarial tests for the separate VR60 Q020 runtime policy."""

from __future__ import annotations

import sys
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace

SCRIPT_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(SCRIPT_DIR))

from validate_1p_control import sha256_file
from validate_1p_lifecycle_suite import FixtureReport, WriteTrace, verify_pinned_file
from validate_mode0_gate import (
    EXPECTED_ACTIVE_SHA256,
    EXPECTED_BASE_IDS,
    EXPECTED_OPTIONAL_FB_MISMATCH,
    EXPECTED_SOURCE_STAGE_FRAMES,
    FLAG_WRITE_PC,
    LEGITIMATE_TERMINAL_PC,
    LOW_TAIL_ALIAS,
    RAW_TAIL_PC,
    SOURCE_STAGE_DUMP_SPEC,
    WRITE_TARGET_FLAG,
    GateReport,
    accepted_boundaries_match,
    compare_checkpoint_pair,
    compare_chronology,
    compare_frames_through_terminal,
    compare_post_results_mode_chronology,
    index_run_matrix,
    source_stage_identity_matches,
    validate_distinct_repetitions,
    validate_flag_transition,
    validate_runtime_checkpoint,
    verify_preflight_transcript,
)


def write_trace(rows: list[dict[str, int]]) -> WriteTrace:
    return WriteTrace(
        rows=rows,
        targets=set(),
        version=3,
        sh2_drc=1,
        profile_pc=0,
        profile_pc_env=0,
        m68k_batching="normal",
        instruction_start_hook=1,
        composed=1,
        caller_addr=0x884D1A,
        caller_max=0,
        declared_target_count=4,
        complete_frames=100,
        complete_events=len(rows),
        errors=0,
        incomplete=False,
    )


def frame_rows(count: int) -> tuple[list[dict[str, int]], list[dict[str, str]]]:
    observed: list[dict[str, int]] = []
    accepted: list[dict[str, str]] = []
    for frame in range(count):
        values = {
            "frame": frame,
            "fb_crc": 0x1000 + frame,
            "scene": 0x4CBC,
            "state": frame & 0xC,
            "is_32x": 1,
        }
        observed.append(values)
        accepted.append({key: str(value) for key, value in values.items()})
    return observed, accepted


def matrix_run(
    arm: str,
    base_id: str,
    repetition: int,
    *,
    identity: tuple[str, str, str] | None = None,
    terminal: int = 11328,
) -> SimpleNamespace:
    digest = f"{arm}-{base_id}"
    artifacts = {
        name: digest
        for name in ("frames.csv", "watch.csv", "caller.csv", "write.csv", "checkpoint.txt")
    }
    return SimpleNamespace(
        arm=arm,
        base_id=base_id,
        repetition=repetition,
        identity=identity or (f"state-{base_id}", f"input-{base_id}", f"source-{base_id}"),
        artifact_hashes=artifacts,
        terminal_entry_frame=terminal,
    )


class Mode0RuntimePolicyTests(unittest.TestCase):
    def checkpoint_inputs(
        self, arm: str = "active"
    ) -> tuple[list[dict[str, int]], dict[int, bytes]]:
        watches = [
            {
                "frame": frame,
                "0xFF7B40": 1,
                "0x20004026": 0,
                "0x20004010": 0,
                "0x20004023": 0,
                "0x2000402E": 0,
                "0x2600FC00": 0x20004020 if arm == "active" else 0,
            }
            for frame in range(12)
        ]
        stage = b"A" * 0x140
        return watches, {
            0xFF6A00: stage,
            0x0600F20C: stage if arm == "active" else b"B" * 0x140,
        }

    def frame_pair(
        self,
        base_id: str,
        count: int = 8,
        terminal: int = 7,
    ) -> tuple[SimpleNamespace, SimpleNamespace, list[dict[str, str]]]:
        observed, accepted = frame_rows(count)
        allowed = EXPECTED_OPTIONAL_FB_MISMATCH[base_id]
        if allowed is not None and allowed < count:
            observed[allowed]["state"] = 8
            accepted[allowed]["state"] = "8"
        active = SimpleNamespace(
            arm="active",
            frames=[row.copy() for row in observed],
            terminal_entry_frame=terminal,
        )
        control = SimpleNamespace(
            arm="control",
            frames=[row.copy() for row in observed],
            terminal_entry_frame=terminal,
        )
        return active, control, accepted

    def test_source_stage_completion_frames_are_exact_and_tamper_fails(self) -> None:
        self.assertEqual(
            EXPECTED_SOURCE_STAGE_FRAMES,
            {"big-forest": 1, "bay-bridge": 3, "acropolis": 3},
        )
        accepted = {
            "savestate": {"sha256": "state"},
            "input_script": {"sha256": "input"},
        }
        entry = {
            "rom_sha256": EXPECTED_ACTIVE_SHA256,
            "savestate_sha256": "state",
            "input_script_sha256": "input",
            "dump_frame": 1,
            "dump_spec": SOURCE_STAGE_DUMP_SPEC,
        }
        self.assertTrue(source_stage_identity_matches(entry, accepted, "big-forest"))
        entry["dump_frame"] = 0
        self.assertFalse(source_stage_identity_matches(entry, accepted, "big-forest"))

    def test_terminal_frame_is_compared_inclusively(self) -> None:
        active, control, accepted = self.frame_pair("big-forest", count=5, terminal=3)

        active.frames[3]["fb_crc"] ^= 1
        report = GateReport()
        compare_frames_through_terminal(report, "big-forest", active, control, accepted)
        self.assertFalse(report.findings)

        active.frames[3]["fb_crc"] ^= 1
        active.frames[4]["fb_crc"] ^= 1
        report = GateReport()
        compare_frames_through_terminal(report, "big-forest", active, control, accepted)
        self.assertFalse(report.findings, "post-terminal frame must not enter accepted coverage")

    def test_framebuffer_adversarial_mismatches_fail(self) -> None:
        cases = (
            ("big-forest", (2,), "framebuffer_mismatch_frame"),
            ("big-forest", (3, 4), "framebuffer_mismatch_count"),
            ("bay-bridge", (5,), "framebuffer_mismatch_frame"),
        )
        for base_id, mismatches, expected_code in cases:
            with self.subTest(base_id=base_id, mismatches=mismatches):
                active, control, accepted = self.frame_pair(base_id)
                for frame in mismatches:
                    active.frames[frame]["fb_crc"] ^= 1
                report = GateReport()
                compare_frames_through_terminal(
                    report, base_id, active, control, accepted
                )
                self.assertIn(expected_code, {item["code"] for item in report.findings})

        active, control, accepted = self.frame_pair("big-forest")
        active.frames[3]["state"] = 4
        control.frames[3]["state"] = 4
        accepted[3]["state"] = "4"
        active.frames[3]["fb_crc"] ^= 1
        report = GateReport()
        compare_frames_through_terminal(
            report, "big-forest", active, control, accepted
        )
        self.assertIn(
            "framebuffer_mismatch_state",
            {item["code"] for item in report.findings},
        )

    def test_no_frame_preflight_rejects_post_frame_masquerade(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            rom = root / "control.32x"
            state = root / "state.bin"
            transcript = root / "preflight.txt"
            rom.write_bytes(b"rom")
            state.write_bytes(b"state")
            lines = [
                f"  ROM: {rom.resolve()}",
                f"Loaded state: {state.resolve()} (5 bytes)",
                "vrd-dbg> status",
                "Session frame: 0",
                "vrd-dbg> read 68k 0xFF0002 4",
                "00FF0002: 00 88 4C BC",
                "vrd-dbg> read 68k 0xFF7B40 1",
                "00FF7B40: 00",
                "vrd-dbg> read master 0x20004026 1",
                "20004026: 00",
                "vrd-dbg> read master 0x2600FC00 4",
                "2600FC00: 00 00 00 00",
                "vrd-dbg> status",
                "Session frame: 0",
                "vrd-dbg> quit",
            ]
            transcript.write_text("\n".join(lines) + "\n")
            verify_preflight_transcript(
                transcript, control_rom=rom, savestate=state
            )
            transcript.write_text(
                "\n".join(lines[:-1] + ["PicoFrame 0", lines[-1]]) + "\n"
            )
            with self.assertRaisesRegex(ValueError, "frame-advancing"):
                verify_preflight_transcript(
                    transcript, control_rom=rom, savestate=state
                )

    def test_tampered_pinned_artifact_fails(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            manifest = root / "manifest.json"
            manifest.write_text("{}\n")
            artifact = root / "artifact.bin"
            artifact.write_bytes(b"accepted")
            spec = {"path": str(artifact), "sha256": sha256_file(artifact)}
            artifact.write_bytes(b"tampered")
            report = GateReport()
            verify_pinned_file(manifest, spec, "artifact", report)
            self.assertIn("provenance_hash_mismatch", {item["code"] for item in report.findings})

    def test_duplicate_slot_and_duplicate_identity_do_not_count(self) -> None:
        runs = [
            matrix_run(arm, base_id, repetition)
            for arm in ("active", "control")
            for base_id in EXPECTED_BASE_IDS
            for repetition in (1, 2)
        ]
        runs[-1] = matrix_run("control", "acropolis", 1)
        report = GateReport()
        index_run_matrix(report, runs)
        codes = {item["code"] for item in report.findings}
        self.assertIn("duplicate_run_slot", codes)
        self.assertIn("run_slots", codes)

        duplicate_identity = ("same", "same", "same")
        runs = [
            matrix_run(arm, base_id, repetition, identity=duplicate_identity)
            for arm in ("active", "control")
            for base_id in EXPECTED_BASE_IDS
            for repetition in (1, 2)
        ]
        report = GateReport()
        grouped = index_run_matrix(report, runs)
        validate_distinct_repetitions(report, grouped)
        self.assertIn("duplicate_identity", {item["code"] for item in report.findings})

    def test_repetition_mismatch_and_coverage_floor_fail(self) -> None:
        runs = [
            matrix_run(arm, base_id, repetition, terminal=500)
            for arm in ("active", "control")
            for base_id in EXPECTED_BASE_IDS
            for repetition in (1, 2)
        ]
        runs[1].identity = ("changed", "changed", "changed")
        report = GateReport()
        grouped = index_run_matrix(report, runs)
        validate_distinct_repetitions(report, grouped)
        codes = {item["code"] for item in report.findings}
        self.assertIn("replicate_identity", codes)
        self.assertIn("arm_coverage", codes)

    def test_checkpoint_requires_three_exact_relationships(self) -> None:
        stage = b"A" * 0x140
        destination = b"B" * 0x140
        active = SimpleNamespace(
            checkpoint={0xFF6A00: stage, 0x0600F20C: stage}
        )
        control = SimpleNamespace(
            checkpoint={0xFF6A00: stage, 0x0600F20C: destination}
        )
        report = GateReport()
        compare_checkpoint_pair(report, "big-forest", active, control)
        self.assertFalse(report.findings)

        control.checkpoint[0x0600F20C] = stage
        report = GateReport()
        compare_checkpoint_pair(report, "big-forest", active, control)
        self.assertIn("stale_destination", {item["code"] for item in report.findings})

        control.checkpoint[0x0600F20C] = destination
        active.checkpoint[0x0600F20C] = destination
        report = GateReport()
        compare_checkpoint_pair(report, "big-forest", active, control)
        self.assertIn("active_payload", {item["code"] for item in report.findings})

    def test_runtime_checkpoint_rejects_mode_ack_dreq_comm_and_sentinel(self) -> None:
        mutations = (
            ("0x20004026", 1, "mode_nonzero"),
            ("0x20004023", 2, "checkpoint_handshake"),
            ("0x20004010", 1, "checkpoint_handshake"),
            ("0x2000402E", 0x27, "checkpoint_handshake"),
            ("0x2600FC00", 0, "active_sentinel"),
        )
        for key, value, code in mutations:
            with self.subTest(key=key):
                watches, checkpoint = self.checkpoint_inputs()
                watches[11][key] = value
                fixture = FixtureReport("checkpoint")
                validate_runtime_checkpoint(
                    fixture,
                    arm="active",
                    watches=watches,
                    checkpoint=checkpoint,
                    mode_scope_end=11,
                )
                self.assertIn(code, {finding.code for finding in fixture.findings})

        watches, checkpoint = self.checkpoint_inputs("control")
        watches[0]["0x2600FC00"] = 1
        fixture = FixtureReport("checkpoint")
        validate_runtime_checkpoint(
            fixture,
            arm="control",
            watches=watches,
            checkpoint=checkpoint,
            mode_scope_end=11,
        )
        self.assertIn(
            "control_sentinel", {finding.code for finding in fixture.findings}
        )

    def test_mode_scope_and_post_results_pairing_are_exact(self) -> None:
        watches, checkpoint = self.checkpoint_inputs()
        watches.extend(
            {
                **watches[-1],
                "frame": frame,
                "0x20004026": 0,
            }
            for frame in range(12, 15)
        )
        watches[13]["0x20004026"] = 2

        fixture = FixtureReport("mode")
        validate_runtime_checkpoint(
            fixture,
            arm="active",
            watches=watches,
            checkpoint=checkpoint,
            mode_scope_end=12,
        )
        self.assertTrue(fixture.passed, fixture.findings)

        watches[12]["0x20004026"] = 2
        fixture = FixtureReport("mode")
        validate_runtime_checkpoint(
            fixture,
            arm="active",
            watches=watches,
            checkpoint=checkpoint,
            mode_scope_end=12,
        )
        self.assertIn("mode_nonzero", {finding.code for finding in fixture.findings})

        watches[12]["0x20004026"] = 0
        active = SimpleNamespace(results_scene_frame=12, watches=watches)
        control_watches = [row.copy() for row in watches]
        control = SimpleNamespace(results_scene_frame=12, watches=control_watches)
        report = GateReport()
        compare_post_results_mode_chronology(
            report, "big-forest", active, control
        )
        self.assertFalse(report.findings)
        control_watches[13]["0x20004026"] = 3
        report = GateReport()
        compare_post_results_mode_chronology(
            report, "big-forest", active, control
        )
        self.assertIn(
            "paired_post_results_mode_chronology",
            {finding["code"] for finding in report.findings},
        )

    def test_results_boundary_cannot_move_earlier(self) -> None:
        accepted = {
            "total_frames": 12229,
            "expected_terminal_entry_frame": 11266,
            "expected_results_scene_frame": 11713,
        }
        self.assertTrue(
            accepted_boundaries_match(
                total_frames=12229,
                terminal_entry_frame=11266,
                results_scene_frame=11713,
                accepted_entry=accepted,
            )
        )
        self.assertFalse(
            accepted_boundaries_match(
                total_frames=12229,
                terminal_entry_frame=11266,
                results_scene_frame=11712,
                accepted_entry=accepted,
            )
        )

    def test_flag_requires_one_exact_zero_to_one_hook_write(self) -> None:
        row = {
            "frame": 0,
            "pc": FLAG_WRITE_PC,
            "target_addr": WRITE_TARGET_FLAG[0],
            "target_size": 1,
            "access_addr": WRITE_TARGET_FLAG[0],
            "access_size": 1,
            "old_value": 0,
            "new_value": 1,
        }
        fixture = FixtureReport("flag")
        validate_flag_transition(fixture, write_trace([row]), 0)
        self.assertTrue(fixture.passed)

        bad = row.copy()
        bad["new_value"] = 2
        fixture = FixtureReport("flag")
        validate_flag_transition(fixture, write_trace([bad]), 0)
        self.assertEqual(fixture.findings[0].code, "flag_write_signature")

        fixture = FixtureReport("flag")
        validate_flag_transition(fixture, write_trace([row, row]), 0)
        self.assertEqual(fixture.findings[0].code, "flag_write_count")

        bad = row.copy()
        bad["old_value"] = 1
        fixture = FixtureReport("flag")
        validate_flag_transition(fixture, write_trace([bad]), 0)
        self.assertEqual(fixture.findings[0].code, "flag_write_signature")

    def test_accepted_caller_and_write_chronology_are_exact(self) -> None:
        caller_rows = [{"frame": 0, "pc": 0x884D1A, "sp": 1, "return_addr": 0xFF0006}]
        write_rows = [
            {"frame": 0, "pc": RAW_TAIL_PC},
            {"frame": 11328, "pc": LEGITIMATE_TERMINAL_PC},
        ]
        active = SimpleNamespace(
            arm="active",
            caller=SimpleNamespace(rows=caller_rows.copy()),
            baseline_write_trace=SimpleNamespace(rows=write_rows.copy()),
            terminal_entry_frame=11328,
        )
        control = SimpleNamespace(
            arm="control",
            caller=SimpleNamespace(rows=caller_rows.copy()),
            baseline_write_trace=SimpleNamespace(rows=write_rows.copy()),
            terminal_entry_frame=11328,
        )
        report = GateReport()
        compare_chronology(
            report, "big-forest", active, control, caller_rows, write_rows
        )
        self.assertFalse(report.findings)

        control.caller.rows = []
        report = GateReport()
        compare_chronology(
            report, "big-forest", active, control, caller_rows, write_rows
        )
        self.assertIn("paired_caller_chronology", {item["code"] for item in report.findings})

        accepted_writes = [{"frame": 0, "pc": 0xDEADBEEF}]
        report = GateReport()
        compare_chronology(
            report, "big-forest", active, active, caller_rows, accepted_writes
        )
        self.assertIn("accepted_write_chronology", {item["code"] for item in report.findings})

        low_alias = [row.copy() for row in write_rows]
        low_alias[0]["pc"] = LOW_TAIL_ALIAS
        active.baseline_write_trace.rows = low_alias
        report = GateReport()
        compare_chronology(
            report, "big-forest", active, control, caller_rows, write_rows
        )
        self.assertIn("raw_tail_pc", {item["code"] for item in report.findings})


if __name__ == "__main__":
    unittest.main()
