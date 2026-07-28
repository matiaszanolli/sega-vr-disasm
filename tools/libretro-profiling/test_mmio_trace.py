#!/usr/bin/env python3
"""Focused unit tests for the VR60 Gate-A passive MMIO logger."""

from __future__ import annotations

import hashlib
import subprocess
import tempfile
import unittest
from contextlib import redirect_stderr, redirect_stdout
from dataclasses import replace
from io import StringIO
from pathlib import Path

from validate_mmio_trace import (
    FILTER_LINE,
    MODE1_FILTER_LINE,
    MODE1_PC_ALLOWLIST_TEXT,
    PC_ALLOWLIST_TEXT,
    TRACE_CAPACITY,
    MmioEvent,
    TraceValidationError,
    TransactionPcPolicy,
    main,
    parse_mmio_trace,
    validate_gate_a_mode0,
    validate_mode1,
)

TOOL_DIR = Path(__file__).resolve().parent
REPO_ROOT = TOOL_DIR.parents[1]
CORE_REPO = REPO_ROOT / "third_party" / "picodrive"
CORE_BASE_COMMIT = "26ecb2b6358fefba24e3d68b9eb2efba7f10d5ee"
CORE_BASE_PATCH = TOOL_DIR / "libretro_vrd_profiling_v4.patch"
CORE_MODE1_OVERLAY = TOOL_DIR / "libretro_vrd_mode1_mmio_overlay.patch"
CORE_BASE_PATCH_SHA256 = (
    "b18ffc2bb490f5cc9a0fd3529d8d341e19e461a69cc7b64779b7419248a9faee"
)
CORE_MODE1_OVERLAY_SHA256 = (
    "76363ab8b336631dfc4082e9923f6fe8bf002d17a86a011d8038eb77a1b4a78a"
)
PATCHED_LIBRETRO_SHA256 = (
    "334d1107f8ad5def3062a64f189f1df6918d2f6225ae337c6fafd789cdaa1376"
)
PATCHED_MEMORY_SHA256 = (
    "bfd0c5619cedd98e89476697820fe178fa57f27fcb6625310f1f28e73c15089a"
)
POLICY = TransactionPcPolicy(
    command_index=frozenset({0x0001C946}),
    trigger=frozenset({0x0001C94E}),
    ready_poll=frozenset({0x0001C956}),
    ready_publish=frozenset({0x02303A3E}),
    ready_flush=frozenset({0x02303A40}),
    busy_guard=frozenset({0x02303A46}),
    full_read=frozenset({0x0001C96C}),
    fifo_write=frozenset({0x0001C978}),
    m68k_dreq_read=frozenset({0x0001C982}),
    master_dreq_read=frozenset({0x02303A4E}),
    completion=frozenset({0x02303A68}),
    completion_flush=frozenset({0x02303A6A}),
)


def valid_events() -> list[MmioEvent]:
    rows: list[MmioEvent] = []

    def append(
        cpu: str,
        pc: int,
        op: str,
        address: int,
        width: int,
        value: int,
    ) -> None:
        rows.append(
            MmioEvent(
                sequence=len(rows),
                frame=len(rows) // 20,
                cpu=cpu,
                pc=pc,
                op=op,
                address=address,
                width=width,
                value=value,
            )
        )

    append("m68k", 0x0001C946, "write", 0x00A15121, 1, 0x3E)
    append("m68k", 0x0001C94E, "write", 0x00A15120, 1, 0x01)
    append("m68k", 0x0001C956, "read", 0x00A15121, 1, 0x3E)
    append("m68k", 0x0001C956, "read", 0x00A15121, 1, 0x3E)
    append("master", 0x02303A3E, "write", 0x20004021, 1, 0x00)
    append("m68k", 0x0001C956, "read", 0x00A15121, 1, 0x00)
    append("master", 0x02303A40, "read", 0x20004021, 1, 0x00)
    append("master", 0x02303A46, "read", 0x20004020, 1, 0x01)
    for group in range(8):
        append(
            "master",
            0x02303A4E,
            "read",
            0x20004010,
            2,
            32 - group * 4,
        )
        append("m68k", 0x0001C96C, "read", 0x00A15107, 1, 0x80)
        append("m68k", 0x0001C96C, "read", 0x00A15107, 1, group)
        for word in range(4):
            append(
                "m68k",
                0x0001C978,
                "write",
                0x00A15112,
                2,
                (group << 8) | word,
            )
    append("m68k", 0x0001C982, "read", 0x00A15110, 2, 4)
    append("master", 0x02303A4E, "read", 0x20004010, 2, 4)
    append("m68k", 0x0001C982, "read", 0x00A15110, 2, 0)
    append("master", 0x02303A4E, "read", 0x20004010, 2, 0)
    append("master", 0x02303A68, "write", 0x20004020, 1, 0x00)
    append("master", 0x02303A6A, "read", 0x20004020, 1, 0x00)
    return rows


