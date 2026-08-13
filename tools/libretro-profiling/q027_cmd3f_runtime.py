#!/usr/bin/env python3
"""Capture and fail-closed validate the Q-027 v5 convergence gate."""

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

sys.path.insert(0, str(Path(__file__).resolve().parent))
from q026_player_runtime import (  # noqa: E402
    ENTITY_ALLOWED_FIELDS,
    FATAL_MARKERS,
    PRESERVED_FIELDS,
    canonical_sha256,
    event,
    native_sdram,
    parse_dumps,
    parse_regs,
    sha256_path,
    sterile_env,
)


SCHEMA = "vrd-vr60-q027-cmd3f-transport-runtime-v2"
APPROVED_V5_SHA256 = "e9f0b227517a928a6411ac6de26c74d7f27a1c1b8dde7be0c4ed5ee9cb31ff2a"
ACTIVE_SHA256 = "50c20e1a82ff8f1f6df49a86dfc51bdef8b2b435f365a16cab3dec0bf7834097"
CONTROL_SHA256 = "33bfdd8c0e4b44187f25b40bfb540e4d7aebcb5dda55cbebf51c7e674834e511"
FRONTEND_SHA256 = "626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50"
CORE_SHA256 = "08a791db331a2df426cb80c12299cb3882b037d2735692f3077e855a52109871"
FRAMES, BEFORE_FRAMES, CONVERGENCE_FRAMES, TERMINAL_FRAMES = 1340, 1262, 60, 18
REPEATS, ARMS = (1, 2), ("active", "control")
TI_EXPECTED, TD_EXPECTED = 1264, 1262
WRITE_TARGETS = (
    "0x00ffc87e:2,0x00ff0002:4,0x00ff7b40:1,0x00ffc80c:1,0x00a1518b:1"
)
INTERPRETER_WATCH_SPEC = (
    "0xFF7B40:1,0xFFC80C:1,0x2000410A:2,"
    "0x2600BC64:4,0x2600BC68:4,0x2600BC6C:4,"
    "0x2600BC8C:4,0x2600BC90:4,0x2600BC00:4,0x2600BC0C:4,"
    "0x2600FB64:4,0x20004020:2"
)
DRC_WATCH_SPEC = "0xFF7B40:1,0xFFC80C:1,0x2000410A:2"
MMIO_COLUMNS = "sequence,frame,cpu,pc,op,address,width,value"
MAILBOX = bytes.fromhex("5132374d000127113f01a55a51323743")
TRACE_MAGIC = 0x51323749
CANARY = bytes.fromhex("5132374b")
HANDLER_MAGIC = 0x51323743
CONTROL_MAGIC = 0x51323753
SEED_SHA256 = "2398c10d257a2129609e6ec502032dca0e223a0d3281a350555724e2d7795098"
ACTIVE_RESULT_SHA256 = "4e4607a0de55c687050e0b622dae25372ece397d1442dc04f047ed4ffd0b724b"
ACTIVE_CHANGED_BYTES = [14, 15, 23, 118, 119, 123, 236, 237, 238, 239, 247]
COMMAND_SHA256 = "20bebae44d6100108f2250d7cc4780f534557c02741860a1ac878099c8d29491"
DRC_COMMAND_SHA256 = "8eb1d4e71c4bce53deb0ee01da6127d13484c9c387d0778b3f5f363b1bb7fd3b"
DISPATCH_PCS = (
    0x06000460, 0x06000462, 0x06000464, 0x06000466,
    0x06000468, 0x0600046A, 0x0600046C, 0x0600046E,
    0x06000470, 0x06000472, 0x02301500, 0x0230160A,
    0x06000474,
)
PROFILE_FIELDS = (
    "frame", "m68k_cycles", "msh2_cycles", "ssh2_cycles", "m68k_useful",
    "msh2_useful", "ssh2_useful", "active", "fb_crc", "scene", "state", "is_32x",
)
INTERPRETER_WATCH_FIELDS = (
    "frame", "0xFF7B40", "0xFFC80C", "0x2000410A", "0x2600BC64",
    "0x2600BC68", "0x2600BC6C", "0x2600BC8C", "0x2600BC90",
    "0x2600BC00", "0x2600BC0C", "0x2600FB64", "0x20004020",
)
DRC_WATCH_FIELDS = ("frame", "0xFF7B40", "0xFFC80C", "0x2000410A")
DISPLAY_WATCH_FIELDS = ("frame", "0xFFC80C", "0x2000410A")

INTERPRETER_TABLE = {
    0: (17729, 16463, 306768, 306780, 0xE419027B, 0xE419027B, 0x4CBC, 0x0000),
    1: (278778, 278738, 307014, 307035, 0x8AF772C5, 0x8AF772C5, 0x4CBC, 0x0008),
    2: (207754, 207786, 273652, 273624, 0x344A67A6, 0xD08BAC75, 0x4CBC, 0x0008),
    3: (15566, 15566, 306805, 306808, 0xDA4F533B, 0xDA4F533B, 0x4CBC, 0x0000),
    4: (278223, 278213, 307038, 307034, 0xD3545AC5, 0xD3545AC5, 0x4CBC, 0x0008),
    5: (208445, 208451, 273656, 273648, 0xA2BBA13F, 0xA2BBA13F, 0x4CBC, 0x0008),
    6: (15566, 15566, 306840, 306840, 0x835DCD3B, 0x835DCD3B, 0x4CBC, 0x0000),
}
INTERPRETER_MASTER_DIFFS = {0, 1, 2, 4, 5}
INTERPRETER_SLAVE_DIFFS = {0, 1, 2, 3, 4, 5}
DRC_ROW = (17125, 15859, 306554, 306574, 0x797BA8C5, 0x4CBC, 0x0000)

FAILED_V3_HASHES = {
    "active.caller.trace": "aa872cb4ab153c105f7c4c2b02b8bc095a2677713c5a85694b79a32d9f5bc7c4",
    "active.debug.txt": "7b7234b37d6b2113c33a5a8b9c9db69962e92700a3fa3d3d36d6af881418a2b0",
    "active.mmio.trace": "063ff81efd2319a8ee3ddd7a08256382080e22383bf6311f2e304c7d2c29a878",
    "active.profile.csv": "8460a227682b5ec0c49d963d0dd8a8e1e3bb5e9bd3bdaa7294e77bdcef8c7351",
    "active.regs.trace": "0797595656d7ab43bfab29db6a6e3fc62b9c0554174be1898d4017efeb0c42d4",
    "active.watch.csv": "1fdc9f1dc08faaa66cf0fe910bc09631f849804d9ba29a8d36160e2c27e205fc",
    "active.write.trace": "edaf37a0f6822b557521d85dba455ca41b597b9faf82656b3cf1ba4ce2884371",
}
FAILED_V3_COMMAND_HASH = "3141f34b00153b14ce0d3d7431ca906781b1ea26caa1de1aeb911dc96360d81d"
DIAGNOSTIC_SOURCES = {
    "failed-v3-pilot": Path("/tmp/q027-pilot"),
    "v4-candidate2": Path("/tmp/q027-runtime-candidate2"),
    "drc-diagnostic": Path("/tmp/q027-drc-diagnostic"),
    "drc-split-diagnostic": Path("/tmp/q027-drc-split-diagnostic"),
    "q026-interpreter-diagnostic": Path("/tmp/q026-interpreter-diagnostic"),
    "interpreter-1400": Path("/tmp/q027-interpreter-1400"),
    "interpreter-late-diagnostic": Path("/tmp/q027-interpreter-late-diagnostic"),
    "convergence-diagnostic": Path("/tmp/q027-convergence-diagnostic"),
    "drc-convergence-diagnostic": Path("/tmp/q027-drc-convergence-diagnostic"),
}


