#!/usr/bin/env python3
"""Capture and validate the separate VR60 Q020 cmd $3E mode-0 gate.

The accepted VR60-011 policy remains unchanged.  This validator reuses its
parsers and liveness/terminal routines, adds the reviewed one-shot mode-0
checks, compares ACTIVE/STAGE-CONTROL/accepted framebuffer chronology, and
counts each Big Forest/Bay Bridge/Acropolis identity only once per arm.
"""

from __future__ import annotations

import argparse
import csv
import io
import json
import os
import re
import subprocess
import sys
import tarfile
from collections.abc import Sequence
from dataclasses import asdict, dataclass, field, replace
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
    Thresholds,
    fixture_policy,
    parse_number,
    reviewed_tool_policy,
    sha256_file,
    validate_input_script,
)
from validate_1p_lifecycle_suite import (
    CALLER_TRACE_VERSION,
    MIN_ACTIVE_FRAMES_PER_LIFECYCLE,
    MIN_AGGREGATE_ACTIVE_FRAMES,
    MIN_COMPLETE_LIFECYCLES,
    MIN_LONGEST_ACTIVE_SPAN,
    WARMUP_FRAMES,
    WRITE_TARGET_DISPLAY_STATE,
    WRITE_TARGET_SCENE,
    WRITE_TARGET_STATE,
    WRITE_TRACE_VERSION,
    FixtureReport,
    LifecycleCallerTrace,
    WriteTrace,
    classify_timeout_lifecycle,
    convert_rows,
    load_csv,
    load_lifecycle_caller_trace,
    require_sha256,
    resolve_manifest_path,
    validate_active_epoch,
    verify_pinned_file,
)
from verify_mode0_rom_pair import (
    EXPECTED_ACTIVE_SHA256,
    EXPECTED_CONTROL_SHA256,
    verify_pair,
)
from verify_mode0_rom_pair import SCHEMA as ROM_PAIR_SCHEMA

SCHEMA_VERSION = 2
POLICY_ID = "VR60-Q020-mode0-gate-v2"
CHECKPOINT_FRAME = 11
REPETITIONS_PER_ARM = 2
EXPECTED_BASE_IDS = ("big-forest", "bay-bridge", "acropolis")
EXPECTED_FIRST_HOOK_FRAMES = {
    "big-forest": 0,
    "bay-bridge": 2,
    "acropolis": 2,
}
# VRD_DUMP_FRAME samples after PicoFrame. The hook-entry tracer labels the
# executing PicoFrame, while the source-to-stage copy becomes dump-visible in
# the immediately following sample.
EXPECTED_SOURCE_STAGE_FRAMES = {
    "big-forest": 1,
    "bay-bridge": 3,
    "acropolis": 3,
}
EXPECTED_ACCEPTED_ARCHIVE_SHA256 = (
    "d173e0bc7fe135e91513805dcb16cf02a84630e1eeb44e6751fd9b6660bcd348"
)
EXPECTED_ACCEPTED_SUITE_SHA256 = (
    "2ebd2689ef7a74a1a3ad3c140f835f80fb24621fb394a63d5e121138040b2716"
)
EXPECTED_ACCEPTED_RESULT_SHA256 = (
    "da3a20c32e2228ad48377f2a7e0c078278f78199ef928c8ff9d8198a0d468a64"
)
EXPECTED_PREFLIGHT_CONTROL_SHA256 = (
    "6a4c89cffa7df47a946b340d39492df05f2be316c76343cf7e4e932a8ca17672"
)
PREFLIGHT_COMMANDS = Path(__file__).resolve().with_name("mode0_preflight.commands")
EXPECTED_PREFLIGHT_COMMANDS_SHA256 = (
    "cd9af832995ea43a42bacaac4102e082c5b3b1075554e79c2f9b32e8986de916"
)

WATCH_FLAG = "0xFF7B40"
WATCH_MODE = "0x20004026"
WATCH_DREQ_LEN = "0x20004010"
WATCH_SENTINEL = "0x2600FC00"
WATCH_COMM0_HI = "0x20004020"
WATCH_COMM1_LO = "0x20004023"
WATCH_SCENE = "0xFF0002"
MODE0_WATCH_SPEC = (
    "0xFF0002:4,"
    "0x20004020:1,0x20004023:1,0x20004024:1,0x2000402E:2,"
    "0xFFC050:2,0xFFC07C:2,0xFFEF07:1,0xFFFEB7:1,0xFFFDA8:1,"
    "0xFF7B40:1,0x20004026:1,0x20004010:2,0x2600FC00:4"
)
MODE0_WRITE_TRACE_SPEC = "0xFFC87E:2,0xFFC07C:2,0xFF0002:4,0xFF7B40:1"
CHECKPOINT_DUMP_SPEC = "0xFF6A00:320,0x0600F20C:320"
SOURCE_STAGE_DUMP_SPEC = "0xFF9000:256,0xFF6A00:256"

WRITE_TARGET_FLAG = (0xFF7B40, 1)
BASELINE_WRITE_TARGETS = {
    WRITE_TARGET_STATE,
    WRITE_TARGET_DISPLAY_STATE,
    WRITE_TARGET_SCENE,
}
MODE0_WRITE_TARGETS = {*BASELINE_WRITE_TARGETS, WRITE_TARGET_FLAG}
ORDERED_MODE0_WRITE_TARGETS = (
    WRITE_TARGET_STATE,
    WRITE_TARGET_DISPLAY_STATE,
    WRITE_TARGET_SCENE,
    WRITE_TARGET_FLAG,
)
FLAG_WRITE_PC = 0x0001C8CA
SENTINEL_VALUE = 0x20004020
RAW_TAIL_PC = 0x00884D6A
LOW_TAIL_ALIAS = 0x00004D6A
LEGITIMATE_TERMINAL_PC = 0x00006C38
EXPECTED_OPTIONAL_FB_MISMATCH = {
    "big-forest": 3,
    "bay-bridge": None,
    "acropolis": 5,
}

REQUIRED_ARTIFACTS = (
    "run.json",
    "frames.csv",
    "watch.csv",
    "caller.csv",
    "write.csv",
    "checkpoint.txt",
    "frontend.log",
)

ACCEPTED_MEMBER_DIR = {
    "big-forest": "big-forest",
    "bay-bridge": "bay-bridge",
    "acropolis": "acropolis",
}
ACCEPTED_SOURCE_NAMES = {
    "big-forest": (
        "sources/big-forest-start.bin",
        "sources/big-forest-input.csv",
        "sources/big-forest.replay",
    ),
    "bay-bridge": (
        "sources/bay-bridge-start.bin",
        "sources/bay-bridge-input.csv",
        "sources/bay-bridge.replay",
    ),
    "acropolis": (
        "sources/acropolis-start.bin",
        "sources/acropolis-input.csv",
        "sources/acropolis.replay",
    ),
}


@dataclass
class LoadedRun:
    arm: str
    base_id: str
    repetition: int
    fixture: FixtureReport
    entry: dict[str, object]
    frames: list[dict[str, int]]
    watches: list[dict[str, int]]
    caller: LifecycleCallerTrace
    write_trace: WriteTrace
    baseline_write_trace: WriteTrace
    checkpoint: dict[int, bytes]
    terminal_entry_frame: int
    results_scene_frame: int
    identity: tuple[str, str, str]
    artifact_hashes: dict[str, str]


@dataclass
class GateReport:
    findings: list[dict[str, str]] = field(default_factory=list)
    runs: list[LoadedRun] = field(default_factory=list)
    metrics: dict[str, object] = field(default_factory=dict)

    @property
    def passed(self) -> bool:
        return not self.findings and all(run.fixture.passed for run in self.runs)

    def fail(self, code: str, message: str) -> None:
        finding = {"code": code, "message": message}
        if finding not in self.findings:
            self.findings.append(finding)

    def to_json(self) -> dict[str, object]:
        return {
            "passed": self.passed,
            "policy_id": POLICY_ID,
            "metrics": self.metrics,
            "findings": self.findings,
            "runs": [
                {
                    "arm": run.arm,
                    "base_id": run.base_id,
                    "repetition": run.repetition,
                    **run.fixture.to_json(),
                }
                for run in self.runs
            ],
        }


