#!/usr/bin/env python3
"""Capture and fail-closed validate the isolated Q-020 mode-1 CMDINT pair."""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile


SCHEMA = "vrd-vr60-q020-mode1-cmdint-runtime-v1"
ACTIVE_SHA256 = "963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470"
CONTROL_SHA256 = "391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd"
DEFAULT_SHA256 = "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900"
FRONTEND_SHA256 = "626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50"
CORE_SHA256 = "aaaa57f0190759e581ca116ab35ab7e1e090fcd93ccadd046242d7532ebbff79"
CANONICAL_CORE_SHA256 = "5677ea8e083f887b2b4e9cabf84dd559a9c6b1180adfa09f34a50023ff7548e8"
NAME_SOURCE_SHA256 = "c1ede354178c8ffa0796f1e243d8ae592dbd38dad4c44ad9336fece8503b22f0"
NAME_SOURCE_SIZE = 679161
NORMAL_FRAMES = 1280
NAME_FRAMES = 190
TRACE_ADDRESS = 0x2600BC20
TRACE_SIZE = 64
WRAM_STATE_OFFSET = 0x76
WRITE_TARGETS = "0x00ffc87e:2,0x00ff0002:4,0x00ff7b40:1"
MMIO_HEADER = (
    "# VRD_MMIO_TRACE version=3 capacity=1048576 sh2_drc=1 profile_pc=0 "
    "profile_pc_env=0 m68k_batching=normal instruction_start_hook=1 "
    "m68k_direct=1 master_direct=1 coverage_from_start=1 "
    "pc_allowlist=m68k:0x0001C922-0x0001C9CC;"
    "master:0x02303B00-0x02303F1C"
)
MMIO_FILTER = (
    "# FILTER mode1_direct=1 "
    "m68k=0x00A15103|0x00A15107|0x00A1510C|0x00A1510E|0x00A15110|"
    "0x00A15112|0x00A15120-0x00A1512F "
    "master_system=0x20004000-0x2000403F "
    "master_peripheral=0xFFFFFE00-0xFFFFFFFF"
)
MMIO_COLUMNS = "sequence,frame,cpu,pc,op,address,width,value"
SCOPED_RESET_WARNING = "ssh2 drc: unhandled op 4778 @ 0600063a"
SCOPED_STOCK_DREQ_WARNING = "DREQ FIFO w16 without 68S?"
FATAL_MARKERS = (
    "illegal opcode", "segmentation fault", "core dumped",
    "traceback (most recent call last)", "addresssanitizer",
    "undefinedbehaviorsanitizer", "debugger command failed",
    "unknown debugger command", "vrd_mmio_trace:", "# incomplete",
)
ARCHIVABLE_SUFFIXES = {".commands", ".csv", ".mds", ".trace", ".txt"}
ARMS = ("active", "control")
ROUTES = ("normal", "name")
REPEATS = (1, 2)


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
BUSY_RESET_DIAGNOSTIC_ARTIFACTS = tuple(
    name
    for arm in ("active", "control", "default")
    for name in (f"{arm}-busy-reset.commands", f"{arm}-busy-reset.txt")
)
SAFE_SETUP_SPCS = (
    0x06000460, 0x06000462, 0x06000464, 0x06000466, 0x06000474, 0x06000476,
    0x06004438, 0x0600443A, 0x0600443C, 0x0600443E, 0x06004440, 0x06004442,
)