def commands_text() -> str:
    checkpoint = (
        "read 68k 0x00FF6A00 320\n"
        "read master 0x0600F20C 320\n"
        "read master 0x2600BC00 16\n"
        "read master 0x2600BC60 64\n"
        "read master 0x2600FB64 4\n"
        "read master 0x0600FB68 152\n"
        "read master 0x2600FC00 16\n"
        "read master 0x20004000 2\n"
        "read master 0x2000401A 2\n"
        "read master 0x20004020 16\n"
        "read master 0x2000410A 2\n"
        "regs master\nregs slave\n"
    )
    terminal = (
        "read 68k 0x00FF0002 4\n"
        "read 68k 0x00FFC87E 2\n"
        "read 68k 0x00FFC80C 1\n"
        "read 68k 0x00FF7B40 1\n"
        "read master 0x2600BC00 16\n"
        "read master 0x2600BC60 64\n"
        "read master 0x2600FB64 4\n"
        "read master 0x0600FB68 152\n"
        "read master 0x2600FC00 16\n"
        "read master 0x20004000 2\n"
        "read master 0x2000401A 2\n"
        "read master 0x20004020 16\n"
        "read master 0x2000410A 2\n"
        "regs master\nregs slave\n"
    )
    return (
        f"run {BEFORE_FRAMES}\n" + checkpoint + f"run {CONVERGENCE_FRAMES}\n" +
        checkpoint + f"run {TERMINAL_FRAMES}\n" + terminal + "quit\n"
    )


def drc_commands_text() -> str:
    return f"run {FRAMES}\nquit\n"


def require_command_identities() -> None:
    if hashlib.sha256(commands_text().encode()).hexdigest() != COMMAND_SHA256:
        raise ValueError("interpreter command schedule identity")
    if hashlib.sha256(drc_commands_text().encode()).hexdigest() != DRC_COMMAND_SHA256:
        raise ValueError("DRC command schedule identity")


def run_frontend(frontend: Path, core: Path, rom: Path, prefix: Path, mode: str) -> None:
    if mode not in ("interpreter", "drc"):
        raise ValueError("capture mode")
    commands = commands_text() if mode == "interpreter" else drc_commands_text()
    command_path = prefix.with_suffix(".commands")
    debug_path = prefix.with_suffix(".debug.txt")
    command_path.write_text(commands)
    common = {
        "VRD_LIBRETRO_CORE": str(core.resolve()),
        "VRD_PROFILE_FRAMES": str(FRAMES),
        "VRD_PROFILE_LOG": str(prefix.with_suffix(".profile.csv")),
        "VRD_FB_CRC": "1",
        "VRD_WATCH": INTERPRETER_WATCH_SPEC if mode == "interpreter" else DRC_WATCH_SPEC,
        "VRD_WATCH_LOG": str(prefix.with_suffix(".watch.csv")),
        "VRD_WRITE_TRACE": WRITE_TARGETS,
        "VRD_WRITE_TRACE_LOG": str(prefix.with_suffix(".write.trace")),
        "VRD_CALLER_TRACE": "00884CBC",
        "VRD_CALLER_TRACE_MAX": "0",
        "VRD_CALLER_TRACE_LOG": str(prefix.with_suffix(".caller.trace")),
    }
    if mode == "interpreter":
        common.update({
            "VRD_MMIO_TRACE": "1",
            "VRD_MMIO_TRACE_MODE": "q027",
            "VRD_MMIO_TRACE_LOG": str(prefix.with_suffix(".mmio.trace")),
            "VRD_Q027_REG_TRACE": str(prefix.with_suffix(".regs.trace")),
        })
    env = sterile_env(**common)
    result = subprocess.run(
        [str(frontend.resolve()), str(rom.resolve()), str(FRAMES), "--debug", "--autoplay"],
        cwd=frontend.resolve().parent, env=env, input=commands, text=True,
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=180, check=False,
    )
    debug_path.write_text(result.stdout)
    if result.returncode != 0:
        raise ValueError(f"frontend failed ({result.returncode}): {debug_path.name}")


def artifact_names() -> tuple[str, ...]:
    interpreter_suffixes = (
        ".commands", ".debug.txt", ".mmio.trace", ".regs.trace",
        ".profile.csv", ".watch.csv", ".write.trace", ".caller.trace",
    )
    drc_suffixes = (
        ".commands", ".debug.txt", ".profile.csv", ".watch.csv",
        ".write.trace", ".caller.trace",
    )
    names = [
        f"interpreter-{arm}-{repeat}{suffix}"
        for arm in ARMS for repeat in REPEATS for suffix in interpreter_suffixes
    ]
    names.extend(
        f"drc-{arm}-{repeat}{suffix}"
        for arm in ARMS for repeat in REPEATS for suffix in drc_suffixes
    )
    return tuple(names)


def artifact_hashes(root: Path, names: tuple[str, ...]) -> dict[str, object]:
    return {
        name: {"size": (root / name).stat().st_size, "sha256": sha256_path(root / name)}
        for name in names
    }


def preserve_diagnostics(output: Path, failed_v3_commands: Path) -> dict[str, object]:
    diagnostics: dict[str, object] = {}
    for label, source_root in DIAGNOSTIC_SOURCES.items():
        if not source_root.is_dir():
            raise ValueError(f"diagnostic source missing: {source_root}")
        files: dict[str, object] = {}
        destination_root = output / "diagnostics" / label
        for source in sorted(source_root.rglob("*")):
            if source.is_symlink():
                raise ValueError(f"diagnostic symlink forbidden: {source}")
            if not source.is_file():
                continue
            relative = source.relative_to(source_root)
            destination = destination_root / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, destination)
            files[relative.as_posix()] = {
                "size": destination.stat().st_size,
                "sha256": sha256_path(destination),
            }
        if not files:
            raise ValueError(f"empty diagnostic source: {source_root}")
        diagnostics[label] = {
            "eligible": False,
            "reason": "pre-approval proposal-shaping diagnostic; never acceptance evidence",
            "files": files,
        }

    failed = diagnostics["failed-v3-pilot"]["files"]
    if set(failed) != set(FAILED_V3_HASHES):
        raise ValueError("failed-v3 diagnostic inventory")
    for name, expected in FAILED_V3_HASHES.items():
        if failed[name]["sha256"] != expected:
            raise ValueError(f"failed-v3 diagnostic identity: {name}")
    if not failed_v3_commands.is_file() \
            or sha256_path(failed_v3_commands) != FAILED_V3_COMMAND_HASH:
        raise ValueError("failed-v3 command identity")
    destination = output / "diagnostics" / "failed-v3-pilot" / "pilot.commands"
    shutil.copy2(failed_v3_commands, destination)
    failed["pilot.commands"] = {
        "size": destination.stat().st_size,
        "sha256": FAILED_V3_COMMAND_HASH,
    }
    return diagnostics