def tar_member_bytes(archive: tarfile.TarFile, name: str) -> bytes:
    candidates = (name, f"./{name}")
    for candidate in candidates:
        try:
            member = archive.getmember(candidate)
        except KeyError:
            continue
        stream = archive.extractfile(member)
        if stream is None:
            break
        return stream.read()
    raise ValueError(f"accepted archive member missing: {name}")


def load_csv_bytes(data: bytes) -> list[dict[str, str]]:
    return list(csv.DictReader(io.StringIO(data.decode("utf-8"))))


def parse_dump(path: Path, expected: tuple[tuple[int, int], ...]) -> dict[int, bytes]:
    regions: dict[int, bytearray] = {}
    current_address: int | None = None
    expected_map = {address: length for address, length in expected}
    for raw_line in path.read_text().splitlines():
        line = raw_line.strip()
        if not line:
            continue
        if line.startswith("# DUMP "):
            address_text, end_text = line.removeprefix("# DUMP ").split("..", 1)
            address = int(address_text, 16)
            end = int(end_text, 16)
            if address not in expected_map or end != address + expected_map[address]:
                raise ValueError(f"unexpected dump header {line}")
            if address in regions:
                raise ValueError(f"duplicate dump region 0x{address:08X}")
            regions[address] = bytearray()
            current_address = address
            continue
        if current_address is None or ":" not in line:
            raise ValueError(f"unexpected dump line {line!r}")
        line_address, words_text = line.split(":", 1)
        expected_line_address = current_address + len(regions[current_address])
        if int(line_address, 16) != expected_line_address:
            raise ValueError(f"non-contiguous dump line {line!r}")
        for word in words_text.split():
            if len(word) != 4:
                raise ValueError(f"invalid dump word {word!r}")
            regions[current_address].extend(bytes.fromhex(word))
    if set(regions) != set(expected_map):
        raise ValueError("dump regions do not match the exact reviewed specification")
    parsed = {address: bytes(data) for address, data in regions.items()}
    for address, length in expected:
        if len(parsed[address]) != length:
            raise ValueError(
                f"dump region 0x{address:08X} has {len(parsed[address])} bytes; expected {length}"
            )
    return parsed


def filtered_baseline_trace(trace: WriteTrace) -> WriteTrace:
    rows = [
        row
        for row in trace.rows
        if (row["target_addr"], row["target_size"]) != WRITE_TARGET_FLAG
    ]
    return replace(
        trace,
        rows=rows,
        targets=set(BASELINE_WRITE_TARGETS),
        declared_target_count=len(BASELINE_WRITE_TARGETS),
        complete_events=len(rows),
    )


def load_mode0_write_trace(path: Path) -> WriteTrace:
    """Parse one exact four-target trace without changing VR60-011's parser."""
    rows: list[dict[str, int]] = []
    targets: set[tuple[int, int]] = set()
    version = sh2_drc = profile_pc = profile_pc_env = None
    instruction_start_hook = composed = caller_addr = caller_max = None
    m68k_batching = None
    declared_target_count = complete_frames = complete_events = errors = None
    phase = "init"
    init_re = re.compile(
        r"# VRD_WRITE_TRACE version=(\d+) sh2_drc=(\d+) profile_pc=(\d+) "
        r"profile_pc_env=(\d+) m68k_batching=([a-z]+) "
        r"instruction_start_hook=(\d+) composed=(\d+) "
        r"caller_addr=(0x[0-9A-Fa-f]+) caller_max=(\d+) targets=(\d+)"
    )
    target_re = re.compile(
        r"# TARGET index=(\d+) addr=(0x[0-9A-Fa-f]+) size=(\d+)"
    )
    complete_re = re.compile(r"# COMPLETE frames=(\d+) events=(\d+) errors=(\d+)")
    columns = (
        "frame,pc,target_addr,target_size,access_addr,access_size,old_value,new_value"
    )
    names = columns.split(",")
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
                    raise ValueError("mode0 write trace has invalid init record")
                (
                    version,
                    sh2_drc,
                    profile_pc,
                    profile_pc_env,
                    m68k_batching,
                    instruction_start_hook,
                    composed,
                    caller_addr_text,
                    caller_max,
                    declared_target_count,
                ) = match.groups()
                version = int(version)
                sh2_drc = int(sh2_drc)
                profile_pc = int(profile_pc)
                profile_pc_env = int(profile_pc_env)
                instruction_start_hook = int(instruction_start_hook)
                composed = int(composed)
                caller_addr = int(caller_addr_text, 0)
                caller_max = int(caller_max)
                declared_target_count = int(declared_target_count)
                if declared_target_count != len(ORDERED_MODE0_WRITE_TARGETS):
                    raise ValueError("mode0 write trace must declare exactly four targets")
                phase = "targets"
                continue
            if phase == "targets":
                match = target_re.fullmatch(line)
                if match is None:
                    raise ValueError("mode0 write trace has invalid target record")
                index = int(match.group(1))
                target = (int(match.group(2), 0), int(match.group(3)))
                expected_index = len(targets)
                if (
                    index != expected_index
                    or target != ORDERED_MODE0_WRITE_TARGETS[expected_index]
                    or target in targets
                ):
                    raise ValueError("mode0 write trace target order/mapping changed")
                targets.add(target)
                if len(targets) == len(ORDERED_MODE0_WRITE_TARGETS):
                    phase = "header"
                continue
            if phase == "header":
                if line != columns:
                    raise ValueError("mode0 write trace has invalid CSV header")
                phase = "data"
                continue
            match = complete_re.fullmatch(line)
            if match is not None:
                complete_frames, complete_events, errors = map(int, match.groups())
                phase = "done"
                continue
            if line.startswith("#") or line == columns:
                raise ValueError("mode0 write trace has invalid control record")
            parts = line.split(",")
            if len(parts) != len(names):
                raise ValueError(f"malformed mode0 write row at line {line_number}")
            rows.append(
                {
                    name: parse_number(value)
                    for name, value in zip(names, parts, strict=True)
                }
            )
    if phase != "done":
        raise ValueError("mode0 write trace has no single final COMPLETE record")
    return WriteTrace(
        rows=rows,
        targets=targets,
        version=version,
        sh2_drc=sh2_drc,
        profile_pc=profile_pc,
        profile_pc_env=profile_pc_env,
        m68k_batching=m68k_batching,
        instruction_start_hook=instruction_start_hook,
        composed=composed,
        caller_addr=caller_addr,
        caller_max=caller_max,
        declared_target_count=declared_target_count,
        complete_frames=complete_frames,
        complete_events=complete_events,
        errors=errors,
        incomplete=False,
    )


def validate_flag_transition(
    fixture: FixtureReport,
    write_trace: WriteTrace,
    expected_first_hook: int,
) -> None:
    flag_rows = [
        row
        for row in write_trace.rows
        if (row["target_addr"], row["target_size"]) == WRITE_TARGET_FLAG
    ]
    if len(flag_rows) != 1:
        fixture.fail("flag_write_count", f"expected one flag write, found {len(flag_rows)}")
        return
    flag = flag_rows[0]
    if (
        flag["frame"] != expected_first_hook
        or flag["pc"] != FLAG_WRITE_PC
        or flag["access_addr"] != WRITE_TARGET_FLAG[0]
        or flag["access_size"] != 1
        or flag["old_value"] != 0
        or flag["new_value"] != 1
    ):
        fixture.fail("flag_write_signature", f"unexpected flag row {flag}")


