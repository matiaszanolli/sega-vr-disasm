"""Validate a reviewed aggregate suite of complete normal-1P lifecycles.

This is the separate VR60-011 policy.  It does not replace or relax
validate_1p_control.py: the original validator remains the VR60-010 continuous
18,000-frame gate.  This offline aggregator reads and revalidates immutable raw
artifacts; it never accepts self-asserted per-fixture summaries.
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import re
import subprocess
import sys
from collections.abc import Sequence
from dataclasses import asdict, dataclass, field
from itertools import pairwise
from pathlib import Path

from validate_1p_control import (
    CANONICAL_CORE,
    CANONICAL_CORE_SHA256,
    CANONICAL_FRONTEND,
    CANONICAL_FRONTEND_SHA256,
    DEFAULT_HOOK_ADDRESS,
    DEFAULT_HOOK_RETURN,
    DEFAULT_MANIFEST,
    DEFAULT_SCENE_POINTER,
    DEFAULT_STATES,
    WATCH_COMM0_HI,
    WATCH_COMM1_LO,
    WATCH_COMM2_HI,
    WATCH_COMM7,
    WATCH_SCENE_POINTER,
    Finding,
    Thresholds,
    control_rom_policy,
    fixture_policy,
    load_caller_trace,
    load_csv,
    longest_nonzero_run,
    longest_run,
    parse_number,
    reviewed_tool_policy,
    sha256_file,
    validate_input_script,
)

SCHEMA_VERSION = 1
POLICY_ID = "VR60-011-lifecycle-suite-v1"

# Reviewed VR60-011 coverage policy.  The 360-frame warmup matches the existing
# capture practice.  The 3 / 1,800 / 3,960 / 18,000 constants were reviewed
# together: 3,960 is 22 complete 180-frame windows and is below the measured
# 4,174-frame active span of the classified VR60-009 timeout lifecycle.
WARMUP_FRAMES = 360
MIN_COMPLETE_LIFECYCLES = 3
MIN_ACTIVE_FRAMES_PER_LIFECYCLE = 1_800
MIN_LONGEST_ACTIVE_SPAN = 3_960
MIN_AGGREGATE_ACTIVE_FRAMES = 18_000

WATCH_C050 = "0xFFC050"
WATCH_C07C = "0xFFC07C"
WATCH_LAP_EF07 = "0xFFEF07"
WATCH_LAP_FEB7 = "0xFFFEB7"
WATCH_LAP_FDA8 = "0xFFFDA8"
LIFECYCLE_WATCH_SPEC = (
    "0xFF0002:4,"
    "0x20004020:1,0x20004023:1,0x20004024:1,0x2000402E:2,"
    "0xFFC050:2,0xFFC07C:2,0xFFEF07:1,0xFFFEB7:1,0xFFFDA8:1"
)
WRITE_TRACE_SPEC = "0xFFC87E:2,0xFFC07C:2,0xFF0002:4"

WRITE_TARGET_STATE = (0xFFC87E, 2)
WRITE_TARGET_DISPLAY_STATE = (0xFFC07C, 2)
WRITE_TARGET_SCENE = (0xFF0002, 4)
ORDERED_WRITE_TARGETS = (
    WRITE_TARGET_STATE,
    WRITE_TARGET_DISPLAY_STATE,
    WRITE_TARGET_SCENE,
)
REQUIRED_WRITE_TARGETS = {
    *ORDERED_WRITE_TARGETS,
}
TIMEOUT_ENTRY_PC = 0x00886C38
RESULTS_SCENE_WRITER_PC = 0x008843D0
RESULTS_SCENE_POINTER = 0x0088FB98
TIMEOUT_DISPLAY_SEQUENCE = (0x0014, 0x0018, 0x001C, 0x0020, 0x0024, 0x0028, 0x002C, 0x0030)
# The surprising 0x0000 old value is intentional: accepted VR60-009 watch
# evidence samples C07C=0x0000 at frame 4533 and 0x0014 at frame 4534.  C30E,
# not C07C, is the field that changes 0x10->0x11 at timeout entry.
TIMEOUT_DISPLAY_WRITE_SIGNATURE = (
    (0x00886C38, 0x0000, 0x0014),
    (0x0088427A, 0x0014, 0x0018),
    (0x008842CE, 0x0018, 0x001C),
    (0x00884322, 0x001C, 0x0020),
    (0x00884336, 0x0020, 0x0024),
    (0x00884384, 0x0024, 0x0028),
    (0x00884398, 0x0028, 0x002C),
    (0x008843CA, 0x002C, 0x0030),
)

REQUIRED_ARTIFACTS = (
    "run.json",
    "frames.csv",
    "watch.csv",
    "caller.csv",
    "write.csv",
    "pc.csv",
    "frontend.log",
)


@dataclass(frozen=True)
class WriteTrace:
    rows: list[dict[str, int]]
    targets: set[tuple[int, int]]
    version: int | None
    instruction_start_hook: int | None
    declared_target_count: int | None
    complete_frames: int | None
    complete_events: int | None
    errors: int | None
    incomplete: bool


@dataclass
class FixtureReport:
    fixture_id: str
    findings: list[Finding] = field(default_factory=list)
    metrics: dict[str, object] = field(default_factory=dict)
    identity: tuple[str, str, str] | None = None
    source_capture_sha256: str | None = None

    @property
    def passed(self) -> bool:
        return not self.findings

    def fail(self, code: str, message: str) -> None:
        finding = Finding(code, message)
        if finding not in self.findings:
            self.findings.append(finding)

    def to_json(self) -> dict[str, object]:
        return {
            "fixture_id": self.fixture_id,
            "passed": self.passed,
            "metrics": self.metrics,
            "findings": [asdict(item) for item in self.findings],
        }


@dataclass
class SuiteReport:
    findings: list[Finding] = field(default_factory=list)
    fixtures: list[FixtureReport] = field(default_factory=list)
    metrics: dict[str, object] = field(default_factory=dict)

    @property
    def passed(self) -> bool:
        return not self.findings and all(fixture.passed for fixture in self.fixtures)

    def fail(self, code: str, message: str) -> None:
        finding = Finding(code, message)
        if finding not in self.findings:
            self.findings.append(finding)

    def to_json(self) -> dict[str, object]:
        return {
            "passed": self.passed,
            "policy_id": POLICY_ID,
            "metrics": self.metrics,
            "findings": [asdict(item) for item in self.findings],
            "fixtures": [fixture.to_json() for fixture in self.fixtures],
        }


def resolve_manifest_path(manifest_path: Path, value: object) -> Path:
    if not isinstance(value, str) or not value:
        raise ValueError("path must be a non-empty string")
    path = Path(value)
    return (manifest_path.parent / path).resolve() if not path.is_absolute() else path.resolve()


def require_sha256(value: object, label: str) -> str:
    if not isinstance(value, str) or not re.fullmatch(r"[0-9a-f]{64}", value):
        raise ValueError(f"{label} must be a lowercase SHA-256")
    return value


def verify_pinned_file(
    manifest_path: Path,
    spec: object,
    label: str,
    report: SuiteReport | FixtureReport,
) -> tuple[Path | None, str | None]:
    if not isinstance(spec, dict):
        report.fail("manifest_schema", f"{label} must be an object")
        return None, None
    if set(spec) != {"path", "sha256"}:
        report.fail(
            "manifest_schema",
            f"{label} must contain exactly path and sha256",
        )
        return None, None
    try:
        path = resolve_manifest_path(manifest_path, spec.get("path"))
        expected = require_sha256(spec.get("sha256"), f"{label}.sha256")
    except ValueError as error:
        report.fail("manifest_schema", str(error))
        return None, None
    if not path.is_file():
        report.fail("provenance_file_missing", f"{label} is missing: {path}")
        return path, None
    actual = sha256_file(path)
    if actual != expected:
        report.fail(
            "provenance_hash_mismatch",
            f"{label} SHA-256 is {actual}; manifest pins {expected}",
        )
    return path, actual


def load_write_trace(path: Path) -> WriteTrace:
    """Parse the write trace as one exact, closed record grammar."""
    rows: list[dict[str, int]] = []
    targets: set[tuple[int, int]] = set()
    target_indices: set[int] = set()
    version = instruction_start_hook = declared_target_count = None
    complete_frames = complete_events = errors = None
    phase = "init"
    init_re = re.compile(
        r"# VRD_WRITE_TRACE version=(\d+) instruction_start_hook=(\d+) targets=(\d+)"
    )
    target_re = re.compile(
        r"# TARGET index=(\d+) addr=(0x[0-9A-Fa-f]+) size=(\d+)"
    )
    complete_re = re.compile(r"# COMPLETE frames=(\d+) events=(\d+) errors=(\d+)")
    expected_columns = (
        "frame,pc,target_addr,target_size,access_addr,access_size,old_value,new_value"
    )
    column_names = expected_columns.split(",")

    with path.open() as stream:
        for line_number, raw_line in enumerate(stream, 1):
            line = raw_line.strip()
            if not line:
                continue
            if phase == "done":
                raise ValueError(
                    f"write trace has a trailing record after COMPLETE at line {line_number}"
                )
            if phase == "init":
                match = init_re.fullmatch(line)
                if match is None:
                    raise ValueError(
                        f"write trace must begin with one exact init record; line {line_number}"
                    )
                version, instruction_start_hook, declared_target_count = map(
                    int, match.groups()
                )
                if declared_target_count != 3:
                    raise ValueError("write trace init must declare exactly 3 targets")
                phase = "targets"
                continue
            if phase == "targets":
                match = target_re.fullmatch(line)
                if match is None:
                    raise ValueError(
                        f"write trace expected an exact target record at line {line_number}"
                    )
                index = int(match.group(1))
                target = (int(match.group(2), 0), int(match.group(3)))
                expected_index = len(target_indices)
                if (
                    index != expected_index
                    or target != ORDERED_WRITE_TARGETS[expected_index]
                    or index in target_indices
                    or target in targets
                ):
                    raise ValueError(
                        f"write trace target {expected_index} has an invalid index/mapping "
                        f"at line {line_number}"
                    )
                target_indices.add(index)
                targets.add(target)
                if len(targets) == 3:
                    phase = "header"
                continue
            if phase == "header":
                if line != expected_columns:
                    raise ValueError(
                        f"write trace expected one exact CSV header at line {line_number}"
                    )
                phase = "data"
                continue
            match = complete_re.fullmatch(line)
            if match is not None:
                complete_frames, complete_events, errors = map(int, match.groups())
                phase = "done"
                continue
            if line.startswith("#") or line == expected_columns:
                raise ValueError(
                    f"write trace has an unknown/duplicate control record at line {line_number}"
                )
            parts = line.split(",")
            if len(parts) != 8:
                raise ValueError(f"malformed write trace row at line {line_number}: {line}")
            try:
                row = {
                    name: parse_number(value)
                    for name, value in zip(column_names, parts, strict=True)
                }
            except ValueError as error:
                raise ValueError(
                    f"invalid numeric write trace row at line {line_number}: {error}"
                ) from error
            rows.append(row)

    if phase != "done":
        raise ValueError("write trace has no single final COMPLETE record")
    return WriteTrace(
        rows=rows,
        targets=targets,
        version=version,
        instruction_start_hook=instruction_start_hook,
        declared_target_count=declared_target_count,
        complete_frames=complete_frames,
        complete_events=complete_events,
        errors=errors,
        incomplete=False,
    )


def convert_rows(
    rows: list[dict[str, str]],
    required_columns: set[str],
) -> list[dict[str, int]]:
    if not rows:
        raise ValueError("CSV has no data rows")
    missing = required_columns - set(rows[0])
    if missing:
        raise ValueError("CSV is missing columns: " + ", ".join(sorted(missing)))
    return [
        {name: parse_number(row[name]) for name in required_columns}
        for row in rows
    ]


def verify_run_provenance(
    fixture: FixtureReport,
    run: object,
    *,
    rom_path: Path,
    rom_sha256: str,
    reference_path: Path,
    reference_sha256: str,
    savestate_path: Path,
    savestate_sha256: str,
    input_path: Path,
    input_sha256: str,
    source_capture_path: Path,
    source_capture_sha256: str,
    total_frames: int,
    expected_terminal_entry_frame: int,
    expected_results_scene_frame: int,
) -> None:
    if not isinstance(run, dict):
        fixture.fail("run_provenance_schema", "run.json must contain an object")
        return
    expected = expected_run_provenance(
        rom_path=rom_path,
        rom_sha256=rom_sha256,
        reference_path=reference_path,
        reference_sha256=reference_sha256,
        savestate_path=savestate_path,
        savestate_sha256=savestate_sha256,
        input_path=input_path,
        input_sha256=input_sha256,
        source_capture_path=source_capture_path,
        source_capture_sha256=source_capture_sha256,
        total_frames=total_frames,
        expected_terminal_entry_frame=expected_terminal_entry_frame,
        expected_results_scene_frame=expected_results_scene_frame,
        frontend_exit_code=0,
    )
    mismatches = [key for key, value in expected.items() if run.get(key) != value]
    unexpected = sorted(set(run) - set(expected))
    missing = sorted(set(expected) - set(run))
    if unexpected:
        mismatches.append("unexpected keys: " + ", ".join(unexpected))
    if missing:
        mismatches.append("missing keys: " + ", ".join(missing))
    if mismatches:
        fixture.fail(
            "run_provenance_mismatch",
            "run.json does not match reviewed capture provenance: " + ", ".join(mismatches),
        )


def expected_run_provenance(
    *,
    rom_path: Path,
    rom_sha256: str,
    reference_path: Path,
    reference_sha256: str,
    savestate_path: Path,
    savestate_sha256: str,
    input_path: Path,
    input_sha256: str,
    source_capture_path: Path,
    source_capture_sha256: str,
    total_frames: int,
    expected_terminal_entry_frame: int,
    expected_results_scene_frame: int,
    frontend_exit_code: int,
) -> dict[str, object]:
    fixture_manifest_entry, fixture_digest = fixture_policy(savestate_path, DEFAULT_MANIFEST)
    if fixture_digest != savestate_sha256:
        raise ValueError("savestate SHA-256 changed while building run provenance")
    return {
        "schema": SCHEMA_VERSION,
        "capture_kind": POLICY_ID,
        "rom": str(rom_path),
        "rom_sha256": rom_sha256,
        "reference_rom": str(reference_path),
        "reference_rom_sha256": reference_sha256,
        "frontend": str(CANONICAL_FRONTEND.resolve()),
        "frontend_sha256": CANONICAL_FRONTEND_SHA256,
        "core": str(CANONICAL_CORE.resolve()),
        "core_sha256": CANONICAL_CORE_SHA256,
        "savestate": str(savestate_path),
        "savestate_sha256": savestate_sha256,
        "fixture_manifest": str(DEFAULT_MANIFEST.resolve()),
        "fixture_manifest_sha256": sha256_file(DEFAULT_MANIFEST),
        "fixture_manifest_entry": fixture_manifest_entry,
        "input_script": str(input_path),
        "input_script_sha256": input_sha256,
        "input_mode": "per-frame CSV replay",
        "source_capture": str(source_capture_path),
        "source_capture_sha256": source_capture_sha256,
        "total_frames": total_frames,
        "expected_terminal_entry_frame": expected_terminal_entry_frame,
        "expected_results_scene_frame": expected_results_scene_frame,
        "warmup_frames": WARMUP_FRAMES,
        "watch_spec": LIFECYCLE_WATCH_SPEC,
        "write_trace_spec": WRITE_TRACE_SPEC,
        "profile_pc": 1,
        "caller_trace_address": f"0x{DEFAULT_HOOK_ADDRESS:08X}",
        "caller_trace_max": 0,
        "scene_pointer": f"0x{DEFAULT_SCENE_POINTER:08X}",
        "hook_return": f"0x{DEFAULT_HOOK_RETURN:08X}",
        "thresholds": asdict(Thresholds()),
        "frontend_exit_code": frontend_exit_code,
        "diagnostic_overrides": [],
    }


def classify_timeout_lifecycle(
    fixture: FixtureReport,
    write_trace: WriteTrace,
    watch_rows: list[dict[str, int]],
    total_frames: int,
    expected_terminal_entry_frame: int,
    expected_results_scene_frame: int,
) -> tuple[int | None, int | None]:
    if (
        write_trace.incomplete
        or write_trace.complete_frames != total_frames
        or write_trace.complete_events is None
        or write_trace.errors != 0
    ):
        fixture.fail(
            "write_trace_incomplete",
            "write trace must end COMPLETE with exact frame count and errors=0",
        )
    if write_trace.complete_events != len(write_trace.rows):
        fixture.fail(
            "write_trace_count",
            f"write trace footer reports {write_trace.complete_events} events, "
            f"but {len(write_trace.rows)} rows were parsed",
        )
    if write_trace.version != 2 or write_trace.instruction_start_hook != 1:
        fixture.fail(
            "write_trace_version",
            "write trace must use reviewed version=2 instruction_start_hook=1",
        )
    if (
        write_trace.declared_target_count != len(REQUIRED_WRITE_TARGETS)
        or write_trace.targets != REQUIRED_WRITE_TARGETS
    ):
        fixture.fail(
            "write_trace_targets",
            "write trace targets must be exactly "
            "0xFFC87E:2, 0xFFC07C:2, and 0xFF0002:4",
        )
    previous_frame = -1
    for row in write_trace.rows:
        if row["frame"] < previous_frame:
            fixture.fail(
                "write_trace_order",
                f"write trace frame {row['frame']} follows frame {previous_frame}",
            )
            break
        previous_frame = row["frame"]
        target = (row["target_addr"], row["target_size"])
        access_end = row["access_addr"] + row["access_size"]
        target_end = row["target_addr"] + row["target_size"]
        if (
            target not in REQUIRED_WRITE_TARGETS
            or row["access_size"] not in (1, 2, 4)
            or row["pc"] == 0xFFFFFFFF
            or row["access_addr"] >= target_end
            or row["target_addr"] >= access_end
        ):
            fixture.fail(
                "write_trace_row",
                f"invalid target/access/PC fields in write-trace frame {row['frame']}",
            )
            break
    invalid_frames = [
        row["frame"] for row in write_trace.rows if not 0 <= row["frame"] < total_frames
    ]
    if invalid_frames:
        fixture.fail(
            "write_trace_frame_range",
            f"write trace contains out-of-range frame {invalid_frames[0]}",
        )

    scene_events = [
        (index, row)
        for index, row in enumerate(write_trace.rows)
        if (row["target_addr"], row["target_size"]) == WRITE_TARGET_SCENE
    ]
    if len(scene_events) != 1:
        fixture.fail(
            "terminal_scene_event_count",
            f"expected exactly one scene-pointer write; found {len(scene_events)}",
        )
        return None, None
    scene_index, scene_event = scene_events[0]
    expected_scene_event = {
        "pc": RESULTS_SCENE_WRITER_PC,
        "access_addr": WRITE_TARGET_SCENE[0],
        "access_size": WRITE_TARGET_SCENE[1],
        "old_value": DEFAULT_SCENE_POINTER,
        "new_value": RESULTS_SCENE_POINTER,
    }
    scene_mismatches = [
        name for name, value in expected_scene_event.items() if scene_event[name] != value
    ]
    if scene_mismatches:
        fixture.fail(
            "terminal_scene_signature",
            "results-scene write does not match reviewed signature: "
            + ", ".join(scene_mismatches),
        )

    display_events = [
        (index, row)
        for index, row in enumerate(write_trace.rows[:scene_index])
        if (row["target_addr"], row["target_size"]) == WRITE_TARGET_DISPLAY_STATE
    ]
    entry_positions = [
        position
        for position, (_index, row) in enumerate(display_events)
        if row["new_value"] == TIMEOUT_DISPLAY_SEQUENCE[0]
    ]
    if len(entry_positions) != 1:
        fixture.fail(
            "terminal_display_entry_count",
            f"expected exactly one pre-exit C07C=0x0014 write; found {len(entry_positions)}",
        )
        return None, scene_event["frame"]
    entry_position = entry_positions[0]
    terminal_events = display_events[entry_position:]
    terminal_values = tuple(row["new_value"] for _index, row in terminal_events)
    if terminal_values != TIMEOUT_DISPLAY_SEQUENCE:
        fixture.fail(
            "terminal_display_sequence",
            "pre-exit C07C new values are "
            + ", ".join(f"0x{value:04X}" for value in terminal_values)
            + "; expected exact reviewed 0x0014..0x0030 sequence",
        )
    if len(terminal_events) == len(TIMEOUT_DISPLAY_WRITE_SIGNATURE):
        for (_event_index, event), (expected_pc, expected_old, expected_new) in zip(
            terminal_events, TIMEOUT_DISPLAY_WRITE_SIGNATURE, strict=True
        ):
            if (
                event["pc"] != expected_pc
                or event["access_addr"] != WRITE_TARGET_DISPLAY_STATE[0]
                or event["access_size"] != WRITE_TARGET_DISPLAY_STATE[1]
            ):
                fixture.fail(
                    "terminal_display_writer",
                    f"C07C 0x{expected_old:04X}->0x{expected_new:04X} was not an "
                    f"exact word write by reviewed PC 0x{expected_pc:08X}",
                )
                break
            if event["old_value"] != expected_old or event["new_value"] != expected_new:
                fixture.fail(
                    "terminal_display_chain",
                    f"reviewed PC 0x{expected_pc:08X} wrote "
                    f"0x{event['old_value']:04X}->0x{event['new_value']:04X}; expected "
                    f"0x{expected_old:04X}->0x{expected_new:04X}",
                )
                break
    entry_index, entry_event = terminal_events[0]
    if entry_index >= scene_index:
        fixture.fail(
            "terminal_event_order",
            "C07C terminal entry does not precede results-scene write",
        )

    boundary = entry_event["frame"]
    scene_frame = scene_event["frame"]
    if boundary != expected_terminal_entry_frame:
        fixture.fail(
            "terminal_boundary_mismatch",
            f"first reviewed C07C=0x0014 write is at frame {boundary}; "
            f"manifest predeclares {expected_terminal_entry_frame}",
        )
    if scene_frame != expected_results_scene_frame:
        fixture.fail(
            "results_scene_frame_mismatch",
            f"reviewed results-scene write is at frame {scene_frame}; "
            f"manifest predeclares {expected_results_scene_frame}",
        )
    if boundary <= WARMUP_FRAMES or boundary >= scene_frame:
        fixture.fail(
            "terminal_event_order",
            f"invalid terminal frames: C07C entry={boundary}, scene exit={scene_frame}",
        )
    if not (0 < boundary < total_frames and 0 <= scene_frame < total_frames):
        fixture.fail("terminal_frame_range", "terminal signature is outside captured frames")
        return None, None

    watch_by_frame = {row["frame"]: row for row in watch_rows}
    if boundary - 1 not in watch_by_frame or boundary not in watch_by_frame:
        fixture.fail("terminal_watch_alignment", "watch trace misses C050 boundary samples")
    else:
        before = watch_by_frame[boundary - 1][WATCH_C050]
        after = watch_by_frame[boundary][WATCH_C050]
        if before != 0xFFFF or after != 0:
            fixture.fail(
                "timeout_counter_signature",
                f"C050 did not show reviewed 0xFFFF->0x0000 expiry at frames "
                f"{boundary - 1}->{boundary}: 0x{before:04X}->0x{after:04X}",
            )
    for frame in range(max(0, boundary - 1), scene_frame + 1):
        row = watch_by_frame.get(frame)
        if row is None:
            fixture.fail("terminal_watch_alignment", f"watch trace misses frame {frame}")
            break
        bad_flags = [
            column
            for column in (WATCH_LAP_EF07, WATCH_LAP_FEB7, WATCH_LAP_FDA8)
            if row[column] != 0
        ]
        if bad_flags:
            fixture.fail(
                "timeout_lap_exclusion",
                f"lap-completion flag {bad_flags[0]} is non-zero at frame {frame}",
            )
            break
    for _index, event in terminal_events:
        watch = watch_by_frame.get(event["frame"])
        if watch is None or watch[WATCH_C07C] != event["new_value"]:
            observed = None if watch is None else watch[WATCH_C07C]
            fixture.fail(
                "terminal_display_watch_mismatch",
                f"C07C write to 0x{event['new_value']:04X} at frame {event['frame']} "
                f"has post-frame watch value "
                + ("missing" if observed is None else f"0x{observed:04X}"),
            )
            break

    return boundary, scene_frame


def validate_active_epoch(
    fixture: FixtureReport,
    frame_rows: list[dict[str, int]],
    watch_rows: list[dict[str, int]],
    caller,
    *,
    active_end: int,
    scene_frame: int,
    total_frames: int,
) -> None:
    thresholds = Thresholds()
    all_frame_numbers = list(range(total_frames))
    if [row["frame"] for row in frame_rows] != all_frame_numbers:
        fixture.fail("frame_sequence", f"frames.csv must contain exactly frames 0-{total_frames - 1}")
        return
    if [row["frame"] for row in watch_rows] != all_frame_numbers:
        fixture.fail("watch_alignment", f"watch.csv must contain exactly frames 0-{total_frames - 1}")
        return

    watch_by_frame = {row["frame"]: row for row in watch_rows}
    preterminal_frames = frame_rows[:active_end]
    preterminal_watches = watch_rows[:active_end]
    if any(row[WATCH_SCENE_POINTER] != DEFAULT_SCENE_POINTER for row in preterminal_watches):
        bad = next(
            row["frame"]
            for row in preterminal_watches
            if row[WATCH_SCENE_POINTER] != DEFAULT_SCENE_POINTER
        )
        fixture.fail(
            "early_or_unknown_scene_exit",
            f"normal-1P scene pointer changed before terminal entry at frame {bad}",
        )
    if any(row["scene"] != (DEFAULT_SCENE_POINTER & 0xFFFF) for row in preterminal_frames):
        bad = next(
            row["frame"]
            for row in preterminal_frames
            if row["scene"] != (DEFAULT_SCENE_POINTER & 0xFFFF)
        )
        fixture.fail("early_or_unknown_scene_exit", f"profile scene changed at frame {bad}")
    if (
        watch_by_frame[scene_frame][WATCH_SCENE_POINTER] != RESULTS_SCENE_POINTER
        or frame_rows[scene_frame]["scene"] != (RESULTS_SCENE_POINTER & 0xFFFF)
    ):
        fixture.fail(
            "terminal_scene_not_observed",
            f"results scene was not observed at exact write frame {scene_frame}",
        )

    selected_frames = frame_rows[WARMUP_FRAMES:active_end]
    selected_watches = watch_rows[WARMUP_FRAMES:active_end]
    active_frames = len(selected_frames)
    fixture.metrics.update(
        {
            "warmup_frames_excluded": WARMUP_FRAMES,
            "active_start_frame": WARMUP_FRAMES,
            "active_end_frame_exclusive": active_end,
            "active_frames": active_frames,
            "terminal_scene_frame": scene_frame,
            "full_windows": active_frames // thresholds.window_frames,
            "final_partial_window_frames": active_frames % thresholds.window_frames,
        }
    )
    if active_frames < MIN_ACTIVE_FRAMES_PER_LIFECYCLE:
        fixture.fail(
            "lifecycle_active_span",
            f"lifecycle has {active_frames} active frames; reviewed minimum is "
            f"{MIN_ACTIVE_FRAMES_PER_LIFECYCLE}",
        )
    if not selected_frames:
        return
    if any(row["is_32x"] != 1 for row in selected_frames):
        fixture.fail("not_32x", "one or more active frames were not marked as 32X")

    states = [row["state"] for row in selected_frames]
    expected_state_set = set(DEFAULT_STATES)
    unexpected = sorted(set(states) - expected_state_set)
    if unexpected:
        fixture.fail(
            "unexpected_state",
            "unexpected C87E values: " + ", ".join(f"0x{value:04X}" for value in unexpected),
        )
    state_stall, stalled_state = longest_run(states)
    fixture.metrics["max_state_stall"] = state_stall
    if state_stall > thresholds.max_state_stall:
        fixture.fail(
            "state_stall",
            f"C87E stayed at 0x{int(stalled_state):04X} for {state_stall} frames "
            f"(limit {thresholds.max_state_stall})",
        )
    state_index = {value: index for index, value in enumerate(DEFAULT_STATES)}
    collapsed: list[tuple[int, int]] = []
    for row in selected_frames:
        if not collapsed or collapsed[-1][1] != row["state"]:
            collapsed.append((row["frame"], row["state"]))
    for (_previous_frame, previous), (frame, current) in pairwise(collapsed):
        if previous in state_index and current in state_index:
            expected_next = DEFAULT_STATES[(state_index[previous] + 1) % len(DEFAULT_STATES)]
            if current != expected_next:
                fixture.fail(
                    "state_order",
                    f"C87E jumped 0x{previous:04X}->0x{current:04X} at frame {frame}; "
                    f"expected 0x{expected_next:04X}",
                )
                break
    full_window_count = len(selected_frames) // thresholds.window_frames
    chunks = [
        selected_frames[offset : offset + thresholds.window_frames]
        for offset in range(0, full_window_count * thresholds.window_frames, thresholds.window_frames)
    ]
    if len(selected_frames) % thresholds.window_frames:
        # Do not discard the tail or judge a 1-3 frame remainder as if it were a
        # standalone 180-frame window.  Recheck the final full-width rolling
        # window so every tail frame participates in a reviewed liveness check.
        chunks.append(selected_frames[-thresholds.window_frames :])
    remainder = len(selected_frames) % thresholds.window_frames
    exact_tail = selected_frames[-remainder:] if remainder else []
    fixture.metrics["tail_check"] = (
        f"overlapping-{thresholds.window_frames}"
        + ("+exact-substantial-tail" if len(exact_tail) >= len(DEFAULT_STATES) else "")
        if remainder
        else "aligned-full-windows"
    )
    fixture.metrics["state_windows_checked"] = len(chunks)
    for chunk in chunks:
        missing = expected_state_set - {row["state"] for row in chunk}
        if missing:
            fixture.fail(
                "state_window",
                f"C87E missed {', '.join(f'0x{value:04X}' for value in sorted(missing))} "
                f"during frames {chunk[0]['frame']}-{chunk[-1]['frame']}",
            )
    if len(exact_tail) >= len(DEFAULT_STATES):
        missing = expected_state_set - {row["state"] for row in exact_tail}
        if missing:
            fixture.fail(
                "state_tail",
                "substantial final partial window missed states: "
                + ", ".join(f"0x{value:04X}" for value in sorted(missing)),
            )

    if caller.pc_enabled != 1:
        fixture.fail("caller_trace_disabled", "caller trace does not report pc_enabled=1")
    if caller.max_hits != 0:
        fixture.fail("caller_trace_capped", "caller trace must be unlimited")
    if caller.complete_frames != total_frames:
        fixture.fail(
            "caller_trace_incomplete",
            f"caller trace COMPLETE frame count is {caller.complete_frames}; expected {total_frames}",
        )
    if (
        caller.total_hits is None
        or caller.logged_hits is None
        or caller.dropped_hits != 0
        or caller.total_hits != caller.logged_hits
        or caller.logged_hits != len(caller.rows)
    ):
        fixture.fail(
            "caller_trace_incomplete",
            "caller trace must have matching total/logged rows and dropped=0",
        )
    invalid_caller_frames = [
        row["frame"] for row in caller.rows if not 0 <= row["frame"] < total_frames
    ]
    if invalid_caller_frames:
        fixture.fail(
            "caller_trace_frame_range",
            f"caller trace contains out-of-range frame {invalid_caller_frames[0]}",
        )
    first_frame = selected_frames[0]["frame"]
    last_frame = selected_frames[-1]["frame"]
    hook_rows = [
        row for row in caller.rows if first_frame <= row["frame"] <= last_frame
    ]
    bad_returns = [row for row in hook_rows if row["return_addr"] != DEFAULT_HOOK_RETURN]
    if bad_returns:
        fixture.fail(
            "wrong_hook_caller",
            f"hook return was 0x{bad_returns[0]['return_addr']:08X} at frame "
            f"{bad_returns[0]['frame']}",
        )
    if not hook_rows:
        fixture.fail("hook_missing", "normal-1P hook has no active-epoch hits")
    else:
        hook_frames = [row["frame"] for row in hook_rows]
        gaps = [hook_frames[0] - first_frame]
        gaps.extend(right - left for left, right in pairwise(hook_frames))
        gaps.append(last_frame - hook_frames[-1])
        max_gap = max(gaps)
        fixture.metrics["max_hook_gap"] = max_gap
        if max_gap > thresholds.max_hook_gap:
            fixture.fail(
                "hook_gap",
                f"normal-1P hook gap is {max_gap} frames (limit {thresholds.max_hook_gap})",
            )
        for chunk in chunks:
            lo, hi = chunk[0]["frame"], chunk[-1]["frame"]
            if not any(lo <= frame <= hi for frame in hook_frames):
                fixture.fail("hook_window", f"no hook hit during frames {lo}-{hi}")
        if len(exact_tail) >= len(DEFAULT_STATES):
            lo, hi = exact_tail[0]["frame"], exact_tail[-1]["frame"]
            if not any(lo <= frame <= hi for frame in hook_frames):
                fixture.fail("hook_tail", f"no hook hit in substantial final tail {lo}-{hi}")

    hashes = [row["fb_crc"] for row in selected_frames]
    if any(value == 0 for value in hashes):
        fixture.fail("framebuffer_hash_disabled", "one or more active framebuffer hashes are zero")
    fb_stall, _value = longest_run(hashes)
    fixture.metrics["max_framebuffer_stall"] = fb_stall
    fixture.metrics["unique_framebuffer_hashes"] = len(set(hashes))
    if fb_stall > thresholds.max_framebuffer_stall:
        fixture.fail(
            "framebuffer_stall",
            f"framebuffer hash was unchanged for {fb_stall} frames "
            f"(limit {thresholds.max_framebuffer_stall})",
        )
    for chunk in chunks:
        if len({row["fb_crc"] for row in chunk}) < 2:
            fixture.fail(
                "framebuffer_window",
                f"no framebuffer change during frames {chunk[0]['frame']}-{chunk[-1]['frame']}",
            )
    if len(exact_tail) >= len(DEFAULT_STATES) and len({row["fb_crc"] for row in exact_tail}) < 2:
        fixture.fail(
            "framebuffer_tail",
            f"no framebuffer change in substantial final tail "
            f"{exact_tail[0]['frame']}-{exact_tail[-1]['frame']}",
        )

    comm_columns = (
        ("comm0_busy", WATCH_COMM0_HI),
        ("comm2_busy", WATCH_COMM2_HI),
        ("comm7_stuck", WATCH_COMM7),
    )
    for code, column in comm_columns:
        stall = longest_nonzero_run([row[column] for row in selected_watches])
        fixture.metrics[f"max_{code}_stall"] = stall
        if stall > thresholds.max_comm_busy_stall:
            fixture.fail(
                code,
                f"{column} remained non-zero for {stall} frames "
                f"(limit {thresholds.max_comm_busy_stall})",
            )
    fixture.metrics["comm1_done_samples"] = sum(
        1 for row in selected_watches if row[WATCH_COMM1_LO] & 1
    )

    for name, column in (("master", "msh2_useful"), ("slave", "ssh2_useful")):
        for chunk in chunks:
            if not any(row[column] > 0 for row in chunk):
                fixture.fail(
                    f"{name}_sh2_no_useful_work",
                    f"{name.title()} SH2 did no useful work during "
                    f"frames {chunk[0]['frame']}-{chunk[-1]['frame']}",
                )
        if len(exact_tail) >= len(DEFAULT_STATES) and not any(
            row[column] > 0 for row in exact_tail
        ):
            fixture.fail(
                f"{name}_sh2_no_tail_work",
                f"{name.title()} SH2 did no useful work in substantial final tail "
                f"{exact_tail[0]['frame']}-{exact_tail[-1]['frame']}",
            )


def analyze_fixture(
    manifest_path: Path,
    entry: object,
    *,
    rom_path: Path,
    rom_sha256: str,
    reference_path: Path,
    reference_sha256: str,
) -> FixtureReport:
    fixture_id = entry.get("id", "<missing>") if isinstance(entry, dict) else "<invalid>"
    fixture = FixtureReport(str(fixture_id))
    if not isinstance(entry, dict):
        fixture.fail("manifest_schema", "fixture entry must be an object")
        return fixture
    expected_fixture_keys = {
        "id", "artifact_dir", "savestate", "input_script", "source_capture",
        "total_frames", "expected_terminal_entry_frame", "expected_results_scene_frame",
        "artifacts",
    }
    if set(entry) != expected_fixture_keys:
        fixture.fail(
            "manifest_schema",
            "fixture entry keys must be exactly: " + ", ".join(sorted(expected_fixture_keys)),
        )
        return fixture
    if not isinstance(fixture_id, str) or not fixture_id:
        fixture.fail("manifest_schema", "fixture id must be a non-empty string")
    total_frames = entry.get("total_frames")
    if not isinstance(total_frames, int) or total_frames <= WARMUP_FRAMES:
        fixture.fail(
            "manifest_schema",
            f"fixture total_frames must be an integer greater than {WARMUP_FRAMES}",
        )
        return fixture
    expected_terminal_entry_frame = entry.get("expected_terminal_entry_frame")
    if (
        not isinstance(expected_terminal_entry_frame, int)
        or not WARMUP_FRAMES < expected_terminal_entry_frame < total_frames
    ):
        fixture.fail(
            "manifest_schema",
            "fixture expected_terminal_entry_frame must be predeclared between "
            f"{WARMUP_FRAMES + 1} and total_frames - 1",
        )
        return fixture
    expected_results_scene_frame = entry.get("expected_results_scene_frame")
    if (
        not isinstance(expected_results_scene_frame, int)
        or not expected_terminal_entry_frame < expected_results_scene_frame < total_frames
    ):
        fixture.fail(
            "manifest_schema",
            "fixture expected_results_scene_frame must be predeclared after "
            "expected_terminal_entry_frame and before total_frames",
        )
        return fixture
    try:
        artifact_dir = resolve_manifest_path(manifest_path, entry.get("artifact_dir"))
    except ValueError as error:
        fixture.fail("manifest_schema", str(error))
        return fixture
    if not artifact_dir.is_dir():
        fixture.fail("artifact_directory_missing", f"artifact directory is missing: {artifact_dir}")
        return fixture

    savestate_path, savestate_sha256 = verify_pinned_file(
        manifest_path, entry.get("savestate"), f"{fixture_id}.savestate", fixture
    )
    input_path, input_sha256 = verify_pinned_file(
        manifest_path, entry.get("input_script"), f"{fixture_id}.input_script", fixture
    )
    source_capture_path, source_capture_sha256 = verify_pinned_file(
        manifest_path, entry.get("source_capture"), f"{fixture_id}.source_capture", fixture
    )
    if None in (
        savestate_path,
        savestate_sha256,
        input_path,
        input_sha256,
        source_capture_path,
        source_capture_sha256,
    ):
        return fixture
    fixture.identity = (
        str(savestate_sha256),
        str(input_sha256),
        str(source_capture_sha256),
    )
    fixture.source_capture_sha256 = str(source_capture_sha256)
    fixture_manifest_entry, fixture_digest = fixture_policy(
        savestate_path, DEFAULT_MANIFEST
    )
    if fixture_digest != savestate_sha256:
        fixture.fail(
            "fixture_policy_hash_mismatch",
            "savestate changed between manifest hash verification and fixture policy",
        )
    if (
        fixture_manifest_entry is not None
        and fixture_manifest_entry.get("status") == "invalid_control"
    ):
        fixture.fail(
            "invalid_control_fixture",
            str(
                fixture_manifest_entry.get(
                    "reason", "control fixture manifest marks savestate invalid"
                )
            ),
        )
    try:
        validated_input_sha = validate_input_script(input_path, total_frames)
    except (OSError, ValueError, csv.Error) as error:
        fixture.fail("input_script_invalid", str(error))
    else:
        if validated_input_sha != input_sha256:
            fixture.fail("input_script_hash_mismatch", "validated input hash changed unexpectedly")

    artifact_hashes = entry.get("artifacts")
    if not isinstance(artifact_hashes, dict):
        fixture.fail("manifest_schema", "fixture artifacts must be an object of pinned hashes")
        return fixture
    if set(artifact_hashes) != set(REQUIRED_ARTIFACTS):
        fixture.fail(
            "manifest_schema",
            "fixture artifacts must pin exactly: " + ", ".join(REQUIRED_ARTIFACTS),
        )
        return fixture
    for name in REQUIRED_ARTIFACTS:
        try:
            expected = require_sha256(artifact_hashes.get(name), f"{fixture_id}.artifacts.{name}")
        except ValueError as error:
            fixture.fail("manifest_schema", str(error))
            continue
        path = artifact_dir / name
        if not path.is_file() or path.stat().st_size == 0:
            fixture.fail("artifact_missing", f"{fixture_id} is missing non-empty {name}")
            continue
        actual = sha256_file(path)
        if actual != expected:
            fixture.fail(
                "artifact_hash_mismatch",
                f"{fixture_id}/{name} SHA-256 is {actual}; manifest pins {expected}",
            )
    if fixture.findings:
        return fixture

    try:
        run = json.loads((artifact_dir / "run.json").read_text())
        frame_rows = convert_rows(
            load_csv(artifact_dir / "frames.csv"),
            {
                "frame", "msh2_cycles", "ssh2_cycles", "msh2_useful", "ssh2_useful",
                "fb_crc", "scene", "state", "is_32x",
            },
        )
        watch_rows = convert_rows(
            load_csv(artifact_dir / "watch.csv"),
            {
                "frame", WATCH_SCENE_POINTER, WATCH_COMM0_HI, WATCH_COMM1_LO,
                WATCH_COMM2_HI, WATCH_COMM7, WATCH_C050, WATCH_C07C,
                WATCH_LAP_EF07, WATCH_LAP_FEB7, WATCH_LAP_FDA8,
            },
        )
        caller = load_caller_trace(artifact_dir / "caller.csv")
        write_trace = load_write_trace(artifact_dir / "write.csv")
    except (OSError, ValueError, csv.Error, json.JSONDecodeError) as error:
        fixture.fail("artifact_parse", str(error))
        return fixture

    verify_run_provenance(
        fixture,
        run,
        rom_path=rom_path,
        rom_sha256=rom_sha256,
        reference_path=reference_path,
        reference_sha256=reference_sha256,
        savestate_path=savestate_path,
        savestate_sha256=savestate_sha256,
        input_path=input_path,
        input_sha256=input_sha256,
        source_capture_path=source_capture_path,
        source_capture_sha256=source_capture_sha256,
        total_frames=total_frames,
        expected_terminal_entry_frame=expected_terminal_entry_frame,
        expected_results_scene_frame=expected_results_scene_frame,
    )
    if len(frame_rows) != total_frames or len(watch_rows) != total_frames:
        fixture.fail(
            "incomplete_frame_artifacts",
            f"frames/watch rows are {len(frame_rows)}/{len(watch_rows)}; expected {total_frames}",
        )
        return fixture
    boundary, scene_frame = classify_timeout_lifecycle(
        fixture,
        write_trace,
        watch_rows,
        total_frames,
        expected_terminal_entry_frame,
        expected_results_scene_frame,
    )
    if boundary is not None and scene_frame is not None:
        validate_active_epoch(
            fixture,
            frame_rows,
            watch_rows,
            caller,
            active_end=boundary,
            scene_frame=scene_frame,
            total_frames=total_frames,
        )
    return fixture


def analyze_suite(manifest_path: Path, *, diagnostic: bool = False) -> SuiteReport:
    report = SuiteReport()
    if manifest_path.is_file():
        report.metrics["manifest_path"] = str(manifest_path)
        report.metrics["manifest_sha256"] = sha256_file(manifest_path)
    try:
        manifest = json.loads(manifest_path.read_text())
    except (OSError, json.JSONDecodeError) as error:
        report.fail("manifest_error", str(error))
        return report
    if not isinstance(manifest, dict):
        report.fail("manifest_schema", "manifest root must be an object")
        return report
    expected_manifest_keys = {
        "schema", "policy_id", "diagnostic", "rom", "reference_rom",
        "frontend", "core", "fixtures",
    }
    if set(manifest) != expected_manifest_keys:
        report.fail(
            "manifest_schema",
            "manifest keys must be exactly: " + ", ".join(sorted(expected_manifest_keys)),
        )
    if manifest.get("schema") != SCHEMA_VERSION or manifest.get("policy_id") != POLICY_ID:
        report.fail(
            "manifest_policy",
            f"manifest must declare schema={SCHEMA_VERSION} and policy_id={POLICY_ID}",
        )
    if manifest.get("diagnostic") is not False:
        report.fail(
            "diagnostic_manifest",
            "manifest diagnostic must be exactly false for acceptance",
        )
    if diagnostic:
        report.fail(
            "diagnostic_override",
            "--diagnostic analysis can never produce PASS",
        )

    rom_path, rom_sha256 = verify_pinned_file(
        manifest_path, manifest.get("rom"), "rom", report
    )
    reference_path, reference_sha256 = verify_pinned_file(
        manifest_path, manifest.get("reference_rom"), "reference_rom", report
    )
    frontend_path, frontend_sha256 = verify_pinned_file(
        manifest_path, manifest.get("frontend"), "frontend", report
    )
    core_path, core_sha256 = verify_pinned_file(
        manifest_path, manifest.get("core"), "core", report
    )
    if None not in (rom_path, rom_sha256, reference_path, reference_sha256):
        comparison = control_rom_policy(rom_path, reference_path)
        if not comparison.eligible:
            report.fail("control_rom_not_isolated", comparison.reason)
    if None not in (frontend_path, frontend_sha256, core_path, core_sha256):
        identity = reviewed_tool_policy(frontend_path, core_path)
        if not identity.eligible:
            report.fail("unreviewed_profiler_tools", identity.reason)

    entries = manifest.get("fixtures")
    if not isinstance(entries, list):
        report.fail("manifest_schema", "fixtures must be an array")
        return report
    if None in (rom_path, rom_sha256, reference_path, reference_sha256):
        return report
    report.fixtures = [
        analyze_fixture(
            manifest_path,
            entry,
            rom_path=rom_path,
            rom_sha256=rom_sha256,
            reference_path=reference_path,
            reference_sha256=reference_sha256,
        )
        for entry in entries
    ]

    seen_ids: set[str] = set()
    seen_identities: dict[tuple[str, str, str], str] = {}
    seen_captures: dict[str, str] = {}
    for fixture in report.fixtures:
        if fixture.fixture_id in seen_ids:
            fixture.fail("duplicate_fixture_id", f"duplicate fixture id {fixture.fixture_id}")
        seen_ids.add(fixture.fixture_id)
        if fixture.identity is not None:
            previous = seen_identities.get(fixture.identity)
            if previous is not None:
                fixture.fail(
                    "duplicate_fixture_identity",
                    f"savestate/input/source identity duplicates fixture {previous}",
                )
            else:
                seen_identities[fixture.identity] = fixture.fixture_id
        if fixture.source_capture_sha256 is not None:
            previous_capture = seen_captures.get(fixture.source_capture_sha256)
            if previous_capture is not None:
                fixture.fail(
                    "duplicate_source_capture",
                    f"source-capture SHA-256 duplicates fixture {previous_capture}",
                )
            else:
                seen_captures[fixture.source_capture_sha256] = fixture.fixture_id

    eligible = [fixture for fixture in report.fixtures if fixture.passed]
    active_spans = [int(fixture.metrics.get("active_frames", 0)) for fixture in eligible]
    aggregate = sum(active_spans)
    longest = max(active_spans, default=0)
    report.metrics.update(
        {
            "reviewed_min_complete_lifecycles": MIN_COMPLETE_LIFECYCLES,
            "reviewed_min_active_frames_per_lifecycle": MIN_ACTIVE_FRAMES_PER_LIFECYCLE,
            "reviewed_min_longest_active_span": MIN_LONGEST_ACTIVE_SPAN,
            "reviewed_min_aggregate_active_frames": MIN_AGGREGATE_ACTIVE_FRAMES,
            "manifest_fixture_count": len(report.fixtures),
            "eligible_distinct_lifecycles": len(eligible),
            "eligible_active_frames_per_lifecycle": active_spans,
            "aggregate_eligible_active_frames": aggregate,
            "longest_eligible_active_span": longest,
        }
    )
    if len(eligible) < MIN_COMPLETE_LIFECYCLES:
        report.fail(
            "insufficient_lifecycle_count",
            f"{len(eligible)} eligible distinct lifecycles; reviewed minimum is "
            f"{MIN_COMPLETE_LIFECYCLES}",
        )
    if longest < MIN_LONGEST_ACTIVE_SPAN:
        report.fail(
            "insufficient_longest_span",
            f"longest eligible active span is {longest}; reviewed minimum is "
            f"{MIN_LONGEST_ACTIVE_SPAN}",
        )
    if aggregate < MIN_AGGREGATE_ACTIVE_FRAMES:
        report.fail(
            "insufficient_aggregate_coverage",
            f"aggregate eligible active coverage is {aggregate}; reviewed minimum is "
            f"{MIN_AGGREGATE_ACTIVE_FRAMES}",
        )
    return report


def run_lifecycle_capture(
    *,
    rom: Path,
    savestate: Path,
    input_script: Path,
    output_dir: Path,
    total_frames: int,
) -> int:
    """Run one fresh capture with a sterile, exact VR60-011 profiler environment."""
    env = {"PATH": os.environ.get("PATH", "/usr/local/bin:/usr/bin:/bin")}
    env.update(
        {
            "VRD_PROFILE_LOG": str((output_dir / "frames.csv").resolve()),
            "VRD_PROFILE_FRAMES": str(total_frames),
            "VRD_PROFILE_PC": "1",
            "VRD_PROFILE_PC_LOG": str((output_dir / "pc.csv").resolve()),
            "VRD_FB_CRC": "1",
            "VRD_SCENE_ADDR": "0xFFC87E",
            "VRD_WATCH": LIFECYCLE_WATCH_SPEC,
            "VRD_WATCH_LOG": str((output_dir / "watch.csv").resolve()),
            "VRD_CALLER_TRACE": f"0x{DEFAULT_HOOK_ADDRESS:X}",
            "VRD_CALLER_TRACE_LOG": str((output_dir / "caller.csv").resolve()),
            "VRD_CALLER_TRACE_MAX": "0",
            "VRD_WRITE_TRACE": WRITE_TRACE_SPEC,
            "VRD_WRITE_TRACE_LOG": str((output_dir / "write.csv").resolve()),
            "VRD_LOAD_STATE": str(savestate),
            "VRD_INPUT_SCRIPT": str(input_script),
        }
    )
    command = [
        str(CANONICAL_FRONTEND.resolve()),
        str(rom),
        str(total_frames),
    ]
    with (output_dir / "frontend.log").open("x") as log:
        process = subprocess.Popen(
            command,
            cwd=CANONICAL_FRONTEND.resolve().parent,
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
        )
        assert process.stdout is not None
        for line in process.stdout:
            log.write(line)
            if line.startswith(("  Frame ", "Running ")):
                print(line, end="", flush=True)
        return process.wait()


def capture_fixture(args: argparse.Namespace) -> int:
    rom = Path(args.rom).resolve()
    reference_rom = Path(args.reference_rom).resolve()
    savestate = Path(args.savestate).resolve()
    input_script = Path(args.input_script).resolve()
    source_capture = Path(args.source_capture).resolve()
    output_dir = Path(args.output_dir).resolve()
    for label, path in (
        ("ROM", rom),
        ("reference ROM", reference_rom),
        ("savestate", savestate),
        ("input script", input_script),
        ("source capture", source_capture),
    ):
        if not path.is_file():
            print(f"FAIL [capture_input_missing] {label} not found: {path}", file=sys.stderr)
            return 2
    comparison = control_rom_policy(rom, reference_rom)
    if not comparison.eligible:
        print(f"FAIL [control_rom_not_isolated] {comparison.reason}", file=sys.stderr)
        return 2
    identity = reviewed_tool_policy(CANONICAL_FRONTEND, CANONICAL_CORE)
    if not identity.eligible:
        print(f"FAIL [unreviewed_profiler_tools] {identity.reason}", file=sys.stderr)
        return 2
    fixture_manifest_entry, _fixture_digest = fixture_policy(savestate, DEFAULT_MANIFEST)
    if (
        fixture_manifest_entry is not None
        and fixture_manifest_entry.get("status") == "invalid_control"
    ):
        reason = str(
            fixture_manifest_entry.get(
                "reason", "control fixture manifest marks savestate invalid"
            )
        )
        print(f"FAIL [invalid_control_fixture] {reason}", file=sys.stderr)
        return 2
    try:
        input_sha256 = validate_input_script(input_script, args.frames)
    except (OSError, ValueError, csv.Error) as error:
        print(f"FAIL [input_script_invalid] {error}", file=sys.stderr)
        return 2
    if not WARMUP_FRAMES < args.expected_terminal_entry_frame < args.frames:
        print(
            "FAIL [terminal_boundary_configuration] expected terminal entry must be "
            f"between {WARMUP_FRAMES + 1} and total frames - 1",
            file=sys.stderr,
        )
        return 2
    if not args.expected_terminal_entry_frame < args.expected_results_scene_frame < args.frames:
        print(
            "FAIL [results_scene_configuration] expected results-scene frame must be "
            "after terminal entry and before total frames",
            file=sys.stderr,
        )
        return 2
    try:
        output_dir.mkdir(parents=True, exist_ok=False)
    except FileExistsError:
        print(
            f"FAIL [output_exists] refusing to reuse capture directory {output_dir}",
            file=sys.stderr,
        )
        return 2

    try:
        frontend_status = run_lifecycle_capture(
            rom=rom,
            savestate=savestate,
            input_script=input_script,
            output_dir=output_dir,
            total_frames=args.frames,
        )
    except OSError as error:
        print(f"FAIL [frontend_error] {error}", file=sys.stderr)
        return 2

    savestate_sha256 = sha256_file(savestate)
    source_capture_sha256 = sha256_file(source_capture)
    run = expected_run_provenance(
        rom_path=rom,
        rom_sha256=comparison.candidate_sha256,
        reference_path=reference_rom,
        reference_sha256=comparison.reference_sha256,
        savestate_path=savestate,
        savestate_sha256=savestate_sha256,
        input_path=input_script,
        input_sha256=input_sha256,
        source_capture_path=source_capture,
        source_capture_sha256=source_capture_sha256,
        total_frames=args.frames,
        expected_terminal_entry_frame=args.expected_terminal_entry_frame,
        expected_results_scene_frame=args.expected_results_scene_frame,
        frontend_exit_code=frontend_status,
    )
    with (output_dir / "run.json").open("x") as stream:
        json.dump(run, stream, indent=2)
        stream.write("\n")
    if frontend_status != 0:
        print(f"FAIL [frontend_exit] profiling frontend exited {frontend_status}", file=sys.stderr)
        return 1
    missing = [
        name
        for name in REQUIRED_ARTIFACTS
        if not (output_dir / name).is_file() or (output_dir / name).stat().st_size == 0
    ]
    if missing:
        print(
            "FAIL [fresh_artifacts_missing] frontend did not produce: " + ", ".join(missing),
            file=sys.stderr,
        )
        return 1

    fixture_entry = {
        "id": args.fixture_id,
        "artifact_dir": str(output_dir),
        "savestate": {
            "path": str(savestate),
            "sha256": savestate_sha256,
        },
        "input_script": {
            "path": str(input_script),
            "sha256": input_sha256,
        },
        "source_capture": {
            "path": str(source_capture),
            "sha256": source_capture_sha256,
        },
        "total_frames": args.frames,
        "expected_terminal_entry_frame": args.expected_terminal_entry_frame,
        "expected_results_scene_frame": args.expected_results_scene_frame,
        "artifacts": {
            name: sha256_file(output_dir / name)
            for name in REQUIRED_ARTIFACTS
        },
    }
    entry_path = output_dir / "fixture-entry.json"
    with entry_path.open("x") as stream:
        json.dump(fixture_entry, stream, indent=2)
        stream.write("\n")
    print(f"CAPTURED: {args.fixture_id}")
    print(json.dumps(fixture_entry, indent=2))
    print(
        "Review this raw capture and copy fixture-entry.json into a suite manifest; "
        "capture alone is not a PASS."
    )
    return 0


def parse_cli(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)
    validate = subparsers.add_parser("validate", help="validate a reviewed suite manifest")
    validate.add_argument("manifest", help="reviewed lifecycle-suite manifest")
    validate.add_argument("--result", help="new path for the JSON result")
    validate.add_argument(
        "--diagnostic",
        action="store_true",
        help="analyze artifacts for diagnosis; the result can never PASS",
    )
    capture = subparsers.add_parser("capture", help="capture one fresh complete lifecycle")
    capture.add_argument("rom", help="reviewed hook-bypass control ROM")
    capture.add_argument("--reference-rom", required=True, help="exact live branch ROM")
    capture.add_argument("--savestate", required=True, help="normal-1P lifecycle start state")
    capture.add_argument("--input-script", required=True, help="exact full-length input replay")
    capture.add_argument(
        "--source-capture",
        required=True,
        help="pinned source replay/capture used to derive the input (may equal input CSV)",
    )
    capture.add_argument("--output-dir", required=True, help="new capture directory")
    capture.add_argument("--fixture-id", required=True, help="stable reviewed fixture identifier")
    capture.add_argument("--frames", required=True, type=int, help="full capture frame count")
    capture.add_argument(
        "--expected-terminal-entry-frame",
        required=True,
        type=int,
        help="predeclared frame of the first reviewed C07C=0x0014 terminal write",
    )
    capture.add_argument(
        "--expected-results-scene-frame",
        required=True,
        type=int,
        help="predeclared frame of the reviewed 0x0088FB98 results-scene write",
    )
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_cli(argv)
    if args.command == "capture":
        return capture_fixture(args)
    manifest_path = Path(args.manifest).resolve()
    result_path = Path(args.result).resolve() if args.result else None
    if result_path is not None and result_path.exists():
        print(f"FAIL [result_exists] refusing to overwrite {result_path}", file=sys.stderr)
        return 2
    report = analyze_suite(manifest_path, diagnostic=args.diagnostic)
    payload = json.dumps(report.to_json(), indent=2) + "\n"
    if result_path is not None:
        result_path.parent.mkdir(parents=True, exist_ok=True)
        try:
            with result_path.open("x") as stream:
                stream.write(payload)
        except FileExistsError:
            print(f"FAIL [result_exists] refusing to overwrite {result_path}", file=sys.stderr)
            return 2
    if report.passed:
        print("PASS: reviewed normal-1P lifecycle suite satisfies VR60-011")
        print(json.dumps(report.metrics, indent=2))
        return 0
    print("FAIL: normal-1P lifecycle suite does not satisfy VR60-011", file=sys.stderr)
    for finding in report.findings:
        print(f"  [{finding.code}] {finding.message}", file=sys.stderr)
    for fixture in report.fixtures:
        for finding in fixture.findings:
            print(
                f"  [{fixture.fixture_id}:{finding.code}] {finding.message}",
                file=sys.stderr,
            )
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