def capture(args: argparse.Namespace) -> dict[str, object]:
    require_command_identities()
    output = args.output_dir.resolve()
    if output.exists():
        raise ValueError("output directory already exists")
    for path, expected in (
        (args.active, ACTIVE_SHA256), (args.control, CONTROL_SHA256),
        (args.frontend, FRONTEND_SHA256), (args.core, CORE_SHA256),
    ):
        if not path.is_file() or sha256_path(path) != expected:
            raise ValueError(f"input identity: {path}")
    output.mkdir(parents=True)
    for mode in ("interpreter", "drc"):
        for arm, rom in (("active", args.active), ("control", args.control)):
            for repeat in REPEATS:
                run_frontend(args.frontend, args.core, rom,
                             output / f"{mode}-{arm}-{repeat}", mode)

    diagnostics = preserve_diagnostics(output, args.failed_v3_commands)
    runtime_tool = sha256_path(Path(__file__).resolve())
    payload = {
        "schema": SCHEMA,
        "approved_v5_sha256": APPROVED_V5_SHA256,
        "status": "CAPTURE_COMPLETE",
        "eligible": False,
        "promotable": False,
        "non_promotable": True,
        "scope": "master_comm0_stock_dispatch_player_shadow_convergence_gate",
        "authority_transferred": False,
        "cmd3f_promoted": False,
        "shared_lane_transport": False,
        "bridge_enabled": False,
        "collision_enabled": False,
        "cadence_changed": False,
        "fps_claim": None,
        "cpu_budget_claim": None,
        "fixture": "trustworthy_normal_1p_autoplay_from_boot",
        "organic_gameplay": True,
        "frames": FRAMES,
        "repeats_per_arm": 2,
        "roms": {"active": ACTIVE_SHA256, "control": CONTROL_SHA256},
        "toolchain": {
            "frontend": FRONTEND_SHA256,
            "core": CORE_SHA256,
            "runtime_tool": runtime_tool,
            "interpreter_commands": COMMAND_SHA256,
            "drc_commands": DRC_COMMAND_SHA256,
        },
        "capture_modes": {
            "interpreter": {
                "sh2_drc": False,
                "schedule": [BEFORE_FRAMES, CONVERGENCE_FRAMES, TERMINAL_FRAMES],
                "mmio_mode": "q027",
                "watch": INTERPRETER_WATCH_SPEC,
                "write_targets": WRITE_TARGETS,
            },
            "drc": {
                "sh2_drc": True,
                "schedule": [FRAMES],
                "mmio_mode": None,
                "watch": DRC_WATCH_SPEC,
                "write_targets": WRITE_TARGETS,
            },
        },
        "diagnostics": diagnostics,
        "artifacts": artifact_hashes(output, artifact_names()),
    }
    (output / "run.json").write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    return payload


def parse_profile(path: Path) -> list[dict[str, str]]:
    with path.open() as stream:
        reader = csv.DictReader(stream)
        if tuple(reader.fieldnames or ()) != PROFILE_FIELDS:
            raise ValueError(f"profile schema: {path.name}")
        rows = list(reader)
    if len(rows) != FRAMES - 2 \
            or [int(row["frame"]) for row in rows] != list(range(2, FRAMES)):
        raise ValueError(f"profile coverage/order: {path.name}")
    return rows


def parse_watch(path: Path, mode: str) -> list[dict[str, str]]:
    expected_fields = INTERPRETER_WATCH_FIELDS if mode == "interpreter" else DRC_WATCH_FIELDS
    with path.open() as stream:
        reader = csv.DictReader(stream)
        if tuple(reader.fieldnames or ()) != expected_fields:
            raise ValueError(f"watch schema: {path.name}")
        rows = list(reader)
    if len(rows) != FRAMES - 1 \
            or [int(row["frame"]) for row in rows] != list(range(1, FRAMES)):
        raise ValueError(f"watch coverage/order: {path.name}")
    return rows


def parse_mmio(path: Path) -> tuple[list[dict[str, object]], dict[str, str]]:
    lines = path.read_text().splitlines()
    if len(lines) < 4 or "sh2_drc=0" not in lines[0] \
            or "profile_pc=0" not in lines[0] or "profile_pc_env=0" not in lines[0] \
            or "m68k_batching=normal" not in lines[0] \
            or "instruction_start_hook=1" not in lines[0] \
            or "pc_allowlist=m68k:0x0001C6FE-0x0001C76C|" not in lines[0] \
            or lines[1] != (
                "# FILTER q027_passive=1 m68k_system=0x00A15100-0x00A1513F "
                "master_system=0x20004000-0x2000403F "
                "master_peripheral=0xFFFFFE00-0xFFFFFFFF "
                "master_sdram=all_writes master_framebuffer=all_writes "
                "master_regs=exact_instruction_pc"
            ) or lines[2] != MMIO_COLUMNS:
        raise ValueError(f"MMIO header: {path.name}")
    footer = lines[-1]
    if not footer.startswith(f"# COMPLETE frames={FRAMES} "):
        raise ValueError(f"MMIO completion: {path.name}")
    fields = dict(re.findall(r"([a-z0-9_]+)=([^ ]+)", footer))
    for key in ("dropped", "errors", "overflow", "q027_regs_errors"):
        if fields.get(key) != "0":
            raise ValueError(f"MMIO {key}: {path.name}")
    if fields.get("direct_m68k") != "1" or fields.get("direct_master") != "1" \
            or fields.get("observer_detached") != "1" \
            or fields.get("q027_edge_snapshots") != "1":
        raise ValueError(f"MMIO observer coverage: {path.name}")
    rows: list[dict[str, object]] = []
    for index, raw in enumerate(csv.DictReader(lines[2:-1])):
        row: dict[str, object] = {
            "sequence": int(raw["sequence"], 0), "frame": int(raw["frame"], 0),
            "cpu": raw["cpu"], "pc": int(raw["pc"], 0), "op": raw["op"],
            "address": int(raw["address"], 0), "width": int(raw["width"], 0),
            "value": int(raw["value"], 0),
        }
        if row["sequence"] != index:
            raise ValueError(f"MMIO sequence: {path.name}")
        rows.append(row)
    if int(fields.get("events", "-1")) != len(rows) \
            or fields.get("events") != fields.get("recorded"):
        raise ValueError(f"MMIO count: {path.name}")
    return rows, fields


def parse_register_trace(path: Path) -> list[dict[str, int]]:
    lines = path.read_text().splitlines()
    if len(lines) < 2 or not lines[-1].startswith("# COMPLETE rows=") \
            or "errors=0" not in lines[-1]:
        raise ValueError(f"register trace completion: {path.name}")
    rows = [
        {key: int(value, 0) for key, value in raw.items()}
        for raw in csv.DictReader(lines[:-1])
    ]
    if [row["sequence"] for row in rows] != list(range(len(rows))):
        raise ValueError(f"register trace sequence: {path.name}")
    fields = dict(re.findall(r"([a-z]+)=([0-9A-F]+)", lines[-1]))
    expected_mask = 0x1FFF if rows else 0
    if int(fields.get("rows", "-1"), 10) != len(rows) \
            or int(fields.get("mask", "-1"), 16) != expected_mask:
        raise ValueError(f"register trace footer: {path.name}")
    return rows


def parse_trace(path: Path, kind: str, mode: str) -> tuple[list[str], list[dict[str, str]]]:
    lines = path.read_text().splitlines()
    if not lines or not lines[-1].startswith(f"# COMPLETE frames={FRAMES} ") \
            or "errors=0" not in lines[-1]:
        raise ValueError(f"{kind} completion: {path.name}")
    expected_drc = "sh2_drc=0" if mode == "interpreter" else "sh2_drc=1"
    header = lines[0]
    for fragment in (
        expected_drc, "profile_pc=0", "profile_pc_env=0", "m68k_batching=normal",
        "instruction_start_hook=1", "composed=1",
    ):
        if fragment not in header:
            raise ValueError(f"{kind} observer header: {path.name}")
    if kind == "write trace":
        expected_targets = (
            "# TARGET index=0 addr=0xFFC87E size=2",
            "# TARGET index=1 addr=0xFF0002 size=4",
            "# TARGET index=2 addr=0xFF7B40 size=1",
            "# TARGET index=3 addr=0xFFC80C size=1",
            "# TARGET index=4 addr=0xA1518B size=1",
        )
        if tuple(lines[1:6]) != expected_targets:
            raise ValueError(f"write trace targets: {path.name}")
        csv_start = 6
    else:
        if "addr=0x00884CBC" not in header or "max_hits=0" not in header:
            raise ValueError(f"caller trace target: {path.name}")
        csv_start = 1
    rows = list(csv.DictReader(lines[csv_start:-1]))
    return lines, rows


