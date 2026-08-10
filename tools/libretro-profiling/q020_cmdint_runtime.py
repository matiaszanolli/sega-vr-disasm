#!/usr/bin/env python3
"""Capture and fail-closed validate the non-promotable Q-020 CMDINT probe."""

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


SCHEMA = "vrd-vr60-q020-cmdint-runtime-v1"
PROBE_SHA256 = "a8814b3392bedec01fbd6f5719e12a186c75f98de2fd7b9806af12be108f2783"
DEFAULT_SHA256 = "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900"
Q020_FRONTEND_SHA256 = "626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50"
Q020_CORE_SHA256 = "b2fe478891e8cb5299fefc22bb908a67b80a804df379f7724ed212c0e1b1a333"
CANONICAL_FRONTEND_SHA256 = "cf93393318db52a1d0071b35c708bf10710ed6dfbc617c22e8e339eedac87e9f"
CANONICAL_CORE_SHA256 = "5677ea8e083f887b2b4e9cabf84dd559a9c6b1180adfa09f34a50023ff7548e8"
NAME_SOURCE_SHA256 = "c1ede354178c8ffa0796f1e243d8ae592dbd38dad4c44ad9336fece8503b22f0"
NAME_SOURCE_SIZE = 679161

TRACE_ADDRESS = 0x2600BC20
TRACE_SIZE = 64
WRAM_STATE_OFFSET = 0x76
NORMAL_FRAMES = 1260
NAME_FRAMES = 190
WRITE_TARGETS = "0x00ffc87e:2,0x00ff0002:4,0x00ff7b41:1"


