#!/usr/bin/env python3
"""Strict parser and transaction validator for the VR60 Gate-A MMIO trace."""

from __future__ import annotations

import argparse
import csv
import re
import sys
from collections.abc import Iterable
from dataclasses import dataclass
from itertools import pairwise
from pathlib import Path

TRACE_CAPACITY = 1_048_576
PC_ALLOWLIST_TEXT = (
    "m68k:0x0001C6FE-0x0001C76C;"
    "master:0x023016B0-0x02301760"
)
MODE1_PC_ALLOWLIST_TEXT = (
    "m68k:0x0001C922-0x0001C990;"
    "master:0x02303A10-0x02303AA8"
)
TRACE_COLUMNS = (
    "sequence",
    "frame",
    "cpu",
    "pc",
    "op",
    "address",
    "width",
    "value",
)
FILTER_LINE = (
    "# FILTER m68k_read8=0x00A15107 "
    "m68k_write16=0x00A15112 "
    "m68k_write8=0x00A15120|0x00A15123 "
    "master_write8=0x20004020|0x20004023"
)
MODE1_FILTER_LINE = (
    "# FILTER m68k_read8=0x00A15107|0x00A15121|0x00A15123 "
    "m68k_read16=0x00A15110 "
    "m68k_write16=0x00A15112 "
    "m68k_write8=0x00A15120|0x00A15121|0x00A15123 "
    "master_read8=0x20004020|0x20004021|0x20004023 "
    "master_read16=0x20004010 "
    "master_write8=0x20004020|0x20004021|0x20004023"
)
HEADER_RE = re.compile(
    r"^# VRD_MMIO_TRACE version=2 capacity=(\d+) sh2_drc=(\d+) "
    r"profile_pc=(\d+) profile_pc_env=(\d+) m68k_batching=(\w+) "
    r"instruction_start_hook=(\d+) m68k_wrapped=(\d+) master_wrapped=(\d+) "
    r"coverage_from_start=(\d+) pc_allowlist=(\S+)$"
)
COMPLETE_RE = re.compile(
    r"^# COMPLETE frames=(\d+) events=(\d+) recorded=(\d+) dropped=(\d+) "
    r"errors=(\d+) overflow=(\d+) pc_allowlist=(\S+)$"
)
HEX32_RE = re.compile(r"^0x[0-9A-F]{8}$")
HEX_RE = re.compile(r"^0x[0-9A-F]+$")
PC_RANGE_RE = re.compile(r"^(0x[0-9A-F]{8})-(0x[0-9A-F]{8})$")


class TraceValidationError(ValueError):
    """The trace is structurally incomplete, malformed, or ineligible."""


@dataclass(frozen=True)
class MmioEvent:
    sequence: int
    frame: int
    cpu: str
    pc: int
    op: str
    address: int
    width: int
    value: int

    @property
    def kind(self) -> str:
        return EVENT_KIND[(self.cpu, self.op, self.address, self.width)]


@dataclass(frozen=True, order=True)
class PcRange:
    start: int
    end: int

    def contains(self, pc: int) -> bool:
        return self.start <= pc < self.end


@dataclass(frozen=True)
class PcAllowlist:
    m68k: tuple[PcRange, ...]
    master: tuple[PcRange, ...]

    def ranges_for(self, cpu: str) -> tuple[PcRange, ...]:
        if cpu == "m68k":
            return self.m68k
        if cpu == "master":
            return self.master
        return ()

    def contains(self, cpu: str, pc: int) -> bool:
        return any(pc_range.contains(pc) for pc_range in self.ranges_for(cpu))


@dataclass(frozen=True)
class MmioTrace:
    frames: int
    events: tuple[MmioEvent, ...]
    pc_allowlist: PcAllowlist


@dataclass(frozen=True)
class TransactionPcPolicy:
    """Allowed exact PCs for every event class in a transaction."""

    command_index: frozenset[int]
    trigger: frozenset[int]
    ready_poll: frozenset[int]
    ready_publish: frozenset[int]
    ready_flush: frozenset[int]
    busy_guard: frozenset[int]
    full_read: frozenset[int]
    fifo_write: frozenset[int]
    m68k_dreq_read: frozenset[int]
    master_dreq_read: frozenset[int]
    completion: frozenset[int]
    completion_flush: frozenset[int]

    def allowed_for(self, kind: str) -> frozenset[int]:
        if kind == "dreq_read":
            return self.m68k_dreq_read | self.master_dreq_read
        if kind == "master_hi_read":
            return self.busy_guard | self.completion_flush
        if kind in {"ack_read", "ack_clear", "master_ack"}:
            return frozenset()
        return getattr(self, kind)