def comm_words(value: str) -> tuple[int, ...]:
    parts = value.split("/")
    if len(parts) != 8:
        raise ValueError("Q-027 COMM snapshot encoding")
    return tuple(int(part, 16) for part in parts)


def trace_words(value: bytes) -> tuple[int, ...]:
    return tuple(int.from_bytes(value[offset:offset + 4], "big")
                 for offset in range(0, len(value), 4))


def q027_events(rows: list[dict[str, object]]) -> list[dict[str, object]]:
    return [row for row in rows if (
        (row["cpu"] == "m68k" and 0x0001C930 <= int(row["pc"]) < 0x0001C9A2) or
        (row["cpu"] == "master" and (
            0x02304000 <= int(row["pc"]) < 0x02304314 or
            0x02304500 <= int(row["pc"]) < 0x02304504 or
            0x02301500 <= int(row["pc"]) < 0x023025E0 or
            0x06000460 <= int(row["pc"]) < 0x06000478
        ))
    )]


def validate_q027_seed(rows: list[dict[str, object]]) -> bytes:
    length = [row for row in rows if event(
        row, "m68k", 0x0001C70A, "write", 0x00A15110, 2, 0x00A0
    )]
    fifo = [row for row in rows if event(
        row, "m68k", 0x0001C762, "write", 0x00A15112, 2
    )]
    destination = [
        row for row in rows if row["cpu"] == "master" and row["pc"] == 0x02301714
        and row["op"] == "write" and 0x0600F20C <= int(row["address"]) < 0x0600F34C
    ]
    provenance = [row for row in rows if event(
        row, "master", 0x023016B4, "write", 0x2600FC00, 4, 0x20004020
    )]
    if len(length) != 1 or len(fifo) != 32 or len(destination) != 160 \
            or len(provenance) != 1:
        raise ValueError("exactly one mode-0 seed lifecycle")
    if [int(row["address"]) for row in destination] != list(range(0x0600F20C, 0x0600F34C, 2)):
        raise ValueError("mode-0 destination chronology")
    fifo_bytes = b"".join(int(row["value"]).to_bytes(2, "big") for row in fifo)
    destination_bytes = b"".join(int(row["value"]).to_bytes(2, "big") for row in destination)
    if fifo_bytes != destination_bytes[-len(fifo_bytes):]:
        raise ValueError("mode-0 observed FIFO tail/destination payload")
    return destination_bytes


def require_exact_protocol(rows: list[dict[str, object]], arm: str) -> dict[str, object]:
    hi_reads = [row for row in rows if event(
        row, "m68k", 0x0001C958, "read", 0x00A15120, 1
    )]
    if not hi_reads or hi_reads[-1]["value"] != 0 \
            or any(int(row["value"]) not in (0, 1) for row in hi_reads):
        raise ValueError("pre-Edge1 COMM0_HI admission")
    edge_writes = [
        row for row in rows if row["cpu"] == "m68k" and row["op"] == "write"
        and row["address"] == 0x00A15103 and row["width"] == 1 and row["value"] == 1
        and row["pc"] in (0x0001C96A, 0x0001C992)
    ]
    if [(row["pc"], row["value"]) for row in edge_writes] != [(0x0001C96A, 1), (0x0001C992, 1)]:
        raise ValueError("exact two 68K INTM edges")
    if len({int(row["frame"]) for row in edge_writes}) != 1 \
            or int(edge_writes[0]["frame"]) != TI_EXPECTED:
        raise ValueError("interpreter transaction frame T_I")
    edge1_hi = [row for row in rows if event(
        row, "master", 0x02304114, "read", 0x20004020, 1, 0
    )]
    if len(edge1_hi) != 1:
        raise ValueError("Edge1 ISR COMM0_HI-only admission")
    normalization = [row for row in rows if (
        event(row, "m68k", 0x0001C97A, "write", 0x00A15120, 2, 0) or
        event(row, "m68k", 0x0001C980, "read", 0x00A15120, 2, 0) or
        event(row, "m68k", 0x0001C98A, "write", 0x00A15120, 2, 0x013F)
    )]
    expected = [
        (0x0001C97A, "write", 0), (0x0001C980, "read", 0),
        (0x0001C98A, "write", 0x013F),
    ]
    if [(row["pc"], row["op"], row["value"]) for row in normalization] != expected:
        raise ValueError("exclusive clear/readback/publish chronology")
    clear_seq, read_seq, publish_seq = (int(row["sequence"]) for row in normalization)
    if not int(edge_writes[0]["sequence"]) < int(edge1_hi[0]["sequence"]) < clear_seq \
            < read_seq < publish_seq < int(edge_writes[1]["sequence"]):
        raise ValueError("two-edge ownership chronology")
    overlapping = [
        row for row in rows if clear_seq <= int(row["sequence"]) <= publish_seq
        and row["cpu"] == "master" and 0x20004020 <= int(row["address"]) <= 0x20004021
    ]
    if overlapping:
        raise ValueError("Master COMM0 overlap while 68K owns lane")
    post_publish_68k = [
        row for row in rows if int(row["sequence"]) > publish_seq and row["cpu"] == "m68k"
        and 0x00A15120 <= int(row["address"]) <= 0x00A1512F
    ]
    if post_publish_68k:
        raise ValueError("68K COMM access after publish")
    edge2_read = [row for row in rows if event(
        row, "master", 0x02304164, "read", 0x20004020, 2, 0x013F
    )]
    if len(edge2_read) != 1 or int(edge2_read[0]["sequence"]) < publish_seq:
        raise ValueError("Edge2 exact COMM0 word")
    shared = [row for row in q027_events(rows) if (
        row["cpu"] == "m68k" and 0x00A15122 <= int(row["address"]) <= 0x00A1512F or
        row["cpu"] == "master" and 0x20004022 <= int(row["address"]) <= 0x2000402F
    ) and int(row["sequence"]) >= int(edge_writes[0]["sequence"])]
    if shared:
        raise ValueError("Q-027 access to COMM1-7")
    handler_clear = [row for row in rows if event(
        row, "master", 0x023015B2, "write", 0x20004020, 2, 0
    )]
    control_clear = [row for row in rows if event(
        row, "master", 0x023041BA, "write", 0x20004020, 2, 0
    )]
    if arm == "active" and (len(handler_clear) != 1 or control_clear):
        raise ValueError("ACTIVE handler-owned COMM0 clear")
    if arm == "control" and (len(control_clear) != 1 or handler_clear):
        raise ValueError("CONTROL ISR-owned COMM0 clear")
    return {
        "transaction_frame": TI_EXPECTED,
        "hi_reads": len(hi_reads),
        "edge_events": 2,
        "normalization_sequences": [clear_seq, read_seq, publish_seq],
    }


def validate_registers(path: Path, arm: str) -> dict[str, object]:
    rows = parse_register_trace(path)
    if arm == "control":
        if rows:
            raise ValueError("CONTROL dispatched stock table/handler")
        return {"rows": 0, "mask": "0x0000"}
    if [row["pc"] for row in rows] != list(DISPATCH_PCS):
        raise ValueError("ACTIVE exact stock dispatcher chronology")
    for row in rows:
        if row["pr"] != 0x06000474 or row["r15"] != 0x0600FF80:
            raise ValueError("stock dispatcher PR/R15 contract")
    entry, exit_row = rows[10], rows[11]
    for register in (
        "pr", "gbr", "mach", "macl", "r8", "r9", "r10", "r11",
        "r12", "r13", "r14", "r15",
    ):
        if entry[register] != exit_row[register]:
            raise ValueError(f"handler context restore: {register}")
    if entry["r8"] != 0x20004020:
        raise ValueError("handler R8 COMM0 base")
    return {
        "rows": len(rows), "mask": "0x1FFF",
        "entry": {key: entry[key] for key in (
            "pr", "gbr", "mach", "macl", "r8", "r9", "r10", "r11",
            "r12", "r13", "r14", "r15",
        )},
    }


