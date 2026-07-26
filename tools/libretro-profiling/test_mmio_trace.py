#!/usr/bin/env python3
"""Focused unit tests for the VR60 Gate-A passive MMIO logger."""

from __future__ import annotations

import tempfile
import unittest
from dataclasses import replace
from pathlib import Path

from validate_mmio_trace import (
    FILTER_LINE,
    PC_ALLOWLIST_TEXT,
    TRACE_CAPACITY,
    MmioEvent,
    TraceValidationError,
    TransactionPcPolicy,
    parse_mmio_trace,
    validate_gate_a_mode0,
    validate_transactions,
)

TOOL_DIR = Path(__file__).resolve().parent
REPO_ROOT = TOOL_DIR.parents[1]
CORE_SOURCE = (
    REPO_ROOT
    / "third_party"
    / "picodrive"
    / "platform"
    / "libretro"
    / "libretro.c"
)
CORE_MEMORY_SOURCE = (
    REPO_ROOT
    / "third_party"
    / "picodrive"
    / "pico"
    / "32x"
    / "memory.c"
)
POLICY = TransactionPcPolicy(
    trigger=frozenset({0x0001C700}),
    master_ack=frozenset({0x023016C0}),
    ack_clear=frozenset({0x0001C710}),
    full_read=frozenset({0x0001C720}),
    fifo_write=frozenset({0x0001C730}),
    completion=frozenset({0x02301710}),
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

    append("m68k", 0x0001C700, "write", 0x00A15120, 1, 0x01)
    append("master", 0x023016C0, "write", 0x20004023, 1, 0x02)
    append("m68k", 0x0001C710, "write", 0x00A15123, 1, 0x00)
    for group in range(8):
        append("m68k", 0x0001C720, "read", 0x00A15107, 1, 0x80)
        append("m68k", 0x0001C720, "read", 0x00A15107, 1, group)
        for word in range(4):
            append(
                "m68k",
                0x0001C730,
                "write",
                0x00A15112,
                2,
                (group << 8) | word,
            )
    append("master", 0x02301710, "write", 0x20004020, 1, 0x00)
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


def render_trace(
    events: list[MmioEvent],
    *,
    status: str = "COMPLETE",
    dropped: int = 0,
    errors: int = 0,
    overflow: int = 0,
) -> str:
    frames = max((event.frame for event in events), default=0) + 1
    lines = [
        (
            f"# VRD_MMIO_TRACE version=2 capacity={TRACE_CAPACITY} "
            "sh2_drc=1 profile_pc=0 profile_pc_env=0 "
            "m68k_batching=normal instruction_start_hook=1 "
            "m68k_wrapped=1 master_wrapped=1 coverage_from_start=1 "
            f"pc_allowlist={PC_ALLOWLIST_TEXT}"
        ),
        FILTER_LINE,
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
            f"overflow={overflow} pc_allowlist={PC_ALLOWLIST_TEXT}"
        )
    else:
        lines.append(
            f"# INCOMPLETE frames={frames} events={total} "
            f"recorded={len(events)} dropped={dropped} errors={errors} "
            f"overflow={overflow} pc_allowlist={PC_ALLOWLIST_TEXT} reason=test"
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


class MmioTraceParserTests(unittest.TestCase):
    def test_eight_group_transaction_is_accepted(self) -> None:
        path = write_temp_trace(render_trace(valid_events()))
        trace = parse_mmio_trace(path)
        self.assertEqual(validate_transactions(trace, POLICY), 1)
        self.assertEqual(len(trace.events), 52)

    def test_incomplete_and_overflow_traces_are_rejected(self) -> None:
        for text in (
            render_trace(valid_events(), status="INCOMPLETE"),
            render_trace(valid_events(), dropped=1, overflow=1),
        ):
            with self.subTest(
                footer=text.splitlines()[-1]
            ), self.assertRaises(TraceValidationError):
                parse_mmio_trace(write_temp_trace(text))

    def test_malformed_sequence_is_rejected(self) -> None:
        events = valid_events()
        events[4] = replace(events[4], sequence=99)
        with self.assertRaisesRegex(TraceValidationError, "not contiguous"):
            parse_mmio_trace(write_temp_trace(render_trace(events)))

    def test_transition_grammar_rejects_missing_fifo_word(self) -> None:
        events = valid_events()
        del events[6]
        events = [replace(event, sequence=i) for i, event in enumerate(events)]
        trace = parse_mmio_trace(write_temp_trace(render_trace(events)))
        with self.assertRaisesRegex(TraceValidationError, "expected fifo_write"):
            validate_transactions(trace, POLICY)

    def test_wrong_width_and_address_are_rejected(self) -> None:
        base = valid_events()
        for changed in (
            replace(base[0], width=2),
            replace(base[0], address=0x00A15121),
        ):
            events = list(base)
            events[0] = changed
            with self.subTest(event=changed), self.assertRaisesRegex(
                TraceValidationError, "CPU/op/address/width"
            ):
                parse_mmio_trace(write_temp_trace(render_trace(events)))

    def test_wrong_exact_pc_is_rejected(self) -> None:
        events = valid_events()
        events[0] = replace(events[0], pc=0x0001C702)
        trace = parse_mmio_trace(write_temp_trace(render_trace(events)))
        with self.assertRaisesRegex(TraceValidationError, "is not allowed"):
            validate_transactions(trace, POLICY)

    def test_wrong_transition_value_is_rejected(self) -> None:
        events = valid_events()
        events[1] = replace(events[1], value=0x00)
        trace = parse_mmio_trace(write_temp_trace(render_trace(events)))
        with self.assertRaisesRegex(TraceValidationError, "master_ack wrote"):
            validate_transactions(trace, POLICY)


class GateAMode0Tests(unittest.TestCase):
    def test_active_transaction_and_empty_control_are_accepted(self) -> None:
        active = parse_mmio_trace(
            write_temp_trace(render_trace(valid_gate_a_events()))
        )
        control = parse_mmio_trace(write_temp_trace(render_trace([])))
        self.assertEqual(validate_gate_a_mode0(active, 1), 1)
        self.assertEqual(validate_gate_a_mode0(control, 0), 0)

    def test_missing_fifo_word_is_rejected(self) -> None:
        events = valid_gate_a_events()
        del events[-2]
        events = [replace(event, sequence=i) for i, event in enumerate(events)]
        trace = parse_mmio_trace(write_temp_trace(render_trace(events)))
        with self.assertRaisesRegex(TraceValidationError, "expected fifo_write"):
            validate_gate_a_mode0(trace, 1)

    def test_malformed_retry_edge_is_rejected(self) -> None:
        events = valid_gate_a_events()
        events[1] = replace(events[1], value=0)
        trace = parse_mmio_trace(write_temp_trace(render_trace(events)))
        with self.assertRaisesRegex(TraceValidationError, "trigger-set"):
            validate_gate_a_mode0(trace, 1)


class PcAllowlistTests(unittest.TestCase):
    def tamper_allowlist(self, replacement: str) -> str:
        return render_trace(valid_events()).replace(
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
        events = valid_events()
        events[0] = replace(events[0], pc=0x023016C0)
        with self.assertRaisesRegex(TraceValidationError, "outside the pinned"):
            parse_mmio_trace(write_temp_trace(render_trace(events)))


class MmioCallbackSourceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.source = CORE_SOURCE.read_text(encoding="utf-8")
        cls.memory_source = CORE_MEMORY_SOURCE.read_text(encoding="utf-8")

    def test_wrappers_call_each_saved_callback_exactly_once(self) -> None:
        checks = (
            (
                "static unsigned int vrd_mmio_trace_read_byte",
                "vrd_mmio_trace_orig_read_byte(",
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
        )
        for signature, callback, source in checks:
            with self.subTest(wrapper=signature):
                body = c_function_body(source, signature)
                self.assertEqual(body.count(callback), 1)

    def test_wrappers_never_reread_or_emit_events_directly(self) -> None:
        signatures = (
            ("static unsigned int vrd_mmio_trace_read_byte", self.source),
            ("static void vrd_mmio_trace_write_byte", self.source),
            ("static void vrd_mmio_trace_write_word", self.source),
            ("static void vrd_mmio_trace_append", self.source),
            (
                "static void REGPARM(3) vrd_mmio_trace_master_write8",
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
            "vrd_mmio_trace_master_observer(pc, address, value & 0xff);",
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


if __name__ == "__main__":
    unittest.main()