def sha256_path(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def raw_words(guest_bytes: bytes) -> bytes:
    """Convert guest big-endian bytes to PicoDrive's serialized u16 layout."""
    if len(guest_bytes) % 2:
        raise ValueError("serialized conversion requires whole words")
    return b"".join(
        guest_bytes[offset : offset + 2][::-1]
        for offset in range(0, len(guest_bytes), 2)
    )


def prepare_name_fixture(source: Path, output: Path) -> list[dict[str, object]]:
    """Rebind one pinned default state and seed only reviewed route prerequisites."""
    if source.stat().st_size != NAME_SOURCE_SIZE or sha256_path(source) != NAME_SOURCE_SHA256:
        raise ValueError("name source fixture identity")
    image = bytearray(source.read_bytes())
    changes: list[dict[str, object]] = []

    def replace(offset: int, expected: bytes, replacement: bytes, reason: str) -> None:
        if image[offset : offset + len(expected)] != expected:
            raise ValueError(f"name fixture preimage: {reason}")
        image[offset : offset + len(expected)] = replacement
        changes.append(
            {
                "offset": offset,
                "size": len(expected),
                "before": expected.hex(),
                "after": replacement.hex(),
                "reason": reason,
            }
        )

    default_vectors = raw_words(bytes.fromhex("060006ac") * 16)
    vector_offset = image.find(default_vectors)
    if vector_offset < 0 or image.find(default_vectors, vector_offset + 1) >= 0:
        raise ValueError("name fixture Master vector table is not unique")
    replace(
        vector_offset,
        default_vectors,
        raw_words(bytes.fromhex("02303b00") * 16),
        "rebind all Master external vectors to probe ISR",
    )
    replace(
        vector_offset + 0x380,
        raw_words(bytes.fromhex("060045cc")),
        raw_words(bytes.fromhex("02303c50")),
        "rebind Master startup literal to probe shim",
    )
    trace = bytearray(TRACE_SIZE)
    trace[0:4] = bytes.fromhex("51323050")
    trace[44:48] = (1).to_bytes(4, "big")
    trace[48:52] = bytes.fromhex("aecdcfaf")
    replace(
        vector_offset + 0xBB20,
        b"\0" * TRACE_SIZE,
        raw_words(trace),
        "initialize probe trace exactly as one completed startup-shim call",
    )

    base = WRAM_STATE_OFFSET
    replace(
        base + 0xC210,
        raw_words(bytes.fromhex("cccc0ccc")),
        raw_words(bytes.fromhex("00010000")),
        "seed fifth score non-sentinel (diagnostic route prerequisite)",
    )
    replace(
        base + 0xA042,
        raw_words(bytes.fromhex("0001")),
        raw_words(bytes.fromhex("0000")),
        "match name-dispatch A042 result for seeded fifth score",
    )
    replace(
        base + 0x7B41,
        b"\x01",
        b"\x00",
        "arm diagnostic one-shot in loaded fixture",
    )
    if image[base + 2 : base + 6] != raw_words(bytes.fromhex("00891122")):
        raise ValueError("name fixture is not at the pinned name-entry dispatcher")
    if image[base + 0xA019] != 0:
        raise ValueError("name fixture A019 precondition")
    output.write_bytes(image)
    return changes


def sterile_env(**values: str) -> dict[str, str]:
    env = os.environ.copy()
    for name in tuple(env):
        if name.startswith("VRD_"):
            env.pop(name)
    env.update(values)
    return env


def run_frontend(
    frontend: Path,
    rom: Path,
    frames: int,
    output: Path,
    *,
    core: Path,
    extra_args: list[str] | None = None,
    env_values: dict[str, str] | None = None,
    input_text: str | None = None,
) -> None:
    frontend = frontend.resolve()
    rom = rom.resolve()
    core = core.resolve()
    args = [str(frontend), str(rom), str(frames)] + (extra_args or [])
    env = sterile_env(VRD_LIBRETRO_CORE=str(core), **(env_values or {}))
    result = subprocess.run(
        args,
        cwd=frontend.parent,
        env=env,
        input=input_text,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        timeout=180,
        check=False,
    )
    output.write_text(result.stdout)
    if result.returncode != 0:
        raise ValueError(f"frontend failed ({result.returncode}): {output.name}")


def write_name_input(path: Path) -> None:
    with path.open("x", newline="") as stream:
        writer = csv.writer(stream, lineterminator="\n")
        writer.writerow(("frame", "mask"))
        for frame in range(NAME_FRAMES):
            writer.writerow((frame, "0x0100" if 5 <= frame < 10 else "0x0000"))


def artifact_hashes(directory: Path, names: list[str]) -> dict[str, dict[str, object]]:
    return {
        name: {
            "path": name,
            "size": (directory / name).stat().st_size,
            "sha256": sha256_path(directory / name),
        }
        for name in names
    }


def capture(args: argparse.Namespace) -> dict[str, object]:
    output = args.output_dir.resolve()
    if output.exists():
        raise ValueError("output directory already exists")
    for path in (
        args.rom,
        args.default,
        args.frontend,
        args.core,
        args.canonical_frontend,
        args.canonical_core,
        args.name_source_state,
    ):
        if not path.is_file():
            raise ValueError(f"missing input: {path}")
    expected = {
        args.rom: PROBE_SHA256,
        args.default: DEFAULT_SHA256,
        args.frontend: Q020_FRONTEND_SHA256,
        args.core: Q020_CORE_SHA256,
        args.canonical_frontend: CANONICAL_FRONTEND_SHA256,
        args.canonical_core: CANONICAL_CORE_SHA256,
    }
    for path, digest in expected.items():
        if sha256_path(path) != digest:
            raise ValueError(f"tool/input identity: {path}")

    output.mkdir(parents=True)
    source_copy = output / "name-source.mds"
    shutil.copy2(args.name_source_state, source_copy)
    prepared = output / "name-route-seeded.mds"
    fixture_changes = prepare_name_fixture(source_copy, prepared)
    name_input = output / "name-input.csv"
    write_name_input(name_input)

    debug_commands = (
        "run 11\nread master 0x2600BC20 64\nregs master\n"
        "run 1230\nread master 0x2600BC20 64\nregs master\n"
        "reset\nrun 30\nread master 0x2600BC20 64\nregs master\nquit\n"
    )
    (output / "cold-normal-vres.commands").write_text(debug_commands)
    run_frontend(
        args.frontend,
        args.rom,
        1300,
        output / "cold-normal-vres.log",
        core=args.core,
        extra_args=["--debug", "--autoplay"],
        input_text=debug_commands,
    )

    negative_commands = (
        "run 1241\nread master 0x2600BC20 64\n"
        "read 68k 0x00FF7B41 1\nregs master\nquit\n"
    )
    (output / "unpatched-core-comparison.commands").write_text(negative_commands)
    run_frontend(
        args.frontend,
        args.rom,
        1300,
        output / "unpatched-core-comparison.log",
        core=args.canonical_core,
        extra_args=["--debug", "--autoplay"],
        input_text=negative_commands,
    )

    normal_write = output / "normal-write.log"
    run_frontend(
        args.frontend,
        args.rom,
        NORMAL_FRAMES,
        output / "normal-run.log",
        core=args.core,
        extra_args=["--autoplay"],
        env_values={
            "VRD_PROFILE_MAX_FRAMES": str(NORMAL_FRAMES),
            "VRD_WRITE_TRACE": WRITE_TARGETS,
            "VRD_WRITE_TRACE_LOG": str(normal_write),
        },
    )

    name_commands = (
        "run 190\nread 68k 0x00FF0002 4\nread 68k 0x00FF7B41 1\n"
        "read master 0x2600BC20 64\nregs master\nquit\n"
    )
    (output / "name.commands").write_text(name_commands)
    run_frontend(
        args.frontend,
        args.rom,
        NAME_FRAMES,
        output / "name-debug.log",
        core=args.core,
        extra_args=["--debug"],
        env_values={
            "VRD_LOAD_STATE": str(prepared),
            "VRD_INPUT_SCRIPT": str(name_input),
        },
        input_text=name_commands,
    )
    name_write = output / "name-write.log"
    run_frontend(
        args.frontend,
        args.rom,
        NAME_FRAMES,
        output / "name-run.log",
        core=args.core,
        env_values={
            "VRD_LOAD_STATE": str(prepared),
            "VRD_INPUT_SCRIPT": str(name_input),
            "VRD_PROFILE_MAX_FRAMES": str(NAME_FRAMES),
            "VRD_WRITE_TRACE": WRITE_TARGETS,
            "VRD_WRITE_TRACE_LOG": str(name_write),
        },
    )

    artifact_names = [
        "name-source.mds",
        "name-route-seeded.mds",
        "name-input.csv",
        "cold-normal-vres.commands",
        "cold-normal-vres.log",
        "unpatched-core-comparison.commands",
        "unpatched-core-comparison.log",
        "normal-run.log",
        "normal-write.log",
        "name.commands",
        "name-debug.log",
        "name-run.log",
        "name-write.log",
    ]
    payload: dict[str, object] = {
        "schema": SCHEMA,
        "status": "CAPTURED_UNVALIDATED",
        "non_promotable": True,
        "organic_gameplay": False,
        "evidence_scope": "diagnostic_route_feasibility",
        "rom": {"path": str(args.rom.resolve()), "sha256": PROBE_SHA256},
        "default_rom": {"path": str(args.default.resolve()), "sha256": DEFAULT_SHA256},
        "toolchain": {
            "q020_frontend": {"path": str(args.frontend.resolve()), "sha256": Q020_FRONTEND_SHA256},
            "q020_core": {"path": str(args.core.resolve()), "sha256": Q020_CORE_SHA256},
            "canonical_frontend": {
                "path": str(args.canonical_frontend.resolve()),
                "sha256": CANONICAL_FRONTEND_SHA256,
            },
            "canonical_core": {
                "path": str(args.canonical_core.resolve()),
                "sha256": CANONICAL_CORE_SHA256,
            },
        },
        "name_fixture": {
            "source_path": "name-source.mds",
            "source_origin": str(args.name_source_state.resolve()),
            "source_sha256": NAME_SOURCE_SHA256,
            "seeded": True,
            "changes": fixture_changes,
        },
        "expected_chronology": {
            "cold_init_count": 1,
            "normal_installer_pc": "0x0088E0D4",
            "normal_cmd_event": 2,
            "vres_event": 3,
            "post_vres_boot_cmd_event": 4,
            "post_vres_init_count": 3,
            "post_vres_stock_pc": "0x06000452",
            "name_installer_pc": "0x00891822",
        },
        "artifacts": artifact_hashes(output, artifact_names),
    }
    (output / "run.json").write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    return payload


def parse_trace_dumps(text: str) -> list[dict[str, int]]:
    lines = text.splitlines()
    dumps: list[dict[str, int]] = []
    for index, line in enumerate(lines):
        if "2600BC20:" not in line:
            continue
        raw = bytearray()
        for part, address in enumerate(("2600BC20:", "2600BC30:", "2600BC40:", "2600BC50:")):
            current = lines[index + part] if index + part < len(lines) else ""
            if address not in current:
                raise ValueError("incomplete trace dump")
            values = re.findall(r"\b[0-9A-F]{2}\b", current.split(address, 1)[1])
            if len(values) != 16:
                raise ValueError("malformed trace dump")
            raw.extend(int(value, 16) for value in values)
        words = [int.from_bytes(raw[offset : offset + 4], "big") for offset in range(0, 64, 4)]
        keys = (
            "magic", "phase", "sequence", "cmd_count", "vres_count", "error",
            "sr", "spc", "pre_mask", "comm01", "event", "init_count", "inverse",
            "reserved0", "reserved1", "reserved2",
        )
        dumps.append(dict(zip(keys, words, strict=True)))
    return dumps


def parse_write_trace(path: Path, frames: int) -> list[dict[str, int]]:
    lines = path.read_text().splitlines()
    if len(lines) < 7 or not lines[0].startswith("# VRD_WRITE_TRACE version=3 "):
        raise ValueError(f"write trace header: {path.name}")
    expected_targets = [
        "# TARGET index=0 addr=0xFFC87E size=2",
        "# TARGET index=1 addr=0xFF0002 size=4",
        "# TARGET index=2 addr=0xFF7B41 size=1",
    ]
    if lines[1:4] != expected_targets:
        raise ValueError(f"write trace targets: {path.name}")
    if lines[4] != "frame,pc,target_addr,target_size,access_addr,access_size,old_value,new_value":
        raise ValueError(f"write trace CSV header: {path.name}")
    terminal = re.fullmatch(r"# COMPLETE frames=(\d+) events=(\d+) errors=(\d+)", lines[-1])
    if not terminal or int(terminal.group(1)) != frames or int(terminal.group(3)) != 0:
        raise ValueError(f"write trace terminal: {path.name}")
    rows: list[dict[str, int]] = []
    reader = csv.DictReader(lines[4:-1])
    for row in reader:
        if row.keys() != {
            "frame", "pc", "target_addr", "target_size", "access_addr",
            "access_size", "old_value", "new_value",
        }.keys():
            raise ValueError(f"write trace row schema: {path.name}")
        rows.append({key: int(value, 0) for key, value in row.items()})
    if len(rows) != int(terminal.group(2)):
        raise ValueError(f"write trace event count: {path.name}")
    return rows


def require_trace(trace: dict[str, int], **expected: int) -> None:
    for key, value in expected.items():
        if trace.get(key) != value:
            raise ValueError(f"trace {key}: expected 0x{value:X}, got 0x{trace.get(key, -1):X}")


def require_route(rows: list[dict[str, int]], pc: int, old: int) -> None:
    route = [
        row for row in rows
        if row["pc"] == pc and row["target_addr"] == 0xFF0002
        and row["target_size"] == 4 and row["old_value"] == old
        and row["new_value"] == 0x0089C914
    ]
    if len(route) != 1:
        raise ValueError(f"route installer 0x{pc:08X}")
    oneshot = [
        row for row in rows
        if row["pc"] == 0x0089C91C and row["target_addr"] == 0xFF7B41
        and row["target_size"] == 1 and row["old_value"] == 0
        and row["new_value"] == 1
    ]
    if len(oneshot) != 1 or oneshot[0]["frame"] != route[0]["frame"]:
        raise ValueError("route one-shot chronology")


def validate(run_path: Path) -> dict[str, object]:
    run_path = run_path.resolve()
    payload = json.loads(run_path.read_text())
    if payload.get("schema") != SCHEMA or payload.get("status") != "CAPTURED_UNVALIDATED":
        raise ValueError("run schema/status")
    if payload.get("non_promotable") is not True or payload.get("organic_gameplay") is not False:
        raise ValueError("runtime scope flags")
    if payload.get("evidence_scope") != "diagnostic_route_feasibility":
        raise ValueError("runtime evidence scope")
    if payload.get("rom", {}).get("sha256") != PROBE_SHA256:
        raise ValueError("probe ROM identity")
    if payload.get("default_rom", {}).get("sha256") != DEFAULT_SHA256:
        raise ValueError("default ROM identity")
    toolchain = payload.get("toolchain", {})
    required_tools = {
        "q020_frontend": Q020_FRONTEND_SHA256,
        "q020_core": Q020_CORE_SHA256,
        "canonical_frontend": CANONICAL_FRONTEND_SHA256,
        "canonical_core": CANONICAL_CORE_SHA256,
    }
    for name, digest in required_tools.items():
        if toolchain.get(name, {}).get("sha256") != digest:
            raise ValueError(f"toolchain identity: {name}")

    directory = run_path.parent
    artifacts = payload.get("artifacts", {})
    if not isinstance(artifacts, dict) or not artifacts:
        raise ValueError("artifacts")
    for name, metadata in artifacts.items():
        path = directory / name
        if metadata.get("path") != name or not path.is_file():
            raise ValueError(f"artifact path: {name}")
        if path.stat().st_size != metadata.get("size") or sha256_path(path) != metadata.get("sha256"):
            raise ValueError(f"artifact identity: {name}")

    seeded = directory / "name-route-seeded.mds"
    with __import__("tempfile").TemporaryDirectory() as temp:
        regenerated = Path(temp) / "seeded.mds"
        source_path = directory / payload["name_fixture"]["source_path"]
        changes = prepare_name_fixture(source_path, regenerated)
        if changes != payload["name_fixture"].get("changes") or regenerated.read_bytes() != seeded.read_bytes():
            raise ValueError("name fixture transformation")
    if payload["name_fixture"].get("seeded") is not True:
        raise ValueError("name fixture seed disclosure")

    lifecycle = parse_trace_dumps((directory / "cold-normal-vres.log").read_text())
    if len(lifecycle) != 3:
        raise ValueError("cold/normal/VRES checkpoint count")
    require_trace(
        lifecycle[0], magic=0x51323050, phase=0, sequence=0, cmd_count=0,
        vres_count=0, error=0, event=0, init_count=1, inverse=0xAECDCFAF,
    )
    require_trace(
        lifecycle[1], magic=0x51323050, phase=2, sequence=1, cmd_count=1,
        vres_count=0, error=0, sr=0x81, spc=0x06000460, pre_mask=0x8202,
        event=2, init_count=1, inverse=0xAECDCFAF,
    )
    require_trace(
        lifecycle[2], magic=0x51323050, phase=4, sequence=3, cmd_count=2,
        vres_count=1, error=0, sr=0x81, spc=0x06000460, pre_mask=0x8202,
        event=4, init_count=3, inverse=0xAECDCFAF,
    )
    lifecycle_pcs = re.findall(r"Master SH2: PC=([0-9A-F]{8})", (directory / "cold-normal-vres.log").read_text())
    if lifecycle_pcs != ["06000460", "06000460", "06000452"]:
        raise ValueError(f"Master chronology: {lifecycle_pcs}")

    negative_text = (directory / "unpatched-core-comparison.log").read_text()
    negative = parse_trace_dumps(negative_text)
    if len(negative) != 1:
        raise ValueError("unpatched negative checkpoint")
    require_trace(
        negative[0], magic=0x51323050, phase=2, sequence=1, cmd_count=1,
        vres_count=0, error=0, sr=0x81, spc=0x06000460, pre_mask=0x8202,
        event=2, init_count=1, inverse=0xAECDCFAF,
    )
    if "00FF7B41: 01" not in negative_text:
        raise ValueError("unpatched negative did not execute producer")

    normal_rows = parse_write_trace(directory / "normal-write.log", NORMAL_FRAMES)
    require_route(normal_rows, 0x0088E0D4, 0x00884D98)
    name_rows = parse_write_trace(directory / "name-write.log", NAME_FRAMES)
    require_route(name_rows, 0x00891822, 0x00891122)

    name_text = (directory / "name-debug.log").read_text()
    name = parse_trace_dumps(name_text)
    if len(name) != 1:
        raise ValueError("name checkpoint")
    require_trace(
        name[0], magic=0x51323050, phase=2, sequence=1, cmd_count=1,
        vres_count=0, error=0, sr=0x81, spc=0x06000460, pre_mask=0x8202,
        event=2, init_count=1, inverse=0xAECDCFAF,
    )
    if "00FF7B41: 01" not in name_text:
        raise ValueError("name one-shot final state")

    result = {
        "schema": SCHEMA,
        "status": "PASS",
        "non_promotable": True,
        "organic_gameplay": False,
        "evidence_scope": "diagnostic_route_feasibility",
        "probe_sha256": PROBE_SHA256,
        "default_sha256": DEFAULT_SHA256,
        "unpatched_fastpath_static_defect": "CONFIRMED_BY_SOURCE",
        "historical_two_edge_unpatched_failure": "RETAINED_IN_README",
        "current_one_edge_canonical_core_comparison": "PASS_VIA_LATER_IRQ_RECOMPUTE",
        "cold_init_count": 1,
        "normal_cmd_count": 1,
        "vres_count": 1,
        "post_vres_cmd_count": 2,
        "post_vres_init_count": 3,
        "normal_installer_pc": "0x0088E0D4",
        "name_installer_pc": "0x00891822",
        "name_fixture_seeded": True,
    }
    return result


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="operation", required=True)
    capture_parser = subparsers.add_parser("capture")
    capture_parser.add_argument("--rom", type=Path, required=True)
    capture_parser.add_argument("--default", type=Path, required=True)
    capture_parser.add_argument("--frontend", type=Path, required=True)
    capture_parser.add_argument("--core", type=Path, required=True)
    capture_parser.add_argument("--canonical-frontend", type=Path, required=True)
    capture_parser.add_argument("--canonical-core", type=Path, required=True)
    capture_parser.add_argument("--name-source-state", type=Path, required=True)
    capture_parser.add_argument("--output-dir", type=Path, required=True)
    validate_parser = subparsers.add_parser("validate")
    validate_parser.add_argument("run", type=Path)
    validate_parser.add_argument("--result", type=Path)
    args = parser.parse_args()

    try:
        if args.operation == "capture":
            payload = capture(args)
            print(f"Q-020 runtime capture complete: {args.output_dir / 'run.json'}")
            print("Status remains CAPTURED_UNVALIDATED and non-promotable")
        else:
            payload = validate(args.run)
            encoded = json.dumps(payload, indent=2, sort_keys=True) + "\n"
            if args.result:
                if args.result.exists():
                    raise ValueError("result path already exists")
                args.result.write_text(encoded)
            print("Q-020 CMDINT runtime validation PASS (non-promotable)")
    except (OSError, ValueError, subprocess.SubprocessError, json.JSONDecodeError) as error:
        print(f"Q-020 CMDINT runtime FAILED: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