@dataclass(frozen=True)
class GateAMode0PcPolicy:
    trigger_reset: int = 0x0001C716
    trigger_set: int = 0x0001C724
    master_ack: int = 0x023016B0
    ack_clear: int = 0x0001C744
    fifo_write: int = 0x0001C760
    completion: int = 0x02301714


EVENT_KIND = {
    ("m68k", "read", 0x00A15107, 1): "full_read",
    ("m68k", "read", 0x00A15121, 1): "ready_poll",
    ("m68k", "read", 0x00A15123, 1): "ack_read",
    ("m68k", "read", 0x00A15110, 2): "dreq_read",
    ("m68k", "write", 0x00A15112, 2): "fifo_write",
    ("m68k", "write", 0x00A15120, 1): "trigger",
    ("m68k", "write", 0x00A15121, 1): "command_index",
    ("m68k", "write", 0x00A15123, 1): "ack_clear",
    ("master", "write", 0x20004023, 1): "master_ack",
    ("master", "write", 0x20004020, 1): "completion",
    ("master", "write", 0x20004021, 1): "ready_publish",
    ("master", "read", 0x20004023, 1): "ack_read",
    ("master", "read", 0x20004020, 1): "master_hi_read",
    ("master", "read", 0x20004021, 1): "ready_flush",
    ("master", "read", 0x20004010, 2): "dreq_read",
}
TRANSITION_VALUES = {
    "command_index": 0x3E,
    "trigger": 0x01,
    "ready_publish": 0x00,
    "ready_flush": 0x00,
    "completion": 0x00,
}
GATE_A_PC_ALLOWLIST = PcAllowlist(
    m68k=(PcRange(0x0001C6FE, 0x0001C76C),),
    master=(PcRange(0x023016B0, 0x02301760),),
)
MODE1_PC_ALLOWLIST = PcAllowlist(
    m68k=(PcRange(0x0001C922, 0x0001C990),),
    master=(PcRange(0x02303A10, 0x02303AA8),),
)
GATE_A_MODE0_PC_POLICY = GateAMode0PcPolicy()


def _parse_decimal(value: str, label: str, line_number: int) -> int:
    if not value.isdecimal():
        raise TraceValidationError(
            f"line {line_number}: {label} must be unsigned decimal"
        )
    return int(value)


def _parse_hex(
    value: str, label: str, line_number: int, *, fixed_32: bool = False
) -> int:
    pattern = HEX32_RE if fixed_32 else HEX_RE
    if not pattern.fullmatch(value):
        expected = "0x plus eight uppercase hex digits" if fixed_32 else (
            "0x plus uppercase hex digits"
        )
        raise TraceValidationError(
            f"line {line_number}: {label} must be {expected}"
        )
    return int(value, 16)


def _parse_pc_allowlist(value: str, label: str) -> PcAllowlist:
    parsed: dict[str, tuple[PcRange, ...]] = {}
    for clause in value.split(";"):
        if ":" not in clause:
            raise TraceValidationError(f"{label}: malformed CPU/range clause")
        cpu, raw_ranges = clause.split(":", 1)
        if cpu not in ("m68k", "master"):
            raise TraceValidationError(f"{label}: wrong CPU {cpu!r}")
        if cpu in parsed:
            raise TraceValidationError(f"{label}: duplicate CPU {cpu}")
        if not raw_ranges:
            raise TraceValidationError(f"{label}: missing range for {cpu}")
        ranges: list[PcRange] = []
        for raw_range in raw_ranges.split(","):
            match = PC_RANGE_RE.fullmatch(raw_range)
            if not match:
                raise TraceValidationError(
                    f"{label}: malformed PC range {raw_range!r}"
                )
            start, end = (int(item, 16) for item in match.groups())
            if start >= end:
                raise TraceValidationError(
                    f"{label}: empty or reversed PC range {raw_range}"
                )
            ranges.append(PcRange(start, end))
        if ranges != sorted(ranges):
            raise TraceValidationError(f"{label}: {cpu} ranges are not sorted")
        for left, right in pairwise(ranges):
            if left.end > right.start:
                raise TraceValidationError(
                    f"{label}: overlapping {cpu} PC ranges"
                )
        parsed[cpu] = tuple(ranges)
    if set(parsed) != {"m68k", "master"}:
        raise TraceValidationError(f"{label}: missing CPU allowlist")

    all_ranges = [
        (pc_range, cpu)
        for cpu, ranges in parsed.items()
        for pc_range in ranges
    ]
    for index, (left, left_cpu) in enumerate(all_ranges):
        for right, right_cpu in all_ranges[index + 1 :]:
            if left.start < right.end and right.start < left.end:
                raise TraceValidationError(
                    f"{label}: overlapping {left_cpu}/{right_cpu} PC ranges"
                )
    return PcAllowlist(m68k=parsed["m68k"], master=parsed["master"])


