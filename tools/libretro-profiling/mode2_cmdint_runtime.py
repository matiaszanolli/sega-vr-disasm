#!/usr/bin/env python3
"""Capture and fail-closed validate the isolated Q-021 mode-2 CMDINT pair."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

import mode1_cmdint_runtime as shared


SCHEMA = "vrd-vr60-q021-mode2-cmdint-runtime-v1"
ACTIVE_SHA256 = "96d79e3fb4d2df8a69852917ac811f860935ae950fc87222d008fa45d47ee276"
CONTROL_SHA256 = "da5ce4ec9ef8e050c7babeb113e26aa7335a3ff5285285e55a6606d2f96309b8"
DEFAULT_SHA256 = shared.DEFAULT_SHA256
FRONTEND_SHA256 = shared.FRONTEND_SHA256
CORE_SHA256 = shared.CORE_SHA256
CANONICAL_CORE_SHA256 = shared.CANONICAL_CORE_SHA256
NAME_SOURCE_SHA256 = shared.NAME_SOURCE_SHA256
NAME_SOURCE_SIZE = shared.NAME_SOURCE_SIZE
# The one-shot transfer completes in frame 1259 on the pinned autoplay route.
# Capture at the first post-transfer boundary: later execution changes this
# SDRAM region, so a later read cannot prove the transport payload itself.
NORMAL_FRAMES = 1260
NAME_FRAMES = shared.NAME_FRAMES
TRACE_ADDRESS = shared.TRACE_ADDRESS
TRACE_SIZE = shared.TRACE_SIZE
WRITE_TARGETS = shared.WRITE_TARGETS
ARMS = shared.ARMS
ROUTES = shared.ROUTES
REPEATS = shared.REPEATS
PAYLOAD_BYTES = 3840
FIFO_WORDS = 1920
FIFO_WORDS_PER_GROUP = 4
FIFO_GROUPS = 480
SOURCE_ADDRESS = 0x00FF6B40
DESTINATION_ADDRESS = 0x06010000
DESTINATION_END = 0x06010F00
TRACE_MAGIC = 0x51323249  # "Q22I"
TRACE_INVERSE = 0xAECDCDB6
SAFE_SETUP_SPCS = shared.SAFE_SETUP_SPCS


def expected_artifacts() -> tuple[str, ...]:
    names = ["name-source.mds", "name-route-seeded.mds", "name-input.csv"]
    for arm in ARMS:
        for route in ROUTES:
            for repeat in REPEATS:
                prefix = f"{arm}-{route}-{repeat}"
                names.extend((
                    f"{prefix}.mmio.trace", f"{prefix}.write.trace",
                    f"{prefix}.caller.trace", f"{prefix}.commands",
                    f"{prefix}.debug.txt",
                ))
    names.extend((
        "active-vres.commands", "active-vres.debug.txt",
        "default-reset-baseline.commands", "default-reset-baseline.txt",
    ))
    return tuple(names)


EXPECTED_ARTIFACTS = expected_artifacts()


def prepare_name_fixture(source: Path, output: Path) -> list[dict[str, object]]:
    """Reuse the accepted fixture transform, rebinding only its trace sentinel."""
    changes = shared.prepare_name_fixture(source, output)
    image = bytearray(output.read_bytes())
    old_trace = bytearray(TRACE_SIZE)
    old_trace[0:4] = bytes.fromhex("51323149")
    old_trace[48:52] = (1).to_bytes(4, "big")
    old_trace[60:64] = bytes.fromhex("aecdceb6")
    new_trace = bytearray(old_trace)
    new_trace[0:4] = TRACE_MAGIC.to_bytes(4, "big")
    new_trace[60:64] = TRACE_INVERSE.to_bytes(4, "big")
    old_serialized = shared.raw_words(old_trace)
    offset = image.find(old_serialized)
    if offset < 0 or image.find(old_serialized, offset + 1) >= 0:
        raise ValueError("name fixture Q21I trace sentinel is not unique")
    image[offset : offset + TRACE_SIZE] = shared.raw_words(new_trace)
    output.write_bytes(image)
    trace_change = changes[2]
    if trace_change.get("after") != old_serialized.hex():
        raise ValueError("name fixture accepted trace transformation changed")
    trace_change["after"] = shared.raw_words(new_trace).hex()
    trace_change["reason"] = "initialize Q22I trace as one completed startup-shim call"
    return changes


def require_m68k_event(row: dict[str, object], pc: int, op: str, address: int,
                       width: int, value: int | None = None) -> None:
    shared.require_event(row, "m68k", pc, op, address, width, value)


def validate_transaction(rows: list[dict[str, object]]) -> bytes:
    """Pin one 3840-byte transaction, including both CPUs' exact chronology."""
    m68k = [row for row in rows if row["cpu"] == "m68k"]
    master = [row for row in rows if row["cpu"] == "master"]
    index = 0
    prefix = (
        (0x1C92E, "read", 0xA15103, 1, 0),
        (0x1C938, "read", 0xA15107, 1, 0),
        (0x1C940, "read", 0xA15110, 2, 0),
        (0x1C94A, "write", 0xA1510C, 2, 1),
        (0x1C952, "write", 0xA1510E, 2, 0),
        (0x1C95A, "write", 0xA15110, 2, FIFO_WORDS),
        (0x1C962, "write", 0xA15107, 1, 4),
        (0x1C96A, "read", 0xA15103, 1, 0),
        (0x1C96A, "write", 0xA15103, 1, 1),
    )
    for pc, op, address, width, value in prefix:
        require_m68k_event(m68k[index], pc, op, address, width, value)
        index += 1
    setup_polls: list[dict[str, object]] = []
    while index < len(m68k) and shared.event_is(
        m68k[index], "m68k", 0x1C972, "read", 0xA15103, 1
    ):
        setup_polls.append(m68k[index]); index += 1
    if not setup_polls or setup_polls[-1]["value"] != 0 or any(
        row["value"] != 1 for row in setup_polls[:-1]
    ):
        raise ValueError("setup INTM acknowledgement polls")

    fifo_words: list[int] = []
    for _group in range(FIFO_GROUPS):
        require_m68k_event(m68k[index], 0x1C98C, "read", 0xA15107, 1, 4)
        index += 1
        for _word in range(FIFO_WORDS_PER_GROUP):
            require_m68k_event(m68k[index], 0x1C992, "write", 0xA15112, 2)
            fifo_words.append(int(m68k[index]["value"])); index += 1
    if len(fifo_words) != FIFO_WORDS:
        raise ValueError("mode-2 FIFO word count")
    tail = (
        (0x1C9A0, "read", 0xA15110, 2, 0),
        (0x1C9AA, "read", 0xA15107, 1, 0),
        (0x1C9B4, "read", 0xA15103, 1, 0),
        (0x1C9BE, "read", 0xA15103, 1, 0),
        (0x1C9BE, "write", 0xA15103, 1, 1),
    )
    for pc, op, address, width, value in tail:
        require_m68k_event(m68k[index], pc, op, address, width, value)
        index += 1
    completion_polls: list[dict[str, object]] = []
    while index < len(m68k) and shared.event_is(
        m68k[index], "m68k", 0x1C9C6, "read", 0xA15103, 1
    ):
        completion_polls.append(m68k[index]); index += 1
    if index != len(m68k) or not completion_polls or completion_polls[-1]["value"] != 0 \
            or any(row["value"] != 1 for row in completion_polls[:-1]):
        raise ValueError("completion INTM acknowledgement polls")

    mi = 0
    shared.require_master_event(master[mi], "read", 0xFFFFFE17, 1)
    initial_tocr = int(master[mi]["value"]); mi += 1
    shared.require_master_event(master[mi], "write", 0xFFFFFE17, 1, initial_tocr ^ 2); mi += 1
    for op, address, width, value in (
        ("read", 0x20004006, 2, 0x4004),
        ("read", 0x20004010, 2, FIFO_WORDS),
        ("read", 0x2000400C, 2, 1), ("read", 0x2000400E, 2, 0),
        ("read", 0xFFFFFF88, 4, 0),
    ):
        shared.require_master_event(master[mi], op, address, width, value); mi += 1
    shared.require_master_event(master[mi], "read", 0xFFFFFF8C, 4)
    prior_chcr = int(master[mi]["value"]); mi += 1
    if prior_chcr == 0x44E3:
        shared.require_master_event(master[mi], "write", 0xFFFFFF8C, 4, 0x44E0); mi += 1
        shared.require_master_event(master[mi], "read", 0xFFFFFF8C, 4, 0x44E0); mi += 1
    elif prior_chcr != 0x44E0:
        raise ValueError("setup prior CHCR lifecycle")
    for op, address, width, value in (
        ("write", 0xFFFFFF80, 4, 0x20004012),
        ("write", 0xFFFFFF84, 4, DESTINATION_ADDRESS),
        ("write", 0xFFFFFF88, 4, FIFO_WORDS),
        ("write", 0xFFFFFF8C, 4, 0x44E1),
        ("write", 0xFFFFFFB0, 4, 1), ("read", 0xFFFFFFB0, 4, 1),
        ("read", 0x20004000, 2, 0x8202), ("write", 0x20004000, 2, 0x8200),
        ("read", 0x20004000, 2, 0x8200), ("write", 0x2000401A, 2, 0),
        ("read", 0x2000401A, 2, None), ("write", 0x20004000, 2, 0x8202),
        ("read", 0x20004000, 2, 0x8202),
    ):
        shared.require_master_event(master[mi], op, address, width, value); mi += 1
    setup_ack_sequence = int(master[mi - 1]["sequence"])

    shared.require_master_event(master[mi], "read", 0xFFFFFE17, 1, initial_tocr ^ 2); mi += 1
    shared.require_master_event(master[mi], "write", 0xFFFFFE17, 1, initial_tocr); mi += 1
    for op, address, width, value in (
        ("read", 0x20004006, 2, 0x4000), ("read", 0x20004010, 2, 0),
        ("read", 0x2000400C, 2, 1), ("read", 0x2000400E, 2, 0),
        ("read", 0xFFFFFF80, 4, 0x20004012),
        ("read", 0xFFFFFF84, 4, DESTINATION_END),
        ("read", 0xFFFFFF88, 4, 0), ("read", 0xFFFFFF8C, 4, 0x44E3),
        ("read", 0xFFFFFFB0, 4, 1), ("read", 0xFFFFFF8C, 4, 0x44E3),
        ("read", 0xFFFFFF88, 4, 0), ("read", 0xFFFFFF84, 4, DESTINATION_END),
        ("write", 0xFFFFFF8C, 4, 0x44E0), ("read", 0xFFFFFF8C, 4, 0x44E0),
        ("read", 0x20004000, 2, 0x8202), ("write", 0x20004000, 2, 0x8200),
        ("read", 0x20004000, 2, 0x8200), ("write", 0x2000401A, 2, 0),
        ("read", 0x2000401A, 2, None), ("write", 0x20004000, 2, 0x8202),
        ("read", 0x20004000, 2, 0x8202),
    ):
        shared.require_master_event(master[mi], op, address, width, value); mi += 1
    if mi != len(master):
        raise ValueError("unexpected Master MMIO event")
    first_fifo = min(int(row["sequence"]) for row in rows if row["pc"] == 0x1C992)
    last_fifo = max(int(row["sequence"]) for row in rows if row["pc"] == 0x1C992)
    completion_start = int(master[-21]["sequence"])
    completion_ack = int(master[-1]["sequence"])
    if not setup_ack_sequence < first_fifo <= last_fifo < completion_start < completion_ack:
        raise ValueError("cross-CPU transaction ordering")
    return b"".join(word.to_bytes(2, "big") for word in fifo_words)