def valid_gate_a_events() -> list[MmioEvent]:
    rows: list[MmioEvent] = []

    def append(
        cpu: str,
        pc: int,
        op: str,
        address: int,
        width: int,
        value: int,
    ) -> None:
        rows.append(
            MmioEvent(
                sequence=len(rows),
                frame=1,
                cpu=cpu,
                pc=pc,
                op=op,
                address=address,
                width=width,
                value=value,
            )
        )

    for _ in range(8):
        append("m68k", 0x0001C716, "write", 0x00A15120, 1, 0)
        append("m68k", 0x0001C724, "write", 0x00A15120, 1, 1)
    append("master", 0x023016B0, "write", 0x20004023, 1, 3)
    append("m68k", 0x0001C744, "write", 0x00A15123, 1, 1)
    for word in range(32):
        append(
            "m68k",
            0x0001C760,
            "write",
            0x00A15112,
            2,
            word,
        )
    append("master", 0x02301714, "write", 0x20004020, 1, 0)
    return rows


def repeated_mode1_events(count: int) -> list[MmioEvent]:
    events: list[MmioEvent] = []
    for transaction in range(count):
        frame_offset = transaction * 10
        for event in valid_events():
            events.append(
                replace(
                    event,
                    sequence=len(events),
                    frame=event.frame + frame_offset,
                )
            )
    return events


def render_trace(
    events: list[MmioEvent],
    *,
    status: str = "COMPLETE",
    dropped: int = 0,
    errors: int = 0,
    overflow: int = 0,
    gate_b_mode1: bool = True,
) -> str:
    frames = max((event.frame for event in events), default=0) + 1
    lines = [
        (
            f"# VRD_MMIO_TRACE version=2 capacity={TRACE_CAPACITY} "
            "sh2_drc=1 profile_pc=0 profile_pc_env=0 "
            "m68k_batching=normal instruction_start_hook=1 "
            "m68k_wrapped=1 master_wrapped=1 coverage_from_start=1 "
            f"pc_allowlist={MODE1_PC_ALLOWLIST_TEXT if gate_b_mode1 else PC_ALLOWLIST_TEXT}"
        ),
        MODE1_FILTER_LINE if gate_b_mode1 else FILTER_LINE,
        "sequence,frame,cpu,pc,op,address,width,value",
    ]
    lines.extend(
        (
            f"{event.sequence},{event.frame},{event.cpu},0x{event.pc:08X},"
            f"{event.op},0x{event.address:08X},{event.width},0x{event.value:X}"
        )
        for event in events
    )
    total = len(events) + dropped
    if status == "COMPLETE":
        lines.append(
            f"# COMPLETE frames={frames} events={total} "
            f"recorded={len(events)} dropped={dropped} errors={errors} "
            f"overflow={overflow} pc_allowlist={MODE1_PC_ALLOWLIST_TEXT if gate_b_mode1 else PC_ALLOWLIST_TEXT}"
        )
    else:
        lines.append(
            f"# INCOMPLETE frames={frames} events={total} "
            f"recorded={len(events)} dropped={dropped} errors={errors} "
            f"overflow={overflow} pc_allowlist={MODE1_PC_ALLOWLIST_TEXT if gate_b_mode1 else PC_ALLOWLIST_TEXT} reason=test"
        )
    return "\n".join(lines) + "\n"


def write_temp_trace(text: str) -> Path:
    directory = Path(tempfile.mkdtemp())
    path = directory / "mmio.csv"
    path.write_text(text, encoding="utf-8")
    return path


def c_function_body(source: str, signature: str) -> str:
    start = source.index(signature)
    opening = source.index("{", start)
    depth = 0
    for index in range(opening, len(source)):
        if source[index] == "{":
            depth += 1
        elif source[index] == "}":
            depth -= 1
            if depth == 0:
                return source[opening + 1 : index]
    raise AssertionError(f"unterminated function: {signature}")