def _require_gate_a_allowlist(value: str, label: str) -> PcAllowlist:
    allowlist = _parse_pc_allowlist(value, label)
    if allowlist != GATE_A_PC_ALLOWLIST or value != PC_ALLOWLIST_TEXT:
        if (
            allowlist.m68k == GATE_A_PC_ALLOWLIST.master
            or allowlist.master == GATE_A_PC_ALLOWLIST.m68k
        ):
            detail = "wrong-CPU"
        elif any(
            actual.start <= expected.start and actual.end >= expected.end
            and actual != expected
            for cpu in ("m68k", "master")
            for expected in GATE_A_PC_ALLOWLIST.ranges_for(cpu)
            for actual in allowlist.ranges_for(cpu)
        ):
            detail = "broadened"
        else:
            detail = "missing or changed"
        raise TraceValidationError(
            f"{label}: {detail} PC range relative to reviewed Gate-A policy"
        )
    return allowlist


def _require_mode1_allowlist(value: str, label: str) -> PcAllowlist:
    allowlist = _parse_pc_allowlist(value, label)
    if allowlist != MODE1_PC_ALLOWLIST or value != MODE1_PC_ALLOWLIST_TEXT:
        raise TraceValidationError(
            f"{label}: missing, broadened, or changed range relative to mode-1 policy"
        )
    return allowlist