def sha256_path(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def raw_words(guest_bytes: bytes) -> bytes:
    if len(guest_bytes) % 2:
        raise ValueError("serialized conversion requires whole words")
    return b"".join(
        guest_bytes[offset : offset + 2][::-1]
        for offset in range(0, len(guest_bytes), 2)
    )


def prepare_name_fixture(source: Path, output: Path) -> list[dict[str, object]]:
    """Rebind the pinned diagnostic state to this pair and seed route inputs."""
    if source.stat().st_size != NAME_SOURCE_SIZE or sha256_path(source) != NAME_SOURCE_SHA256:
        raise ValueError("name source fixture identity")
    image = bytearray(source.read_bytes())
    changes: list[dict[str, object]] = []

    def replace(offset: int, expected: bytes, replacement: bytes, reason: str) -> None:
        if image[offset : offset + len(expected)] != expected:
            raise ValueError(f"name fixture preimage: {reason}")
        image[offset : offset + len(expected)] = replacement
        changes.append({
            "offset": offset, "size": len(expected), "before": expected.hex(),
            "after": replacement.hex(), "reason": reason,
        })

    default_vectors = raw_words(bytes.fromhex("060006ac") * 16)
    vector_offset = image.find(default_vectors)
    if vector_offset < 0 or image.find(default_vectors, vector_offset + 1) >= 0:
        raise ValueError("name fixture Master vector table is not unique")
    replace(
        vector_offset, default_vectors, raw_words(bytes.fromhex("02303b00") * 16),
        "rebind all Master external vectors to mode-1 ISR",
    )
    replace(
        vector_offset + 0x380, raw_words(bytes.fromhex("060045cc")),
        raw_words(bytes.fromhex("02303e60")),
        "rebind Master startup literal to mode-1 shim",
    )
    trace = bytearray(TRACE_SIZE)
    trace[0:4] = bytes.fromhex("51323149")
    trace[48:52] = (1).to_bytes(4, "big")
    trace[60:64] = bytes.fromhex("aecdceb6")
    replace(
        vector_offset + 0xBB20, b"\0" * TRACE_SIZE, raw_words(trace),
        "initialize Q21I trace as one completed startup-shim call",
    )
    base = WRAM_STATE_OFFSET
    replace(
        base + 0xC210, raw_words(bytes.fromhex("cccc0ccc")),
        raw_words(bytes.fromhex("00010000")),
        "seed fifth score non-sentinel (diagnostic route prerequisite)",
    )
    replace(
        base + 0xA042, raw_words(bytes.fromhex("0001")),
        raw_words(bytes.fromhex("0000")),
        "match name-dispatch A042 result for seeded fifth score",
    )
    if image[base + 0x7B41] != 1:
        raise ValueError("name fixture one-shot must retain source preimage 1")
    if image[base + 2 : base + 6] != raw_words(bytes.fromhex("00891122")):
        raise ValueError("name fixture is not at pinned name-entry dispatcher")
    if image[base + 0xA019] != 0:
        raise ValueError("name fixture A019 precondition")
    output.write_bytes(image)
    return changes


def write_name_input(path: Path) -> None:
    with path.open("x", newline="") as stream:
        writer = csv.writer(stream, lineterminator="\n")
        writer.writerow(("frame", "mask"))
        for frame in range(NAME_FRAMES):
            writer.writerow((frame, "0x0100" if 5 <= frame < 10 else "0x0000"))


def sterile_env(**values: str) -> dict[str, str]:
    env = os.environ.copy()
    for name in tuple(env):
        if name.startswith("VRD_"):
            env.pop(name)
    env.update(values)
    return env


def run_frontend(
    frontend: Path, rom: Path, frames: int, output: Path, *, core: Path,
    extra_args: list[str] | None = None,
    env_values: dict[str, str] | None = None,
    input_text: str | None = None,
) -> None:
    args = [str(frontend.resolve()), str(rom.resolve()), str(frames)] + (extra_args or [])
    result = subprocess.run(
        args, cwd=frontend.resolve().parent,
        env=sterile_env(VRD_LIBRETRO_CORE=str(core.resolve()), **(env_values or {})),
        input=input_text, text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, timeout=180, check=False,
    )
    output.write_text(result.stdout)
    if result.returncode != 0:
        raise ValueError(f"frontend failed ({result.returncode}): {output.name}")


def artifact_hashes(directory: Path, names: tuple[str, ...]) -> dict[str, dict[str, object]]:
    return {
        name: {"path": name, "size": (directory / name).stat().st_size,
               "sha256": sha256_path(directory / name)}
        for name in names
    }


def parse_mmio_trace(path: Path, frames: int) -> tuple[list[dict[str, object]], dict[str, int]]:
    lines = path.read_text().splitlines()
    if len(lines) < 4 or lines[:3] != [MMIO_HEADER, MMIO_FILTER, MMIO_COLUMNS]:
        raise ValueError(f"MMIO trace header: {path.name}")
    match = re.fullmatch(
        r"# COMPLETE frames=(\d+) events=(\d+) recorded=(\d+) dropped=(\d+) "
        r"errors=(\d+) overflow=(\d+) raw_m68k=(\d+) raw_master=(\d+) "
        r"pc_rejected_m68k=(\d+) pc_rejected_master=(\d+) direct_m68k=(\d+) "
        r"direct_master=(\d+) observer_detached=(\d+) pc_allowlist="
        r"m68k:0x0001C922-0x0001C9CC;master:0x02303B00-0x02303F1C",
        lines[-1],
    )
    if not match:
        raise ValueError(f"MMIO trace terminal: {path.name}")
    keys = (
        "frames", "events", "recorded", "dropped", "errors", "overflow",
        "raw_m68k", "raw_master", "pc_rejected_m68k", "pc_rejected_master",
        "direct_m68k", "direct_master", "observer_detached",
    )
    footer = dict(zip(keys, (int(value) for value in match.groups()), strict=True))
    if (
        footer["frames"] != frames or footer["events"] != footer["recorded"]
        or footer["dropped"] or footer["errors"] or footer["overflow"]
        or footer["direct_m68k"] != 1 or footer["direct_master"] != 1
        or footer["observer_detached"] != 1 or footer["raw_m68k"] <= 0
        or footer["raw_master"] <= 0 or footer["pc_rejected_m68k"] <= 0
        or footer["pc_rejected_master"] <= 0
    ):
        raise ValueError(f"MMIO trace coverage/footer: {path.name}")
    rows: list[dict[str, object]] = []
    for sequence, row in enumerate(csv.DictReader(lines[2:-1])):
        if set(row) != set(MMIO_COLUMNS.split(",")):
            raise ValueError(f"MMIO row schema: {path.name}")
        parsed: dict[str, object] = {
            "sequence": int(row["sequence"], 0), "frame": int(row["frame"], 0),
            "cpu": row["cpu"], "pc": int(row["pc"], 0), "op": row["op"],
            "address": int(row["address"], 0), "width": int(row["width"], 0),
            "value": int(row["value"], 0),
        }
        if parsed["sequence"] != sequence:
            raise ValueError(f"MMIO sequence gap: {path.name}")
        cpu = parsed["cpu"]
        pc = int(parsed["pc"])
        address = int(parsed["address"])
        if cpu == "m68k":
            if not 0x0001C922 <= pc < 0x0001C9CC:
                raise ValueError(f"MMIO m68k PC policy: {path.name}")
            if 0x00A15120 <= address <= 0x00A1512F:
                raise ValueError(f"forbidden COMM access: {path.name}")
        elif cpu == "master":
            if not 0x02303B00 <= pc < 0x02303F1C:
                raise ValueError(f"MMIO Master PC policy: {path.name}")
            if 0x20004020 <= address <= 0x2000402F:
                raise ValueError(f"forbidden COMM access: {path.name}")
        else:
            raise ValueError(f"MMIO CPU: {path.name}")
        if parsed["op"] not in {"read", "write"} or parsed["width"] not in {1, 2, 4}:
            raise ValueError(f"MMIO operation: {path.name}")
        rows.append(parsed)
    if len(rows) != footer["recorded"]:
        raise ValueError(f"MMIO recorded count: {path.name}")
    return rows, footer


def event_is(row: dict[str, object], cpu: str, pc: int, op: str, address: int,
             width: int, value: int | None = None) -> bool:
    return (
        row["cpu"] == cpu and row["pc"] == pc and row["op"] == op
        and row["address"] == address and row["width"] == width
        and (value is None or row["value"] == value)
    )


def require_event(row: dict[str, object], cpu: str, pc: int, op: str,
                  address: int, width: int, value: int | None = None) -> None:
    if not event_is(row, cpu, pc, op, address, width, value):
        raise ValueError(
            f"MMIO event expected {cpu}/{pc:08X}/{op}/{address:08X}/{width}/"
            f"{value!r}, got {row}"
        )


def require_master_event(row: dict[str, object], op: str, address: int,
                         width: int, value: int | None = None) -> None:
    if (
        row["cpu"] != "master" or row["op"] != op or row["address"] != address
        or row["width"] != width or (value is not None and row["value"] != value)
    ):
        raise ValueError(f"Master MMIO chronology at sequence {row.get('sequence')}: {row}")


def validate_transaction(rows: list[dict[str, object]]) -> bytes:
    m68k = [row for row in rows if row["cpu"] == "m68k"]
    master = [row for row in rows if row["cpu"] == "master"]
    index = 0
    prefix = (
        (0x1C92E, "read", 0xA15103, 1, 0), (0x1C938, "read", 0xA15107, 1, 0),
        (0x1C940, "read", 0xA15110, 2, 0), (0x1C94A, "write", 0xA1510C, 2, 0),
        (0x1C952, "write", 0xA1510E, 2, 0xF30C),
        (0x1C95A, "write", 0xA15110, 2, 0x20),
        (0x1C962, "write", 0xA15107, 1, 4), (0x1C96A, "read", 0xA15103, 1, 0),
        (0x1C96A, "write", 0xA15103, 1, 1),
    )
    for pc, op, address, width, value in prefix:
        require_event(m68k[index], "m68k", pc, op, address, width, value)
        index += 1
    setup_polls: list[dict[str, object]] = []
    while index < len(m68k) and event_is(m68k[index], "m68k", 0x1C972, "read", 0xA15103, 1):
        setup_polls.append(m68k[index])
        index += 1
    if not setup_polls or setup_polls[-1]["value"] != 0 or any(
        row["value"] != 1 for row in setup_polls[:-1]
    ):
        raise ValueError("setup INTM acknowledgement polls")
    fifo_words: list[int] = []
    for _group in range(8):
        require_event(m68k[index], "m68k", 0x1C98A, "read", 0xA15107, 1, 4)
        index += 1
        for _word in range(4):
            require_event(m68k[index], "m68k", 0x1C990, "write", 0xA15112, 2)
            fifo_words.append(int(m68k[index]["value"]))
            index += 1
    tail = (
        (0x1C99E, "read", 0xA15110, 2, 0), (0x1C9A8, "read", 0xA15107, 1, 0),
        (0x1C9B2, "read", 0xA15103, 1, 0), (0x1C9BC, "read", 0xA15103, 1, 0),
        (0x1C9BC, "write", 0xA15103, 1, 1),
    )
    for pc, op, address, width, value in tail:
        require_event(m68k[index], "m68k", pc, op, address, width, value)
        index += 1
    completion_polls: list[dict[str, object]] = []
    while index < len(m68k) and event_is(m68k[index], "m68k", 0x1C9C4, "read", 0xA15103, 1):
        completion_polls.append(m68k[index])
        index += 1
    if index != len(m68k) or not completion_polls or completion_polls[-1]["value"] != 0 or any(
        row["value"] != 1 for row in completion_polls[:-1]
    ):
        raise ValueError("completion INTM acknowledgement polls")

    mi = 0
    require_master_event(master[mi], "read", 0xFFFFFE17, 1)
    initial_tocr = int(master[mi]["value"])
    mi += 1
    require_master_event(master[mi], "write", 0xFFFFFE17, 1, initial_tocr ^ 2)
    mi += 1
    for op, address, width, value in (
        ("read", 0x20004006, 2, 0x4004), ("read", 0x20004010, 2, 0x20),
        ("read", 0x2000400C, 2, 0), ("read", 0x2000400E, 2, 0xF30C),
        ("read", 0xFFFFFF88, 4, 0),
    ):
        require_master_event(master[mi], op, address, width, value)
        mi += 1
    require_master_event(master[mi], "read", 0xFFFFFF8C, 4)
    prior_chcr = int(master[mi]["value"])
    mi += 1
    if prior_chcr == 0x44E3:
        require_master_event(master[mi], "write", 0xFFFFFF8C, 4, 0x44E0)
        mi += 1
        require_master_event(master[mi], "read", 0xFFFFFF8C, 4, 0x44E0)
        mi += 1
    elif prior_chcr != 0x44E0:
        raise ValueError("setup prior CHCR lifecycle")
    for op, address, width, value in (
        ("write", 0xFFFFFF80, 4, 0x20004012),
        ("write", 0xFFFFFF84, 4, 0x0600F30C),
        ("write", 0xFFFFFF88, 4, 0x20), ("write", 0xFFFFFF8C, 4, 0x44E1),
        ("write", 0xFFFFFFB0, 4, 1), ("read", 0xFFFFFFB0, 4, 1),
    ):
        require_master_event(master[mi], op, address, width, value)
        mi += 1
    for op, address, width, value in (
        ("read", 0x20004000, 2, 0x8202), ("write", 0x20004000, 2, 0x8200),
        ("read", 0x20004000, 2, 0x8200), ("write", 0x2000401A, 2, 0),
        ("read", 0x2000401A, 2, None), ("write", 0x20004000, 2, 0x8202),
        ("read", 0x20004000, 2, 0x8202),
    ):
        require_master_event(master[mi], op, address, width, value)
        mi += 1
    setup_ack_sequence = int(master[mi - 1]["sequence"])

    require_master_event(master[mi], "read", 0xFFFFFE17, 1, initial_tocr ^ 2)
    mi += 1
    require_master_event(master[mi], "write", 0xFFFFFE17, 1, initial_tocr)
    mi += 1
    for op, address, width, value in (
        ("read", 0x20004006, 2, 0x4000), ("read", 0x20004010, 2, 0),
        ("read", 0x2000400C, 2, 0), ("read", 0x2000400E, 2, 0xF30C),
        ("read", 0xFFFFFF80, 4, 0x20004012),
        ("read", 0xFFFFFF84, 4, 0x0600F34C),
        ("read", 0xFFFFFF88, 4, 0), ("read", 0xFFFFFF8C, 4, 0x44E3),
        ("read", 0xFFFFFFB0, 4, 1), ("read", 0xFFFFFF8C, 4, 0x44E3),
        ("read", 0xFFFFFF88, 4, 0), ("read", 0xFFFFFF84, 4, 0x0600F34C),
        ("write", 0xFFFFFF8C, 4, 0x44E0), ("read", 0xFFFFFF8C, 4, 0x44E0),
        ("read", 0x20004000, 2, 0x8202), ("write", 0x20004000, 2, 0x8200),
        ("read", 0x20004000, 2, 0x8200), ("write", 0x2000401A, 2, 0),
        ("read", 0x2000401A, 2, None), ("write", 0x20004000, 2, 0x8202),
        ("read", 0x20004000, 2, 0x8202),
    ):
        require_master_event(master[mi], op, address, width, value)
        mi += 1
    if mi != len(master):
        raise ValueError("unexpected Master MMIO event")
    first_fifo = min(int(row["sequence"]) for row in rows if row["pc"] == 0x1C990)
    last_fifo = max(int(row["sequence"]) for row in rows if row["pc"] == 0x1C990)
    completion_start = int(master[-21]["sequence"])
    completion_ack = int(master[-1]["sequence"])
    if not setup_ack_sequence < first_fifo <= last_fifo < completion_start < completion_ack:
        raise ValueError("cross-CPU transaction ordering")
    return b"".join(word.to_bytes(2, "big") for word in fifo_words)


def validate_active_mmio(rows: list[dict[str, object]]) -> list[bytes]:
    starts = [index for index, row in enumerate(rows) if event_is(
        row, "m68k", 0x1C92E, "read", 0xA15103, 1, 0
    )]
    if len(starts) < 2 or starts[0] != 0:
        raise ValueError("repeated mode-1 transaction starts")
    starts.append(len(rows))
    payloads = [validate_transaction(rows[starts[i]:starts[i + 1]]) for i in range(len(starts) - 1)]
    if any(len(payload) != 64 for payload in payloads):
        raise ValueError("mode-1 payload size")
    return payloads


def parse_write_trace(path: Path, frames: int) -> list[dict[str, int]]:
    lines = path.read_text().splitlines()
    targets = (
        "# TARGET index=0 addr=0xFFC87E size=2",
        "# TARGET index=1 addr=0xFF0002 size=4",
        "# TARGET index=2 addr=0xFF7B40 size=1",
    )
    if len(lines) < 7 or not lines[0].startswith("# VRD_WRITE_TRACE version=3 ") or tuple(lines[1:4]) != targets:
        raise ValueError(f"write trace header: {path.name}")
    columns = "frame,pc,target_addr,target_size,access_addr,access_size,old_value,new_value"
    if lines[4] != columns:
        raise ValueError(f"write trace columns: {path.name}")
    terminal = re.fullmatch(r"# COMPLETE frames=(\d+) events=(\d+) errors=(\d+)", lines[-1])
    if not terminal or int(terminal.group(1)) != frames or int(terminal.group(3)) != 0:
        raise ValueError(f"write trace terminal: {path.name}")
    rows = [{key: int(value, 0) for key, value in row.items()}
            for row in csv.DictReader(lines[4:-1])]
    if len(rows) != int(terminal.group(2)):
        raise ValueError(f"write trace count: {path.name}")
    return rows


def parse_caller_trace(path: Path, frames: int, address: int) -> list[dict[str, int]]:
    lines = path.read_text().splitlines()
    if len(lines) < 4 or not lines[0].startswith(
        f"# VRD_CALLER_TRACE version=2 addr=0x{address:08X} "
    ) or "instruction_start_hook=1 composed=1 max_hits=0" not in lines[0]:
        raise ValueError(f"caller trace header: {path.name}")
    if lines[1] != "frame,pc,sp,return_addr":
        raise ValueError(f"caller trace columns: {path.name}")
    terminal = re.fullmatch(
        r"# COMPLETE frames=(\d+) hits=(\d+) logged=(\d+) dropped=(\d+) errors=(\d+)",
        lines[-1],
    )
    if not terminal:
        raise ValueError(f"caller trace terminal: {path.name}")
    frame_count, hits, logged, dropped, errors = (int(value) for value in terminal.groups())
    rows = [{key: int(value, 0) for key, value in row.items()}
            for row in csv.DictReader(lines[1:-1])]
    if (
        frame_count != frames or hits <= 0 or hits != logged or logged != len(rows)
        or dropped or errors or any(row["pc"] != address for row in rows)
    ):
        raise ValueError(f"caller trace coverage: {path.name}")
    return rows


def matching_write(rows: list[dict[str, int]], pc: int, target: int,
                   old: int, new: int, size: int) -> list[dict[str, int]]:
    return [row for row in rows if row["pc"] == pc and row["target_addr"] == target
            and row["target_size"] == size and row["old_value"] == old
            and row["new_value"] == new]


def validate_route(rows: list[dict[str, int]], route: str) -> dict[str, int]:
    if route == "normal":
        installer = matching_write(rows, 0x0088E0D4, 0xFF0002, 0x00884D98, 0x0089C914, 4)
        final = matching_write(rows, 0x00884C6A, 0xFF0002, 0x0089C914, 0x00884CBC, 4)
        hook = matching_write(rows, 0x0001C8CA, 0xFF7B40, 0, 1, 1)
    else:
        installer = matching_write(rows, 0x00891822, 0xFF0002, 0x00891122, 0x0089C914, 4)
        final = matching_write(rows, 0x00884C98, 0xFF0002, 0x0089C914, 0x00885618, 4)
        hook = []
    clear = matching_write(rows, 0x0089C916, 0xFF7B40, 0 if route == "normal" else 1, 0, 1)
    if len(installer) != 1 or len(clear) != 1 or len(final) != 1 or (route == "normal" and len(hook) != 1):
        raise ValueError(f"{route} route chronology")
    if not installer[0]["frame"] <= clear[0]["frame"] < final[0]["frame"]:
        raise ValueError(f"{route} route ordering")
    if route == "normal" and not final[0]["frame"] < hook[0]["frame"]:
        raise ValueError("normal hook ordering")
    if route == "name" and any(
        row["pc"] == 0x0001C8CA or (
            row["target_addr"] == 0xFF7B40 and row["new_value"] == 1
        ) for row in rows
    ):
        raise ValueError("name route reached racing hook")
    return {
        "installer_frame": installer[0]["frame"], "clear_frame": clear[0]["frame"],
        "final_frame": final[0]["frame"], "final_handler": final[0]["new_value"],
        "hook_frame": hook[0]["frame"] if hook else 0,
    }


def parse_memory_dump(text: str, address: int, size: int) -> bytes:
    lines = text.splitlines()
    output = bytearray()
    cursor = address
    for line in lines:
        match = re.search(r"([0-9A-F]{8}):((?: [0-9A-F]{2})+)\Z", line)
        if not match or int(match.group(1), 16) != cursor:
            continue
        data = bytes(int(value, 16) for value in match.group(2).split())
        output.extend(data)
        cursor += len(data)
        if len(output) >= size:
            return bytes(output[:size])
    raise ValueError(f"missing memory dump at 0x{address:08X}")


def parse_trace_dumps(text: str) -> list[dict[str, int]]:
    lines = text.splitlines()
    dumps: list[dict[str, int]] = []
    for index, line in enumerate(lines):
        if "2600BC20:" not in line:
            continue
        raw = bytearray()
        for part in range(4):
            expected = f"{0x2600BC20 + part * 16:08X}:"
            current = lines[index + part] if index + part < len(lines) else ""
            if expected not in current:
                raise ValueError("incomplete Q21I trace dump")
            values = current.split(expected, 1)[1].split()
            if len(values) != 16:
                raise ValueError("malformed Q21I trace dump")
            raw.extend(int(value, 16) for value in values)
        words = [int.from_bytes(raw[offset:offset + 4], "big") for offset in range(0, 64, 4)]
        keys = (
            "magic", "phase", "sequence", "setup_count", "completion_count",
            "vres_count", "stock_cmd_count", "error", "sr", "spc", "pre_mask",
            "event", "init_count", "setup_spc", "completion_spc", "inverse",
        )
        dumps.append(dict(zip(keys, words, strict=True)))
    return dumps


def require_trace(trace: dict[str, int], **expected: int) -> None:
    for key, value in expected.items():
        if trace.get(key) != value:
            raise ValueError(f"Q21I {key}: expected 0x{value:X}, got 0x{trace.get(key, -1):X}")


def scoped_stock_warnings(text: str) -> list[str]:
    return [line for line in text.splitlines() if SCOPED_STOCK_DREQ_WARNING in line]


def require_healthy_log(path: Path, *, reset_warning: bool = False) -> list[str]:
    text = path.read_text()
    lowered = text.lower()
    reset_lines = [line for line in text.splitlines() if "unhandled op" in line.lower()]
    if reset_warning:
        if len(reset_lines) != 1 or SCOPED_RESET_WARNING not in reset_lines[0]:
            raise ValueError(f"scoped reset warning: {path.name}")
        lowered = lowered.replace(reset_lines[0].lower(), "")
    elif reset_lines:
        raise ValueError(f"unhandled opcode: {path.name}")
    for line in scoped_stock_warnings(text):
        lowered = lowered.replace(line.lower(), "")
    for marker in FATAL_MARKERS:
        if marker in lowered:
            raise ValueError(f"fatal runtime marker in {path.name}: {marker}")
    if re.search(r"32X shutdown\s*\Z", text) is None:
        raise ValueError(f"missing terminal shutdown: {path.name}")
    return scoped_stock_warnings(text)


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
        if not path.is_file() or sha256_path(path) != digest:
            raise ValueError(f"input identity: {path}")
    if not args.name_source_state.is_file():
        raise ValueError("missing name source state")
    output.mkdir(parents=True)
    source = output / "name-source.mds"
    shutil.copy2(args.name_source_state, source)
    prepared = output / "name-route-seeded.mds"
    changes = prepare_name_fixture(source, prepared)
    name_input = output / "name-input.csv"
    write_name_input(name_input)

    roms = {"active": args.active, "control": args.control}
    for arm, rom in roms.items():
        for route in ROUTES:
            frames = NORMAL_FRAMES if route == "normal" else NAME_FRAMES
            route_env = {"VRD_LOAD_STATE": str(prepared), "VRD_INPUT_SCRIPT": str(name_input)} \
                if route == "name" else {}
            for repeat in REPEATS:
                prefix = output / f"{arm}-{route}-{repeat}"
                commands = (
                    f"run {frames}\nread 68k 0x00FF0002 4\nread 68k 0x00FF7B40 1\n"
                    "read master 0x2600BC20 64\nread 68k 0x00FF6B00 64\n"
                    "read master 0x0600F30C 64\nregs master\nregs slave\nquit\n"
                )
                prefix.with_suffix(".commands").write_text(commands)
                run_frontend(
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

    # Frame 1241 is the pinned stock-safe reset boundary used by the accepted
    # Q-020 CMDINT probe and the canonical default comparison.  Late racing
    # resets with the Slave in its on-chip renderer reproduce a PicoDrive
    # baseline fault even in the accepted default; those failures are retained
    # separately and never accepted by this PASS validator.
    vres_commands = (
        "run 1241\nread master 0x2600BC20 64\nregs master\nregs slave\n"
        "reset\nrun 30\nread master 0x2600BC20 64\nregs master\nregs slave\nquit\n"
    )
    (output / "active-vres.commands").write_text(vres_commands)
    run_frontend(
        args.frontend, args.active, 1320,
        output / "active-vres.debug.txt", core=args.core,
        extra_args=["--debug", "--autoplay"], input_text=vres_commands,
    )
    baseline_commands = "run 1241\nreset\nrun 30\nregs master\nregs slave\nquit\n"
    (output / "default-reset-baseline.commands").write_text(baseline_commands)
    run_frontend(
        args.frontend, args.default, 1300, output / "default-reset-baseline.txt",
        core=args.canonical_core, extra_args=["--debug", "--autoplay"],
        input_text=baseline_commands,
    )

    payload: dict[str, object] = {
        "schema": SCHEMA, "status": "CAPTURE_COMPLETE",
        "non_promotable": True, "organic_gameplay": False,
        "evidence_scope": "isolated_mode1_active_stage_control",
        "authority_transferred": False, "mode2_enabled": False, "cmd3f_enabled": False,
        "roms": {"active": ACTIVE_SHA256, "control": CONTROL_SHA256,
                 "default": DEFAULT_SHA256},
        "toolchain": {"frontend": FRONTEND_SHA256, "core": CORE_SHA256,
                      "canonical_core": CANONICAL_CORE_SHA256},
        "route_contract": {
            "normal": "0088E0D4->0089C914->flag_0_to_0->00884C6A->00884CBC->hook_flag_0_to_1->mode1",
            "name": "00891822->0089C914->flag_1_to_0->C80E_bit3->00884C98->00885618_replay",
            "name_transport_events": 0,
            "name_fixture_seeded": True,
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
            "busy_slave_reset": "unproven_baseline_picodrive_defect_retained_separately",
        },
        "artifacts": artifact_hashes(output, EXPECTED_ARTIFACTS),
    }
    (output / "run.json").write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    return payload


def capture_busy_reset_diagnostic(args: argparse.Namespace) -> dict[str, object]:
    """Archive, but never accept, PicoDrive's busy-Slave reset failure."""
    output = args.output_dir.resolve()
    if output.exists():
        raise ValueError("output directory already exists")
    inputs = {
        args.active: ACTIVE_SHA256, args.control: CONTROL_SHA256,
        args.default: DEFAULT_SHA256, args.frontend: FRONTEND_SHA256,
        args.core: CORE_SHA256, args.canonical_core: CANONICAL_CORE_SHA256,
    }
    for path, digest in inputs.items():
        if not path.is_file() or sha256_path(path) != digest:
            raise ValueError(f"input identity: {path}")
    output.mkdir(parents=True)
    commands = (
        "run 1280\n"
        "read master 0x2600BC20 64\n"
        "read master 0x20004000 2\n"
        "read master 0x20004006 14\n"
        "read master 0xFFFFFF80 16\n"
        "read master 0xFFFFFFB0 4\n"
        "read master 0xFFFFFE17 1\n"
        "regs master\nregs slave\n"
        "reset\nrun 1\n"
        "read master 0x2600BC20 64\n"
        "read master 0x20004000 2\n"
        "read master 0x20004006 14\n"
        "read master 0xFFFFFF80 16\n"
        "read master 0xFFFFFFB0 4\n"
        "read master 0xFFFFFE17 1\n"
        "regs master\nregs slave\n"
        "run 29\nregs master\nregs slave\nquit\n"
    )
    configurations = (
        ("active", args.active, args.core),
        ("control", args.control, args.core),
        ("default", args.default, args.canonical_core),
    )
    observations: dict[str, object] = {}
    for arm, rom, core in configurations:
        command_path = output / f"{arm}-busy-reset.commands"
        log_path = output / f"{arm}-busy-reset.txt"
        command_path.write_text(commands)
        run_frontend(
            args.frontend, rom, 1360, log_path, core=core,
            extra_args=["--debug", "--autoplay"], input_text=commands,
        )
        text = log_path.read_text()
        pcs = re.findall(r"(Master|Slave) SH2: PC=([0-9A-F]{8})", text)
        sysreg_faults = [
            line for line in text.splitlines()
            if "unhandled sysreg" in line.lower() and "@06000638" in line
        ]
        if (
            "Core reset at session frame: 1280" not in text
            or len(pcs) != 6 or pcs[0][0] != "Master" or pcs[1][0] != "Slave"
            or pcs[3] != ("Slave", "06000638") or pcs[5] != ("Slave", "06000638")
            or not sysreg_faults or not any("ssh2 unhandled sysreg" in line for line in sysreg_faults)
            or re.search(r"32X shutdown\s*\Z", text) is None
        ):
            raise ValueError(f"busy reset diagnostic signature: {arm}")
        observations[arm] = {
            "pre_reset_master_pc": pcs[0][1], "pre_reset_slave_pc": pcs[1][1],
            "first_post_reset_master_pc": pcs[2][1],
            "first_post_reset_slave_pc": pcs[3][1],
            "terminal_master_pc": pcs[4][1], "terminal_slave_pc": pcs[5][1],
            "sysreg_fault_lines": len(sysreg_faults),
        }
    payload: dict[str, object] = {
        "schema": SCHEMA, "status": "NON_ACCEPTANCE_DIAGNOSTIC",
        "accepted_by_runtime_validator": False,
        "frame": 1280, "fault_cpu": "Slave SH2", "fault_pc": "0x06000638",
        "finding": "baseline_picodrive_busy_slave_reset_defect",
        "roms": {"active": ACTIVE_SHA256, "control": CONTROL_SHA256,
                 "default": DEFAULT_SHA256},
        "toolchain": {"frontend": FRONTEND_SHA256, "core": CORE_SHA256,
                      "canonical_core": CANONICAL_CORE_SHA256},
        "observations": observations,
        "artifacts": artifact_hashes(output, BUSY_RESET_DIAGNOSTIC_ARTIFACTS),
    }
    (output / "run.json").write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    return payload


def verify_manifest_policy(payload: dict[str, object]) -> None:
    if payload.get("schema") != SCHEMA or payload.get("status") != "CAPTURE_COMPLETE":
        raise ValueError("run schema/status")
    if (
        payload.get("non_promotable") is not True or payload.get("organic_gameplay") is not False
        or payload.get("evidence_scope") != "isolated_mode1_active_stage_control"
        or payload.get("authority_transferred") is not False
        or payload.get("mode2_enabled") is not False or payload.get("cmd3f_enabled") is not False
    ):
        raise ValueError("runtime scope policy")
    if payload.get("roms") != {"active": ACTIVE_SHA256, "control": CONTROL_SHA256,
                               "default": DEFAULT_SHA256}:
        raise ValueError("ROM identity policy")
    if payload.get("toolchain") != {"frontend": FRONTEND_SHA256, "core": CORE_SHA256,
                                    "canonical_core": CANONICAL_CORE_SHA256}:
        raise ValueError("toolchain identity policy")
    expected_routes = {
        "normal": "0088E0D4->0089C914->flag_0_to_0->00884C6A->00884CBC->hook_flag_0_to_1->mode1",
        "name": "00891822->0089C914->flag_1_to_0->C80E_bit3->00884C98->00885618_replay",
        "name_transport_events": 0, "name_fixture_seeded": True,
        "name_fixture_organic": False,
    }
    if payload.get("route_contract") != expected_routes:
        raise ValueError("route contract policy")
    if payload.get("capture_matrix") != {
        "arms": list(ARMS), "routes": list(ROUTES), "repeats_per_arm_route": 2,
    }:
        raise ValueError("capture matrix policy")
    if payload.get("reset_contract") != {
        "validated_boundary_frame": 1241,
        "busy_slave_reset": "unproven_baseline_picodrive_defect_retained_separately",
    }:
        raise ValueError("reset contract policy")


def validate(run_path: Path) -> dict[str, object]:
    run_path = run_path.resolve()
    payload = json.loads(run_path.read_text())
    verify_manifest_policy(payload)
    directory = run_path.parent
    artifacts = payload.get("artifacts")
    if not isinstance(artifacts, dict) or set(artifacts) != set(EXPECTED_ARTIFACTS):
        missing = sorted(set(EXPECTED_ARTIFACTS) - set(artifacts or {}))
        extra = sorted(set(artifacts or {}) - set(EXPECTED_ARTIFACTS))
        raise ValueError(f"artifact set: missing={missing} extra={extra}")
    for name in EXPECTED_ARTIFACTS:
        metadata = artifacts[name]
        path = directory / name
        if Path(name).suffix not in ARCHIVABLE_SUFFIXES or metadata.get("path") != name or not path.is_file():
            raise ValueError(f"artifact path: {name}")
        if metadata.get("size") != path.stat().st_size or metadata.get("sha256") != sha256_path(path):
            raise ValueError(f"artifact identity: {name}")

    fixture = payload.get("name_fixture", {})
    if fixture.get("source_path") != "name-source.mds" or fixture.get("source_sha256") != NAME_SOURCE_SHA256 \
            or fixture.get("seeded_path") != "name-route-seeded.mds":
        raise ValueError("name fixture policy")
    with tempfile.TemporaryDirectory() as temp:
        regenerated = Path(temp) / "name.mds"
        changes = prepare_name_fixture(directory / "name-source.mds", regenerated)
        if changes != fixture.get("changes") or regenerated.read_bytes() != (directory / "name-route-seeded.mds").read_bytes():
            raise ValueError("name fixture transformation")

    mmio: dict[tuple[str, str, int], tuple[list[dict[str, object]], dict[str, int]]] = {}
    routes: dict[tuple[str, str, int], dict[str, int]] = {}
    warnings: dict[tuple[str, str, int], list[str]] = {}
    callers: dict[tuple[str, str, int], list[dict[str, int]]] = {}
    debug_texts: dict[tuple[str, str, int], str] = {}
    debug_traces: dict[tuple[str, str, int], dict[str, int]] = {}
    active_payloads: dict[int, list[bytes]] = {}
    for arm in ARMS:
        for route in ROUTES:
            frames = NORMAL_FRAMES if route == "normal" else NAME_FRAMES
            for repeat in REPEATS:
                prefix = f"{arm}-{route}-{repeat}"
                debug_path = directory / f"{prefix}.debug.txt"
                warnings[(arm, route, repeat)] = require_healthy_log(debug_path)
                text = debug_path.read_text()
                debug_texts[(arm, route, repeat)] = text
                traces = parse_trace_dumps(text)
                if len(traces) != 1:
                    raise ValueError(f"debug trace count: {prefix}")
                debug_traces[(arm, route, repeat)] = traces[0]
                pcs = re.findall(r"(?:Master|Slave) SH2: PC=([0-9A-F]{8})", text)
                if len(pcs) != 2 or any(0x02303B00 <= int(pc, 16) < 0x02303F1C for pc in pcs):
                    raise ValueError(f"SH2 liveness: {prefix}")
                rows, footer = parse_mmio_trace(directory / f"{prefix}.mmio.trace", frames)
                mmio[(arm, route, repeat)] = rows, footer
                route_rows = parse_write_trace(directory / f"{prefix}.write.trace", frames)
                routes[(arm, route, repeat)] = validate_route(route_rows, route)
                callers[(arm, route, repeat)] = parse_caller_trace(
                    directory / f"{prefix}.caller.trace", frames,
                    0x00884CBC if route == "normal" else 0x00885618,
                )
                if callers[(arm, route, repeat)][0]["frame"] < routes[(arm, route, repeat)]["final_frame"]:
                    raise ValueError(f"caller hit precedes installed pointer: {prefix}")
                if arm == "active" and route == "normal":
                    active_payloads[repeat] = validate_active_mmio(rows)
                else:
                    if rows:
                        raise ValueError(f"unexpected transport events: {prefix}")
                    if footer["raw_m68k"] != footer["pc_rejected_m68k"] or footer["raw_master"] != footer["pc_rejected_master"]:
                        raise ValueError(f"zero-event recorder accounting: {prefix}")
            if routes[(arm, route, 1)] != routes[(arm, route, 2)]:
                raise ValueError(f"non-deterministic route lifecycle: {arm}/{route}")
            if warnings[(arm, route, 1)] != warnings[(arm, route, 2)]:
                raise ValueError(f"non-deterministic warning lifecycle: {arm}/{route}")
    if active_payloads[1] != active_payloads[2]:
        raise ValueError("non-deterministic ACTIVE transaction payloads")
    for route in ROUTES:
        for repeat in REPEATS:
            if routes[("active", route, repeat)] != routes[("control", route, repeat)]:
                raise ValueError(f"ACTIVE/CONTROL route lifecycle: {route}/{repeat}")
            if warnings[("active", route, repeat)] != warnings[("control", route, repeat)]:
                raise ValueError(f"ACTIVE/CONTROL warnings: {route}/{repeat}")

    transaction_count = len(active_payloads[1])
    for repeat in REPEATS:
        active_normal = debug_texts[("active", "normal", repeat)]
        active_trace = debug_traces[("active", "normal", repeat)]
        require_trace(
            active_trace, magic=0x51323149, phase=0, sequence=transaction_count * 2,
            setup_count=transaction_count, completion_count=transaction_count,
            vres_count=0, stock_cmd_count=0, error=0, event=2, init_count=1,
            inverse=0xAECDCEB6,
        )
        if active_trace["setup_spc"] not in SAFE_SETUP_SPCS or active_trace["completion_spc"] == 0:
            raise ValueError(f"recorded setup/completion SPC policy: repeat {repeat}")
        source = parse_memory_dump(active_normal, 0x00FF6B00, 64)
        destination = parse_memory_dump(active_normal, 0x0600F30C, 64)
        if active_payloads[repeat][-1] != source or source != destination:
            raise ValueError(f"final 64-byte source/FIFO/destination equivalence: repeat {repeat}")
        if "00FF0002: 00 88 4C BC" not in active_normal or "00FF7B40: 01" not in active_normal:
            raise ValueError(f"ACTIVE normal final lifecycle: repeat {repeat}")

        control_normal = debug_texts[("control", "normal", repeat)]
        require_trace(
            debug_traces[("control", "normal", repeat)], magic=0x51323149, phase=0,
            sequence=0, setup_count=0, completion_count=0, vres_count=0,
            stock_cmd_count=0, error=0, event=0, init_count=1,
            setup_spc=0, completion_spc=0, inverse=0xAECDCEB6,
        )
        if "00FF0002: 00 88 4C BC" not in control_normal or "00FF7B40: 01" not in control_normal:
            raise ValueError(f"CONTROL normal final lifecycle: repeat {repeat}")

        for arm in ARMS:
            text = debug_texts[(arm, "name", repeat)]
            require_trace(
                debug_traces[(arm, "name", repeat)], magic=0x51323149, phase=0,
                sequence=0, setup_count=0, completion_count=0, vres_count=0,
                stock_cmd_count=0, error=0, event=0, init_count=1,
                setup_spc=0, completion_spc=0, inverse=0xAECDCEB6,
            )
            if "00FF0002: 00 88 56 18" not in text or "00FF7B40: 00" not in text:
                raise ValueError(f"{arm} name replay lifecycle: repeat {repeat}")

    vres_path = directory / "active-vres.debug.txt"
    baseline_path = directory / "default-reset-baseline.txt"
    require_healthy_log(vres_path, reset_warning=True)
    require_healthy_log(baseline_path, reset_warning=True)
    vres = parse_trace_dumps(vres_path.read_text())
    if len(vres) != 2:
        raise ValueError("VRES trace count")
    require_trace(
        vres[0], magic=0x51323149, phase=0, sequence=0,
        setup_count=0, completion_count=0, vres_count=0, stock_cmd_count=0,
        error=0, event=0, init_count=1, setup_spc=0, completion_spc=0,
        inverse=0xAECDCEB6,
    )
    require_trace(
        vres[1], magic=0x51323149, phase=4, sequence=2,
        setup_count=0, completion_count=0,
        vres_count=1, stock_cmd_count=1, error=0, event=4, init_count=3,
        setup_spc=0, completion_spc=0, inverse=0xAECDCEB6,
    )
    if len(re.findall(r"(?:Master|Slave) SH2: PC=([0-9A-F]{8})", vres_path.read_text())) != 4:
        raise ValueError("post-VRES SH2 liveness")
    if len(re.findall(r"(?:Master|Slave) SH2: PC=([0-9A-F]{8})", baseline_path.read_text())) != 2:
        raise ValueError("default reset baseline liveness")

    return {
        "schema": SCHEMA, "status": "VALIDATION_STAGE_PASS", "non_promotable": True,
        "capture_manifest_sha256": sha256_path(run_path),
        "organic_gameplay": False, "evidence_scope": "isolated_mode1_active_stage_control",
        "active_transactions_per_normal_run": transaction_count,
        "payload_bytes": 64, "full_checked_groups": 8, "fifo_words_per_group": 4,
        "normal_route_transport": "PASS", "name_route_transport_events": 0,
        "vres_scope": "pinned_stock_safe_frame_1241",
        "busy_slave_vres": "UNPROVEN_BASELINE_PICODRIVE_RESET_DEFECT",
        "name_route_replay_lifecycle": "PASS_SEEDED_DIAGNOSTIC",
        "active_control_lifecycle_equivalent": True,
        "vres_count": 1, "post_vres_init_count": 3,
        "default_sha256": DEFAULT_SHA256, "archive_complete": True,
        "promotable": False, "ordinary_default": False, "promoted": False,
        "real_hardware_proven": False,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="operation", required=True)
    capture_parser = subparsers.add_parser("capture")
    capture_parser.add_argument("--active", type=Path, required=True)
    capture_parser.add_argument("--control", type=Path, required=True)
    capture_parser.add_argument("--default", type=Path, required=True)
    capture_parser.add_argument("--frontend", type=Path, required=True)
    capture_parser.add_argument("--core", type=Path, required=True)
    capture_parser.add_argument("--canonical-core", type=Path, required=True)
    capture_parser.add_argument("--name-source-state", type=Path, required=True)
    capture_parser.add_argument("--output-dir", type=Path, required=True)
    diagnostic_parser = subparsers.add_parser("capture-reset-diagnostic")
    diagnostic_parser.add_argument("--active", type=Path, required=True)
    diagnostic_parser.add_argument("--control", type=Path, required=True)
    diagnostic_parser.add_argument("--default", type=Path, required=True)
    diagnostic_parser.add_argument("--frontend", type=Path, required=True)
    diagnostic_parser.add_argument("--core", type=Path, required=True)
    diagnostic_parser.add_argument("--canonical-core", type=Path, required=True)
    diagnostic_parser.add_argument("--output-dir", type=Path, required=True)
    validate_parser = subparsers.add_parser("validate")
    validate_parser.add_argument("run", type=Path)
    validate_parser.add_argument("--result", type=Path)
    args = parser.parse_args()
    try:
        if args.operation == "capture":
            capture(args)
            print(f"mode-1 runtime capture complete: {args.output_dir / 'run.json'}")
            print("status is CAPTURE_COMPLETE and remains non-promotable")
        elif args.operation == "capture-reset-diagnostic":
            capture_busy_reset_diagnostic(args)
            print(f"busy-Slave reset diagnostic archived: {args.output_dir / 'run.json'}")
            print("diagnostic is explicitly outside the PASS validator")
        else:
            result = validate(args.run)
            encoded = json.dumps(result, indent=2, sort_keys=True) + "\n"
            if args.result:
                if args.result.exists():
                    raise ValueError("result path already exists")
                args.result.write_text(encoded)
            print("mode-1 CMDINT validation-stage PASS (non-default, non-promotable)")
    except (OSError, ValueError, subprocess.SubprocessError, json.JSONDecodeError) as error:
        print(f"mode-1 CMDINT runtime FAILED: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