def validate_direct_writes(rows: list[dict[str, object]], arm: str,
                           registers: dict[str, object]) -> dict[str, object]:
    direct = [row for row in q027_events(rows) if row["cpu"] == "master" and row["op"] == "write"]
    framebuffer = [
        row for row in direct if 0x04000000 <= int(row["address"]) < 0x05000000
        or 0x24000000 <= int(row["address"]) < 0x25000000
    ]
    if framebuffer:
        raise ValueError("Q-027 framebuffer write")
    dedicated = [
        row for row in direct
        if 0x0600FB64 <= native_sdram(int(row["address"])) < 0x0600FC00
    ]
    transaction_dedicated = [row for row in dedicated if int(row["frame"]) >= TI_EXPECTED]
    canary = [
        row for row in transaction_dedicated
        if native_sdram(int(row["address"])) == 0x0600FB64
    ]
    if len(canary) != 1 or canary[0]["value"] != 0x5132374B:
        raise ValueError("admission-local canary")
    if arm == "control":
        if len(transaction_dedicated) != 1:
            raise ValueError("CONTROL dedicated-stack write")
        return {"stack_writes": 0, "stack_low": None}

    stack = [
        row for row in transaction_dedicated
        if native_sdram(int(row["address"])) >= 0x0600FB68
    ]
    if not stack or min(native_sdram(int(row["address"])) for row in stack) < 0x0600FBBC:
        raise ValueError("ACTIVE dedicated stack bound")
    entry = registers["entry"]
    expected = (
        (0x0600FBFC, "r15"), (0x0600FBF8, "pr"), (0x0600FBF4, "gbr"),
        (0x0600FBF0, "mach"), (0x0600FBEC, "macl"), (0x0600FBE8, "r8"),
        (0x0600FBE4, "r9"), (0x0600FBE0, "r10"), (0x0600FBDC, "r11"),
        (0x0600FBD8, "r12"), (0x0600FBD4, "r13"), (0x0600FBD0, "r14"),
    )
    saves = [row for row in stack if 0x02301506 <= int(row["pc"]) <= 0x0230151C]
    if [(native_sdram(int(row["address"])), int(row["value"])) for row in saves] != [
        (address, int(entry[register])) for address, register in expected
    ]:
        raise ValueError("handler preservation frame values")
    player_writes = [
        row for row in direct
        if 0x0600F20C <= native_sdram(int(row["address"])) < 0x0600F30C
        and int(row["frame"]) >= TI_EXPECTED
    ]
    if not player_writes or any(
        int(row["width"]) != 2
        or native_sdram(int(row["address"])) - 0x0600F20C not in ENTITY_ALLOWED_FIELDS
        for row in player_writes
    ):
        raise ValueError("player-only write allowlist")
    mailbox_writes = [
        row for row in direct if 0x2600BC00 <= int(row["address"]) < 0x2600BC10
    ]
    expected_mailbox = [
        (0x2600BC00, 4, 0x5132374D), (0x2600BC04, 2, 0x0001),
        (0x2600BC06, 2, 0x2711), (0x2600BC08, 2, 0x3F01),
        (0x2600BC0A, 2, 0xA55A), (0x2600BC0C, 4, 0x51323743),
    ]
    if [(row["address"], row["width"], row["value"]) for row in mailbox_writes] \
            != expected_mailbox:
        raise ValueError("frozen mailbox write order")
    return {
        "stack_writes": len(stack),
        "stack_low": f"0x{min(native_sdram(int(row['address'])) for row in stack):08X}",
        "player_writes": len(player_writes),
    }


def validate_debug_completion(debug_text: str, name: str) -> None:
    lowered = debug_text.lower()
    for marker in FATAL_MARKERS:
        if marker in lowered:
            raise ValueError(f"fatal runtime marker {marker}: {name}")
    if re.search(r"\d{5}:\d{3}: 32X shutdown\nProfile data written to: .+\n?\Z", debug_text) is None:
        raise ValueError(f"terminal shutdown: {name}")