def parse_mmio_trace(path: Path, *, gate_b_mode1: bool = False) -> MmioTrace:
    """Parse a complete, zero-loss trace using the Gate-A fail-closed format."""

    try:
        lines = path.read_text(encoding="utf-8").splitlines()
    except (OSError, UnicodeError) as exc:
        raise TraceValidationError(f"cannot read trace: {exc}") from exc
    if len(lines) < 4:
        raise TraceValidationError("trace is incomplete: header/footer missing")

    header = HEADER_RE.fullmatch(lines[0])
    if not header:
        raise TraceValidationError("line 1: malformed MMIO trace header")
    (
        capacity,
        sh2_drc,
        profile_pc,
        profile_pc_env,
        batching,
        instruction_hook,
        m68k_wrapped,
        master_wrapped,
        coverage_from_start,
        header_allowlist_text,
    ) = header.groups()
    expected_header = (
        int(capacity) == TRACE_CAPACITY
        and sh2_drc == "1"
        and profile_pc == "0"
        and profile_pc_env == "0"
        and batching == "normal"
        and instruction_hook == "1"
        and m68k_wrapped == "1"
        and master_wrapped == "1"
        and coverage_from_start == "1"
    )
    if not expected_header:
        raise TraceValidationError(
            "trace was not captured with the reviewed passive configuration"
        )
    require_allowlist = (
        _require_mode1_allowlist if gate_b_mode1 else _require_gate_a_allowlist
    )
    expected_filter = MODE1_FILTER_LINE if gate_b_mode1 else FILTER_LINE
    pc_allowlist = require_allowlist(header_allowlist_text, "line 1 pc_allowlist")
    if lines[1] != expected_filter:
        raise TraceValidationError("line 2: MMIO filter declaration mismatch")
    if tuple(lines[2].split(",")) != TRACE_COLUMNS:
        raise TraceValidationError("line 3: trace column declaration mismatch")

    footer = COMPLETE_RE.fullmatch(lines[-1])
    if not footer:
        if lines[-1].startswith("# INCOMPLETE"):
            raise TraceValidationError("trace footer reports INCOMPLETE")
        raise TraceValidationError("trace has no valid COMPLETE footer")
    (
        frames_text,
        total_text,
        recorded_text,
        dropped_text,
        errors_text,
        overflow_text,
        footer_allowlist_text,
    ) = footer.groups()
    frames, total, recorded, dropped, errors, overflow = map(
        int,
        (
            frames_text,
            total_text,
            recorded_text,
            dropped_text,
            errors_text,
            overflow_text,
        ),
    )
    footer_allowlist = require_allowlist(footer_allowlist_text, "footer pc_allowlist")
    if footer_allowlist != pc_allowlist:
        raise TraceValidationError("header/footer PC allowlists differ")
    if frames <= 0:
        raise TraceValidationError("COMPLETE footer has no emulated frames")
    if dropped != 0 or errors != 0 or overflow != 0:
        raise TraceValidationError(
            "COMPLETE footer reports drops, errors, or overflow"
        )

    events: list[MmioEvent] = []
    previous_frame = -1
    reader = csv.reader(lines[3:-1], strict=True)
    try:
        for sequence, row in enumerate(reader):
            line_number = sequence + 4
            if len(row) != len(TRACE_COLUMNS):
                raise TraceValidationError(
                    f"line {line_number}: expected {len(TRACE_COLUMNS)} columns"
                )
            actual_sequence = _parse_decimal(row[0], "sequence", line_number)
            if actual_sequence != sequence:
                raise TraceValidationError(
                    f"line {line_number}: sequence is not contiguous"
                )
            frame = _parse_decimal(row[1], "frame", line_number)
            if frame >= frames:
                raise TraceValidationError(
                    f"line {line_number}: frame is outside COMPLETE range"
                )
            if frame < previous_frame:
                raise TraceValidationError(
                    f"line {line_number}: emulated frame moved backwards"
                )
            previous_frame = frame
            pc = _parse_hex(row[3], "pc", line_number, fixed_32=True)
            address = _parse_hex(
                row[5], "address", line_number, fixed_32=True
            )
            width = _parse_decimal(row[6], "width", line_number)
            value = _parse_hex(row[7], "value", line_number)
            key = (row[2], row[4], address, width)
            if key not in EVENT_KIND:
                raise TraceValidationError(
                    f"line {line_number}: CPU/op/address/width is not allowed"
                )
            if pc == 0:
                raise TraceValidationError(
                    f"line {line_number}: exact CPU PC is missing"
                )
            if not pc_allowlist.contains(row[2], pc):
                raise TraceValidationError(
                    f"line {line_number}: PC is outside the pinned "
                    f"{row[2]} allowlist"
                )
            if value >= 1 << (width * 8):
                raise TraceValidationError(
                    f"line {line_number}: value exceeds access width"
                )
            events.append(
                MmioEvent(
                    sequence=actual_sequence,
                    frame=frame,
                    cpu=row[2],
                    pc=pc,
                    op=row[4],
                    address=address,
                    width=width,
                    value=value,
                )
            )
    except csv.Error as exc:
        raise TraceValidationError(f"malformed CSV: {exc}") from exc

    if recorded != len(events) or total != len(events):
        raise TraceValidationError(
            "COMPLETE totals do not match the recorded event rows"
        )
    return MmioTrace(
        frames=frames,
        events=tuple(events),
        pc_allowlist=pc_allowlist,
    )


def _require_kind(
    events: tuple[MmioEvent, ...], index: int, kind: str
) -> tuple[MmioEvent, int]:
    if index >= len(events):
        raise TraceValidationError(
            f"transaction ended while waiting for {kind}"
        )
    event = events[index]
    if event.kind != kind:
        raise TraceValidationError(
            f"event {event.sequence}: expected {kind}, got {event.kind}"
        )
    return event, index + 1