def validate_active_mmio(rows: list[dict[str, object]]) -> list[bytes]:
    starts = [index for index, row in enumerate(rows) if shared.event_is(
        row, "m68k", 0x1C92E, "read", 0xA15103, 1, 0
    )]
    if starts != [0]:
        raise ValueError("mode-2 must be exactly one lifecycle transaction")
    payload = validate_transaction(rows)
    if len(payload) != PAYLOAD_BYTES:
        raise ValueError("mode-2 payload byte count")
    return [payload]


def parse_terminal_stack_pointers(text: str) -> dict[str, int]:
    found = re.findall(r"(Master|Slave) SH2:.*?R15=([0-9A-F]{8})", text, re.S)
    if len(found) != 2 or {cpu for cpu, _value in found} != {"Master", "Slave"}:
        raise ValueError("terminal SH2 stack pointer evidence")
    return {cpu.lower(): int(value, 16) for cpu, value in found}


def capture(args: argparse.Namespace) -> dict[str, object]:
    output = args.output_dir.resolve()
    if output.exists():
        raise ValueError("output directory already exists")
    inputs = {
        args.active: ACTIVE_SHA256, args.control: CONTROL_SHA256,
        args.default: DEFAULT_SHA256, args.frontend: FRONTEND_SHA256,
        args.core: CORE_SHA256, args.canonical_core: CANONICAL_CORE_SHA256,
    }
    for path, digest in inputs.items():
        if not path.is_file() or shared.sha256_path(path) != digest:
            raise ValueError(f"input identity: {path}")
    if not args.name_source_state.is_file():
        raise ValueError("missing name source state")
    output.mkdir(parents=True)
    source = output / "name-source.mds"
    shutil.copy2(args.name_source_state, source)
    prepared = output / "name-route-seeded.mds"
    changes = prepare_name_fixture(source, prepared)
    name_input = output / "name-input.csv"
    shared.write_name_input(name_input)

    for arm, rom in {"active": args.active, "control": args.control}.items():
        for route in ROUTES:
            frames = NORMAL_FRAMES if route == "normal" else NAME_FRAMES
            route_env = {
                "VRD_LOAD_STATE": str(prepared), "VRD_INPUT_SCRIPT": str(name_input),
            } if route == "name" else {}
            for repeat in REPEATS:
                prefix = output / f"{arm}-{route}-{repeat}"
                commands = (
                    f"run {frames}\nread 68k 0x00FF0002 4\nread 68k 0x00FF7B40 1\n"
                    "read master 0x2600BC20 64\n"
                )
                if route == "normal":
                    commands += (
                        f"read 68k 0x{SOURCE_ADDRESS:08X} {PAYLOAD_BYTES}\n"
                        f"read master 0x{DESTINATION_ADDRESS:08X} {PAYLOAD_BYTES}\n"
                    )
                commands += "regs master\nregs slave\nquit\n"
                prefix.with_suffix(".commands").write_text(commands)
                shared.run_frontend(
                    args.frontend, rom, frames, prefix.with_suffix(".debug.txt"),
                    core=args.core,
                    extra_args=["--debug", "--autoplay"] if route == "normal" else ["--debug"],
                    env_values={
                        **route_env, "VRD_PROFILE_FRAMES": str(frames),
                        "VRD_MMIO_TRACE": "1", "VRD_MMIO_TRACE_MODE": "mode1",
                        "VRD_MMIO_TRACE_LOG": str(prefix.with_suffix(".mmio.trace")),
                        "VRD_WRITE_TRACE": WRITE_TARGETS,
                        "VRD_WRITE_TRACE_LOG": str(prefix.with_suffix(".write.trace")),
                        "VRD_CALLER_TRACE": "00884CBC" if route == "normal" else "00885618",
                        "VRD_CALLER_TRACE_MAX": "0",
                        "VRD_CALLER_TRACE_LOG": str(prefix.with_suffix(".caller.trace")),
                    },
                    input_text=commands,
                )

    vres_commands = (
        "run 1241\nread master 0x2600BC20 64\nregs master\nregs slave\n"
        "reset\nrun 30\nread master 0x2600BC20 64\nregs master\nregs slave\nquit\n"
    )
    (output / "active-vres.commands").write_text(vres_commands)
    shared.run_frontend(
        args.frontend, args.active, 1320, output / "active-vres.debug.txt",
        core=args.core, extra_args=["--debug", "--autoplay"], input_text=vres_commands,
    )
    baseline_commands = "run 1241\nreset\nrun 30\nregs master\nregs slave\nquit\n"
    (output / "default-reset-baseline.commands").write_text(baseline_commands)
    shared.run_frontend(
        args.frontend, args.default, 1300, output / "default-reset-baseline.txt",
        core=args.canonical_core, extra_args=["--debug", "--autoplay"],
        input_text=baseline_commands,
    )

    payload: dict[str, object] = {
        "schema": SCHEMA, "status": "CAPTURE_COMPLETE", "non_promotable": True,
        "organic_gameplay": False,
        "evidence_scope": "isolated_mode2_active_stage_control",
        "authority_transferred": False, "mode0_enabled": False,
        "mode1_enabled": False, "mode2_enabled": True, "cmd3f_enabled": False,
        "roms": {"active": ACTIVE_SHA256, "control": CONTROL_SHA256,
                 "default": DEFAULT_SHA256},
        "toolchain": {"frontend": FRONTEND_SHA256, "core": CORE_SHA256,
                      "canonical_core": CANONICAL_CORE_SHA256},
        "transfer_contract": {
            "payload_bytes": PAYLOAD_BYTES, "fifo_words": FIFO_WORDS,
            "full_checked_groups": FIFO_GROUPS,
            "fifo_words_per_group": FIFO_WORDS_PER_GROUP,
            "source": "0x00FF6B40-0x00FF7A3F",
            "destination": "0x06010000-0x06010EFF",
            "terminal_dar": "0x06010F00",
            "trace_sentinel": "Q22I/inverse with exact zero-or-completed counters",
        },
        "route_contract": {
            "normal": "0088E0D4->0089C914->flag_0_to_0->00884C6A->00884CBC->hook_flag_0_to_1->mode2",
            "name": "00891822->0089C914->flag_1_to_0->C80E_bit3->00884C98->00885618_replay",
            "name_transport_events": 0, "name_fixture_seeded": True,
            "name_fixture_organic": False,
        },
        "name_fixture": {
            "source_path": "name-source.mds", "source_sha256": NAME_SOURCE_SHA256,
            "seeded_path": "name-route-seeded.mds", "changes": changes,
        },
        "capture_matrix": {"arms": list(ARMS), "routes": list(ROUTES),
                           "repeats_per_arm_route": 2},
        "reset_contract": {
            "validated_boundary_frame": 1241,
            "post_transport_reset": "unproven_due_accepted_baseline_picodrive_busy_slave_defect",
        },
        "artifacts": shared.artifact_hashes(output, EXPECTED_ARTIFACTS),
    }
    (output / "run.json").write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    return payload