def validate_interpreter_one(root: Path, arm: str, repeat: int) -> dict[str, object]:
    prefix = root / f"interpreter-{arm}-{repeat}"
    if prefix.with_suffix(".commands").read_text() != commands_text():
        raise ValueError(f"interpreter command split: {arm}-{repeat}")
    debug_text = prefix.with_suffix(".debug.txt").read_text()
    validate_debug_completion(debug_text, f"interpreter-{arm}-{repeat}")
    rows, footer = parse_mmio(prefix.with_suffix(".mmio.trace"))
    seed = validate_q027_seed(rows)
    protocol = require_exact_protocol(rows, arm)
    pre, post = comm_words(footer["q027_comm_pre"]), comm_words(footer["q027_comm_post"])
    if pre[0] != 0x0002 or post[0] != 0 or pre[1:] != post[1:]:
        raise ValueError("COMM0 normalization or COMM1-7 preservation")
    registers = validate_registers(prefix.with_suffix(".regs.trace"), arm)
    direct = validate_direct_writes(rows, arm, registers)

    source_dumps = parse_dumps(debug_text, 0x00FF6A00, 320)
    destination_dumps = parse_dumps(debug_text, 0x0600F20C, 320)
    mailboxes = parse_dumps(debug_text, 0x2600BC00, 16)
    traces = parse_dumps(debug_text, 0x2600BC60, 64)
    canaries = parse_dumps(debug_text, 0x2600FB64, 4)
    stacks = parse_dumps(debug_text, 0x0600FB68, 152)
    sentinels = parse_dumps(debug_text, 0x2600FC00, 16)
    adapter = parse_dumps(debug_text, 0x20004000, 2)
    masks = parse_dumps(debug_text, 0x2000401A, 2)
    comms = parse_dumps(debug_text, 0x20004020, 16)
    fbctl = parse_dumps(debug_text, 0x2000410A, 2)
    if not all(len(values) == expected for values, expected in (
        (source_dumps, 2), (destination_dumps, 2), (mailboxes, 3), (traces, 3),
        (canaries, 3), (stacks, 3), (sentinels, 3), (adapter, 3), (masks, 3),
        (comms, 3), (fbctl, 3),
    )):
        raise ValueError(f"debug dump coverage: {arm}-{repeat}")
    before, after = destination_dumps
    if source_dumps[0] != source_dumps[1] or before != seed or source_dumps[0] != seed:
        raise ValueError("exact accepted 320-byte handler input")
    if hashlib.sha256(seed).hexdigest() != SEED_SHA256:
        raise ValueError("accepted Q-026 seed identity")
    if sentinels[0] != bytes.fromhex("20004020") + b"\0" * 12 \
            or sentinels[1:] != [sentinels[0], sentinels[0]]:
        raise ValueError("accepted mode-0 provenance")
    if any(value != b"\x00\x00" for value in masks):
        raise ValueError("terminal CMD mask low")
    before_trace = trace_words(traces[0])
    after_trace = trace_words(traces[1])
    if before_trace != (TRACE_MAGIC,) + (0,) * 15 or traces[1] != traces[2]:
        raise ValueError("Q-027 trace before/terminal stability")
    common_trace = (
        TRACE_MAGIC, 4, 2, 1 if arm == "active" else 0,
        0x06000464, 0x0600FF80, 0x02304500, 0x0600FF80,
    )
    expected_tail = (
        0x8202, 0, HANDLER_MAGIC if arm == "active" else 0,
        0 if arm == "active" else CONTROL_MAGIC, 0, 0, 0, 0,
    )
    if after_trace[:8] != common_trace or after_trace[8:] != expected_tail:
        raise ValueError(f"Q-027 terminal trace: {after_trace}")
    if canaries[1:] != [CANARY, CANARY]:
        raise ValueError("Q-027 terminal canary")
    if arm == "active":
        if mailboxes != [b"\0" * 16, MAILBOX, MAILBOX]:
            raise ValueError("ACTIVE fixed mailbox image")
        changed = [
            index for index, pair in enumerate(zip(before, after, strict=True))
            if pair[0] != pair[1]
        ]
        if changed != ACTIVE_CHANGED_BYTES \
                or hashlib.sha256(after).hexdigest() != ACTIVE_RESULT_SHA256:
            raise ValueError("ACTIVE exact Q-026 player result")
        allowed_bytes = {byte for offset in ENTITY_ALLOWED_FIELDS for byte in (offset, offset + 1)}
        if not set(changed) <= allowed_bytes:
            raise ValueError("player field mutation policy")
        for offset in PRESERVED_FIELDS:
            if before[offset:offset + 2] != after[offset:offset + 2]:
                raise ValueError(f"preserved field +0x{offset:02X}")
        if stacks[1] != stacks[2]:
            raise ValueError("ACTIVE dedicated stack terminal stability")
    else:
        if mailboxes != [b"\0" * 16] * 3 or before != after or stacks[0] != stacks[1]:
            raise ValueError("CONTROL no handler/player/stack work")
        changed = []

    profile = parse_profile(prefix.with_suffix(".profile.csv"))
    watch = parse_watch(prefix.with_suffix(".watch.csv"), "interpreter")
    write_lines, write_rows = parse_trace(prefix.with_suffix(".write.trace"),
                                          "write trace", "interpreter")
    caller_lines, _ = parse_trace(prefix.with_suffix(".caller.trace"),
                                  "caller trace", "interpreter")
    master_regs = parse_regs(debug_text, "Master")
    slave_regs = parse_regs(debug_text, "Slave")
    if len(master_regs) != 3 or len(slave_regs) != 3:
        raise ValueError(f"dual-SH2 register coverage: {arm}-{repeat}")
    if "PC=0600450A" not in master_regs[-1] or "PC=0600060C" not in slave_regs[-1]:
        raise ValueError(f"terminal SH2 liveness PC: {arm}-{repeat}")
    lifecycle = [row for row in watch if row["0xFF7B40"] == "0x2"]
    if not lifecycle or lifecycle[-1]["0x2600BC64"] != "0x4" \
            or lifecycle[-1]["0x2600BC68"] != "0x2" \
            or lifecycle[-1]["0x2600BC90"] != "0x0":
        raise ValueError(f"terminal Q-027 lifecycle markers: {arm}-{repeat}")
    lifecycle_writes = [
        row for row in write_rows if row["target_addr"] == "0xFF7B40"
        and row["pc"] == "0x01C95A" and row["old_value"] == "0x01"
        and row["new_value"] == "0x02"
    ]
    if len(lifecycle_writes) != 1 or int(lifecycle_writes[0]["frame"]) != TI_EXPECTED:
        raise ValueError("interpreter lifecycle write chronology")
    terminal_scene = parse_dumps(debug_text, 0x00FF0002, 4)
    terminal_state = parse_dumps(debug_text, 0x00FFC87E, 2)
    terminal_toggle = parse_dumps(debug_text, 0x00FFC80C, 1)
    terminal_flag = parse_dumps(debug_text, 0x00FF7B40, 1)
    if len(terminal_scene) != 1 or len(terminal_state) != 1 \
            or len(terminal_toggle) != 1 or terminal_flag != [b"\x02"]:
        raise ValueError(f"terminal 68K state coverage: {arm}-{repeat}")
    return {
        "transaction_frame": TI_EXPECTED,
        "seed_sha256": hashlib.sha256(seed).hexdigest(),
        "before_sha256": hashlib.sha256(before).hexdigest(),
        "after_sha256": hashlib.sha256(after).hexdigest(),
        "changed_entity_bytes": changed,
        "comm_pre": list(pre), "comm_post": list(post),
        "protocol": protocol, "registers": registers, "direct": direct,
        "profile": profile, "watch": watch,
        "profile_sha256": sha256_path(prefix.with_suffix(".profile.csv")),
        "watch_sha256": sha256_path(prefix.with_suffix(".watch.csv")),
        "write_trace_sha256": canonical_sha256(write_lines),
        "caller_trace_sha256": canonical_sha256(caller_lines),
        "terminal_scene": terminal_scene[0].hex(),
        "terminal_state": terminal_state[0].hex(),
        "terminal_toggle": terminal_toggle[0].hex(),
        "system_snapshots_sha256": canonical_sha256([
            [value.hex() for value in adapter], [value.hex() for value in masks],
            [value.hex() for value in comms], [value.hex() for value in fbctl],
        ]),
        "master_register_snapshots": master_regs,
        "slave_register_snapshots": slave_regs,
    }


def validate_drc_one(root: Path, arm: str, repeat: int) -> dict[str, object]:
    prefix = root / f"drc-{arm}-{repeat}"
    if prefix.with_suffix(".commands").read_text() != drc_commands_text():
        raise ValueError(f"DRC uninterrupted schedule: {arm}-{repeat}")
    debug_text = prefix.with_suffix(".debug.txt").read_text()
    validate_debug_completion(debug_text, f"drc-{arm}-{repeat}")
    if parse_regs(debug_text, "Master") or parse_regs(debug_text, "Slave"):
        raise ValueError(f"DRC register/debugger observation: {arm}-{repeat}")
    profile = parse_profile(prefix.with_suffix(".profile.csv"))
    watch = parse_watch(prefix.with_suffix(".watch.csv"), "drc")
    write_lines, write_rows = parse_trace(prefix.with_suffix(".write.trace"),
                                          "write trace", "drc")
    caller_lines, _ = parse_trace(prefix.with_suffix(".caller.trace"),
                                  "caller trace", "drc")
    lifecycle = [
        row for row in write_rows if row["target_addr"] == "0xFF7B40"
        and row["pc"] == "0x01C95A" and row["old_value"] == "0x01"
        and row["new_value"] == "0x02"
    ]
    if len(lifecycle) != 1 or int(lifecycle[0]["frame"]) != TD_EXPECTED:
        raise ValueError("DRC transaction-relative T_D")
    return {
        "transaction_frame": TD_EXPECTED,
        "profile": profile, "watch": watch,
        "profile_sha256": sha256_path(prefix.with_suffix(".profile.csv")),
        "watch_sha256": sha256_path(prefix.with_suffix(".watch.csv")),
        "write_trace_sha256": canonical_sha256(write_lines),
        "caller_trace_sha256": canonical_sha256(caller_lines),
    }


def int_field(row: dict[str, str], field: str) -> int:
    return int(row[field], 0)