def validate_gate_a_mode0(
    trace: MmioTrace, expected_transactions: int
) -> int:
    """Validate the accepted mode-0 cmd-$3E witness inside Gate-A ranges.

    The accepted helper may retry the forced COMM0_HI 0->1 edge up to sixteen
    times.  Its first 128 FIFO words are written by a generic shared routine
    outside the manifest-pinned helper range, so Gate A records the helper's
    final 32 FIFO words.  FULL-read PCs are a Gate-B manifest dependency.
    """

    if expected_transactions < 0:
        raise TraceValidationError("expected transaction count cannot be negative")
    events = trace.events
    index = 0
    transactions = 0
    policy = GATE_A_MODE0_PC_POLICY
    while index < len(events):
        retries = 0
        while (
            index < len(events)
            and events[index].kind == "trigger"
            and events[index].pc == policy.trigger_reset
        ):
            reset = events[index]
            if reset.value != 0:
                raise TraceValidationError(
                    f"event {reset.sequence}: trigger reset did not write 0"
                )
            index += 1
            trigger, index = _require_kind(events, index, "trigger")
            if trigger.pc != policy.trigger_set or trigger.value != 1:
                raise TraceValidationError(
                    f"event {trigger.sequence}: malformed trigger-set edge"
                )
            retries += 1
            if retries > 16:
                raise TraceValidationError(
                    f"transaction {transactions}: more than 16 trigger retries"
                )
        if retries == 0:
            event = events[index]
            raise TraceValidationError(
                f"event {event.sequence}: transaction lacks trigger reset/set"
            )
        ack, index = _require_kind(events, index, "master_ack")
        if ack.pc != policy.master_ack or ack.value != 3:
            raise TraceValidationError(
                f"event {ack.sequence}: malformed mode-0 Master ACK"
            )
        clear, index = _require_kind(events, index, "ack_clear")
        if clear.pc != policy.ack_clear or clear.value != 1:
            raise TraceValidationError(
                f"event {clear.sequence}: malformed mode-0 ACK clear"
            )
        for _ in range(32):
            fifo, index = _require_kind(events, index, "fifo_write")
            if fifo.pc != policy.fifo_write:
                raise TraceValidationError(
                    f"event {fifo.sequence}: wrong mode-0 FIFO writer PC"
                )
        completion, index = _require_kind(events, index, "completion")
        if completion.pc != policy.completion or completion.value != 0:
            raise TraceValidationError(
                f"event {completion.sequence}: malformed mode-0 completion"
            )
        transactions += 1
    if transactions != expected_transactions:
        raise TraceValidationError(
            f"expected {expected_transactions} mode-0 transactions, "
            f"found {transactions}"
        )
    return transactions