def validate_runtime_checkpoint(
    fixture: FixtureReport,
    *,
    arm: str,
    watches: list[dict[str, int]],
    checkpoint: dict[int, bytes],
    mode_scope_end: int,
) -> None:
    scoped_watches = watches[: mode_scope_end + 1]
    if len(scoped_watches) != mode_scope_end + 1:
        fixture.fail("mode_scope", "mode scope exceeds complete watch coverage")
    elif any(row[WATCH_MODE] != 0 for row in scoped_watches):
        bad = next(row["frame"] for row in scoped_watches if row[WATCH_MODE] != 0)
        fixture.fail("mode_nonzero", f"COMM3_HI nonzero at frame {bad}")
    checkpoint_watch = watches[CHECKPOINT_FRAME]
    if (
        checkpoint_watch[WATCH_FLAG] != 1
        or checkpoint_watch[WATCH_MODE] != 0
        or checkpoint_watch[WATCH_DREQ_LEN] != 0
        or checkpoint_watch[WATCH_COMM1_LO] & 2
        or checkpoint_watch["0x2000402E"] != 0
    ):
        fixture.fail("checkpoint_handshake", f"unsettled checkpoint {checkpoint_watch}")
    if arm == "active":
        if checkpoint_watch[WATCH_SENTINEL] != SENTINEL_VALUE:
            fixture.fail("active_sentinel", "ACTIVE did not produce a fresh cmd3E sentinel")
        if checkpoint[0xFF6A00] != checkpoint[0x0600F20C]:
            fixture.fail("active_payload", "ACTIVE staging and SDRAM payload differ")
    else:
        if any(row[WATCH_SENTINEL] != 0 for row in watches):
            fixture.fail("control_sentinel", "CONTROL sentinel changed")


def compare_checkpoint_pair(
    report: GateReport,
    base_id: str,
    active_run: LoadedRun,
    control_run: LoadedRun,
) -> None:
    active_stage = active_run.checkpoint[0xFF6A00]
    active_destination = active_run.checkpoint[0x0600F20C]
    control_stage = control_run.checkpoint[0xFF6A00]
    control_destination = control_run.checkpoint[0x0600F20C]
    if active_stage != active_destination:
        report.fail("active_payload", f"{base_id} ACTIVE staging/destination differ")
    if active_stage != control_stage:
        report.fail("paired_staging", f"{base_id} ACTIVE/CONTROL staging differs")
    if active_destination == control_destination:
        report.fail("stale_destination", f"{base_id} ACTIVE destination equals CONTROL")


def compare_post_results_mode_chronology(
    report: GateReport,
    base_id: str,
    active_run: LoadedRun,
    control_run: LoadedRun,
) -> None:
    results_frame = active_run.results_scene_frame
    if control_run.results_scene_frame != results_frame:
        report.fail("paired_results_boundary", base_id)
        return
    active_modes = [
        (row["frame"], row[WATCH_MODE])
        for row in active_run.watches[results_frame + 1 :]
    ]
    control_modes = [
        (row["frame"], row[WATCH_MODE])
        for row in control_run.watches[results_frame + 1 :]
    ]
    if active_modes != control_modes:
        report.fail("paired_post_results_mode_chronology", base_id)


def compare_frames_through_terminal(
    report: GateReport,
    base_id: str,
    active_run: LoadedRun,
    control_run: LoadedRun,
    accepted_frames: list[dict[str, str]],
) -> None:
    terminal_frame_inclusive = active_run.terminal_entry_frame
    if (
        len(accepted_frames) != len(active_run.frames)
        or len(active_run.frames) != len(control_run.frames)
        or control_run.terminal_entry_frame != terminal_frame_inclusive
    ):
        report.fail("accepted_frame_count", base_id)
        return
    mismatch_frames: list[int] = []
    for frame in range(terminal_frame_inclusive + 1):
        accepted_row = accepted_frames[frame]
        expected = {
            "frame": frame,
            "scene": parse_number(accepted_row["scene"]),
            "state": parse_number(accepted_row["state"]),
            "is_32x": parse_number(accepted_row["is_32x"]),
        }
        for arm_run in (active_run, control_run):
            observed = {key: arm_run.frames[frame][key] for key in expected}
            if observed != expected:
                report.fail(
                    "gameplay_state_divergence",
                    f"{base_id}/{arm_run.arm} frame {frame}: {observed} != {expected}",
                )
        if active_run.frames[frame]["fb_crc"] != control_run.frames[frame]["fb_crc"]:
            mismatch_frames.append(frame)
    allowed_frame = EXPECTED_OPTIONAL_FB_MISMATCH[base_id]
    if len(mismatch_frames) > 1:
        report.fail(
            "framebuffer_mismatch_count",
            f"{base_id} mismatched at {mismatch_frames}",
        )
    elif mismatch_frames:
        mismatch = mismatch_frames[0]
        if allowed_frame is None or mismatch != allowed_frame:
            report.fail(
                "framebuffer_mismatch_frame",
                f"{base_id} mismatched at {mismatch}; allowed {allowed_frame}",
            )
        if (
            active_run.frames[mismatch]["state"] != 8
            or control_run.frames[mismatch]["state"] != 8
        ):
            report.fail(
                "framebuffer_mismatch_state",
                f"{base_id} frame {mismatch} was not sampled state 8",
            )


def compare_chronology(
    report: GateReport,
    base_id: str,
    active_run: LoadedRun,
    control_run: LoadedRun,
    accepted_caller: list[dict[str, int]],
    accepted_writes: list[dict[str, int]],
) -> None:
    if active_run.caller.rows != control_run.caller.rows:
        report.fail("paired_caller_chronology", base_id)
    if active_run.caller.rows != accepted_caller:
        report.fail("accepted_caller_chronology", base_id)
    if active_run.baseline_write_trace.rows != control_run.baseline_write_trace.rows:
        report.fail("paired_write_chronology", base_id)
    if active_run.baseline_write_trace.rows != accepted_writes:
        report.fail("accepted_write_chronology", base_id)
    for arm_run in (active_run, control_run):
        pcs = [row["pc"] for row in arm_run.baseline_write_trace.rows]
        if RAW_TAIL_PC not in pcs or LOW_TAIL_ALIAS in pcs:
            report.fail("raw_tail_pc", f"{base_id}/{arm_run.arm}")
        terminal_low = [
            row
            for row in arm_run.baseline_write_trace.rows
            if row["pc"] == LEGITIMATE_TERMINAL_PC
        ]
        if not terminal_low or any(
            row["frame"] != arm_run.terminal_entry_frame for row in terminal_low
        ):
            report.fail("terminal_low_pc", f"{base_id}/{arm_run.arm}")


def index_run_matrix(
    report: GateReport,
    runs: list[LoadedRun],
) -> dict[tuple[str, str], list[LoadedRun]]:
    grouped: dict[tuple[str, str], list[LoadedRun]] = {}
    seen_slots: set[tuple[str, str, int]] = set()
    for run in runs:
        slot = (run.arm, run.base_id, run.repetition)
        if slot in seen_slots:
            report.fail("duplicate_run_slot", str(slot))
        seen_slots.add(slot)
        grouped.setdefault((run.arm, run.base_id), []).append(run)
    expected_slots = {
        (arm, base_id, repetition)
        for arm in ("active", "control")
        for base_id in EXPECTED_BASE_IDS
        for repetition in (1, 2)
    }
    if seen_slots != expected_slots:
        report.fail("run_slots", "run arm/base/repetition matrix is incomplete")
    return grouped


def validate_distinct_repetitions(
    report: GateReport,
    grouped: dict[tuple[str, str], list[LoadedRun]],
) -> None:
    for arm in ("active", "control"):
        identities: set[tuple[str, str, str]] = set()
        spans: list[int] = []
        for base_id in EXPECTED_BASE_IDS:
            runs = sorted(grouped.get((arm, base_id), []), key=lambda item: item.repetition)
            if len(runs) != REPETITIONS_PER_ARM:
                continue
            if runs[0].identity != runs[1].identity:
                report.fail("replicate_identity", f"{arm}/{base_id}")
            if runs[0].identity in identities:
                report.fail("duplicate_identity", f"{arm}/{base_id}")
            identities.add(runs[0].identity)
            for artifact in (
                "frames.csv",
                "watch.csv",
                "caller.csv",
                "write.csv",
                "checkpoint.txt",
            ):
                if runs[0].artifact_hashes[artifact] != runs[1].artifact_hashes[artifact]:
                    report.fail("replicate_nondeterminism", f"{arm}/{base_id}/{artifact}")
            spans.append(runs[0].terminal_entry_frame - WARMUP_FRAMES)
        aggregate = sum(spans)
        report.metrics[f"{arm}_eligible_distinct_lifecycles"] = len(spans)
        report.metrics[f"{arm}_active_frames_per_lifecycle"] = spans
        report.metrics[f"{arm}_aggregate_active_frames"] = aggregate
        report.metrics[f"{arm}_longest_active_span"] = max(spans, default=0)
        if (
            len(spans) < MIN_COMPLETE_LIFECYCLES
            or any(span < MIN_ACTIVE_FRAMES_PER_LIFECYCLE for span in spans)
            or aggregate < MIN_AGGREGATE_ACTIVE_FRAMES
            or max(spans, default=0) < MIN_LONGEST_ACTIVE_SPAN
        ):
            report.fail("arm_coverage", f"{arm} did not retain reviewed VR60-011 floors")