def validate_interpreter_pair(active: dict[str, object], control: dict[str, object]) -> list[dict[str, object]]:
    active_rows = active["profile"]
    control_rows = control["profile"]
    deltas: list[dict[str, object]] = []
    master_diffs: set[int] = set()
    slave_diffs: set[int] = set()
    crc_diffs: set[int] = set()
    for active_row, control_row in zip(active_rows, control_rows, strict=True):
        frame = int(active_row["frame"])
        if frame != int(control_row["frame"]):
            raise ValueError("interpreter paired frame order")
        for field in PROFILE_FIELDS[1:]:
            if active_row[field] == control_row[field]:
                continue
            offset = frame - TI_EXPECTED
            if field == "msh2_cycles":
                master_diffs.add(offset)
            elif field == "ssh2_cycles":
                slave_diffs.add(offset)
            elif field == "fb_crc":
                crc_diffs.add(offset)
            else:
                raise ValueError(f"interpreter unauthorized profile delta: frame={frame} {field}")
            deltas.append({
                "frame": frame, "relative": offset, "field": field,
                "active": active_row[field], "control": control_row[field],
            })
    if master_diffs != INTERPRETER_MASTER_DIFFS \
            or slave_diffs != INTERPRETER_SLAVE_DIFFS or crc_diffs != {2}:
        raise ValueError("interpreter exact mismatch positions")
    indexed_active = {int(row["frame"]): row for row in active_rows}
    indexed_control = {int(row["frame"]): row for row in control_rows}
    for offset, expected in INTERPRETER_TABLE.items():
        frame = TI_EXPECTED + offset
        arow, crow = indexed_active[frame], indexed_control[frame]
        am, cm, ass, css, acrc, ccrc, scene, state = expected
        observed = (
            int_field(arow, "msh2_cycles"), int_field(crow, "msh2_cycles"),
            int_field(arow, "ssh2_cycles"), int_field(crow, "ssh2_cycles"),
            int_field(arow, "fb_crc"), int_field(crow, "fb_crc"),
            int_field(arow, "scene"), int_field(arow, "state"),
        )
        if observed != expected or int_field(crow, "scene") != scene \
                or int_field(crow, "state") != state:
            raise ValueError(f"interpreter exact transaction table T_I+{offset}")
    for frame in range(TI_EXPECTED + 3, TI_EXPECTED + 76):
        if indexed_active[frame]["fb_crc"] != indexed_control[frame]["fb_crc"]:
            raise ValueError("interpreter displayed CRC re-divergence")
    for frame in range(TI_EXPECTED + 6, TI_EXPECTED + 76):
        if indexed_active[frame] != indexed_control[frame]:
            raise ValueError("interpreter full-profile re-divergence")
    for arow, crow in zip(active["watch"], control["watch"], strict=True):
        if any(arow[field] != crow[field] for field in DISPLAY_WATCH_FIELDS):
            raise ValueError("interpreter display/swap watch divergence")
    return deltas


def validate_drc_pair(active: dict[str, object], control: dict[str, object]) -> list[dict[str, object]]:
    active_rows = active["profile"]
    control_rows = control["profile"]
    deltas: list[dict[str, object]] = []
    for active_row, control_row in zip(active_rows, control_rows, strict=True):
        frame = int(active_row["frame"])
        if frame != int(control_row["frame"]):
            raise ValueError("DRC paired frame order")
        for field in PROFILE_FIELDS[1:]:
            if active_row[field] == control_row[field]:
                continue
            if frame != TD_EXPECTED or field not in ("msh2_cycles", "ssh2_cycles"):
                raise ValueError(f"DRC unauthorized profile delta: frame={frame} {field}")
            deltas.append({
                "frame": frame, "relative": 0, "field": field,
                "active": active_row[field], "control": control_row[field],
            })
    if [(item["field"], int(item["active"]), int(item["control"])) for item in deltas] != [
        ("msh2_cycles", DRC_ROW[0], DRC_ROW[1]),
        ("ssh2_cycles", DRC_ROW[2], DRC_ROW[3]),
    ]:
        raise ValueError("DRC exact transaction cycle delta")
    indexed_active = {int(row["frame"]): row for row in active_rows}
    indexed_control = {int(row["frame"]): row for row in control_rows}
    arow, crow = indexed_active[TD_EXPECTED], indexed_control[TD_EXPECTED]
    if (int_field(arow, "fb_crc"), int_field(crow, "fb_crc"),
            int_field(arow, "scene"), int_field(crow, "scene"),
            int_field(arow, "state"), int_field(crow, "state")) != (
                DRC_ROW[4], DRC_ROW[4], DRC_ROW[5], DRC_ROW[5], DRC_ROW[6], DRC_ROW[6]
            ):
        raise ValueError("DRC exact transaction row identity")
    for frame in range(TD_EXPECTED + 1, TD_EXPECTED + 78):
        if indexed_active[frame] != indexed_control[frame]:
            raise ValueError("DRC post-transaction re-divergence")
    if active["watch"] != control["watch"]:
        raise ValueError("DRC full watch divergence")
    return deltas


def require_same_files(root: Path, prefixes: list[str], suffixes: tuple[str, ...], label: str) -> None:
    for suffix in suffixes:
        hashes = {sha256_path(root / f"{prefix}{suffix}") for prefix in prefixes}
        if len(hashes) != 1:
            raise ValueError(f"{label} byte determinism: {suffix}")


def validate_diagnostics(root: Path, diagnostics: dict[str, object]) -> None:
    if set(diagnostics) != set(DIAGNOSTIC_SOURCES):
        raise ValueError("diagnostic archive inventory")
    for label, record in diagnostics.items():
        if record.get("eligible") is not False or not record.get("reason"):
            raise ValueError(f"diagnostic eligibility policy: {label}")
        files = record.get("files", {})
        if not files:
            raise ValueError(f"diagnostic files: {label}")
        for relative, metadata in files.items():
            path = root / "diagnostics" / label / relative
            if not path.is_file() or path.stat().st_size != metadata.get("size") \
                    or sha256_path(path) != metadata.get("sha256"):
                raise ValueError(f"diagnostic identity: {label}/{relative}")
    failed = diagnostics["failed-v3-pilot"]["files"]
    if set(failed) != set(FAILED_V3_HASHES) | {"pilot.commands"}:
        raise ValueError("failed-v3 pinned inventory")
    for name, expected in FAILED_V3_HASHES.items():
        if failed[name]["sha256"] != expected:
            raise ValueError(f"failed-v3 pinned identity: {name}")
    if failed["pilot.commands"]["sha256"] != FAILED_V3_COMMAND_HASH:
        raise ValueError("failed-v3 pinned command identity")


def require_run_contract(run: dict[str, object]) -> None:
    expected_policy = {
        "schema": SCHEMA,
        "approved_v5_sha256": APPROVED_V5_SHA256,
        "status": "CAPTURE_COMPLETE",
        "eligible": False,
        "promotable": False,
        "non_promotable": True,
        "authority_transferred": False,
        "cmd3f_promoted": False,
        "shared_lane_transport": False,
        "bridge_enabled": False,
        "collision_enabled": False,
        "cadence_changed": False,
        "fps_claim": None,
        "cpu_budget_claim": None,
        "frames": FRAMES,
        "repeats_per_arm": 2,
    }
    for key, expected in expected_policy.items():
        if run.get(key) != expected:
            raise ValueError(f"run contract: {key}")
    if run.get("roms") != {"active": ACTIVE_SHA256, "control": CONTROL_SHA256}:
        raise ValueError("run ROM identities")
    expected_modes = {
        "interpreter": {
            "sh2_drc": False,
            "schedule": [BEFORE_FRAMES, CONVERGENCE_FRAMES, TERMINAL_FRAMES],
            "mmio_mode": "q027", "watch": INTERPRETER_WATCH_SPEC,
            "write_targets": WRITE_TARGETS,
        },
        "drc": {
            "sh2_drc": True, "schedule": [FRAMES], "mmio_mode": None,
            "watch": DRC_WATCH_SPEC, "write_targets": WRITE_TARGETS,
        },
    }
    if run.get("capture_modes") != expected_modes:
        raise ValueError("capture observer/schedule contract")
    toolchain = run.get("toolchain", {})
    if toolchain.get("frontend") != FRONTEND_SHA256 or toolchain.get("core") != CORE_SHA256 \
            or toolchain.get("runtime_tool") != sha256_path(Path(__file__).resolve()) \
            or toolchain.get("interpreter_commands") != COMMAND_SHA256 \
            or toolchain.get("drc_commands") != DRC_COMMAND_SHA256:
        raise ValueError("runtime toolchain identity")