def _validate_complete_mode1_transactions(
    trace: MmioTrace, pc_policy: TransactionPcPolicy
) -> int:
    """Validate the COMM0_LO readiness/eight-group/completion protocol."""

    for field in (
        "command_index",
        "trigger",
        "ready_poll",
        "ready_publish",
        "ready_flush",
        "busy_guard",
        "full_read",
        "fifo_write",
        "m68k_dreq_read",
        "master_dreq_read",
        "completion",
        "completion_flush",
    ):
        if not pc_policy.allowed_for(field):
            raise TraceValidationError(f"PC policy for {field} is empty")
    for event in trace.events:
        if event.kind in {"ack_read", "ack_clear", "master_ack"}:
            raise TraceValidationError(
                f"event {event.sequence}: forbidden COMM1 access in mode-1 protocol"
            )
        allowed = pc_policy.allowed_for(event.kind)
        if event.pc not in allowed:
            raise TraceValidationError(
                f"event {event.sequence}: PC 0x{event.pc:08X} is not "
                f"allowed for {event.kind}"
            )
        expected_value = TRANSITION_VALUES.get(event.kind)
        if expected_value is not None and event.value != expected_value:
            raise TraceValidationError(
                f"event {event.sequence}: {event.kind} observed/wrote "
                f"0x{event.value:X}, expected 0x{expected_value:X}"
            )
        if event.kind == "master_hi_read":
            if event.pc in pc_policy.busy_guard:
                expected_value = 0x01
                label = "busy guard"
            else:
                expected_value = 0x00
                label = "completion flush"
            if event.value != expected_value:
                raise TraceValidationError(
                    f"event {event.sequence}: {label} read "
                    f"0x{event.value:X}, expected 0x{expected_value:X}"
                )

    events = trace.events
    index = 0
    transactions = 0
    while index < len(events):
        if events[index].kind != "command_index":
            raise TraceValidationError(
                f"event {events[index].sequence}: waiting for command_index, "
                f"saw {events[index].kind}"
            )
        end = next(
            (
                position
                for position in range(index, len(events))
                if events[position].kind == "master_hi_read"
                and events[position].pc in pc_policy.completion_flush
            ),
            None,
        )
        if end is None:
            raise TraceValidationError(
                f"transaction {transactions}: waiting for completion flush"
            )
        transaction = events[index : end + 1]
        m68k = [event for event in transaction if event.cpu == "m68k"]
        master = [event for event in transaction if event.cpu == "master"]

        m68k_index = 0
        command_index, m68k_index = _require_kind(
            m68k, m68k_index, "command_index"
        )
        trigger, m68k_index = _require_kind(m68k, m68k_index, "trigger")
        ready_zero = None
        while m68k_index < len(m68k) and m68k[m68k_index].kind == "ready_poll":
            ready = m68k[m68k_index]
            m68k_index += 1
            if ready.value == 0:
                ready_zero = ready
                break
        if ready_zero is None:
            raise TraceValidationError(
                f"transaction {transactions}: no COMM0_LO readiness-zero observation"
            )

        first_fifo = None
        for group in range(8):
            while True:
                full, m68k_index = _require_kind(
                    m68k, m68k_index, "full_read"
                )
                if full.value & 0x80 == 0:
                    break
            for _ in range(4):
                fifo, m68k_index = _require_kind(
                    m68k, m68k_index, "fifo_write"
                )
                if first_fifo is None:
                    first_fifo = fifo

        saw_m68k_zero = None
        while m68k_index < len(m68k) and m68k[m68k_index].kind == "dreq_read":
            dreq = m68k[m68k_index]
            m68k_index += 1
            if dreq.value == 0:
                saw_m68k_zero = dreq
                break
        if saw_m68k_zero is None:
            raise TraceValidationError(
                f"transaction {transactions}: 68K did not observe DREQ_LEN zero"
            )
        if m68k_index != len(m68k):
            event = m68k[m68k_index]
            raise TraceValidationError(
                f"event {event.sequence}: unexpected {event.kind} after 68K DREQ zero"
            )

        master_index = 0
        ready_publish, master_index = _require_kind(
            master, master_index, "ready_publish"
        )
        _, master_index = _require_kind(master, master_index, "ready_flush")
        busy_guard, master_index = _require_kind(
            master, master_index, "master_hi_read"
        )
        if busy_guard.pc not in pc_policy.busy_guard:
            raise TraceValidationError(
                f"event {busy_guard.sequence}: wrong busy guard PC"
            )
        saw_master_zero = None
        while (
            master_index < len(master)
            and master[master_index].kind == "dreq_read"
        ):
            dreq = master[master_index]
            master_index += 1
            if dreq.value == 0:
                saw_master_zero = dreq
                break
        if saw_master_zero is None:
            raise TraceValidationError(
                f"transaction {transactions}: Master did not observe DREQ_LEN zero"
            )
        completion, master_index = _require_kind(
            master, master_index, "completion"
        )
        completion_flush, master_index = _require_kind(
            master, master_index, "master_hi_read"
        )
        if completion_flush.pc not in pc_policy.completion_flush:
            raise TraceValidationError(
                f"event {completion_flush.sequence}: wrong completion flush PC"
            )
        if master_index != len(master):
            event = master[master_index]
            raise TraceValidationError(
                f"event {event.sequence}: unexpected {event.kind} after completion"
            )

        assert first_fifo is not None
        if not (
            command_index.sequence
            < trigger.sequence
            < ready_publish.sequence
            <= ready_zero.sequence
            < first_fifo.sequence
        ):
            raise TraceValidationError(
                f"transaction {transactions}: global command/trigger/readiness/"
                "FIFO order violated"
            )
        if (
            saw_m68k_zero.sequence > completion.sequence
            or saw_master_zero.sequence > completion.sequence
        ):
            raise TraceValidationError(
                f"transaction {transactions}: completion preceded a DREQ-zero witness"
            )

        index = end + 1
        transactions += 1
    return transactions