def sha256_file(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def patch_paths(path: Path) -> frozenset[str]:
    paths: set[str] = set()
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.startswith("diff --git a/"):
            left = line.split()[2]
            if not left.startswith("a/"):
                raise AssertionError(f"malformed patch path: {line}")
            paths.add(left[2:])
    if not paths:
        raise AssertionError(f"patch contains no paths: {path}")
    return frozenset(paths)


def reconstruct_patched_core_sources() -> tuple[str, str]:
    """Apply the tracked v4 + mode-1 overlay chain to the pinned upstream."""

    paths = patch_paths(CORE_BASE_PATCH) | patch_paths(CORE_MODE1_OVERLAY)
    with tempfile.TemporaryDirectory() as temporary:
        root = Path(temporary)
        subprocess.run(
            ["git", "init", "-q"],
            cwd=root,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        for relative in sorted(paths):
            destination = root / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            result = subprocess.run(
                [
                    "git",
                    "-C",
                    str(CORE_REPO),
                    "show",
                    f"{CORE_BASE_COMMIT}:{relative}",
                ],
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
            )
            destination.write_bytes(result.stdout)
        for patch in (CORE_BASE_PATCH, CORE_MODE1_OVERLAY):
            subprocess.run(
                ["git", "apply", "--check", str(patch)],
                cwd=root,
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
            )
            subprocess.run(
                ["git", "apply", str(patch)],
                cwd=root,
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
            )
        return (
            (root / "platform/libretro/libretro.c").read_text(encoding="utf-8"),
            (root / "pico/32x/memory.c").read_text(encoding="utf-8"),
        )


class MmioTraceParserTests(unittest.TestCase):
    def test_eight_group_transaction_is_accepted(self) -> None:
        path = write_temp_trace(render_trace(valid_events()))
        trace = parse_mmio_trace(path, gate_b_mode1=True)
        self.assertEqual(
            validate_mode1(
                trace,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=1,
            ),
            1,
        )
        self.assertEqual(len(trace.events), 70)

    def test_incomplete_and_overflow_traces_are_rejected(self) -> None:
        for text in (
            render_trace(valid_events(), status="INCOMPLETE"),
            render_trace(valid_events(), dropped=1, overflow=1),
        ):
            with self.subTest(
                footer=text.splitlines()[-1]
            ), self.assertRaises(TraceValidationError):
                parse_mmio_trace(write_temp_trace(text), gate_b_mode1=True)

    def test_malformed_sequence_is_rejected(self) -> None:
        events = valid_events()
        events[4] = replace(events[4], sequence=99)
        with self.assertRaisesRegex(TraceValidationError, "not contiguous"):
            parse_mmio_trace(
                write_temp_trace(render_trace(events)), gate_b_mode1=True
            )

    def test_transition_grammar_rejects_missing_fifo_word(self) -> None:
        events = valid_events()
        fifo_index = next(
            index for index, event in enumerate(events)
            if event.kind == "fifo_write"
        )
        del events[fifo_index]
        events = [replace(event, sequence=i) for i, event in enumerate(events)]
        trace = parse_mmio_trace(
            write_temp_trace(render_trace(events)), gate_b_mode1=True
        )
        with self.assertRaisesRegex(TraceValidationError, "expected fifo_write"):
            validate_mode1(
                trace,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=1,
            )

    def test_wrong_width_and_address_are_rejected(self) -> None:
        base = valid_events()
        for changed in (
            replace(base[0], width=2),
            replace(base[0], address=0x00A15122),
        ):
            events = list(base)
            events[0] = changed
            with self.subTest(event=changed), self.assertRaisesRegex(
                TraceValidationError, "CPU/op/address/width"
            ):
                parse_mmio_trace(
                    write_temp_trace(render_trace(events)), gate_b_mode1=True
                )

    def test_wrong_exact_pc_is_rejected(self) -> None:
        events = valid_events()
        events[0] = replace(events[0], pc=0x0001C944)
        trace = parse_mmio_trace(
            write_temp_trace(render_trace(events)), gate_b_mode1=True
        )
        with self.assertRaisesRegex(TraceValidationError, "is not allowed"):
            validate_mode1(
                trace,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=1,
            )

    def test_trigger_must_follow_command_index(self) -> None:
        events = valid_events()
        trigger = events.pop(1)
        events.insert(0, trigger)
        events = [
            replace(event, sequence=sequence)
            for sequence, event in enumerate(events)
        ]
        trace = parse_mmio_trace(
            write_temp_trace(render_trace(events)), gate_b_mode1=True
        )
        with self.assertRaisesRegex(TraceValidationError, "waiting for command_index"):
            validate_mode1(
                trace,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=1,
            )

    def test_master_readiness_cannot_precede_68k_trigger(self) -> None:
        events = valid_events()
        publish_index = next(
            index for index, event in enumerate(events)
            if event.kind == "ready_publish"
        )
        publish = events.pop(publish_index)
        trigger_index = next(
            index for index, event in enumerate(events)
            if event.kind == "trigger"
        )
        events.insert(trigger_index, publish)
        events = [
            replace(event, sequence=sequence)
            for sequence, event in enumerate(events)
        ]
        trace = parse_mmio_trace(
            write_temp_trace(render_trace(events)), gate_b_mode1=True
        )
        with self.assertRaisesRegex(
            TraceValidationError, "global command/trigger/readiness/FIFO"
        ):
            validate_mode1(
                trace,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=1,
            )

    def test_readiness_sequence_is_fail_closed(self) -> None:
        base = valid_events()
        cases = (
            (
                "publication",
                next(i for i, event in enumerate(base)
                     if event.kind == "ready_publish"),
            ),
            (
                "same-byte flush",
                next(i for i, event in enumerate(base)
                     if event.kind == "ready_flush"),
            ),
            (
                "busy guard",
                next(i for i, event in enumerate(base)
                     if event.kind == "master_hi_read"
                     and event.pc in POLICY.busy_guard),
            ),
            (
                "readiness zero",
                next(i for i, event in enumerate(base)
                     if event.kind == "ready_poll" and event.value == 0),
            ),
        )
        for label, remove_index in cases:
            with self.subTest(label=label):
                events = valid_events()
                del events[remove_index]
                events = [
                    replace(event, sequence=sequence)
                    for sequence, event in enumerate(events)
                ]
                trace = parse_mmio_trace(
                    write_temp_trace(render_trace(events)), gate_b_mode1=True
                )
                with self.assertRaises(TraceValidationError):
                    validate_mode1(
                        trace,
                        POLICY,
                        arm="active",
                        expected_eligible_hook_hits=1,
                    )

    def test_fifo_before_readiness_publication_is_rejected(self) -> None:
        events = valid_events()
        fifo_index = next(
            index for index, event in enumerate(events)
            if event.kind == "fifo_write"
        )
        fifo = events.pop(fifo_index)
        publish_index = next(
            index for index, event in enumerate(events)
            if event.kind == "ready_publish"
        )
        events.insert(publish_index, fifo)
        events = [
            replace(event, sequence=sequence)
            for sequence, event in enumerate(events)
        ]
        trace = parse_mmio_trace(
            write_temp_trace(render_trace(events)), gate_b_mode1=True
        )
        with self.assertRaises(TraceValidationError):
            validate_mode1(
                trace,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=1,
            )

    def test_wrong_readiness_and_guard_values_are_rejected(self) -> None:
        base = valid_events()
        indexes = (
            next(i for i, event in enumerate(base)
                 if event.kind == "ready_publish"),
            next(i for i, event in enumerate(base)
                 if event.kind == "ready_flush"),
            next(i for i, event in enumerate(base)
                 if event.kind == "master_hi_read"
                 and event.pc in POLICY.busy_guard),
        )
        for index in indexes:
            with self.subTest(index=index):
                events = valid_events()
                events[index] = replace(events[index], value=0x7F)
                trace = parse_mmio_trace(
                    write_temp_trace(render_trace(events)), gate_b_mode1=True
                )
                with self.assertRaises(TraceValidationError):
                    validate_mode1(
                        trace,
                        POLICY,
                        arm="active",
                        expected_eligible_hook_hits=1,
                    )

    def test_dreq_zero_and_completion_flush_are_fail_closed(self) -> None:
        base = valid_events()
        m68k_zero = next(
            index
            for index, event in enumerate(base)
            if event.kind == "dreq_read"
            and event.cpu == "m68k"
            and event.value == 0
        )
        master_zero = next(
            index
            for index, event in enumerate(base)
            if event.kind == "dreq_read"
            and event.cpu == "master"
            and event.value == 0
        )
        mutations = (
            ("m68k zero", m68k_zero),
            ("master zero", master_zero),
            ("completion flush", len(base) - 1),
        )
        for message, index in mutations:
            with self.subTest(message=message):
                events = valid_events()
                del events[index]
                events = [
                    replace(event, sequence=sequence)
                    for sequence, event in enumerate(events)
                ]
                trace = parse_mmio_trace(
                    write_temp_trace(render_trace(events)), gate_b_mode1=True
                )
                with self.assertRaises(TraceValidationError):
                    validate_mode1(
                        trace,
                        POLICY,
                        arm="active",
                        expected_eligible_hook_hits=1,
                    )

    def test_any_comm1_access_is_rejected(self) -> None:
        forbidden = (
            MmioEvent(0, 0, "m68k", 0x0001C956, "read", 0x00A15123, 1, 3),
            MmioEvent(0, 0, "master", 0x02303A40, "write", 0x20004023, 1, 3),
        )
        for injected in forbidden:
            with self.subTest(cpu=injected.cpu, op=injected.op):
                events = valid_events()
                events.insert(7, injected)
                events = [
                    replace(event, sequence=sequence)
                    for sequence, event in enumerate(events)
                ]
                trace = parse_mmio_trace(
                    write_temp_trace(render_trace(events)), gate_b_mode1=True
                )
                with self.assertRaisesRegex(
                    TraceValidationError, "forbidden COMM1"
                ):
                    validate_mode1(
                        trace,
                        POLICY,
                        arm="active",
                        expected_eligible_hook_hits=1,
                    )

    def test_explicit_active_control_and_lifecycle_counts(self) -> None:
        multi = parse_mmio_trace(
            write_temp_trace(render_trace(repeated_mode1_events(2))),
            gate_b_mode1=True,
        )
        empty = parse_mmio_trace(
            write_temp_trace(render_trace([])),
            gate_b_mode1=True,
        )
        single = parse_mmio_trace(
            write_temp_trace(render_trace(valid_events())),
            gate_b_mode1=True,
        )
        self.assertEqual(
            validate_mode1(
                multi,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=2,
            ),
            2,
        )
        self.assertEqual(
            validate_mode1(
                empty,
                POLICY,
                arm="control",
                expected_eligible_hook_hits=2,
            ),
            0,
        )
        with self.assertRaisesRegex(TraceValidationError, "zero transactions"):
            validate_mode1(
                empty,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=1,
            )
        with self.assertRaisesRegex(TraceValidationError, "CONTROL"):
            validate_mode1(
                single,
                POLICY,
                arm="control",
                expected_eligible_hook_hits=1,
            )
        with self.assertRaisesRegex(TraceValidationError, "expected 2"):
            validate_mode1(
                single,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=2,
            )

    def test_trailing_partial_transaction_is_rejected(self) -> None:
        events = repeated_mode1_events(1)
        trigger = valid_events()[0]
        events.append(
            replace(
                trigger,
                sequence=len(events),
                frame=events[-1].frame + 1,
            )
        )
        trace = parse_mmio_trace(
            write_temp_trace(render_trace(events)), gate_b_mode1=True
        )
        with self.assertRaisesRegex(TraceValidationError, "waiting for"):
            validate_mode1(
                trace,
                POLICY,
                arm="active",
                expected_eligible_hook_hits=2,
            )

    def test_cli_requires_explicit_gate_and_accepts_explicit_control(self) -> None:
        path = write_temp_trace(render_trace([]))
        with redirect_stderr(StringIO()), self.assertRaises(SystemExit):
            main([str(path)])
        pc_args: list[str] = []
        for option, values in (
            ("command-index", POLICY.command_index),
            ("trigger", POLICY.trigger),
            ("ready-poll", POLICY.ready_poll),
            ("ready-publish", POLICY.ready_publish),
            ("ready-flush", POLICY.ready_flush),
            ("busy-guard", POLICY.busy_guard),
            ("full-read", POLICY.full_read),
            ("fifo-write", POLICY.fifo_write),
            ("m68k-dreq-read", POLICY.m68k_dreq_read),
            ("master-dreq-read", POLICY.master_dreq_read),
            ("completion", POLICY.completion),
            ("completion-flush", POLICY.completion_flush),
        ):
            pc_args.extend((f"--{option}-pc", hex(next(iter(values)))))
        with redirect_stdout(StringIO()):
            result = main(
                [
                    str(path),
                    "--mode1",
                    "control",
                    "--expected-eligible-hook-hits",
                    "2",
                    *pc_args,
                ]
            )
        self.assertEqual(result, 0)


class GateAMode0Tests(unittest.TestCase):
    def test_active_transaction_and_empty_control_are_accepted(self) -> None:
        active = parse_mmio_trace(
            write_temp_trace(
                render_trace(valid_gate_a_events(), gate_b_mode1=False)
            ),
            gate_b_mode1=False,
        )
        control = parse_mmio_trace(
            write_temp_trace(render_trace([], gate_b_mode1=False))
        )
        self.assertEqual(validate_gate_a_mode0(active, 1), 1)
        self.assertEqual(validate_gate_a_mode0(control, 0), 0)

    def test_missing_fifo_word_is_rejected(self) -> None:
        events = valid_gate_a_events()
        del events[-2]
        events = [replace(event, sequence=i) for i, event in enumerate(events)]
        trace = parse_mmio_trace(
            write_temp_trace(render_trace(events, gate_b_mode1=False))
        )
        with self.assertRaisesRegex(TraceValidationError, "expected fifo_write"):
            validate_gate_a_mode0(trace, 1)

    def test_malformed_retry_edge_is_rejected(self) -> None:
        events = valid_gate_a_events()
        events[1] = replace(events[1], value=0)
        trace = parse_mmio_trace(
            write_temp_trace(render_trace(events, gate_b_mode1=False))
        )
        with self.assertRaisesRegex(TraceValidationError, "trigger-set"):
            validate_gate_a_mode0(trace, 1)


class PcAllowlistTests(unittest.TestCase):
    def tamper_allowlist(self, replacement: str) -> str:
        return render_trace(valid_gate_a_events(), gate_b_mode1=False).replace(
            PC_ALLOWLIST_TEXT, replacement
        )

    def test_missing_range_is_rejected(self) -> None:
        text = self.tamper_allowlist(
            "m68k:0x0001C6FE-0x0001C76C;master:0x023016B0-0x02301714"
        )
        with self.assertRaisesRegex(TraceValidationError, "missing or changed"):
            parse_mmio_trace(write_temp_trace(text))

    def test_broadened_range_is_rejected(self) -> None:
        text = self.tamper_allowlist(
            "m68k:0x0001C6FC-0x0001C76C;master:0x023016B0-0x02301760"
        )
        with self.assertRaisesRegex(TraceValidationError, "broadened"):
            parse_mmio_trace(write_temp_trace(text))

    def test_overlapping_ranges_are_rejected(self) -> None:
        text = self.tamper_allowlist(
            "m68k:0x0001C6FE-0x0001C740,0x0001C730-0x0001C76C;"
            "master:0x023016B0-0x02301760"
        )
        with self.assertRaisesRegex(TraceValidationError, "overlapping"):
            parse_mmio_trace(write_temp_trace(text))

    def test_wrong_cpu_ranges_are_rejected(self) -> None:
        text = self.tamper_allowlist(
            "m68k:0x023016B0-0x02301760;master:0x0001C6FE-0x0001C76C"
        )
        with self.assertRaisesRegex(TraceValidationError, "wrong-CPU"):
            parse_mmio_trace(write_temp_trace(text))

    def test_event_pc_outside_cpu_range_is_rejected(self) -> None:
        events = valid_gate_a_events()
        events[0] = replace(events[0], pc=0x023016C0)
        with self.assertRaisesRegex(TraceValidationError, "outside the pinned"):
            parse_mmio_trace(
                write_temp_trace(render_trace(events, gate_b_mode1=False))
            )


class MmioCallbackSourceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.source, cls.memory_source = reconstruct_patched_core_sources()

    def test_tracked_patch_chain_identity_and_scope(self) -> None:
        self.assertEqual(sha256_file(CORE_BASE_PATCH), CORE_BASE_PATCH_SHA256)
        self.assertEqual(
            sha256_file(CORE_MODE1_OVERLAY), CORE_MODE1_OVERLAY_SHA256
        )
        self.assertEqual(
            patch_paths(CORE_MODE1_OVERLAY),
            frozenset(
                {"platform/libretro/libretro.c", "pico/32x/memory.c"}
            ),
        )
        self.assertEqual(
            hashlib.sha256(self.source.encode()).hexdigest(),
            PATCHED_LIBRETRO_SHA256,
        )
        self.assertEqual(
            hashlib.sha256(self.memory_source.encode()).hexdigest(),
            PATCHED_MEMORY_SHA256,
        )

    def test_wrappers_call_each_saved_callback_exactly_once(self) -> None:
        checks = (
            (
                "static unsigned int vrd_mmio_trace_read_byte",
                "vrd_mmio_trace_orig_read_byte(",
                self.source,
            ),
            (
                "static unsigned int vrd_mmio_trace_read_word",
                "vrd_mmio_trace_orig_read_word(",
                self.source,
            ),
            (
                "static void vrd_mmio_trace_write_byte",
                "vrd_mmio_trace_orig_write_byte(",
                self.source,
            ),
            (
                "static void vrd_mmio_trace_write_word",
                "vrd_mmio_trace_orig_write_word(",
                self.source,
            ),
            (
                "static void REGPARM(3) vrd_mmio_trace_master_write8",
                "vrd_mmio_trace_master_orig_write8(",
                self.memory_source,
            ),
            (
                "static u32 REGPARM(2) vrd_mmio_trace_master_read8",
                "vrd_mmio_trace_master_orig_read8(",
                self.memory_source,
            ),
            (
                "static u32 REGPARM(2) vrd_mmio_trace_master_read16",
                "vrd_mmio_trace_master_orig_read16(",
                self.memory_source,
            ),
        )
        for signature, callback, source in checks:
            with self.subTest(wrapper=signature):
                body = c_function_body(source, signature)
                self.assertEqual(body.count(callback), 1)

    def test_wrappers_never_reread_or_emit_events_directly(self) -> None:
        signatures = (
            ("static unsigned int vrd_mmio_trace_read_byte", self.source),
            ("static unsigned int vrd_mmio_trace_read_word", self.source),
            ("static void vrd_mmio_trace_write_byte", self.source),
            ("static void vrd_mmio_trace_write_word", self.source),
            ("static void vrd_mmio_trace_append", self.source),
            (
                "static void REGPARM(3) vrd_mmio_trace_master_write8",
                self.memory_source,
            ),
            (
                "static u32 REGPARM(2) vrd_mmio_trace_master_read8",
                self.memory_source,
            ),
            (
                "static u32 REGPARM(2) vrd_mmio_trace_master_read16",
                self.memory_source,
            ),
        )
        forbidden = (
            "PicoCpuFM68k.read_",
            "p32x_sh2_read",
            "malloc(",
            "realloc(",
            "fprintf(",
            "fwrite(",
            "fflush(",
        )
        for signature, source in signatures:
            body = c_function_body(source, signature)
            for token in forbidden:
                with self.subTest(wrapper=signature, token=token):
                    self.assertNotIn(token, body)

    def test_master_wrapper_saves_and_restores_drc_sr_around_one_access(
        self,
    ) -> None:
        body = c_function_body(
            self.memory_source,
            "static void REGPARM(3) vrd_mmio_trace_master_write8",
        )
        ordered = (
            "DRC_SAVE_SR(sh2);",
            "vrd_mmio_trace_master_orig_write8(address, value, sh2);",
            "vrd_mmio_trace_master_observer(pc, address, value & 0xff, 1, 1);",
            "DRC_RESTORE_SR(sh2);",
        )
        positions = [body.index(token) for token in ordered]
        self.assertEqual(positions, sorted(positions))

    def test_pc_filter_is_central_and_end_exclusive(self) -> None:
        body = c_function_body(
            self.source, "static void vrd_mmio_trace_append"
        )
        for token in (
            "pc >= VRD_MMIO_TRACE_M68K_PC_START",
            "pc < VRD_MMIO_TRACE_M68K_PC_END",
            "pc >= VRD_MMIO_TRACE_MASTER_PC_START",
            "pc < VRD_MMIO_TRACE_MASTER_PC_END",
            "if (!pc_allowed)",
        ):
            self.assertIn(token, body)

    def test_comm0_lo_capture_is_mode1_only(self) -> None:
        body = c_function_body(
            self.source, "void vrd_mmio_trace_master_event"
        )
        self.assertIn(
            "!vrd_mmio_trace_mode1 && address == 0x20004021", body
        )


if __name__ == "__main__":
    unittest.main()
    main,