def verify_manifest_policy(payload: dict[str, object]) -> None:
    if payload.get("schema") != SCHEMA or payload.get("status") != "CAPTURE_COMPLETE":
        raise ValueError("run schema/status")
    if (
        payload.get("non_promotable") is not True
        or payload.get("organic_gameplay") is not False
        or payload.get("evidence_scope") != "isolated_mode2_active_stage_control"
        or payload.get("authority_transferred") is not False
        or payload.get("mode0_enabled") is not False
        or payload.get("mode1_enabled") is not False
        or payload.get("mode2_enabled") is not True
        or payload.get("cmd3f_enabled") is not False
    ):
        raise ValueError("runtime scope policy")
    if payload.get("roms") != {
        "active": ACTIVE_SHA256, "control": CONTROL_SHA256, "default": DEFAULT_SHA256,
    }:
        raise ValueError("ROM identity policy")
    if payload.get("toolchain") != {
        "frontend": FRONTEND_SHA256, "core": CORE_SHA256,
        "canonical_core": CANONICAL_CORE_SHA256,
    }:
        raise ValueError("toolchain identity policy")
    if payload.get("transfer_contract") != {
        "payload_bytes": PAYLOAD_BYTES, "fifo_words": FIFO_WORDS,
        "full_checked_groups": FIFO_GROUPS,
        "fifo_words_per_group": FIFO_WORDS_PER_GROUP,
        "source": "0x00FF6B40-0x00FF7A3F",
        "destination": "0x06010000-0x06010EFF",
        "terminal_dar": "0x06010F00",
        "trace_sentinel": "Q22I/inverse with exact zero-or-completed counters",
    }:
        raise ValueError("transfer arithmetic policy")
    if payload.get("capture_matrix") != {
        "arms": list(ARMS), "routes": list(ROUTES), "repeats_per_arm_route": 2,
    }:
        raise ValueError("capture matrix policy")