def validate_mode1(
    trace: MmioTrace,
    pc_policy: TransactionPcPolicy,
    *,
    arm: str,
    expected_eligible_hook_hits: int,
) -> int:
    """Validate an explicit mode-1 arm against lifecycle-derived hook hits."""

    if arm not in ("active", "control"):
        raise TraceValidationError("mode-1 arm must be active or control")
    if expected_eligible_hook_hits <= 0:
        raise TraceValidationError(
            "expected eligible subsequent hook hits must be positive"
        )
    if arm == "control":
        if trace.events:
            raise TraceValidationError(
                f"mode-1 CONTROL must contain zero MMIO events, found {len(trace.events)}"
            )
        return 0
    if not trace.events:
        raise TraceValidationError(
            "mode-1 ACTIVE contains zero transactions"
        )
    transactions = _validate_complete_mode1_transactions(trace, pc_policy)
    if transactions != expected_eligible_hook_hits:
        raise TraceValidationError(
            f"mode-1 ACTIVE expected {expected_eligible_hook_hits} transactions "
            f"for eligible subsequent hook hits, found {transactions}"
        )
    return transactions


def _parse_pc_set(values: Iterable[str]) -> frozenset[int]:
    parsed = frozenset(int(value, 0) for value in values)
    if any(value <= 0 or value > 0xFFFFFFFF for value in parsed):
        raise argparse.ArgumentTypeError("PC values must be non-zero 32-bit integers")
    return parsed


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("trace", type=Path)
    parser.add_argument(
        "--gate-a-mode0",
        choices=("active", "control"),
        help="validate the manifest-bound Gate-A mode-0 witness",
    )
    parser.add_argument(
        "--mode1",
        choices=("active", "control"),
        help="validate an explicit mode-1 ACTIVE or CONTROL trace",
    )
    parser.add_argument(
        "--expected-eligible-hook-hits",
        type=int,
        help="lifecycle-derived eligible subsequent hook-hit count",
    )
    pc_destinations: list[str] = []
    for kind in (
        "command-index",
        "trigger",
        "ready-poll",
        "ready-publish",
        "ready-flush",
        "busy-guard",
        "full-read",
        "fifo-write",
        "m68k-dreq-read",
        "master-dreq-read",
        "completion",
        "completion-flush",
    ):
        option = f"--{kind}-pc"
        parser.add_argument(option, action="append")
        pc_destinations.append(kind.replace("-", "_") + "_pc")
    args = parser.parse_args(argv)
    pc_values = [getattr(args, destination) for destination in pc_destinations]
    if bool(args.gate_a_mode0) == bool(args.mode1):
        parser.error("select exactly one of --gate-a-mode0 or --mode1")
    if args.gate_a_mode0:
        if any(pc_values) or args.expected_eligible_hook_hits is not None:
            parser.error(
                "--gate-a-mode0 cannot be combined with mode-1 count/PC policy"
            )
        policy = None
    else:
        if args.expected_eligible_hook_hits is None:
            parser.error("--mode1 requires --expected-eligible-hook-hits")
        missing = [
            destination
            for destination, values in zip(
                pc_destinations, pc_values, strict=True
            )
            if not values
        ]
        if missing:
            parser.error(
                "all twelve --*-pc policies are required outside Gate-A mode"
            )
        policy = TransactionPcPolicy(
            command_index=_parse_pc_set(args.command_index_pc),
            trigger=_parse_pc_set(args.trigger_pc),
            ready_poll=_parse_pc_set(args.ready_poll_pc),
            ready_publish=_parse_pc_set(args.ready_publish_pc),
            ready_flush=_parse_pc_set(args.ready_flush_pc),
            busy_guard=_parse_pc_set(args.busy_guard_pc),
            full_read=_parse_pc_set(args.full_read_pc),
            fifo_write=_parse_pc_set(args.fifo_write_pc),
            m68k_dreq_read=_parse_pc_set(args.m68k_dreq_read_pc),
            master_dreq_read=_parse_pc_set(args.master_dreq_read_pc),
            completion=_parse_pc_set(args.completion_pc),
            completion_flush=_parse_pc_set(args.completion_flush_pc),
        )
    try:
        trace = parse_mmio_trace(args.trace, gate_b_mode1=bool(args.mode1))
        if args.gate_a_mode0:
            transactions = validate_gate_a_mode0(
                trace, 1 if args.gate_a_mode0 == "active" else 0
            )
        else:
            assert policy is not None
            transactions = validate_mode1(
                trace,
                policy,
                arm=args.mode1,
                expected_eligible_hook_hits=args.expected_eligible_hook_hits,
            )
    except (OSError, TraceValidationError, ValueError) as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1
    print(
        f"PASS: {transactions} transactions, {len(trace.events)} events, "
        f"{trace.frames} emulated frames"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
