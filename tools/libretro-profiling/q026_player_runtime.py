#!/usr/bin/env python3
"""Capture and fail-closed validate the Q-026 normal-1P ACTIVE/CONTROL pair."""

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


SCHEMA = "vrd-vr60-q026-player-cmdint-runtime-v1"
ACTIVE_SHA256 = "c9358ad4ff04d7420c7bef1f45c163afb4506efae4990c4b48a475188e0b76f8"
CONTROL_SHA256 = "240dfd0a8df87a8118982849f354bc720b0011d480221f2031e3ceeb6dc1a66d"
FRONTEND_SHA256 = "626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50"
CORE_SHA256 = "17d16aa506cef1bc215b290b20248b458b22b54374ae342a72eb2f3c2033e906"
FRAMES = 1280
BEFORE_FRAMES = 1262
AFTER_FRAMES = 1
REPEATS = (1, 2)
ARMS = ("active", "control")
WRITE_TARGETS = "0x00ffc87e:2,0x00ff0002:4,0x00ff7b40:1"
WATCH_SPEC = (
    "0xFF7B40:1,0x2600BC04:4,0x2600BC08:4,0x2600BC0C:4,"
    "0x2600FB90:4,0x20004024:1"
)
ENTITY_ALLOWED_FIELDS = {
    0x02, 0x04, 0x06, 0x0C, 0x0E, 0x10, 0x14, 0x16,
    0x30, 0x34, 0x3C, 0x40, 0x62, 0x6A, 0x6C, 0x6E,
    0x74, 0x76, 0x78, 0x7A, 0x7E, 0x80, 0x82, 0x84,
    0x86, 0x8E, 0x90, 0x92, 0x94, 0x96, 0x98, 0x9A,
    0xAA, 0xBC, 0xE6, 0xE8, 0xEC, 0xEE, 0xF0, 0xF2,
    0xF4, 0xF6, 0xF8, 0xFA,
}
PRESERVED_FIELDS = (0xCE, 0xD2, 0xD6, 0xDA)
MMIO_COLUMNS = "sequence,frame,cpu,pc,op,address,width,value"
FATAL_MARKERS = (
    "illegal opcode", "segmentation fault", "core dumped",
    "traceback (most recent call last)", "addresssanitizer",
    "undefinedbehaviorsanitizer", "debugger command failed",
    "unknown debugger command", "# incomplete",
    "vrd_mmio_trace:",
)