def validate(run_path: Path) -> dict[str, object]:
    run_path = run_path.resolve()
    payload = json.loads(run_path.read_text())
    verify_manifest_policy(payload)
    directory = run_path.parent
    artifacts = payload.get("artifacts")
    if not isinstance(artifacts, dict) or set(artifacts) != set(EXPECTED_ARTIFACTS):
        raise ValueError("artifact set")
    for name in EXPECTED_ARTIFACTS:
        metadata = artifacts[name]
        path = directory / name
        if Path(name).suffix not in shared.ARCHIVABLE_SUFFIXES or metadata.get("path") != name \
                or not path.is_file():
            raise ValueError(f"artifact path: {name}")
        if metadata.get("size") != path.stat().st_size \
                or metadata.get("sha256") != shared.sha256_path(path):
            raise ValueError(f"artifact identity: {name}")

    fixture = payload.get("name_fixture", {})
    if fixture.get("source_path") != "name-source.mds" \
            or fixture.get("source_sha256") != NAME_SOURCE_SHA256 \
            or fixture.get("seeded_path") != "name-route-seeded.mds":
        raise ValueError("name fixture policy")
    with tempfile.TemporaryDirectory() as temp:
        regenerated = Path(temp) / "name.mds"
        changes = prepare_name_fixture(directory / "name-source.mds", regenerated)
        if changes != fixture.get("changes") \
                or regenerated.read_bytes() != (directory / "name-route-seeded.mds").read_bytes():
            raise ValueError("name fixture transformation")

    routes: dict[tuple[str, str, int], dict[str, int]] = {}
    warnings: dict[tuple[str, str, int], list[str]] = {}
    texts: dict[tuple[str, str, int], str] = {}
    traces: dict[tuple[str, str, int], dict[str, int]] = {}
    payloads: dict[int, bytes] = {}
    sources: dict[tuple[str, int], bytes] = {}
    destinations: dict[tuple[str, int], bytes] = {}
    stacks: dict[tuple[str, int], dict[str, int]] = {}
    for arm in ARMS:
        for route in ROUTES:
            frames = NORMAL_FRAMES if route == "normal" else NAME_FRAMES
            for repeat in REPEATS:
                prefix = f"{arm}-{route}-{repeat}"
                debug_path = directory / f"{prefix}.debug.txt"
                warnings[(arm, route, repeat)] = shared.require_healthy_log(debug_path)
                text = debug_path.read_text(); texts[(arm, route, repeat)] = text
                trace_dumps = shared.parse_trace_dumps(text)
                if len(trace_dumps) != 1:
                    raise ValueError(f"debug trace count: {prefix}")
                traces[(arm, route, repeat)] = trace_dumps[0]
                pcs = re.findall(r"(?:Master|Slave) SH2: PC=([0-9A-F]{8})", text)
                if len(pcs) != 2 or any(0x02303B00 <= int(pc, 16) < 0x02303F20 for pc in pcs):
                    raise ValueError(f"SH2 liveness: {prefix}")
                rows, footer = shared.parse_mmio_trace(
                    directory / f"{prefix}.mmio.trace", frames
                )
                write_rows = shared.parse_write_trace(
                    directory / f"{prefix}.write.trace", frames
                )
                routes[(arm, route, repeat)] = shared.validate_route(write_rows, route)
                caller = shared.parse_caller_trace(
                    directory / f"{prefix}.caller.trace", frames,
                    0x00884CBC if route == "normal" else 0x00885618,
                )
                if caller[0]["frame"] < routes[(arm, route, repeat)]["final_frame"]:
                    raise ValueError(f"caller hit precedes installed pointer: {prefix}")
                if arm == "active" and route == "normal":
                    payloads[repeat] = validate_active_mmio(rows)[0]
                else:
                    if rows:
                        raise ValueError(f"unexpected transport events: {prefix}")
                    if footer["raw_m68k"] != footer["pc_rejected_m68k"] \
                            or footer["raw_master"] != footer["pc_rejected_master"]:
                        raise ValueError(f"zero-event recorder accounting: {prefix}")
                if route == "normal":
                    sources[(arm, repeat)] = shared.parse_memory_dump(
                        text, SOURCE_ADDRESS, PAYLOAD_BYTES
                    )
                    destinations[(arm, repeat)] = shared.parse_memory_dump(
                        text, DESTINATION_ADDRESS, PAYLOAD_BYTES
                    )
                    stacks[(arm, repeat)] = parse_terminal_stack_pointers(text)
            if routes[(arm, route, 1)] != routes[(arm, route, 2)]:
                raise ValueError(f"non-deterministic route lifecycle: {arm}/{route}")
            if warnings[(arm, route, 1)] != warnings[(arm, route, 2)]:
                raise ValueError(f"non-deterministic warning lifecycle: {arm}/{route}")

    if payloads[1] != payloads[2]:
        raise ValueError("non-deterministic ACTIVE payload")
    for route in ROUTES:
        for repeat in REPEATS:
            if routes[("active", route, repeat)] != routes[("control", route, repeat)]:
                raise ValueError(f"ACTIVE/CONTROL route lifecycle: {route}/{repeat}")
            if warnings[("active", route, repeat)] != warnings[("control", route, repeat)]:
                raise ValueError(f"ACTIVE/CONTROL warnings: {route}/{repeat}")

    canonical_source = sources[("active", 1)]
    for arm in ARMS:
        for repeat in REPEATS:
            if sources[(arm, repeat)] != canonical_source:
                raise ValueError(f"ACTIVE/CONTROL staged source mismatch: {arm}/{repeat}")
            if any(value > DESTINATION_ADDRESS for value in stacks[(arm, repeat)].values()):
                raise ValueError(f"stack intrudes upward AI range: {arm}/{repeat}")
    for repeat in REPEATS:
        if payloads[repeat] != sources[("active", repeat)] \
                or payloads[repeat] != destinations[("active", repeat)]:
            raise ValueError(f"full source/FIFO/destination equivalence: {repeat}")
        if destinations[("control", repeat)] == sources[("control", repeat)]:
            raise ValueError(f"STAGE-CONTROL destination unexpectedly equals source: {repeat}")
        if destinations[("control", repeat)] != destinations[("control", 1)]:
            raise ValueError("non-deterministic STAGE-CONTROL destination image")

        shared.require_trace(
            traces[("active", "normal", repeat)], magic=TRACE_MAGIC, phase=0,
            sequence=2, setup_count=1, completion_count=1, vres_count=0,
            stock_cmd_count=0, error=0, event=2, init_count=1,
            inverse=TRACE_INVERSE,
        )
        if traces[("active", "normal", repeat)]["setup_spc"] not in SAFE_SETUP_SPCS \
                or traces[("active", "normal", repeat)]["completion_spc"] == 0:
            raise ValueError(f"recorded setup/completion SPC policy: {repeat}")
        shared.require_trace(
            traces[("control", "normal", repeat)], magic=TRACE_MAGIC, phase=0,
            sequence=0, setup_count=0, completion_count=0, vres_count=0,
            stock_cmd_count=0, error=0, event=0, init_count=1,
            setup_spc=0, completion_spc=0, inverse=TRACE_INVERSE,
        )
        for arm in ARMS:
            shared.require_trace(
                traces[(arm, "name", repeat)], magic=TRACE_MAGIC, phase=0,
                sequence=0, setup_count=0, completion_count=0, vres_count=0,
                stock_cmd_count=0, error=0, event=0, init_count=1,
                setup_spc=0, completion_spc=0, inverse=TRACE_INVERSE,
            )

    vres_path = directory / "active-vres.debug.txt"
    baseline_path = directory / "default-reset-baseline.txt"
    shared.require_healthy_log(vres_path, reset_warning=True)
    shared.require_healthy_log(baseline_path, reset_warning=True)
    vres = shared.parse_trace_dumps(vres_path.read_text())
    if len(vres) != 2:
        raise ValueError("VRES trace count")
    shared.require_trace(
        vres[0], magic=TRACE_MAGIC, phase=0, sequence=0, setup_count=0,
        completion_count=0, vres_count=0, stock_cmd_count=0, error=0,
        event=0, init_count=1, setup_spc=0, completion_spc=0,
        inverse=TRACE_INVERSE,
    )
    shared.require_trace(
        vres[1], magic=TRACE_MAGIC, phase=4, sequence=2, setup_count=0,
        completion_count=0, vres_count=1, stock_cmd_count=1, error=0,
        event=4, init_count=3, setup_spc=0, completion_spc=0,
        inverse=TRACE_INVERSE,
    )

    return {
        "schema": SCHEMA, "status": "VALIDATION_STAGE_PASS", "non_promotable": True,
        "capture_manifest_sha256": shared.sha256_path(run_path),
        "organic_gameplay": False,
        "evidence_scope": "isolated_mode2_active_stage_control",
        "active_transactions_per_normal_run": 1,
        "payload_bytes": PAYLOAD_BYTES, "fifo_words": FIFO_WORDS,
        "full_checked_groups": FIFO_GROUPS,
        "fifo_words_per_group": FIFO_WORDS_PER_GROUP,
        "source_fifo_destination_full_equality": True,
        "stage_control_source_equal": True,
        "stage_control_transport_events": 0,
        "trace_sentinel": "Q22I_VALID",
        "slave_stack_boundary": "at_or_below_0x06010000_downward_of_ai_range",
        "normal_route_transport": "PASS", "name_route_transport_events": 0,
        "vres_scope": "pinned_stock_safe_frame_1241",
        "post_transport_vres": "UNPROVEN_BASELINE_PICODRIVE_BUSY_SLAVE_DEFECT",
        "default_sha256": DEFAULT_SHA256, "archive_complete": True,
        "promotable": False, "ordinary_default": False, "promoted": False,
        "authority_transferred": False, "cmd3f_enabled": False,
        "real_hardware_proven": False,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="operation", required=True)
    capture_parser = subparsers.add_parser("capture")
    for name in ("active", "control", "default", "frontend", "core",
                 "canonical-core", "name-source-state", "output-dir"):
        capture_parser.add_argument(f"--{name}", type=Path, required=True)
    validate_parser = subparsers.add_parser("validate")
    validate_parser.add_argument("run", type=Path)
    validate_parser.add_argument("--result", type=Path)
    args = parser.parse_args()
    try:
        if args.operation == "capture":
            capture(args)
            print(f"mode-2 runtime capture complete: {args.output_dir / 'run.json'}")
            print("status is CAPTURE_COMPLETE and remains non-promotable")
        else:
            result = validate(args.run)
            encoded = json.dumps(result, indent=2, sort_keys=True) + "\n"
            if args.result:
                if args.result.exists():
                    raise ValueError("result path already exists")
                args.result.write_text(encoded)
            print("mode-2 CMDINT validation-stage PASS (non-default, non-promotable)")
    except (OSError, ValueError, subprocess.SubprocessError, json.JSONDecodeError) as error:
        print(f"mode-2 CMDINT runtime FAILED: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