def expected_run_provenance(
    *,
    arm: str,
    base_id: str,
    repetition: int,
    rom_path: Path,
    rom_sha256: str,
    pair_manifest_path: Path,
    pair_manifest_sha256: str,
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
        raise ValueError("savestate changed while building run provenance")
    return {
        "schema": SCHEMA_VERSION,
        "capture_kind": POLICY_ID,
        "arm": arm,
        "base_id": base_id,
        "repetition": repetition,
        "rom": str(rom_path),
        "rom_sha256": rom_sha256,
        "rom_pair_manifest": str(pair_manifest_path),
        "rom_pair_manifest_sha256": pair_manifest_sha256,
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
        "checkpoint_frame": CHECKPOINT_FRAME,
        "watch_spec": MODE0_WATCH_SPEC,
        "write_trace_spec": MODE0_WRITE_TRACE_SPEC,
        "dump_spec": CHECKPOINT_DUMP_SPEC,
        "write_trace_version": WRITE_TRACE_VERSION,
        "caller_trace_version": CALLER_TRACE_VERSION,
        "sh2_drc": 1,
        "profile_pc": 0,
        "profile_pc_env_present": 0,
        "m68k_batching": "normal",
        "instruction_start_hook": "composed",
        "caller_trace_address": f"0x{DEFAULT_HOOK_ADDRESS:08X}",
        "caller_trace_max": 0,
        "scene_pointer": f"0x{DEFAULT_SCENE_POINTER:08X}",
        "hook_return": f"0x{DEFAULT_HOOK_RETURN:08X}",
        "thresholds": asdict(Thresholds()),
        "frontend_exit_code": frontend_exit_code,
        "diagnostic_overrides": [],
    }


def verify_run_provenance(
    fixture: FixtureReport,
    run: object,
    expected: dict[str, object],
) -> None:
    if not isinstance(run, dict):
        fixture.fail("run_provenance_schema", "run.json must contain an object")
        return
    mismatches = [key for key, value in expected.items() if run.get(key) != value]
    if set(run) != set(expected):
        mismatches.append("schema keys")
    if mismatches:
        fixture.fail(
            "run_provenance_mismatch",
            "run.json differs from reviewed mode0 capture provenance: "
            + ", ".join(mismatches),
        )


def run_mode0_capture(
    *,
    arm: str,
    base_id: str,
    repetition: int,
    rom: Path,
    pair_manifest: Path,
    savestate: Path,
    input_script: Path,
    source_capture: Path,
    output_dir: Path,
    total_frames: int,
    expected_terminal_entry_frame: int,
    expected_results_scene_frame: int,
) -> int:
    """Capture one immutable mode0 lifecycle in a sterile exact environment."""
    if arm not in ("active", "control"):
        raise ValueError("arm must be active or control")
    output_dir.mkdir(parents=True, exist_ok=False)
    env = {"PATH": os.environ.get("PATH", "/usr/local/bin:/usr/bin:/bin")}
    env.update(
        {
            "VRD_PROFILE_LOG": str((output_dir / "frames.csv").resolve()),
            "VRD_PROFILE_FRAMES": str(total_frames),
            "VRD_FB_CRC": "1",
            "VRD_SCENE_ADDR": "0xFFC87E",
            "VRD_WATCH": MODE0_WATCH_SPEC,
            "VRD_WATCH_LOG": str((output_dir / "watch.csv").resolve()),
            "VRD_CALLER_TRACE": f"0x{DEFAULT_HOOK_ADDRESS:X}",
            "VRD_CALLER_TRACE_LOG": str((output_dir / "caller.csv").resolve()),
            "VRD_CALLER_TRACE_MAX": "0",
            "VRD_WRITE_TRACE": MODE0_WRITE_TRACE_SPEC,
            "VRD_WRITE_TRACE_LOG": str((output_dir / "write.csv").resolve()),
            "VRD_DUMP_FRAME": str(CHECKPOINT_FRAME),
            "VRD_DUMP": CHECKPOINT_DUMP_SPEC,
            "VRD_DUMP_FILE": str((output_dir / "checkpoint.txt").resolve()),
            "VRD_LOAD_STATE": str(savestate),
            "VRD_INPUT_SCRIPT": str(input_script),
        }
    )
    command = [str(CANONICAL_FRONTEND.resolve()), str(rom.resolve()), str(total_frames)]
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
                print(f"[{arm}/{base_id}/r{repetition}] {line}", end="", flush=True)
        frontend_status = process.wait()

    run = expected_run_provenance(
        arm=arm,
        base_id=base_id,
        repetition=repetition,
        rom_path=rom.resolve(),
        rom_sha256=sha256_file(rom),
        pair_manifest_path=pair_manifest.resolve(),
        pair_manifest_sha256=sha256_file(pair_manifest),
        savestate_path=savestate.resolve(),
        savestate_sha256=sha256_file(savestate),
        input_path=input_script.resolve(),
        input_sha256=sha256_file(input_script),
        source_capture_path=source_capture.resolve(),
        source_capture_sha256=sha256_file(source_capture),
        total_frames=total_frames,
        expected_terminal_entry_frame=expected_terminal_entry_frame,
        expected_results_scene_frame=expected_results_scene_frame,
        frontend_exit_code=frontend_status,
    )
    (output_dir / "run.json").write_text(json.dumps(run, indent=2) + "\n")
    return frontend_status


def run_preflight(
    *,
    control_rom: Path,
    savestate: Path,
    output_path: Path,
    command_script: Path = PREFLIGHT_COMMANDS,
) -> int:
    """Read source-state prerequisites through the debugger without a PicoFrame."""
    if sha256_file(command_script) != EXPECTED_PREFLIGHT_COMMANDS_SHA256:
        raise ValueError("preflight debugger command script hash changed")
    env = {"PATH": os.environ.get("PATH", "/usr/local/bin:/usr/bin:/bin")}
    env["VRD_LOAD_STATE"] = str(savestate.resolve())
    command = [
        str(CANONICAL_FRONTEND.resolve()),
        str(control_rom.resolve()),
        "--debug-script",
        str(command_script.resolve()),
    ]
    with output_path.open("x") as transcript:
        process = subprocess.run(
            command,
            cwd=CANONICAL_FRONTEND.resolve().parent,
            env=env,
            text=True,
            stdout=transcript,
            stderr=subprocess.STDOUT,
            check=False,
        )
    return process.returncode


def verify_preflight_transcript(
    path: Path,
    *,
    control_rom: Path,
    savestate: Path,
) -> None:
    """Fail closed unless a raw debugger transcript proves exact frame-0 reads."""
    text = path.read_text()
    lines = text.splitlines()
    expected_commands = [
        "vrd-dbg> status",
        "vrd-dbg> read 68k 0xFF0002 4",
        "vrd-dbg> read 68k 0xFF7B40 1",
        "vrd-dbg> read master 0x20004026 1",
        "vrd-dbg> read master 0x2600FC00 4",
        "vrd-dbg> status",
        "vrd-dbg> quit",
    ]
    observed_commands = [line for line in lines if line.startswith("vrd-dbg> ")]
    if observed_commands != expected_commands:
        raise ValueError("preflight debugger command sequence changed")
    if lines.count("Session frame: 0") != 2 or any(
        line.startswith("Session frame: ") and line != "Session frame: 0"
        for line in lines
    ):
        raise ValueError("preflight is not pinned to debugger session frame 0")
    expected_reads = {
        "00FF0002: 00 88 4C BC",
        "00FF7B40: 00",
        "20004026: 00",
        "2600FC00: 00 00 00 00",
    }
    observed_reads = {
        line
        for line in lines
        if re.fullmatch(r"[0-9A-F]{8}: (?:[0-9A-F]{2})(?: [0-9A-F]{2})*", line)
    }
    if observed_reads != expected_reads:
        raise ValueError(f"preflight debugger values changed: {sorted(observed_reads)}")
    expected_rom_line = f"  ROM: {control_rom.resolve()}"
    expected_state_prefix = f"Loaded state: {savestate.resolve()} ("
    if lines.count(expected_rom_line) != 1:
        raise ValueError("preflight ROM identity line missing/duplicated")
    if sum(line.startswith(expected_state_prefix) for line in lines) != 1:
        raise ValueError("preflight savestate identity line missing/duplicated")
    forbidden = ("PicoFrame", "Advanced ", "Running ")
    if any(token in line for token in forbidden for line in lines):
        raise ValueError("preflight transcript contains frame-advancing output")


def run_source_stage_capture(
    *,
    active_rom: Path,
    savestate: Path,
    input_script: Path,
    dump_frame: int,
    output_dir: Path,
) -> int:
    """Capture the live source/staging relationship independently of cmd $3E."""
    output_dir.mkdir(parents=True, exist_ok=False)
    input_rows = load_csv(input_script)
    prefix_path = output_dir / "input-prefix.csv"
    with prefix_path.open("x", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(("frame", "mask"))
        for frame, row in enumerate(input_rows[: dump_frame + 1]):
            if parse_number(row["frame"]) != frame:
                raise ValueError("source-stage input prefix is not contiguous")
            writer.writerow((frame, row["mask"]))
    validate_input_script(prefix_path, dump_frame + 1)
    env = {"PATH": os.environ.get("PATH", "/usr/local/bin:/usr/bin:/bin")}
    env.update(
        {
            "VRD_PROFILE_FRAMES": str(dump_frame + 1),
            "VRD_DUMP_FRAME": str(dump_frame),
            "VRD_DUMP": SOURCE_STAGE_DUMP_SPEC,
            "VRD_DUMP_FILE": str((output_dir / "source-stage.txt").resolve()),
            "VRD_LOAD_STATE": str(savestate.resolve()),
            "VRD_INPUT_SCRIPT": str(prefix_path.resolve()),
        }
    )
    command = [
        str(CANONICAL_FRONTEND.resolve()),
        str(active_rom.resolve()),
        str(dump_frame + 1),
    ]
    with (output_dir / "frontend.log").open("x") as log:
        process = subprocess.run(
            command,
            cwd=CANONICAL_FRONTEND.resolve().parent,
            env=env,
            text=True,
            stdout=log,
            stderr=subprocess.STDOUT,
            check=False,
        )
    return process.returncode


def load_accepted_metadata(
    archive_path: Path,
    report: GateReport,
) -> tuple[dict[str, object] | None, tarfile.TarFile | None]:
    if sha256_file(archive_path) != EXPECTED_ACCEPTED_ARCHIVE_SHA256:
        report.fail("accepted_archive_hash", "accepted VR60-011 archive SHA-256 changed")
        return None, None
    archive = tarfile.open(archive_path, "r:gz")  # noqa: SIM115 - caller owns lifetime
    try:
        suite_bytes = tar_member_bytes(archive, "suite.json")
        result_bytes = tar_member_bytes(archive, "result.json")
        if sha256_bytes(suite_bytes) != EXPECTED_ACCEPTED_SUITE_SHA256:
            report.fail("accepted_suite_hash", "accepted suite.json SHA-256 changed")
        if sha256_bytes(result_bytes) != EXPECTED_ACCEPTED_RESULT_SHA256:
            report.fail("accepted_result_hash", "accepted result.json SHA-256 changed")
        suite = json.loads(suite_bytes)
    except (ValueError, json.JSONDecodeError):
        archive.close()
        raise
    return suite, archive


def sha256_bytes(data: bytes) -> str:
    import hashlib

    return hashlib.sha256(data).hexdigest()


def accepted_fixture_map(suite: dict[str, object]) -> dict[str, dict[str, object]]:
    fixture_ids = {
        "big-forest-a": "big-forest",
        "bay-bridge-race-a": "bay-bridge",
        "acropolis-race-a": "acropolis",
    }
    result: dict[str, dict[str, object]] = {}
    fixtures = suite.get("fixtures")
    if not isinstance(fixtures, list):
        raise TypeError("accepted suite fixtures missing")
    for entry in fixtures:
        if not isinstance(entry, dict) or entry.get("id") not in fixture_ids:
            raise ValueError("accepted suite fixture identity changed")
        result[fixture_ids[str(entry["id"])]] = entry
    if set(result) != set(EXPECTED_BASE_IDS):
        raise ValueError("accepted suite fixture set changed")
    return result


def verify_preflights(
    manifest_path: Path,
    preflights: object,
    accepted: dict[str, dict[str, object]],
    report: GateReport,
    control_rom: Path,
    expected_base_ids: tuple[str, ...] = EXPECTED_BASE_IDS,
) -> None:
    if not isinstance(preflights, list) or len(preflights) != len(expected_base_ids):
        report.fail(
            "preflight_schema",
            f"exactly {len(expected_base_ids)} preflights are required",
        )
        return
    seen: set[str] = set()
    for entry in preflights:
        if not isinstance(entry, dict) or set(entry) != {
            "base_id",
            "rom_sha256",
            "savestate_path",
            "savestate_sha256",
            "frontend_sha256",
            "core_sha256",
            "command_script_sha256",
            "path",
            "sha256",
        }:
            report.fail("preflight_schema", "preflight keys are invalid")
            continue
        base_id = entry.get("base_id")
        if base_id not in expected_base_ids or base_id in seen:
            report.fail("preflight_identity", f"invalid/duplicate preflight {base_id}")
            continue
        seen.add(str(base_id))
        accepted_state = accepted[str(base_id)]["savestate"]["sha256"]
        try:
            savestate_path = resolve_manifest_path(
                manifest_path, entry.get("savestate_path")
            )
        except ValueError as error:
            report.fail("preflight_schema", str(error))
            continue
        if (
            entry.get("rom_sha256") != EXPECTED_PREFLIGHT_CONTROL_SHA256
            or entry.get("savestate_sha256") != accepted_state
            or entry.get("frontend_sha256") != CANONICAL_FRONTEND_SHA256
            or entry.get("core_sha256") != CANONICAL_CORE_SHA256
            or entry.get("command_script_sha256")
            != EXPECTED_PREFLIGHT_COMMANDS_SHA256
        ):
            report.fail("preflight_identity", f"{base_id} tool/ROM/state identity changed")
        if not savestate_path.is_file() or sha256_file(savestate_path) != accepted_state:
            report.fail("preflight_identity", f"{base_id} savestate missing/tampered")
        try:
            path = resolve_manifest_path(manifest_path, entry.get("path"))
            expected_hash = require_sha256(entry.get("sha256"), "preflight.sha256")
        except ValueError as error:
            report.fail("preflight_schema", str(error))
            continue
        if not path.is_file() or sha256_file(path) != expected_hash:
            report.fail("preflight_hash", f"{base_id} preflight missing/tampered")
            continue
        try:
            verify_preflight_transcript(
                path,
                control_rom=control_rom,
                savestate=savestate_path,
            )
        except (OSError, ValueError) as error:
            report.fail("preflight_values", f"{base_id}: {error}")


def verify_source_stages(
    manifest_path: Path,
    entries: object,
    accepted: dict[str, dict[str, object]],
    report: GateReport,
    expected_base_ids: tuple[str, ...] = EXPECTED_BASE_IDS,
) -> None:
    if not isinstance(entries, list) or len(entries) != len(expected_base_ids):
        report.fail(
            "source_stage_schema",
            f"exactly {len(expected_base_ids)} live source-stage dumps are required",
        )
        return
    seen: set[str] = set()
    for entry in entries:
        expected_keys = {
            "base_id",
            "rom_sha256",
            "savestate_sha256",
            "input_script_sha256",
            "input_prefix",
            "input_prefix_sha256",
            "dump_frame",
            "dump_spec",
            "path",
            "sha256",
        }
        if not isinstance(entry, dict) or set(entry) != expected_keys:
            report.fail("source_stage_schema", "source-stage keys are invalid")
            continue
        base_id = entry.get("base_id")
        if base_id not in expected_base_ids or base_id in seen:
            report.fail("source_stage_identity", f"invalid/duplicate source-stage {base_id}")
            continue
        base_id = str(base_id)
        seen.add(base_id)
        accepted_entry = accepted[base_id]
        if not source_stage_identity_matches(entry, accepted_entry, base_id):
            report.fail("source_stage_identity", f"{base_id} provenance changed")
        try:
            path = resolve_manifest_path(manifest_path, entry.get("path"))
            expected_hash = require_sha256(entry.get("sha256"), "source_stage.sha256")
            input_prefix = resolve_manifest_path(manifest_path, entry.get("input_prefix"))
            prefix_hash = require_sha256(
                entry.get("input_prefix_sha256"),
                "source_stage.input_prefix_sha256",
            )
        except ValueError as error:
            report.fail("source_stage_schema", str(error))
            continue
        if not path.is_file() or sha256_file(path) != expected_hash:
            report.fail("source_stage_hash", f"{base_id} source-stage missing/tampered")
            continue
        if not input_prefix.is_file() or sha256_file(input_prefix) != prefix_hash:
            report.fail("source_stage_hash", f"{base_id} input prefix missing/tampered")
            continue
        try:
            validate_input_script(
                input_prefix,
                EXPECTED_SOURCE_STAGE_FRAMES[base_id] + 1,
            )
        except (OSError, ValueError, csv.Error) as error:
            report.fail("source_stage_input", f"{base_id}: {error}")
            continue
        try:
            regions = parse_dump(path, ((0xFF9000, 0x100), (0xFF6A00, 0x100)))
        except (OSError, ValueError) as error:
            report.fail("source_stage_parse", f"{base_id}: {error}")
            continue
        if regions[0xFF9000] != regions[0xFF6A00]:
            report.fail("source_stage_mismatch", f"{base_id} live source differs from staging")


def source_stage_identity_matches(
    entry: dict[str, object],
    accepted_entry: dict[str, object],
    base_id: str,
) -> bool:
    return (
        entry.get("rom_sha256") == EXPECTED_ACTIVE_SHA256
        and entry.get("savestate_sha256") == accepted_entry["savestate"]["sha256"]
        and entry.get("input_script_sha256")
        == accepted_entry["input_script"]["sha256"]
        and entry.get("dump_frame") == EXPECTED_SOURCE_STAGE_FRAMES[base_id]
        and entry.get("dump_spec") == SOURCE_STAGE_DUMP_SPEC
    )


def accepted_boundaries_match(
    *,
    total_frames: object,
    terminal_entry_frame: object,
    results_scene_frame: object,
    accepted_entry: dict[str, object],
) -> bool:
    return (
        total_frames == accepted_entry["total_frames"]
        and terminal_entry_frame == accepted_entry["expected_terminal_entry_frame"]
        and results_scene_frame == accepted_entry["expected_results_scene_frame"]
    )


def load_run(
    manifest_path: Path,
    entry: object,
    *,
    pair_manifest_path: Path,
    pair_manifest_sha256: str,
    rom_paths: dict[str, Path],
    rom_hashes: dict[str, str],
    accepted: dict[str, dict[str, object]],
) -> LoadedRun | None:
    fixture_id = "<invalid>"
    if isinstance(entry, dict):
        fixture_id = (
            f"{entry.get('arm', '?')}/{entry.get('base_id', '?')}/"
            f"r{entry.get('repetition', '?')}"
        )
    fixture = FixtureReport(fixture_id)
    if not isinstance(entry, dict):
        fixture.fail("manifest_schema", "run entry must be an object")
        return None
    expected_keys = {
        "arm", "base_id", "repetition", "artifact_dir", "savestate",
        "input_script", "source_capture", "total_frames",
        "expected_terminal_entry_frame", "expected_results_scene_frame", "artifacts",
    }
    if set(entry) != expected_keys:
        fixture.fail("manifest_schema", "run entry keys differ from reviewed schema")
        return None
    arm = entry["arm"]
    base_id = entry["base_id"]
    repetition = entry["repetition"]
    if arm not in ("active", "control"):
        fixture.fail("arm", f"invalid arm {arm}")
    if base_id not in EXPECTED_BASE_IDS:
        fixture.fail("base_id", f"invalid base fixture {base_id}")
    if repetition not in (1, 2):
        fixture.fail("repetition", f"invalid repetition {repetition}")
    if fixture.findings:
        return None
    accepted_entry = accepted[str(base_id)]
    total_frames = entry["total_frames"]
    terminal_entry = entry["expected_terminal_entry_frame"]
    results_frame = entry["expected_results_scene_frame"]
    if not accepted_boundaries_match(
        total_frames=total_frames,
        terminal_entry_frame=terminal_entry,
        results_scene_frame=results_frame,
        accepted_entry=accepted_entry,
    ):
        fixture.fail("accepted_boundaries", "total/terminal/results frames changed")

    try:
        artifact_dir = resolve_manifest_path(manifest_path, entry["artifact_dir"])
    except ValueError as error:
        fixture.fail("manifest_schema", str(error))
        return None
    if not artifact_dir.is_dir():
        fixture.fail("artifact_directory_missing", str(artifact_dir))
        return None
    pinned: list[tuple[Path | None, str | None]] = []
    for name in ("savestate", "input_script", "source_capture"):
        pinned.append(
            verify_pinned_file(manifest_path, entry[name], f"{fixture_id}.{name}", fixture)
        )
    if any(path is None or digest is None for path, digest in pinned):
        return None
    (savestate_path, savestate_sha), (input_path, input_sha), (
        source_path,
        source_sha,
    ) = pinned
    assert savestate_path and savestate_sha and input_path and input_sha and source_path and source_sha
    accepted_identity = (
        accepted_entry["savestate"]["sha256"],
        accepted_entry["input_script"]["sha256"],
        accepted_entry["source_capture"]["sha256"],
    )
    identity = (savestate_sha, input_sha, source_sha)
    if identity != accepted_identity:
        fixture.fail("accepted_identity", f"{base_id} source identity changed")
    fixture_manifest_entry, fixture_digest = fixture_policy(savestate_path, DEFAULT_MANIFEST)
    if fixture_digest != savestate_sha:
        fixture.fail("fixture_policy_hash_mismatch", "savestate hash changed")
    if fixture_manifest_entry is not None:
        fixture.fail("fixture_policy", "accepted mode0 source unexpectedly has manifest policy")
    try:
        if validate_input_script(input_path, int(total_frames)) != input_sha:
            fixture.fail("input_script_hash", "validated input hash changed")
    except (OSError, ValueError, csv.Error) as error:
        fixture.fail("input_script_invalid", str(error))

    artifacts = entry["artifacts"]
    if not isinstance(artifacts, dict) or set(artifacts) != set(REQUIRED_ARTIFACTS):
        fixture.fail("artifact_schema", "artifacts must pin the exact reviewed set")
        return None
    artifact_hashes: dict[str, str] = {}
    for name in REQUIRED_ARTIFACTS:
        try:
            expected_hash = require_sha256(artifacts[name], f"{fixture_id}.{name}")
        except ValueError as error:
            fixture.fail("artifact_schema", str(error))
            continue
        path = artifact_dir / name
        if not path.is_file() or path.stat().st_size == 0:
            fixture.fail("artifact_missing", f"{fixture_id}/{name}")
            continue
        digest = sha256_file(path)
        artifact_hashes[name] = digest
        if digest != expected_hash:
            fixture.fail("artifact_hash_mismatch", f"{fixture_id}/{name}")
    if fixture.findings:
        return None
    try:
        run = json.loads((artifact_dir / "run.json").read_text())
        frames = convert_rows(
            load_csv(artifact_dir / "frames.csv"),
            {"frame", "msh2_cycles", "ssh2_cycles", "fb_crc", "scene", "state", "is_32x"},
        )
        watches = convert_rows(
            load_csv(artifact_dir / "watch.csv"),
            {
                "frame", WATCH_SCENE, WATCH_COMM0_HI, WATCH_COMM1_LO,
                "0x20004024", "0x2000402E", "0xFFC050", "0xFFC07C",
                "0xFFEF07", "0xFFFEB7", "0xFFFDA8", WATCH_FLAG, WATCH_MODE,
                WATCH_DREQ_LEN, WATCH_SENTINEL,
            },
        )
        caller = load_lifecycle_caller_trace(artifact_dir / "caller.csv")
        write_trace = load_mode0_write_trace(artifact_dir / "write.csv")
        checkpoint = parse_dump(
            artifact_dir / "checkpoint.txt",
            ((0xFF6A00, 0x140), (0x0600F20C, 0x140)),
        )
    except (OSError, ValueError, csv.Error, json.JSONDecodeError) as error:
        fixture.fail("artifact_parse", str(error))
        return None

    expected_provenance = expected_run_provenance(
        arm=str(arm),
        base_id=str(base_id),
        repetition=int(repetition),
        rom_path=rom_paths[str(arm)],
        rom_sha256=rom_hashes[str(arm)],
        pair_manifest_path=pair_manifest_path,
        pair_manifest_sha256=pair_manifest_sha256,
        savestate_path=savestate_path,
        savestate_sha256=savestate_sha,
        input_path=input_path,
        input_sha256=input_sha,
        source_capture_path=source_path,
        source_capture_sha256=source_sha,
        total_frames=int(total_frames),
        expected_terminal_entry_frame=int(terminal_entry),
        expected_results_scene_frame=int(results_frame),
        frontend_exit_code=0,
    )
    verify_run_provenance(fixture, run, expected_provenance)
    if len(frames) != total_frames or len(watches) != total_frames:
        fixture.fail("incomplete_frame_artifacts", "frames/watch row count mismatch")

    if write_trace.targets != MODE0_WRITE_TARGETS or write_trace.declared_target_count != 4:
        fixture.fail("mode0_write_targets", "write trace must contain baseline targets plus FF7B40:1")
    expected_first_hook = EXPECTED_FIRST_HOOK_FRAMES[str(base_id)]
    # Caller rows name the executing PicoFrame; instruction-start write rows
    # become visible in the immediately following completed-frame sample.
    validate_flag_transition(
        fixture,
        write_trace,
        EXPECTED_SOURCE_STAGE_FRAMES[str(base_id)],
    )

    baseline_trace = filtered_baseline_trace(write_trace)
    boundary, observed_results = classify_timeout_lifecycle(
        fixture,
        baseline_trace,
        watches,
        int(total_frames),
        int(terminal_entry),
        int(results_frame),
    )
    if boundary is not None and observed_results is not None:
        validate_active_epoch(
            fixture,
            frames,
            watches,
            caller,
            baseline_trace,
            active_end=boundary,
            scene_frame=observed_results,
            total_frames=int(total_frames),
        )

    if not caller.rows or caller.rows[0]["frame"] != expected_first_hook:
        fixture.fail("first_hook_frame", f"{base_id} first hook frame changed")
    validate_runtime_checkpoint(
        fixture,
        arm=str(arm),
        watches=watches,
        checkpoint=checkpoint,
        mode_scope_end=int(results_frame),
    )

    return LoadedRun(
        str(arm),
        str(base_id),
        int(repetition),
        fixture,
        entry,
        frames,
        watches,
        caller,
        write_trace,
        baseline_trace,
        checkpoint,
        int(terminal_entry),
        int(results_frame),
        identity,
        artifact_hashes,
    )


def parsed_caller_rows(data: bytes) -> list[dict[str, int]]:
    with io.StringIO(data.decode("utf-8")) as stream:
        rows = [
            row
            for row in csv.DictReader(
                line for line in stream if not line.startswith("#")
            )
        ]
    return [
        {name: parse_number(value) for name, value in row.items()}
        for row in rows
    ]


def parsed_write_rows(data: bytes) -> list[dict[str, int]]:
    with io.StringIO(data.decode("utf-8")) as stream:
        rows = [
            row
            for row in csv.DictReader(
                line for line in stream if not line.startswith("#")
            )
        ]
    return [
        {name: parse_number(value) for name, value in row.items()}
        for row in rows
    ]


def analyze_gate(manifest_path: Path, *, diagnostic: bool = False) -> GateReport:
    report = GateReport()
    if manifest_path.is_file():
        report.metrics["manifest_sha256"] = sha256_file(manifest_path)
    try:
        manifest = json.loads(manifest_path.read_text())
    except (OSError, json.JSONDecodeError) as error:
        report.fail("manifest_error", str(error))
        return report
    if not isinstance(manifest, dict) or set(manifest) != {
        "schema", "policy_id", "diagnostic", "rom_pair_manifest",
        "preflight_control", "accepted_evidence", "frontend", "core",
        "preflights", "source_stages", "runs",
    }:
        report.fail("manifest_schema", "manifest root keys differ from reviewed schema")
        return report
    if (
        manifest["schema"] != SCHEMA_VERSION
        or manifest["policy_id"] != POLICY_ID
        or manifest["diagnostic"] is not diagnostic
    ):
        report.fail("policy", "schema/policy/diagnostic mode is not acceptance-eligible")
    if diagnostic:
        report.fail(
            "diagnostic_nonacceptance",
            "pair diagnostic cannot satisfy or contribute to the 12-slot acceptance gate",
        )

    pair_path, pair_hash = verify_pinned_file(
        manifest_path, manifest["rom_pair_manifest"], "rom_pair_manifest", report
    )
    preflight_control_path, preflight_control_hash = verify_pinned_file(
        manifest_path, manifest["preflight_control"], "preflight_control", report
    )
    archive_path, archive_hash = verify_pinned_file(
        manifest_path, manifest["accepted_evidence"], "accepted_evidence", report
    )
    frontend_path, _frontend_hash = verify_pinned_file(
        manifest_path, manifest["frontend"], "frontend", report
    )
    core_path, _core_hash = verify_pinned_file(
        manifest_path, manifest["core"], "core", report
    )
    if None in (
        pair_path,
        pair_hash,
        preflight_control_path,
        preflight_control_hash,
        archive_path,
        archive_hash,
        frontend_path,
        core_path,
    ):
        return report
    if preflight_control_hash != EXPECTED_PREFLIGHT_CONTROL_SHA256:
        report.fail(
            "preflight_control_hash",
            "preflight ROM is not the accepted source-built hook-bypass control",
        )
    identity = reviewed_tool_policy(frontend_path, core_path)
    if not identity.eligible:
        report.fail("tool_identity", identity.reason)
    try:
        pair = json.loads(pair_path.read_text())
    except (OSError, json.JSONDecodeError) as error:
        report.fail("rom_pair_manifest", str(error))
        return report
    if (
        not isinstance(pair, dict)
        or pair.get("schema") != ROM_PAIR_SCHEMA
        or pair.get("eligible") is not True
        or pair.get("active_sha256") != EXPECTED_ACTIVE_SHA256
        or pair.get("control_sha256") != EXPECTED_CONTROL_SHA256
    ):
        report.fail("rom_pair_manifest", "ROM-pair manifest is not the reviewed passing pair")
        return report
    active_path = Path(str(pair["active_path"])).resolve()
    control_path = Path(str(pair["control_path"])).resolve()
    default_path = Path(str(pair["default_reference_path"])).resolve()
    pair_recheck = verify_pair(active_path, control_path, default_path)
    if not pair_recheck["eligible"]:
        report.fail("rom_pair_recheck", ", ".join(pair_recheck["findings"]))
    rom_paths = {"active": active_path, "control": control_path}
    rom_hashes = {
        "active": str(pair["active_sha256"]),
        "control": str(pair["control_sha256"]),
    }

    try:
        accepted_suite, archive = load_accepted_metadata(archive_path, report)
        if accepted_suite is None or archive is None:
            return report
        accepted = accepted_fixture_map(accepted_suite)
    except (OSError, ValueError, tarfile.TarError, json.JSONDecodeError) as error:
        report.fail("accepted_evidence", str(error))
        return report
    try:
        entries = manifest["runs"]
        diagnostic_base_ids: tuple[str, ...] = EXPECTED_BASE_IDS
        if diagnostic and isinstance(entries, list):
            diagnostic_base_ids = tuple(
                sorted(
                    {
                        str(entry.get("base_id"))
                        for entry in entries
                        if isinstance(entry, dict)
                        and entry.get("base_id") in EXPECTED_BASE_IDS
                    }
                )
            )
        verify_preflights(
            manifest_path,
            manifest["preflights"],
            accepted,
            report,
            preflight_control_path,
            diagnostic_base_ids,
        )
        verify_source_stages(
            manifest_path,
            manifest["source_stages"],
            accepted,
            report,
            diagnostic_base_ids,
        )
        if not isinstance(entries, list) or len(entries) != 12:
            report.fail("run_count", "exactly 12 runs (2 arms x 3 fixtures x 2) are required")
            entries = [] if not isinstance(entries, list) else entries
        for entry in entries:
            run = load_run(
                manifest_path,
                entry,
                pair_manifest_path=pair_path,
                pair_manifest_sha256=pair_hash,
                rom_paths=rom_paths,
                rom_hashes=rom_hashes,
                accepted=accepted,
            )
            if run is not None:
                report.runs.append(run)

        grouped = index_run_matrix(report, report.runs)
        validate_distinct_repetitions(report, grouped)

        for base_id in EXPECTED_BASE_IDS:
            active_runs = sorted(
                grouped.get(("active", base_id), []), key=lambda item: item.repetition
            )
            control_runs = sorted(
                grouped.get(("control", base_id), []), key=lambda item: item.repetition
            )
            if len(active_runs) != REPETITIONS_PER_ARM or len(control_runs) != REPETITIONS_PER_ARM:
                continue
            member_dir = ACCEPTED_MEMBER_DIR[base_id]
            accepted_frames = load_csv_bytes(
                tar_member_bytes(archive, f"{member_dir}/frames.csv")
            )
            accepted_caller = parsed_caller_rows(
                tar_member_bytes(archive, f"{member_dir}/caller.csv")
            )
            accepted_writes = parsed_write_rows(
                tar_member_bytes(archive, f"{member_dir}/write.csv")
            )
            for active_run, control_run in zip(
                active_runs, control_runs, strict=True
            ):
                if active_run.repetition != control_run.repetition:
                    report.fail("paired_repetition", base_id)
                    continue
                compare_checkpoint_pair(report, base_id, active_run, control_run)
                compare_post_results_mode_chronology(
                    report, base_id, active_run, control_run
                )
                compare_frames_through_terminal(
                    report,
                    base_id,
                    active_run,
                    control_run,
                    accepted_frames,
                )
                compare_chronology(
                    report,
                    base_id,
                    active_run,
                    control_run,
                    accepted_caller,
                    accepted_writes,
                )
    finally:
        archive.close()
    return report


def capture_command(args: argparse.Namespace) -> int:
    try:
        status = run_mode0_capture(
            arm=args.arm,
            base_id=args.base_id,
            repetition=args.repetition,
            rom=args.rom.resolve(),
            pair_manifest=args.rom_pair_manifest.resolve(),
            savestate=args.savestate.resolve(),
            input_script=args.input_script.resolve(),
            source_capture=args.source_capture.resolve(),
            output_dir=args.output_dir.resolve(),
            total_frames=args.frames,
            expected_terminal_entry_frame=args.expected_terminal_entry_frame,
            expected_results_scene_frame=args.expected_results_scene_frame,
        )
    except (OSError, ValueError) as error:
        print(f"FAIL [mode0_capture] {error}", file=sys.stderr)
        return 2
    if status != 0:
        print(f"FAIL [mode0_capture] frontend exited {status}", file=sys.stderr)
        return 1
    artifact_hashes = {
        name: sha256_file(args.output_dir.resolve() / name)
        for name in REQUIRED_ARTIFACTS
    }
    entry = {
        "arm": args.arm,
        "base_id": args.base_id,
        "repetition": args.repetition,
        "artifact_dir": str(args.output_dir.resolve()),
        "savestate": {
            "path": str(args.savestate.resolve()),
            "sha256": sha256_file(args.savestate),
        },
        "input_script": {
            "path": str(args.input_script.resolve()),
            "sha256": sha256_file(args.input_script),
        },
        "source_capture": {
            "path": str(args.source_capture.resolve()),
            "sha256": sha256_file(args.source_capture),
        },
        "total_frames": args.frames,
        "expected_terminal_entry_frame": args.expected_terminal_entry_frame,
        "expected_results_scene_frame": args.expected_results_scene_frame,
        "artifacts": artifact_hashes,
    }
    entry_path = args.output_dir.resolve() / "entry.json"
    entry_path.write_text(json.dumps(entry, indent=2) + "\n")
    print(f"PASS [mode0_capture] entry={entry_path}")
    return 0


def validate_command(args: argparse.Namespace) -> int:
    report = analyze_gate(args.manifest.resolve(), diagnostic=args.diagnostic)
    payload = report.to_json()
    if args.json:
        print(json.dumps(payload, indent=2))
    else:
        verdict = "PASS" if report.passed else "FAIL"
        print(f"{verdict} [{POLICY_ID}]")
        for finding in report.findings:
            print(f"  {finding['code']}: {finding['message']}")
        for run in report.runs:
            for finding in run.fixture.findings:
                print(
                    f"  {run.arm}/{run.base_id}/r{run.repetition} "
                    f"{finding.code}: {finding.message}"
                )
        for key, value in report.metrics.items():
            print(f"  {key}={value}")
    return 0 if report.passed else 1


def pair_diagnostic_command(args: argparse.Namespace) -> int:
    report = analyze_gate(args.manifest.resolve(), diagnostic=True)
    allowed_nonacceptance = {
        "diagnostic_nonacceptance",
        "run_count",
        "run_slots",
        "arm_coverage",
    }
    unexpected = [
        finding
        for finding in report.findings
        if finding["code"] not in allowed_nonacceptance
    ]
    slots = {(run.arm, run.base_id, run.repetition) for run in report.runs}
    bases = {run.base_id for run in report.runs}
    repetitions = {run.repetition for run in report.runs}
    expected_arms = {run.arm for run in report.runs} == {"active", "control"}
    checks_passed = (
        not unexpected
        and len(report.runs) == 2
        and len(slots) == 2
        and len(bases) == 1
        and len(repetitions) == 1
        and expected_arms
        and all(run.fixture.passed for run in report.runs)
    )
    payload = {
        "diagnostic_checks_passed": checks_passed,
        "gate_eligible": False,
        "reason": "two-run milestone is not the required 12-slot acceptance matrix",
        "report": report.to_json(),
    }
    if args.json:
        print(json.dumps(payload, indent=2))
    else:
        verdict = "PASS" if checks_passed else "FAIL"
        print(f"{verdict} [{POLICY_ID} pair diagnostic; gate_eligible=false]")
        for finding in unexpected:
            print(f"  {finding['code']}: {finding['message']}")
        for run in report.runs:
            for finding in run.fixture.findings:
                print(
                    f"  {run.arm}/{run.base_id}/r{run.repetition} "
                    f"{finding.code}: {finding.message}"
                )
    return 0 if checks_passed else 1


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)
    capture = subparsers.add_parser("capture")
    capture.add_argument("--arm", choices=("active", "control"), required=True)
    capture.add_argument("--base-id", choices=EXPECTED_BASE_IDS, required=True)
    capture.add_argument("--repetition", type=int, choices=(1, 2), required=True)
    capture.add_argument("--rom", type=Path, required=True)
    capture.add_argument("--rom-pair-manifest", type=Path, required=True)
    capture.add_argument("--savestate", type=Path, required=True)
    capture.add_argument("--input-script", type=Path, required=True)
    capture.add_argument("--source-capture", type=Path, required=True)
    capture.add_argument("--output-dir", type=Path, required=True)
    capture.add_argument("--frames", type=int, required=True)
    capture.add_argument("--expected-terminal-entry-frame", type=int, required=True)
    capture.add_argument("--expected-results-scene-frame", type=int, required=True)
    capture.set_defaults(func=capture_command)

    validate = subparsers.add_parser("validate")
    validate.add_argument("--manifest", type=Path, required=True)
    validate.add_argument("--diagnostic", action="store_true")
    validate.add_argument("--json", action="store_true")
    validate.set_defaults(func=validate_command)

    pair = subparsers.add_parser("validate-pair-diagnostic")
    pair.add_argument("--manifest", type=Path, required=True)
    pair.add_argument("--json", action="store_true")
    pair.set_defaults(func=pair_diagnostic_command)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
