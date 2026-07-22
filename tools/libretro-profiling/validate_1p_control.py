#!/usr/bin/env python3
"""Run and validate a deterministic normal-1P VRD control fixture.

This is a correctness gate, not an FPS benchmark.  It combines independent
signals from the instrumented PicoDrive core and exits non-zero if any signal
stops being live during the requested validation window.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import os
from dataclasses import asdict, dataclass, field
from pathlib import Path
import re
import subprocess
import sys
from typing import Iterable, Sequence


SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_MANIFEST = SCRIPT_DIR / "control_fixtures.json"
CANONICAL_FRONTEND = SCRIPT_DIR / "profiling_frontend"
CANONICAL_CORE = SCRIPT_DIR / "picodrive_libretro.so"
# These binaries were rebuilt from the reviewed tracked frontend source and
# libretro_vrd_profiling_v4.patch.  Changing either identity requires an
# explicit review and constant update before the new tool can produce PASS.
CANONICAL_FRONTEND_SHA256 = "31bddb9e49951ee447640f71a0ec4fab5858a6e8f8d35adc1c4b16e5c72eecf0"
CANONICAL_CORE_SHA256 = "1375814edb9d7a487ff11b4a7cec4eb9fb24ea10e3f5e4f99a80bce4875dcb92"
DEFAULT_SCENE_POINTER = 0x00884CBC
DEFAULT_HOOK_ADDRESS = 0x00884D1A
DEFAULT_HOOK_RETURN = 0x00FF0006
DEFAULT_STATES = (0x0000, 0x0004, 0x0008, 0x000C)
MIN_CONTROL_FRAMES = 18_000
MAX_CONTROL_WINDOW_FRAMES = 180
HOOK_SITE_OFFSET = 0x004D62
HOOK_SITE_STOCK_BYTES = bytes.fromhex("4EBA69764EBA691C")
HOOK_SITE_LIVE_BYTES = bytes.fromhex("4EF90001C8B04E71")

WATCH_SCENE_POINTER = "0xFF0002"
WATCH_COMM0_HI = "0x20004020"
WATCH_COMM1_LO = "0x20004023"
WATCH_COMM2_HI = "0x20004024"
WATCH_COMM7 = "0x2000402E"
WATCH_SPEC = (
    "0xFF0002:4,"
    "0x20004020:1,0x20004023:1,0x20004024:1,0x2000402E:2"
)


@dataclass(frozen=True)
class Thresholds:
    window_frames: int = 180
    max_state_stall: int = 12
    max_hook_gap: int = 12
    max_framebuffer_stall: int = 30
    max_comm_busy_stall: int = 12


@dataclass(frozen=True)
class Finding:
    code: str
    message: str


@dataclass
class ValidationReport:
    findings: list[Finding] = field(default_factory=list)
    metrics: dict[str, object] = field(default_factory=dict)

    @property
    def passed(self) -> bool:
        return not self.findings

    def fail(self, code: str, message: str) -> None:
        if not any(item.code == code and item.message == message for item in self.findings):
            self.findings.append(Finding(code, message))

    def to_json(self) -> dict[str, object]:
        return {
            "passed": self.passed,
            "metrics": self.metrics,
            "findings": [asdict(item) for item in self.findings],
        }


@dataclass(frozen=True)
class CallerTrace:
    rows: list[dict[str, int]]
    complete_frames: int | None
    total_hits: int | None
    logged_hits: int | None
    dropped_hits: int | None
    max_hits: int | None
    pc_enabled: int | None


@dataclass(frozen=True)
class ControlRomComparison:
    eligible: bool
    reason: str
    candidate_sha256: str
    reference_sha256: str
    candidate_size: int
    reference_size: int
    candidate_hook_bytes: str
    reference_hook_bytes: str
    outside_hook_difference_count: int | None
    first_outside_hook_difference: str | None


@dataclass(frozen=True)
class ToolIdentity:
    eligible: bool
    reason: str
    frontend_path: str
    frontend_sha256: str | None
    core_path: str
    core_sha256: str | None


def parse_number(value: str) -> int:
    return int(value.strip(), 0)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def sha256_if_file(path: Path) -> str | None:
    return sha256_file(path) if path.is_file() else None


def reviewed_tool_policy(frontend: Path, core: Path) -> ToolIdentity:
    frontend = frontend.resolve()
    core = core.resolve()
    frontend_digest = sha256_if_file(frontend)
    core_digest = sha256_if_file(core)
    reasons: list[str] = []
    if frontend != CANONICAL_FRONTEND.resolve():
        reasons.append(f"frontend path is not canonical: {frontend}")
    if core != CANONICAL_CORE.resolve():
        reasons.append(f"core path is not canonical: {core}")
    if frontend_digest != CANONICAL_FRONTEND_SHA256:
        reasons.append("frontend SHA-256 does not match the reviewed identity")
    if core_digest != CANONICAL_CORE_SHA256:
        reasons.append("core SHA-256 does not match the reviewed identity")
    return ToolIdentity(
        eligible=not reasons,
        reason="reviewed canonical profiler binaries" if not reasons else "; ".join(reasons),
        frontend_path=str(frontend),
        frontend_sha256=frontend_digest,
        core_path=str(core),
        core_sha256=core_digest,
    )


def load_csv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="") as stream:
        return list(csv.DictReader(stream))


def load_caller_trace(path: Path) -> CallerTrace:
    rows: list[dict[str, int]] = []
    complete_frames = total_hits = logged_hits = dropped_hits = None
    max_hits = pc_enabled = None
    saw_header = False

    init_re = re.compile(r"pc_enabled=(\d+)\s+max_hits=(\d+)")
    complete_re = re.compile(
        r"frames=(\d+)\s+hits=(\d+)\s+logged=(\d+)\s+dropped=(\d+)"
    )
    with path.open() as stream:
        for raw_line in stream:
            line = raw_line.strip()
            if not line:
                continue
            if line.startswith("# VRD_CALLER_TRACE"):
                match = init_re.search(line)
                if match:
                    pc_enabled, max_hits = map(int, match.groups())
                continue
            if line.startswith("# COMPLETE"):
                match = complete_re.search(line)
                if match:
                    complete_frames, total_hits, logged_hits, dropped_hits = map(
                        int, match.groups()
                    )
                continue
            if line == "frame,sp,return_addr":
                saw_header = True
                continue
            if line.startswith("#"):
                continue
            parts = line.split(",")
            if len(parts) != 3:
                raise ValueError(f"malformed caller trace row: {line}")
            rows.append(
                {
                    "frame": parse_number(parts[0]),
                    "sp": parse_number(parts[1]),
                    "return_addr": parse_number(parts[2]),
                }
            )

    if not saw_header:
        raise ValueError("caller trace has no CSV header; profiler core is stale")
    return CallerTrace(
        rows, complete_frames, total_hits, logged_hits, dropped_hits, max_hits, pc_enabled
    )


def longest_run(values: Iterable[object], predicate=lambda _value: True) -> tuple[int, object | None]:
    best = current = 0
    best_value: object | None = None
    previous: object | None = None
    for value in values:
        if predicate(value) and value == previous:
            current += 1
        elif predicate(value):
            current = 1
        else:
            current = 0
        if current > best:
            best, best_value = current, value
        previous = value
    return best, best_value


def longest_nonzero_run(values: Iterable[int]) -> int:
    best = current = 0
    for value in values:
        current = current + 1 if value != 0 else 0
        best = max(best, current)
    return best


def windows(rows: Sequence[dict[str, object]], size: int) -> Iterable[Sequence[dict[str, object]]]:
    for offset in range(0, len(rows), size):
        yield rows[offset : offset + size]


def fixture_policy(savestate: Path, manifest_path: Path) -> tuple[dict[str, object] | None, str]:
    manifest = json.loads(manifest_path.read_text())
    digest = sha256_file(savestate)
    for entry in manifest.get("fixtures", []):
        if entry.get("sha256", "").lower() == digest:
            return entry, digest
    return None, digest


def control_rom_policy(rom: Path, reference_rom: Path) -> ControlRomComparison:
    """Prove that a control ROM differs from the live branch ROM only at the hook.

    Checking the candidate hook bytes alone is insufficient: any unrelated ROM edit could
    otherwise enter the control.  The reference must contain the reviewed live jump, the
    candidate must contain the reviewed stock JSR pair, and every byte outside that eight-byte
    span must be identical.
    """
    candidate = rom.read_bytes()
    reference = reference_rom.read_bytes()
    hook_end = HOOK_SITE_OFFSET + len(HOOK_SITE_STOCK_BYTES)
    candidate_hook = candidate[HOOK_SITE_OFFSET:hook_end]
    reference_hook = reference[HOOK_SITE_OFFSET:hook_end]

    outside_difference_count: int | None = None
    first_outside_difference: str | None = None
    if len(candidate) == len(reference):
        outside_difference_count = 0
        for offset, (candidate_byte, reference_byte) in enumerate(zip(candidate, reference)):
            if (
                not HOOK_SITE_OFFSET <= offset < hook_end
                and candidate_byte != reference_byte
            ):
                outside_difference_count += 1
                if first_outside_difference is None:
                    first_outside_difference = f"0x{offset:X}"

    reasons: list[str] = []
    if reference_hook != HOOK_SITE_LIVE_BYTES:
        reasons.append(
            "reference ROM does not contain the reviewed live VR60 jump at the hook site"
        )
    if candidate_hook != HOOK_SITE_STOCK_BYTES:
        reasons.append(
            "candidate ROM does not contain the reviewed original two-JSR hook bypass"
        )
    if len(candidate) != len(reference):
        reasons.append(
            f"candidate/reference sizes differ ({len(candidate)} != {len(reference)})"
        )
    elif outside_difference_count:
        reasons.append(
            f"candidate differs from the live reference at {outside_difference_count} "
            f"byte(s) outside the hook span; first difference {first_outside_difference}"
        )

    eligible = not reasons
    reason = (
        "candidate is byte-for-byte equal to the live reference outside the reviewed "
        "eight-byte hook delta"
        if eligible
        else "; ".join(reasons)
    )
    return ControlRomComparison(
        eligible=eligible,
        reason=reason,
        candidate_sha256=hashlib.sha256(candidate).hexdigest(),
        reference_sha256=hashlib.sha256(reference).hexdigest(),
        candidate_size=len(candidate),
        reference_size=len(reference),
        candidate_hook_bytes=candidate_hook.hex(),
        reference_hook_bytes=reference_hook.hex(),
        outside_hook_difference_count=outside_difference_count,
        first_outside_hook_difference=first_outside_difference,
    )


def validate_input_script(path: Path, total_frames: int) -> str:
    with path.open(newline="") as stream:
        reader = csv.DictReader(stream)
        if reader.fieldnames != ["frame", "mask"]:
            raise ValueError("input script header must be exactly: frame,mask")
        rows = list(reader)
    if len(rows) != total_frames:
        raise ValueError(
            f"input script has {len(rows)} rows; expected exactly {total_frames}"
        )
    for expected_frame, row in enumerate(rows):
        try:
            frame = parse_number(row["frame"])
            mask = parse_number(row["mask"])
        except (KeyError, ValueError) as error:
            raise ValueError(f"invalid input script row {expected_frame + 2}: {error}") from error
        if frame != expected_frame:
            raise ValueError(
                f"input script row {expected_frame + 2} has frame {frame}; expected {expected_frame}"
            )
        if not 0 <= mask <= 0xFFFF:
            raise ValueError(f"input mask out of range at frame {frame}: {mask}")
    return sha256_file(path)


def analyze_artifacts(
    output_dir: Path,
    *,
    validation_frames: int,
    warmup_frames: int = 0,
    expected_scene_pointer: int = DEFAULT_SCENE_POINTER,
    expected_states: Sequence[int] = DEFAULT_STATES,
    expected_hook_return: int = DEFAULT_HOOK_RETURN,
    thresholds: Thresholds = Thresholds(),
    forced_findings: Sequence[Finding] = (),
    minimum_control_frames: int = MIN_CONTROL_FRAMES,
) -> ValidationReport:
    report = ValidationReport(findings=list(forced_findings))
    approved = Thresholds()
    if validation_frames <= 0 or thresholds.window_frames <= 0 or validation_frames % thresholds.window_frames:
        report.fail(
            "configuration",
            "validation_frames must be a positive exact multiple of window_frames",
        )
        return report
    if thresholds.window_frames > MAX_CONTROL_WINDOW_FRAMES:
        report.fail(
            "configuration",
            f"window_frames exceeds reviewed maximum {MAX_CONTROL_WINDOW_FRAMES}",
        )
        return report
    for name in (
        "max_state_stall", "max_hook_gap", "max_framebuffer_stall", "max_comm_busy_stall"
    ):
        if getattr(thresholds, name) > getattr(approved, name):
            report.fail("configuration", f"{name} is looser than the reviewed control threshold")
            return report
    if validation_frames < minimum_control_frames:
        report.fail(
            "short_control_window",
            f"validation covers {validation_frames} frames; a control PASS requires at least "
            f"{minimum_control_frames} frames",
        )
    expected_total = warmup_frames + validation_frames

    try:
        frame_rows_raw = load_csv(output_dir / "frames.csv")
        watch_rows_raw = load_csv(output_dir / "watch.csv")
        caller = load_caller_trace(output_dir / "caller.csv")
    except (OSError, ValueError, csv.Error) as error:
        report.fail("artifact_error", str(error))
        return report

    if len(frame_rows_raw) != expected_total:
        report.fail(
            "incomplete_frame_log",
            f"frame log has {len(frame_rows_raw)} rows; expected exactly {expected_total}",
        )
        return report
    if len(watch_rows_raw) != expected_total:
        report.fail(
            "incomplete_watch_log",
            f"watch log has {len(watch_rows_raw)} rows; expected exactly {expected_total}",
        )
        return report

    required_frame_columns = {
        "frame", "msh2_cycles", "ssh2_cycles", "msh2_useful", "ssh2_useful",
        "fb_crc", "scene", "state", "is_32x",
    }
    required_watch_columns = {
        "frame", WATCH_SCENE_POINTER, WATCH_COMM0_HI, WATCH_COMM1_LO,
        WATCH_COMM2_HI, WATCH_COMM7,
    }
    if not required_frame_columns.issubset(frame_rows_raw[0]):
        missing = sorted(required_frame_columns - set(frame_rows_raw[0]))
        report.fail("artifact_schema", f"frame log missing columns: {', '.join(missing)}")
        return report
    if not required_watch_columns.issubset(watch_rows_raw[0]):
        missing = sorted(required_watch_columns - set(watch_rows_raw[0]))
        report.fail("artifact_schema", f"watch log missing columns: {', '.join(missing)}")
        return report

    def convert(raw: dict[str, str], names: Iterable[str]) -> dict[str, object]:
        return {name: parse_number(raw[name]) for name in names}

    try:
        frame_rows = [convert(row, required_frame_columns) for row in frame_rows_raw]
        watch_rows = [convert(row, required_watch_columns) for row in watch_rows_raw]
    except (KeyError, ValueError) as error:
        report.fail("artifact_parse", f"invalid numeric field: {error}")
        return report

    expected_frame_numbers = list(range(expected_total))
    if [int(row["frame"]) for row in frame_rows] != expected_frame_numbers:
        report.fail(
            "frame_sequence",
            f"frame log must contain exactly frames 0-{expected_total - 1}",
        )
        return report
    if [int(row["frame"]) for row in watch_rows] != expected_frame_numbers:
        report.fail(
            "watch_alignment",
            f"watch log must contain exactly frames 0-{expected_total - 1}",
        )
        return report
    invalid_caller_frames = [
        row["frame"] for row in caller.rows if not 0 <= row["frame"] < expected_total
    ]
    if invalid_caller_frames:
        report.fail(
            "caller_trace_frame_range",
            f"caller trace contains out-of-range frame {invalid_caller_frames[0]}",
        )
        return report

    selected_frames = frame_rows[warmup_frames:expected_total]
    selected_frame_numbers = [int(row["frame"]) for row in selected_frames]
    for previous, current in zip(selected_frame_numbers, selected_frame_numbers[1:]):
        if current != previous + 1:
            report.fail(
                "frame_sequence",
                f"frame log is not contiguous: {previous} is followed by {current}",
            )
            return report
    watch_by_frame = {int(row["frame"]): row for row in watch_rows}
    selected_watches: list[dict[str, object]] = []
    for frame_row in selected_frames:
        frame_number = int(frame_row["frame"])
        if frame_number not in watch_by_frame:
            report.fail("watch_alignment", f"watch log is missing frame {frame_number}")
            return report
        selected_watches.append(watch_by_frame[frame_number])

    first_frame = int(selected_frames[0]["frame"])
    last_frame = int(selected_frames[-1]["frame"])
    report.metrics.update(
        {
            "validation_start_frame": first_frame,
            "validation_end_frame": last_frame,
            "validation_frames": len(selected_frames),
            "window_frames": thresholds.window_frames,
        }
    )

    if any(int(row["is_32x"]) != 1 for row in selected_frames):
        report.fail("not_32x", "one or more validation frames were not marked as 32X")

    scene_low = expected_scene_pointer & 0xFFFF
    bad_profile_scenes = [
        int(row["frame"]) for row in selected_frames if int(row["scene"]) != scene_low
    ]
    bad_full_scenes = [
        int(row["frame"])
        for row in selected_watches
        if int(row[WATCH_SCENE_POINTER]) != expected_scene_pointer
    ]
    if bad_profile_scenes:
        report.fail(
            "wrong_scene",
            f"scene low word was not 0x{scene_low:04X}; first bad frame {bad_profile_scenes[0]}",
        )
    if bad_full_scenes:
        report.fail(
            "wrong_scene_pointer",
            f"$FF0002 was not 0x{expected_scene_pointer:08X}; first bad frame {bad_full_scenes[0]}",
        )

    states = [int(row["state"]) for row in selected_frames]
    expected_state_set = set(expected_states)
    unexpected = sorted(set(states) - expected_state_set)
    if unexpected:
        report.fail(
            "unexpected_state",
            "unexpected $C87E values: " + ", ".join(f"0x{value:04X}" for value in unexpected),
        )
    state_stall, stalled_state = longest_run(states)
    report.metrics["max_state_stall"] = state_stall
    if state_stall > thresholds.max_state_stall:
        report.fail(
            "state_stall",
            f"$C87E stayed at 0x{int(stalled_state):04X} for {state_stall} frames "
            f"(limit {thresholds.max_state_stall})",
        )

    state_index = {value: index for index, value in enumerate(expected_states)}
    collapsed: list[tuple[int, int]] = []
    for row in selected_frames:
        state = int(row["state"])
        if not collapsed or collapsed[-1][1] != state:
            collapsed.append((int(row["frame"]), state))
    for (previous_frame, previous), (frame, current) in zip(collapsed, collapsed[1:]):
        if previous in state_index and current in state_index:
            expected_next = expected_states[(state_index[previous] + 1) % len(expected_states)]
            if current != expected_next:
                report.fail(
                    "state_order",
                    f"$C87E jumped 0x{previous:04X}->0x{current:04X} at frame {frame}; "
                    f"expected 0x{expected_next:04X}",
                )
                break

    state_window_count = 0
    for chunk in windows(selected_frames, thresholds.window_frames):
        state_window_count += 1
        chunk_states = {int(row["state"]) for row in chunk}
        missing = expected_state_set - chunk_states
        if missing:
            report.fail(
                "state_window",
                f"$C87E did not visit {', '.join(f'0x{x:04X}' for x in sorted(missing))} "
                f"during frames {chunk[0]['frame']}-{chunk[-1]['frame']}",
            )
    report.metrics["state_windows_checked"] = state_window_count

    if caller.pc_enabled != 1:
        report.fail("caller_trace_disabled", "caller trace header does not report pc_enabled=1")
    if caller.max_hits != 0:
        report.fail(
            "caller_trace_capped",
            f"caller trace used max_hits={caller.max_hits}; control traces must be unlimited",
        )
    if caller.complete_frames != expected_total:
        report.fail(
            "caller_trace_incomplete",
            f"caller trace footer reports {caller.complete_frames} frames; expected {expected_total}",
        )
    if caller.dropped_hits not in (0, None):
        report.fail("caller_trace_dropped", f"caller trace dropped {caller.dropped_hits} hits")
    if caller.logged_hits is None or caller.total_hits is None:
        report.fail("caller_trace_incomplete", "caller trace has no COMPLETE footer")
    elif caller.logged_hits != len(caller.rows) or caller.total_hits != caller.logged_hits:
        report.fail(
            "caller_trace_count",
            f"trace footer hits/logged={caller.total_hits}/{caller.logged_hits}, "
            f"but {len(caller.rows)} rows were parsed",
        )

    hook_rows = [row for row in caller.rows if first_frame <= row["frame"] <= last_frame]
    report.metrics["hook_hits"] = len(hook_rows)
    bad_returns = [row for row in hook_rows if row["return_addr"] != expected_hook_return]
    if bad_returns:
        first = bad_returns[0]
        report.fail(
            "wrong_hook_caller",
            f"hook return address was 0x{first['return_addr']:08X} at frame {first['frame']}; "
            f"expected 0x{expected_hook_return:08X}",
        )
    if not hook_rows:
        report.fail("hook_missing", "game_frame_orch_013 hook had no hits in the validation window")
    else:
        hook_frames = [row["frame"] for row in hook_rows]
        gaps = [hook_frames[0] - first_frame]
        gaps.extend(b - a for a, b in zip(hook_frames, hook_frames[1:]))
        gaps.append(last_frame - hook_frames[-1])
        max_gap = max(gaps)
        report.metrics["max_hook_gap"] = max_gap
        if max_gap > thresholds.max_hook_gap:
            report.fail(
                "hook_gap",
                f"game_frame_orch_013 went {max_gap} frames without a hit "
                f"(limit {thresholds.max_hook_gap})",
            )
        for chunk in windows(selected_frames, thresholds.window_frames):
            lo, hi = int(chunk[0]["frame"]), int(chunk[-1]["frame"])
            if not any(lo <= frame <= hi for frame in hook_frames):
                report.fail("hook_window", f"no hook hit during frames {lo}-{hi}")

    hashes = [int(row["fb_crc"]) for row in selected_frames]
    if any(value == 0 for value in hashes):
        report.fail("framebuffer_hash_disabled", "one or more framebuffer hashes are zero")
    fb_stall, _ = longest_run(hashes)
    report.metrics["max_framebuffer_stall"] = fb_stall
    report.metrics["unique_framebuffer_hashes"] = len(set(hashes))
    if fb_stall > thresholds.max_framebuffer_stall:
        report.fail(
            "framebuffer_stall",
            f"displayed framebuffer hash was unchanged for {fb_stall} frames "
            f"(limit {thresholds.max_framebuffer_stall})",
        )
    for chunk in windows(selected_frames, thresholds.window_frames):
        if len({int(row["fb_crc"]) for row in chunk}) < 2:
            report.fail(
                "framebuffer_window",
                f"no framebuffer change during frames {chunk[0]['frame']}-{chunk[-1]['frame']}",
            )

    comm0 = [int(row[WATCH_COMM0_HI]) for row in selected_watches]
    comm1 = [int(row[WATCH_COMM1_LO]) for row in selected_watches]
    comm2 = [int(row[WATCH_COMM2_HI]) for row in selected_watches]
    comm7 = [int(row[WATCH_COMM7]) for row in selected_watches]
    comm0_stall = longest_nonzero_run(comm0)
    comm2_stall = longest_nonzero_run(comm2)
    comm7_stall = longest_nonzero_run(comm7)
    report.metrics["max_comm0_busy_stall"] = comm0_stall
    report.metrics["max_comm2_busy_stall"] = comm2_stall
    report.metrics["max_comm7_doorbell_stall"] = comm7_stall
    if comm0_stall > thresholds.max_comm_busy_stall:
        report.fail(
            "comm0_busy",
            f"COMM0_HI remained non-zero for {comm0_stall} frames "
            f"(limit {thresholds.max_comm_busy_stall})",
        )
    if comm2_stall > thresholds.max_comm_busy_stall:
        report.fail(
            "comm2_busy",
            f"COMM2_HI remained non-zero for {comm2_stall} frames "
            f"(limit {thresholds.max_comm_busy_stall})",
        )
    if comm7_stall > thresholds.max_comm_busy_stall:
        report.fail(
            "comm7_stuck",
            f"COMM7 remained non-zero for {comm7_stall} frames "
            f"(limit {thresholds.max_comm_busy_stall})",
        )
    # COMM transitions can begin and finish inside one emulated frame, so the
    # end-of-frame watch is not an access-event trace. Record COMM1 observations
    # for diagnosis but do not require a sampled done bit or value transition.
    report.metrics["comm1_done_samples"] = sum(1 for value in comm1 if value & 1)

    for name, column in (("Master", "msh2_useful"), ("Slave", "ssh2_useful")):
        for chunk in windows(selected_frames, thresholds.window_frames):
            if not any(int(row[column]) > 0 for row in chunk):
                report.fail(
                    f"{name.lower()}_sh2_no_useful_work",
                    f"{name} SH2 reported no non-idle work during frames "
                    f"{chunk[0]['frame']}-{chunk[-1]['frame']}",
                )

    return report


def run_frontend(args: argparse.Namespace, output_dir: Path, total_frames: int) -> int:
    frontend = CANONICAL_FRONTEND.resolve()
    profiler_dir = frontend.parent
    core = CANONICAL_CORE.resolve()
    if not frontend.is_file():
        raise FileNotFoundError(f"profiling frontend not found: {frontend}")
    if not core.is_file():
        raise FileNotFoundError(f"profiling core not found: {core}")

    env = os.environ.copy()
    for name in (
        "VRD_GATE_3D", "VRD_SCENE", "VRD_DUMP_FRAME", "VRD_DUMP",
        "VRD_DUMP_FILE", "VRD_SH2_STATE",
    ):
        env.pop(name, None)
    env.update(
        {
            "VRD_PROFILE_LOG": str((output_dir / "frames.csv").resolve()),
            "VRD_PROFILE_FRAMES": str(total_frames),
            "VRD_PROFILE_PC": "1",
            "VRD_PROFILE_PC_LOG": str((output_dir / "pc.csv").resolve()),
            "VRD_FB_CRC": "1",
            "VRD_SCENE_ADDR": "0xFFC87E",
            "VRD_WATCH": WATCH_SPEC,
            "VRD_WATCH_LOG": str((output_dir / "watch.csv").resolve()),
            "VRD_CALLER_TRACE": f"0x{args.hook_address:X}",
            "VRD_CALLER_TRACE_LOG": str((output_dir / "caller.csv").resolve()),
            "VRD_CALLER_TRACE_MAX": "0",
            "VRD_HOLD_INPUT": f"0x{args.hold_input:X}",
        }
    )
    if args.savestate:
        env["VRD_LOAD_STATE"] = str(Path(args.savestate).resolve())
    else:
        env.pop("VRD_LOAD_STATE", None)
    if args.input_script:
        env["VRD_INPUT_SCRIPT"] = str(Path(args.input_script).resolve())
    else:
        env.pop("VRD_INPUT_SCRIPT", None)

    command = [str(frontend), str(Path(args.rom).resolve()), str(total_frames)]
    with (output_dir / "frontend.log").open("w") as log:
        process = subprocess.Popen(
            command,
            cwd=profiler_dir,
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
        )
        assert process.stdout is not None
        for line in process.stdout:
            log.write(line)
            if line.startswith("  Frame ") or line.startswith("Running "):
                print(line, end="", flush=True)
        return process.wait()


def parse_cli(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("rom", help="VRD ROM to execute")
    parser.add_argument(
        "--reference-rom",
        required=True,
        help="live branch ROM; the candidate must differ only by the reviewed hook bypass",
    )
    parser.add_argument("--output-dir", required=True, help="artifact directory")
    parser.add_argument(
        "--frames", type=int, default=MIN_CONTROL_FRAMES,
        help=f"validation frames (PASS minimum {MIN_CONTROL_FRAMES})",
    )
    parser.add_argument("--warmup-frames", type=int, default=0)
    parser.add_argument("--savestate", help="candidate savestate; SHA-256 policy is enforced")
    parser.add_argument(
        "--input-script",
        help="complete deterministic CSV replay with frame,mask for every emulated frame",
    )
    parser.add_argument("--hold-input", type=parse_number, default=0x100)
    parser.add_argument(
        "--analyze-only",
        action="store_true",
        help="diagnose existing artifacts without replacing provenance; can never PASS",
    )
    parser.add_argument(
        "--diagnose-invalid-fixture",
        action="store_true",
        help="run a manifest-invalid fixture for diagnostics; the result can never pass",
    )
    parser.add_argument(
        "--diagnose-rom-mismatch", "--diagnose-active-hook",
        dest="diagnose_rom_mismatch",
        action="store_true",
        help="run a ROM pair that fails exact control isolation; the result can never pass",
    )
    parser.add_argument(
        "--diagnose-short-run",
        action="store_true",
        help=f"permit fewer than {MIN_CONTROL_FRAMES} frames; the result can never pass",
    )
    parser.add_argument(
        "--diagnose-unreviewed-tools",
        action="store_true",
        help="run with non-reviewed canonical-path binaries for diagnostics; can never pass",
    )
    args = parser.parse_args(argv)
    args.window_frames = Thresholds().window_frames
    args.max_state_stall = Thresholds().max_state_stall
    args.max_hook_gap = Thresholds().max_hook_gap
    args.max_framebuffer_stall = Thresholds().max_framebuffer_stall
    args.max_comm_busy_stall = Thresholds().max_comm_busy_stall
    if args.frames <= 0 or args.warmup_frames < 0:
        parser.error("frame counts must be positive (warmup may be zero)")
    if args.frames % args.window_frames:
        parser.error(f"--frames must be an exact multiple of {args.window_frames}")
    if args.frames < MIN_CONTROL_FRAMES and not args.diagnose_short_run:
        parser.error(
            f"--frames below {MIN_CONTROL_FRAMES} requires --diagnose-short-run and cannot PASS"
        )
    args.scene_pointer = DEFAULT_SCENE_POINTER
    args.hook_address = DEFAULT_HOOK_ADDRESS
    args.hook_return = DEFAULT_HOOK_RETURN
    return args


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_cli(argv)
    output_dir = Path(args.output_dir).resolve()
    if args.analyze_only:
        if not output_dir.is_dir():
            print(
                f"FAIL [analysis_output_missing] --analyze-only requires an existing "
                f"artifact directory: {output_dir}",
                file=sys.stderr,
            )
            return 2
    elif output_dir.exists():
        print(
            f"FAIL [output_exists] live validation requires a new output directory; "
            f"refusing to reuse: {output_dir}",
            file=sys.stderr,
        )
        return 2
    forced_findings: list[Finding] = []
    fixture_entry: dict[str, object] | None = None
    fixture_digest: str | None = None

    rom = Path(args.rom).resolve()
    if not rom.is_file():
        print(f"FAIL [rom_missing] ROM not found: {rom}", file=sys.stderr)
        return 2
    reference_rom = Path(args.reference_rom).resolve()
    if not reference_rom.is_file():
        print(f"FAIL [reference_rom_missing] live reference ROM not found: {reference_rom}", file=sys.stderr)
        return 2
    rom_comparison = control_rom_policy(rom, reference_rom)
    if not rom_comparison.eligible:
        if not args.diagnose_rom_mismatch:
            print(
                f"FAIL [control_rom_not_isolated] {rom_comparison.reason}.\n"
                f"candidate hook=0x{rom_comparison.candidate_hook_bytes}; "
                f"reference hook=0x{rom_comparison.reference_hook_bytes}.\n"
                "Build a reviewed assembly-source control ROM from the exact live reference, "
                "changing only the hook back to 4EBA69764EBA691C. Use "
                "--diagnose-rom-mismatch only to collect a result that can never PASS.",
                file=sys.stderr,
            )
            return 2
        forced_findings.append(Finding("control_rom_not_isolated", rom_comparison.reason))

    if args.analyze_only:
        forced_findings.append(
            Finding(
                "analyze_only_diagnostic",
                "offline artifact analysis is diagnostic-only and can never produce a control PASS",
            )
        )

    if args.savestate:
        savestate = Path(args.savestate).resolve()
        if not savestate.is_file():
            print(f"FAIL [fixture_missing] savestate not found: {savestate}", file=sys.stderr)
            return 2
        fixture_entry, fixture_digest = fixture_policy(savestate, DEFAULT_MANIFEST)
        if fixture_entry and fixture_entry.get("status") == "invalid_control":
            reason = str(fixture_entry.get("reason", "manifest marks fixture invalid"))
            if not args.diagnose_invalid_fixture:
                print(
                    f"FAIL [invalid_control_fixture] {savestate.name}: {reason}\n"
                    "Use --diagnose-invalid-fixture only to reproduce the failure; "
                    "that mode can never produce PASS.",
                    file=sys.stderr,
                )
                return 2
            forced_findings.append(Finding("invalid_control_fixture", reason))

    total_frames = args.warmup_frames + args.frames
    input_script_digest: str | None = None
    if args.input_script:
        input_script = Path(args.input_script).resolve()
        if not input_script.is_file():
            print(f"FAIL [input_script_missing] input script not found: {input_script}", file=sys.stderr)
            return 2
        try:
            input_script_digest = validate_input_script(input_script, total_frames)
        except (OSError, ValueError, csv.Error) as error:
            print(f"FAIL [input_script_invalid] {error}", file=sys.stderr)
            return 2
    tool_identity = reviewed_tool_policy(CANONICAL_FRONTEND, CANONICAL_CORE)
    if not tool_identity.eligible:
        if not (args.analyze_only or args.diagnose_unreviewed_tools):
            print(
                f"FAIL [unreviewed_profiler_tools] {tool_identity.reason}. "
                "Rebuild/review the canonical tools and update their pinned identities, or use "
                "--diagnose-unreviewed-tools only for a result that can never PASS.",
                file=sys.stderr,
            )
            return 2
        forced_findings.append(Finding("unreviewed_profiler_tools", tool_identity.reason))

    frontend_path = CANONICAL_FRONTEND.resolve()
    core_path = CANONICAL_CORE.resolve()
    run_metadata = {
        "schema": 2,
        "validator_argv": list(sys.argv[1:] if argv is None else argv),
        "rom": str(rom),
        "rom_sha256": rom_comparison.candidate_sha256,
        "reference_rom": str(reference_rom),
        "reference_rom_sha256": rom_comparison.reference_sha256,
        "rom_comparison": asdict(rom_comparison),
        "tool_identity": asdict(tool_identity),
        "frontend": str(frontend_path),
        "frontend_sha256": tool_identity.frontend_sha256,
        "core_sha256": tool_identity.core_sha256,
        "reviewed_frontend_sha256": CANONICAL_FRONTEND_SHA256,
        "reviewed_core_sha256": CANONICAL_CORE_SHA256,
        "hook_site_offset": f"0x{HOOK_SITE_OFFSET:X}",
        "hook_site_bytes": rom_comparison.candidate_hook_bytes,
        "control_rom_eligible": rom_comparison.eligible,
        "control_rom_policy": rom_comparison.reason,
        "savestate": str(Path(args.savestate).resolve()) if args.savestate else None,
        "savestate_sha256": fixture_digest,
        "fixture_manifest": str(DEFAULT_MANIFEST.resolve()),
        "fixture_manifest_sha256": sha256_file(DEFAULT_MANIFEST),
        "fixture_manifest_entry": fixture_entry,
        "validation_frames": args.frames,
        "minimum_control_frames": MIN_CONTROL_FRAMES,
        "warmup_frames": args.warmup_frames,
        "window_frames": args.window_frames,
        "watch_spec": WATCH_SPEC,
        "caller_trace_max": 0,
        "hold_input": f"0x{args.hold_input:X}",
        "input_script": str(Path(args.input_script).resolve()) if args.input_script else None,
        "input_script_sha256": input_script_digest,
        "input_mode": "per-frame CSV replay" if args.input_script else "fixed held joypad mask",
        "autoplay": False,
        "scene_pointer": f"0x{args.scene_pointer:08X}",
        "hook_address": f"0x{args.hook_address:08X}",
        "hook_return": f"0x{args.hook_return:08X}",
        "thresholds": {
            "max_state_stall": args.max_state_stall,
            "max_hook_gap": args.max_hook_gap,
            "max_framebuffer_stall": args.max_framebuffer_stall,
            "max_comm_busy_stall": args.max_comm_busy_stall,
        },
    }
    if args.analyze_only:
        run_path = output_dir / "run.json"
        if not run_path.is_file():
            forced_findings.append(
                Finding(
                    "analysis_provenance_missing",
                    "run.json is missing; existing artifacts have no recorded live-run provenance",
                )
            )
        else:
            try:
                recorded_metadata = json.loads(run_path.read_text())
            except (OSError, json.JSONDecodeError) as error:
                forced_findings.append(
                    Finding("analysis_provenance_invalid", f"cannot read run.json: {error}")
                )
            else:
                provenance_keys = (
                    "schema", "rom_sha256", "reference_rom_sha256", "frontend_sha256",
                    "core_sha256", "savestate_sha256", "validation_frames",
                    "fixture_manifest_sha256",
                    "minimum_control_frames", "warmup_frames", "window_frames", "watch_spec",
                    "caller_trace_max", "hold_input", "input_script_sha256", "scene_pointer",
                    "hook_address", "hook_return", "thresholds",
                )
                mismatches = [
                    key for key in provenance_keys
                    if recorded_metadata.get(key) != run_metadata.get(key)
                ]
                if mismatches:
                    forced_findings.append(
                        Finding(
                            "analysis_provenance_mismatch",
                            "current ROM/tool/run arguments do not match recorded provenance: "
                            + ", ".join(mismatches),
                        )
                    )
    else:
        try:
            output_dir.mkdir(parents=True, exist_ok=False)
        except FileExistsError:
            print(
                f"FAIL [output_exists] output directory appeared during preflight: {output_dir}",
                file=sys.stderr,
            )
            return 2
        (output_dir / "run.json").write_text(json.dumps(run_metadata, indent=2) + "\n")
        try:
            frontend_status = run_frontend(args, output_dir, total_frames)
        except OSError as error:
            print(f"FAIL [frontend_error] {error}", file=sys.stderr)
            return 2
        if frontend_status != 0:
            print(f"FAIL [frontend_exit] profiling frontend exited {frontend_status}", file=sys.stderr)
            return 2
        required_artifacts = (
            "frames.csv", "watch.csv", "caller.csv", "pc.csv", "frontend.log"
        )
        missing_artifacts = [
            name
            for name in required_artifacts
            if not (output_dir / name).is_file() or (output_dir / name).stat().st_size == 0
        ]
        if missing_artifacts:
            print(
                "FAIL [fresh_artifacts_missing] live frontend did not freshly produce: "
                + ", ".join(missing_artifacts),
                file=sys.stderr,
            )
            return 2

    thresholds = Thresholds(
        window_frames=args.window_frames,
        max_state_stall=args.max_state_stall,
        max_hook_gap=args.max_hook_gap,
        max_framebuffer_stall=args.max_framebuffer_stall,
        max_comm_busy_stall=args.max_comm_busy_stall,
    )
    report = analyze_artifacts(
        output_dir,
        validation_frames=args.frames,
        warmup_frames=args.warmup_frames,
        expected_scene_pointer=args.scene_pointer,
        expected_hook_return=args.hook_return,
        thresholds=thresholds,
        forced_findings=forced_findings,
        minimum_control_frames=MIN_CONTROL_FRAMES,
    )
    result_name = "analysis-result.json" if args.analyze_only else "result.json"
    (output_dir / result_name).write_text(json.dumps(report.to_json(), indent=2) + "\n")

    if report.passed:
        print("PASS: normal-1P control remained live for the entire validation window")
        print(json.dumps(report.metrics, indent=2))
        return 0
    print("FAIL: normal-1P control is not valid", file=sys.stderr)
    for finding in report.findings:
        print(f"  [{finding.code}] {finding.message}", file=sys.stderr)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