def sha256_path(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def canonical_sha256(value: object) -> str:
    encoded = json.dumps(value, sort_keys=True, separators=(",", ":")).encode()
    return hashlib.sha256(encoded).hexdigest()


def sterile_env(**values: str) -> dict[str, str]:
    env = os.environ.copy()
    for name in tuple(env):
        if name.startswith("VRD_"):
            env.pop(name)
    env.update(values)
    return env


def commands_text() -> str:
    reads = (
        "read 68k 0x00FF6A00 320\n"
        "read master 0x0600F20C 320\n"
        "read master 0x2600BC00 16\n"
        "read master 0x2600FB90 4\n"
        "read master 0x2600FC00 16\n"
        "read master 0x20004022 4\n"
        "read master 0x2000402E 2\n"
        "regs master\nregs slave\n"
    )
    terminal = (
        "read 68k 0x00FF0002 4\nread 68k 0x00FFC87E 2\n"
        "read 68k 0x00FF7B40 1\n"
        "read master 0x2600BC00 16\n"
        "read master 0x2600FB90 4\nread master 0x2600FC00 16\n"
        "read master 0x20004022 4\nread master 0x2000402E 2\n"
        "regs master\nregs slave\n"
    )
    return (
        f"run {BEFORE_FRAMES}\n" + reads + f"run {AFTER_FRAMES}\n" + reads +
        f"run {FRAMES - BEFORE_FRAMES - AFTER_FRAMES}\n" + terminal + "quit\n"
    )


def run_frontend(frontend: Path, core: Path, rom: Path, prefix: Path) -> None:
    command_path = prefix.with_suffix(".commands")
    debug_path = prefix.with_suffix(".debug.txt")
    command_path.write_text(commands_text())
    env = sterile_env(
        VRD_LIBRETRO_CORE=str(core.resolve()), VRD_PROFILE_FRAMES=str(FRAMES),
        VRD_MMIO_TRACE="1", VRD_MMIO_TRACE_MODE="q026",
        VRD_MMIO_TRACE_LOG=str(prefix.with_suffix(".mmio.trace")),
        VRD_PROFILE_LOG=str(prefix.with_suffix(".profile.csv")), VRD_FB_CRC="1",
        VRD_WATCH=WATCH_SPEC, VRD_WATCH_LOG=str(prefix.with_suffix(".watch.csv")),
        VRD_WRITE_TRACE=WRITE_TARGETS,
        VRD_WRITE_TRACE_LOG=str(prefix.with_suffix(".write.trace")),
        VRD_CALLER_TRACE="00884CBC", VRD_CALLER_TRACE_MAX="0",
        VRD_CALLER_TRACE_LOG=str(prefix.with_suffix(".caller.trace")),
    )
    result = subprocess.run(
        [str(frontend.resolve()), str(rom.resolve()), str(FRAMES), "--debug", "--autoplay"],
        cwd=frontend.resolve().parent, env=env, input=command_path.read_text(), text=True,
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=180, check=False,
    )
    debug_path.write_text(result.stdout)
    if result.returncode != 0:
        raise ValueError(f"frontend failed ({result.returncode}): {debug_path.name}")


def artifact_names() -> tuple[str, ...]:
    suffixes = (
        ".commands", ".debug.txt", ".mmio.trace", ".profile.csv",
        ".watch.csv", ".write.trace", ".caller.trace",
    )
    return tuple(f"{arm}-{repeat}{suffix}" for arm in ARMS for repeat in REPEATS
                 for suffix in suffixes)


def artifact_hashes(root: Path, names: tuple[str, ...]) -> dict[str, object]:
    return {name: {"size": (root / name).stat().st_size,
                   "sha256": sha256_path(root / name)} for name in names}


def capture(args: argparse.Namespace) -> dict[str, object]:
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
    for arm, rom in (("active", args.active), ("control", args.control)):
        for repeat in REPEATS:
            run_frontend(args.frontend, args.core, rom, output / f"{arm}-{repeat}")
    diagnostics: dict[str, object] = {}
    for label, path, expected in (
        ("failed_pilot_watch", args.failed_pilot_watch,
         "5b506f2d4da0079293f1735bc059eefffa21257517b86d83be265f169306d427"),
        ("failed_pilot_log", args.failed_pilot_log,
         "b56f839bee2af09953c83dd85fdc0cc8912c65710a1b599189099417c42f2e6b"),
    ):
        if not path.is_file() or sha256_path(path) != expected:
            raise ValueError(f"failed pilot identity: {path}")
        destination = output / path.name
        shutil.copy2(path, destination)
        diagnostics[label] = {"path": destination.name, "sha256": expected,
                              "size": destination.stat().st_size}
    payload = {
        "schema": SCHEMA, "status": "CAPTURE_COMPLETE", "eligible": False,
        "promotable": False, "non_promotable": True,
        "scope": "bounded_direct_cmdint_player_physics_precursor",
        "authority_transferred": False, "cmd3f_enabled": False,
        "bridge_enabled": False, "collision_enabled": False,
        "cadence_changed": False, "organic_gameplay": True,
        "fixture": "trustworthy_normal_1p_autoplay_from_boot",
        "frames": FRAMES, "repeats_per_arm": 2,
        "roms": {"active": ACTIVE_SHA256, "control": CONTROL_SHA256},
        "toolchain": {"frontend": FRONTEND_SHA256, "core": CORE_SHA256},
        "failed_pilot_diagnostics": diagnostics,
        "artifacts": artifact_hashes(output, artifact_names()),
    }
    (output / "run.json").write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    return payload


def parse_mmio(path: Path) -> tuple[list[dict[str, object]], dict[str, object]]:
    lines = path.read_text().splitlines()
    if len(lines) < 4 or "pc_allowlist=m68k:0x0001C6FE-0x0001C76C|" not in lines[0] \
            or lines[1] != (
                "# FILTER q026_direct=1 m68k_system=0x00A15100-0x00A1513F "
                "master_system=0x20004000-0x2000403F "
                "master_peripheral=0xFFFFFE00-0xFFFFFFFF "
                "master_sdram=all_writes master_framebuffer=all_writes"
            ) or lines[2] != MMIO_COLUMNS:
        raise ValueError(f"MMIO header: {path.name}")
    footer = lines[-1]
    if not footer.startswith(f"# COMPLETE frames={FRAMES} "):
        raise ValueError(f"MMIO completion: {path.name}")
    fields = dict(re.findall(r"([a-z0-9_]+)=([^ ]+)", footer))
    for key in ("dropped", "errors", "overflow"):
        if fields.get(key) != "0":
            raise ValueError(f"MMIO {key}: {path.name}")
    if fields.get("direct_m68k") != "1" or fields.get("direct_master") != "1" \
            or fields.get("observer_detached") != "1":
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
    if int(fields.get("events", "-1")) != len(rows) or fields.get("events") != fields.get("recorded"):
        raise ValueError(f"MMIO count: {path.name}")
    return rows, fields


def event(row: dict[str, object], cpu: str, pc: int, op: str, address: int,
          width: int, value: int | None = None) -> bool:
    return (row["cpu"], row["pc"], row["op"], row["address"], row["width"]) == \
        (cpu, pc, op, address, width) and (value is None or row["value"] == value)


def validate_seed(rows: list[dict[str, object]]) -> bytes:
    len_events = [r for r in rows if event(r, "m68k", 0x1C70A, "write", 0xA15110, 2, 0xA0)]
    fifo = [r for r in rows if event(r, "m68k", 0x1C762, "write", 0xA15112, 2)]
    destination = [r for r in rows if r["cpu"] == "master" and
                   r["pc"] == 0x2301714 and r["op"] == "write"
                   and 0x0600F20C <= int(r["address"]) < 0x0600F34C]
    provenance = [r for r in rows if event(
        r, "master", 0x23016B0, "write", 0x2600FC00, 4, 0x20004020
    )]
    if len(len_events) != 1 or len(fifo) != 32 or len(destination) != 160 \
            or len(provenance) != 1:
        raise ValueError("exactly one mode-0 seed lifecycle")
    if [int(r["address"]) for r in destination] != list(range(0x0600F20C, 0x0600F34C, 2)):
        raise ValueError("mode-0 destination chronology")
    fifo_bytes = b"".join(int(r["value"]).to_bytes(2, "big") for r in fifo)
    destination_bytes = b"".join(int(r["value"]).to_bytes(2, "big") for r in destination)
    if fifo_bytes != destination_bytes[-len(fifo_bytes):]:
        raise ValueError("mode-0 observed FIFO tail/destination payload")
    return destination_bytes


def parse_dumps(text: str, address: int, size: int) -> list[bytes]:
    lines = text.splitlines()
    outputs: list[bytes] = []
    for start, line in enumerate(lines):
        if not re.search(rf"(?:^|> ){address:08X}:", line):
            continue
        output = bytearray()
        cursor = address
        for current in lines[start:]:
            match = re.search(r"([0-9A-F]{8}):((?: [0-9A-F]{2})+)\Z", current)
            if not match or int(match.group(1), 16) != cursor:
                break
            data = bytes(int(value, 16) for value in match.group(2).split())
            output.extend(data); cursor += len(data)
            if len(output) >= size:
                outputs.append(bytes(output[:size])); break
    return outputs


def parse_regs(text: str, cpu: str) -> list[str]:
    pattern = rf"{cpu} SH2: PC=[\s\S]*?(?=vrd-dbg>|\n\s*{('Slave' if cpu == 'Master' else 'Master')} SH2:|\Z)"
    return [re.sub(r"\s+", " ", match.group(0)).strip()
            for match in re.finditer(pattern, text)]


def parse_profile(path: Path) -> list[dict[str, str]]:
    with path.open() as stream:
        rows = list(csv.DictReader(stream))
    if len(rows) != FRAMES - 2 or [int(r["frame"]) for r in rows] != list(range(2, FRAMES)):
        raise ValueError(f"profile coverage: {path.name}")
    return rows


def parse_watch(path: Path) -> list[dict[str, str]]:
    with path.open() as stream:
        rows = list(csv.DictReader(stream))
    if len(rows) != FRAMES - 1 or [int(r["frame"]) for r in rows] != list(range(1, FRAMES)):
        raise ValueError(f"watch coverage: {path.name}")
    return rows


def parse_simple_trace(path: Path, kind: str) -> list[str]:
    lines = path.read_text().splitlines()
    if not lines or not lines[-1].startswith(f"# COMPLETE frames={FRAMES} ") \
            or "errors=0" not in lines[-1]:
        raise ValueError(f"{kind} completion: {path.name}")
    return lines


def words(value: str) -> tuple[int, int, int]:
    parts = value.split("/")
    if len(parts) != 3:
        raise ValueError("COMM snapshot encoding")
    return tuple(int(part, 16) for part in parts)  # type: ignore[return-value]


def native_sdram(address: int) -> int:
    return address - 0x20000000 if 0x26000000 <= address < 0x26040000 else address


def validate_one(root: Path, arm: str, repeat: int) -> dict[str, object]:
    prefix = root / f"{arm}-{repeat}"
    debug_text = prefix.with_suffix(".debug.txt").read_text()
    lowered = debug_text.lower()
    for marker in FATAL_MARKERS:
        if marker in lowered:
            raise ValueError(f"fatal runtime marker {marker}: {arm}-{repeat}")
    if re.search(r"\d{5}:\d{3}: 32X shutdown\n"
                 r"Profile data written to: .+\n?\Z", debug_text) is None:
        raise ValueError(f"terminal shutdown: {arm}-{repeat}")
    rows, footer = parse_mmio(prefix.with_suffix(".mmio.trace"))
    seed = validate_seed(rows)
    edge_writes = [r for r in rows if event(
        r, "m68k", 0x1C8F4, "write", 0xA15103, 1, 1
    )]
    isr_writes = [r for r in rows if r["op"] == "write" and
                  0x02304000 <= int(r["pc"]) < 0x02304290]
    handler_writes = [r for r in rows if r["op"] == "write" and (
        0x02301500 <= int(r["pc"]) < 0x023015C8 or
        0x023017C0 <= int(r["pc"]) < 0x023025E0
    )]
    if arm == "active":
        if len(edge_writes) != 1 or footer.get("q026_edge_snapshots") != "1":
            raise ValueError("ACTIVE exact edge/snapshot")
        pre, post = words(footer["q026_comm_pre"]), words(footer["q026_comm_post"])
        if pre != post or (pre[1] >> 8) != 0:
            raise ValueError("COMM1/2/7 preservation or COMM2_HI admission")
        if not isr_writes or not handler_writes:
            raise ValueError("ACTIVE direct handler coverage")
    else:
        if edge_writes or isr_writes or handler_writes \
                or footer.get("q026_edge_snapshots") != "0":
            raise ValueError("CONTROL direct work")
        pre = post = (0, 0, 0)

    if arm == "active":
        direct_writes = isr_writes + handler_writes
        direct_writes.sort(key=lambda row: int(row["sequence"]))
        for row in direct_writes:
            raw_address, width = int(row["address"]), int(row["width"])
            address = native_sdram(raw_address)
            end = address + width
            allowed = (
                0x0600BC00 <= address and end <= 0x0600BC10 or
                0x0600FB90 <= address and end <= 0x0600FC00 or
                0x0600FC04 <= address and end <= 0x0600FC10 or
                0x0600FED0 <= address and end <= 0x0600FF80 or
                address in (0x20004000, 0x2000401A, 0xFFFFFE17) or
                (0x0600F20C <= address and end <= 0x0600F30C and
                 width == 2 and address - 0x0600F20C in ENTITY_ALLOWED_FIELDS) or
                (address == 0x0600F30C and width == 2) or
                (address == 0x0600F338 and width == 1)
            )
            if not allowed:
                raise ValueError(f"out-of-range direct write 0x{raw_address:08X}")
        markers = [(int(r["address"]), int(r["value"])) for r in direct_writes
                   if int(r["address"]) in (0x2600BC08, 0x2600BC04, 0x2600FB90,
                                             0x2600FC04, 0x2600FC08, 0x2600BC0C)]
        expected_markers = [
            (0x2600BC08, 1), (0x2600BC04, 1), (0x2600FB90, 0x5132534B),
            (0x2600FC04, 0x51323645), (0x2600FC08, 0x51323643),
            (0x2600BC0C, 1), (0x2600BC04, 2),
        ]
        if markers != expected_markers:
            raise ValueError(f"ordered markers: {markers}")
        canary_index = next(i for i, row in enumerate(direct_writes)
                            if int(row["address"]) == 0x2600FB90)
        stack_index = next(i for i, row in enumerate(direct_writes)
                           if 0x0600FB94 <= native_sdram(int(row["address"])) < 0x0600FC00)
        if canary_index >= stack_index:
            raise ValueError("canary must precede dedicated stack")

    source_dumps = parse_dumps(debug_text, 0x00FF6A00, 320)
    destination_dumps = parse_dumps(debug_text, 0x0600F20C, 320)
    traces = parse_dumps(debug_text, 0x2600BC00, 16)
    canaries = parse_dumps(debug_text, 0x2600FB90, 4)
    sentinels = parse_dumps(debug_text, 0x2600FC00, 16)
    comm1_2 = parse_dumps(debug_text, 0x20004022, 4)
    comm7 = parse_dumps(debug_text, 0x2000402E, 2)
    if not all(len(values) == expected for values, expected in (
        (source_dumps, 2), (destination_dumps, 2), (traces, 3),
        (canaries, 3), (sentinels, 3), (comm1_2, 3), (comm7, 3),
    )):
        raise ValueError(f"debug dump coverage: {arm}-{repeat}")
    before, after = destination_dumps
    if source_dumps[0] != source_dumps[1] or before != seed or source_dumps[0] != seed:
        raise ValueError("exact 320-byte handler input")
    if arm == "active":
        allowed_bytes = {byte for offset in ENTITY_ALLOWED_FIELDS for byte in (offset, offset + 1)}
        allowed_bytes.update((0x100, 0x101, 0x12C))
        changed = {index for index, pair in enumerate(zip(before, after, strict=True))
                   if pair[0] != pair[1]}
        if not changed or not changed <= allowed_bytes:
            raise ValueError(f"player field mutation policy: {sorted(changed)}")
        for offset in PRESERVED_FIELDS:
            if before[offset:offset + 2] != after[offset:offset + 2]:
                raise ValueError(f"preserved field +0x{offset:02X}")
        if traces[0] != bytes.fromhex("51323649000000000000000000000000") \
                or traces[1] != bytes.fromhex("51323649000000020000000100000001") \
                or canaries[0] != b"\0" * 4 or canaries[1:] != [bytes.fromhex("5132534B")] * 2 \
                or sentinels[0] != bytes.fromhex("20004020") + b"\0" * 12 \
                or sentinels[1:] != [bytes.fromhex("20004020513236455132364300000000")] * 2:
            raise ValueError("ACTIVE before/after marker dumps")
    else:
        if before != after or traces != [bytes.fromhex("51323649") + b"\0" * 12] * 3 \
                or canaries != [b"\0" * 4] * 3 \
                or sentinels != [bytes.fromhex("20004020") + b"\0" * 12] * 3:
            raise ValueError("CONTROL no-direct-work dumps")

    profile = parse_profile(prefix.with_suffix(".profile.csv"))
    watch = parse_watch(prefix.with_suffix(".watch.csv"))
    write_trace = parse_simple_trace(prefix.with_suffix(".write.trace"), "write trace")
    caller_trace = parse_simple_trace(prefix.with_suffix(".caller.trace"), "caller trace")
    master_regs, slave_regs = parse_regs(debug_text, "Master"), parse_regs(debug_text, "Slave")
    if len(master_regs) != 3 or len(slave_regs) != 3:
        raise ValueError(f"dual-SH2 register coverage: {arm}-{repeat}")
    watch_equivalence = [
        (row["frame"], row["0xFF7B40"], row["0x20004024"])
        for row in watch
    ]
    lifecycle_rows = [row for row in watch if row["0xFF7B40"] == "0x2"]
    if not lifecycle_rows:
        raise ValueError(f"Q-026 lifecycle not reached: {arm}-{repeat}")
    terminal_watch = lifecycle_rows[-1]
    if arm == "active":
        expected = {
            "0x2600BC04": "0x2",
            "0x2600BC08": "0x1", "0x2600BC0C": "0x1",
            "0x2600FB90": "0x5132534B",
        }
    else:
        expected = {
            "0x2600BC04": "0x0",
            "0x2600BC08": "0x0", "0x2600BC0C": "0x0",
            "0x2600FB90": "0x0",
        }
    if any(terminal_watch[key] != value for key, value in expected.items()):
        raise ValueError(f"terminal Q-026 lifecycle markers: {arm}-{repeat}")
    profile_equivalence = [
        (r["fb_crc"], r["scene"], r["state"], r["ssh2_cycles"])
        for r in profile
    ]
    return {
        "seed_sha256": hashlib.sha256(seed).hexdigest(),
        "before_sha256": hashlib.sha256(before).hexdigest(),
        "after_sha256": hashlib.sha256(after).hexdigest(),
        "changed_entity_bytes": sorted(
            i for i, pair in enumerate(zip(before, after, strict=True)) if pair[0] != pair[1]
        ),
        "edge_events": len(edge_writes), "isr_writes": len(isr_writes),
        "handler_writes": len(handler_writes), "comm_pre": list(pre), "comm_post": list(post),
        "profile_equivalence_sha256": canonical_sha256(profile_equivalence),
        "watch_equivalence_sha256": canonical_sha256(watch_equivalence),
        "write_trace_sha256": canonical_sha256(write_trace),
        "caller_trace_sha256": canonical_sha256(caller_trace),
        "terminal_watch": {key: terminal_watch[key] for key in expected},
        "terminal_master": master_regs[-1], "terminal_slave": slave_regs[-1],
        "debug_comm1_2": [value.hex() for value in comm1_2],
        "debug_comm7": [value.hex() for value in comm7],
    }


def validate(path: Path) -> dict[str, object]:
    run = json.loads(path.read_text())
    root = path.parent
    if run.get("schema") != SCHEMA or run.get("status") != "CAPTURE_COMPLETE" \
            or run.get("roms") != {"active": ACTIVE_SHA256, "control": CONTROL_SHA256} \
            or run.get("toolchain") != {"frontend": FRONTEND_SHA256, "core": CORE_SHA256}:
        raise ValueError("run contract")
    expected_artifacts = artifact_names()
    if set(run.get("artifacts", {})) != set(expected_artifacts):
        raise ValueError("artifact inventory")
    for name in expected_artifacts:
        metadata = run["artifacts"][name]
        if (root / name).stat().st_size != metadata["size"] \
                or sha256_path(root / name) != metadata["sha256"]:
            raise ValueError(f"artifact identity: {name}")
    results = {(arm, repeat): validate_one(root, arm, repeat)
               for arm in ARMS for repeat in REPEATS}
    for repeat in REPEATS:
        active, control = results[("active", repeat)], results[("control", repeat)]
        for key in ("seed_sha256", "before_sha256", "profile_equivalence_sha256",
                    "watch_equivalence_sha256", "write_trace_sha256",
                    "caller_trace_sha256", "terminal_master", "terminal_slave",
                    "debug_comm1_2", "debug_comm7"):
            if active[key] != control[key]:
                raise ValueError(f"paired {key} equivalence repeat {repeat}")
    for arm in ARMS:
        left, right = results[(arm, 1)], results[(arm, 2)]
        if left != right:
            raise ValueError(f"repeat determinism: {arm}")
    result = {
        "schema": SCHEMA, "status": "PASS", "eligible": True,
        "promotable": False, "non_promotable": True,
        "scope": "bounded_direct_cmdint_player_physics_precursor",
        "authority_transferred": False, "cmd3f_enabled": False,
        "bridge_enabled": False, "collision_enabled": False,
        "cadence_changed": False, "fps_claim": None,
        "capture_sha256": sha256_path(path),
        "repeats": {f"{arm}-{repeat}": results[(arm, repeat)]
                    for arm in ARMS for repeat in REPEATS},
        "limitations": [
            "Q-026 validates one bounded direct player-physics CMDINT invocation only",
            "cmd $3F shadow, render bridge, collision/equivalence, authority, cadence, and FPS remain open",
            "COMM2_HI is proven zero at the exact ACTIVE edge; unrelated renderer traffic may be busy at frame boundaries",
            "startup canary persistence was disproven by the retained failed pilot; admission-local refresh is validated",
        ],
    }
    output = root / "result.json"
    output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
    return result


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    cap = sub.add_parser("capture")
    cap.add_argument("--active", type=Path, required=True)
    cap.add_argument("--control", type=Path, required=True)
    cap.add_argument("--frontend", type=Path, required=True)
    cap.add_argument("--core", type=Path, required=True)
    cap.add_argument("--output-dir", type=Path, required=True)
    cap.add_argument("--failed-pilot-watch", type=Path,
                     default=Path("/tmp/q026-active-watch.csv"))
    cap.add_argument("--failed-pilot-log", type=Path,
                     default=Path("/tmp/q026-active-pilot.txt"))
    val = sub.add_parser("validate")
    val.add_argument("run", type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        payload = capture(args) if args.command == "capture" else validate(args.run.resolve())
    except (OSError, ValueError, subprocess.SubprocessError, json.JSONDecodeError) as error:
        print(f"Q-026 runtime {args.command} FAILED: {error}")
        return 1
    print(f"Q-026 runtime {args.command}: {payload['status']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