def public_interpreter_result(value: dict[str, object]) -> dict[str, object]:
    return {key: item for key, item in value.items() if key not in (
        "profile", "watch", "master_register_snapshots", "slave_register_snapshots",
    )}


def public_drc_result(value: dict[str, object]) -> dict[str, object]:
    return {key: item for key, item in value.items() if key not in ("profile", "watch")}


def validate(path: Path) -> dict[str, object]:
    result_path = path.parent / "result.json"
    result_path.unlink(missing_ok=True)
    require_command_identities()
    run = json.loads(path.read_text())
    root = path.parent
    require_run_contract(run)
    names = artifact_names()
    if set(run.get("artifacts", {})) != set(names):
        raise ValueError("artifact inventory")
    for name in names:
        metadata = run["artifacts"][name]
        if (root / name).stat().st_size != metadata["size"] \
                or sha256_path(root / name) != metadata["sha256"]:
            raise ValueError(f"artifact identity: {name}")
    validate_diagnostics(root, run.get("diagnostics", {}))

    interpreter = {
        (arm, repeat): validate_interpreter_one(root, arm, repeat)
        for arm in ARMS for repeat in REPEATS
    }
    drc = {
        (arm, repeat): validate_drc_one(root, arm, repeat)
        for arm in ARMS for repeat in REPEATS
    }

    for arm in ARMS:
        require_same_files(
            root, [f"interpreter-{arm}-1", f"interpreter-{arm}-2"],
            (".commands", ".mmio.trace", ".regs.trace", ".profile.csv", ".watch.csv",
             ".write.trace", ".caller.trace"), f"interpreter {arm} repeat",
        )
        require_same_files(
            root, [f"drc-{arm}-1", f"drc-{arm}-2"],
            (".commands", ".profile.csv", ".watch.csv", ".write.trace", ".caller.trace"),
            f"DRC {arm} repeat",
        )
        if public_interpreter_result(interpreter[(arm, 1)]) \
                != public_interpreter_result(interpreter[(arm, 2)]):
            raise ValueError(f"interpreter structured repeat determinism: {arm}")
        if public_drc_result(drc[(arm, 1)]) != public_drc_result(drc[(arm, 2)]):
            raise ValueError(f"DRC structured repeat determinism: {arm}")

    require_same_files(
        root,
        [f"interpreter-{arm}-{repeat}" for arm in ARMS for repeat in REPEATS],
        (".commands", ".write.trace", ".caller.trace"),
        "interpreter paired chronology",
    )
    require_same_files(
        root,
        [f"drc-{arm}-{repeat}" for arm in ARMS for repeat in REPEATS],
        (".commands", ".watch.csv", ".write.trace", ".caller.trace"),
        "DRC paired chronology",
    )

    interpreter_deltas: list[list[dict[str, object]]] = []
    drc_deltas: list[list[dict[str, object]]] = []
    for repeat in REPEATS:
        active, control = interpreter[("active", repeat)], interpreter[("control", repeat)]
        for key in (
            "transaction_frame", "seed_sha256", "before_sha256", "write_trace_sha256",
            "caller_trace_sha256", "terminal_scene", "terminal_state", "terminal_toggle",
            "system_snapshots_sha256", "master_register_snapshots", "slave_register_snapshots",
        ):
            if active[key] != control[key]:
                raise ValueError(f"interpreter paired {key} equivalence repeat {repeat}")
        if active["comm_pre"][1:] != control["comm_pre"][1:] \
                or active["comm_post"][1:] != control["comm_post"][1:]:
            raise ValueError(f"paired COMM1-7 equivalence repeat {repeat}")
        interpreter_deltas.append(validate_interpreter_pair(active, control))
        drc_deltas.append(validate_drc_pair(
            drc[("active", repeat)], drc[("control", repeat)]
        ))
    if interpreter_deltas[0] != interpreter_deltas[1]:
        raise ValueError("interpreter paired-delta repeat determinism")
    if drc_deltas[0] != drc_deltas[1]:
        raise ValueError("DRC paired-delta repeat determinism")

    result = {
        "schema": SCHEMA,
        "approved_v5_sha256": APPROVED_V5_SHA256,
        "status": "PASS",
        "eligible": True,
        "promotable": False,
        "non_promotable": True,
        "scope": "master_comm0_stock_dispatch_player_shadow_convergence_gate",
        "authority_transferred": False,
        "cmd3f_promoted": False,
        "shared_lane_transport": False,
        "bridge_enabled": False,
        "collision_enabled": False,
        "cadence_changed": False,
        "fps_claim": None,
        "cpu_budget_claim": None,
        "capture_sha256": sha256_path(path),
        "interpreter": {
            "transaction_frame": TI_EXPECTED,
            "displayed_crc_mismatch_relative_frames": [2],
            "displayed_crc_mismatch": {
                "frame": TI_EXPECTED + 2,
                "active": "0x344A67A6",
                "control": "0xD08BAC75",
            },
            "displayed_crc_first_equality_boundary": TI_EXPECTED + 3,
            "full_profile_first_equality_boundary": TI_EXPECTED + 6,
            "terminal_relative_frame": 75,
            "paired_deltas": interpreter_deltas[0],
        },
        "drc": {
            "transaction_frame": TD_EXPECTED,
            "displayed_crc_mismatch_relative_frames": [],
            "full_profile_first_equality_boundary": TD_EXPECTED + 1,
            "terminal_relative_frame": 77,
            "paired_deltas": drc_deltas[0],
        },
        "repeats": {
            "interpreter": {
                f"{arm}-{repeat}": public_interpreter_result(interpreter[(arm, repeat)])
                for arm in ARMS for repeat in REPEATS
            },
            "drc": {
                f"{arm}-{repeat}": public_drc_result(drc[(arm, repeat)])
                for arm in ARMS for repeat in REPEATS
            },
        },
        "diagnostics": {
            "eligible": False,
            "labels": sorted(run["diagnostics"]),
            "reason": "pre-approval proposal-shaping captures are hash-bound but ineligible",
        },
        "claim": (
            "one bounded Master-COMM0 real-stock-table $3F player-shadow invocation with "
            "exact deterministic convergence in the pinned PicoDrive fixture"
        ),
        "limitations": [
            "the interpreter capture retains one exact displayed-buffer CRC mismatch at T_I+2",
            "the result does not validate render equivalence and cannot promote command $3F",
            "the mailbox contains fixed proof sentinels, not legacy shared-lane game values",
            "no render bridge, AI, collision, authority, cadence, CPU budget, or FPS is claimed",
            "no missing/reordered emulated capture rows were observed; physical presentation is unmeasured",
            "PicoDrive observer results do not establish real-hardware timing",
        ],
    }
    result_path.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
    return result


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)
    cap = commands.add_parser("capture")
    cap.add_argument("--active", type=Path, required=True)
    cap.add_argument("--control", type=Path, required=True)
    cap.add_argument("--frontend", type=Path, required=True)
    cap.add_argument("--core", type=Path, required=True)
    cap.add_argument("--output-dir", type=Path, required=True)
    cap.add_argument("--failed-v3-commands", type=Path,
                     default=Path("/tmp/q027-pilot.commands"))
    val = commands.add_parser("validate")
    val.add_argument("run", type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        payload = capture(args) if args.command == "capture" else validate(args.run.resolve())
    except (OSError, ValueError, subprocess.SubprocessError, json.JSONDecodeError) as error:
        print(f"Q-027 runtime {args.command} FAILED: {error}")
        return 1
    print(f"Q-027 runtime {args.command}: {payload['status']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
