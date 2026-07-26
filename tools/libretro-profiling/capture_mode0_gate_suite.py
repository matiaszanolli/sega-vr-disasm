#!/usr/bin/env python3
"""Capture the complete fail-closed VR60 Q020 mode-0 acceptance matrix."""

from __future__ import annotations

import argparse
import csv
import json
import sys
import tarfile
from collections.abc import Sequence
from pathlib import Path

from validate_1p_control import (
    CANONICAL_CORE,
    CANONICAL_CORE_SHA256,
    CANONICAL_FRONTEND,
    CANONICAL_FRONTEND_SHA256,
    sha256_file,
)
from validate_mode0_gate import (
    EXPECTED_ACCEPTED_ARCHIVE_SHA256,
    EXPECTED_BASE_IDS,
    EXPECTED_PREFLIGHT_COMMANDS_SHA256,
    EXPECTED_PREFLIGHT_CONTROL_SHA256,
    EXPECTED_SOURCE_STAGE_FRAMES,
    MODE0_WATCH_SPEC,
    POLICY_ID,
    PREFLIGHT_COMMANDS,
    SCHEMA_VERSION,
    SOURCE_STAGE_DUMP_SPEC,
    accepted_fixture_map,
    analyze_gate,
    parse_dump,
    run_mode0_capture,
    run_preflight,
    run_source_stage_capture,
    tar_member_bytes,
    verify_preflight_transcript,
)
from verify_mode0_rom_pair import (
    EXPECTED_ACTIVE_SHA256,
    EXPECTED_CONTROL_SHA256,
    verify_pair,
)
from verify_mode0_rom_pair import (
    SCHEMA as ROM_PAIR_SCHEMA,
)

SOURCE_NAMES = {
    "big-forest": (
        "big-forest-start.bin",
        "big-forest-input.csv",
        "big-forest.replay",
    ),
    "bay-bridge": (
        "bay-bridge-start.bin",
        "bay-bridge-input.csv",
        "bay-bridge.replay",
    ),
    "acropolis": (
        "acropolis-start.bin",
        "acropolis-input.csv",
        "acropolis.replay",
    ),
}


def pinned(path: Path) -> dict[str, str]:
    return {"path": str(path.resolve()), "sha256": sha256_file(path)}


def write_json(path: Path, payload: object) -> None:
    path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")


def extract_sources(
    archive: tarfile.TarFile,
    accepted: dict[str, dict[str, object]],
    source_dir: Path,
) -> dict[str, tuple[Path, Path, Path]]:
    source_dir.mkdir()
    result: dict[str, tuple[Path, Path, Path]] = {}
    for base_id in EXPECTED_BASE_IDS:
        names = SOURCE_NAMES[base_id]
        paths: list[Path] = []
        for name in names:
            path = source_dir / name
            path.write_bytes(tar_member_bytes(archive, f"sources/{name}"))
            paths.append(path)
        fixture = accepted[base_id]
        expected_hashes = (
            fixture["savestate"]["sha256"],
            fixture["input_script"]["sha256"],
            fixture["source_capture"]["sha256"],
        )
        observed_hashes = tuple(sha256_file(path) for path in paths)
        if observed_hashes != expected_hashes:
            raise ValueError(f"{base_id} accepted source bytes changed")
        result[base_id] = (paths[0], paths[1], paths[2])
    return result


def capture_suite(args: argparse.Namespace) -> int:
    output = args.output.resolve()
    if output.exists():
        raise ValueError(f"refusing existing output directory: {output}")
    pair_manifest_path = args.rom_pair_manifest.resolve()
    accepted_archive_path = args.accepted_evidence.resolve()
    preflight_control = args.preflight_control.resolve()
    if sha256_file(accepted_archive_path) != EXPECTED_ACCEPTED_ARCHIVE_SHA256:
        raise ValueError("accepted VR60-011 evidence archive hash changed")
    if sha256_file(preflight_control) != EXPECTED_PREFLIGHT_CONTROL_SHA256:
        raise ValueError("preflight control ROM hash changed")

    pair = json.loads(pair_manifest_path.read_text())
    if (
        pair.get("schema") != ROM_PAIR_SCHEMA
        or pair.get("eligible") is not True
        or pair.get("active_sha256") != EXPECTED_ACTIVE_SHA256
        or pair.get("control_sha256") != EXPECTED_CONTROL_SHA256
    ):
        raise ValueError("mode-0 ROM-pair manifest is not acceptance-eligible")
    active_rom = Path(str(pair["active_path"])).resolve()
    control_rom = Path(str(pair["control_path"])).resolve()
    default_rom = Path(str(pair["default_reference_path"])).resolve()
    recheck = verify_pair(active_rom, control_rom, default_rom)
    if not recheck["eligible"]:
        raise ValueError("mode-0 ROM pair recheck failed: " + ", ".join(recheck["findings"]))

    with tarfile.open(accepted_archive_path, "r:gz") as archive:
        accepted_suite = json.loads(tar_member_bytes(archive, "suite.json"))
        accepted = accepted_fixture_map(accepted_suite)
        output.mkdir(parents=True)
        sources = extract_sources(archive, accepted, output / "sources")

    preflight_dir = output / "preflights"
    preflight_dir.mkdir()
    preflights: list[dict[str, object]] = []
    for base_id in EXPECTED_BASE_IDS:
        savestate, _input_script, _source_capture = sources[base_id]
        path = preflight_dir / f"{base_id}.txt"
        status = run_preflight(
            control_rom=preflight_control,
            savestate=savestate,
            output_path=path,
        )
        if status != 0:
            raise ValueError(f"{base_id} preflight frontend exited {status}")
        verify_preflight_transcript(
            path,
            control_rom=preflight_control,
            savestate=savestate,
        )
        preflights.append(
            {
                "base_id": base_id,
                "rom_sha256": sha256_file(preflight_control),
                "savestate_path": str(savestate),
                "savestate_sha256": sha256_file(savestate),
                "frontend_sha256": CANONICAL_FRONTEND_SHA256,
                "core_sha256": CANONICAL_CORE_SHA256,
                "command_script_sha256": EXPECTED_PREFLIGHT_COMMANDS_SHA256,
                "path": str(path),
                "sha256": sha256_file(path),
            }
        )

    source_stages: list[dict[str, object]] = []
    for base_id in EXPECTED_BASE_IDS:
        savestate, input_script, _source_capture = sources[base_id]
        dump_frame = EXPECTED_SOURCE_STAGE_FRAMES[base_id]
        artifact_dir = output / "source-stages" / base_id
        status = run_source_stage_capture(
            active_rom=active_rom,
            savestate=savestate,
            input_script=input_script,
            dump_frame=dump_frame,
            output_dir=artifact_dir,
        )
        if status != 0:
            raise ValueError(f"{base_id} source-stage frontend exited {status}")
        dump_path = artifact_dir / "source-stage.txt"
        regions = parse_dump(dump_path, ((0xFF9000, 0x100), (0xFF6A00, 0x100)))
        if regions[0xFF9000] != regions[0xFF6A00]:
            raise ValueError(f"{base_id} live source-stage bytes differ")
        source_stages.append(
            {
                "base_id": base_id,
                "rom_sha256": sha256_file(active_rom),
                "savestate_sha256": sha256_file(savestate),
                "input_script_sha256": sha256_file(input_script),
                "input_prefix": str(artifact_dir / "input-prefix.csv"),
                "input_prefix_sha256": sha256_file(
                    artifact_dir / "input-prefix.csv"
                ),
                "dump_frame": dump_frame,
                "dump_spec": SOURCE_STAGE_DUMP_SPEC,
                "path": str(dump_path),
                "sha256": sha256_file(dump_path),
            }
        )

    runs: list[dict[str, object]] = []
    for base_id in EXPECTED_BASE_IDS:
        accepted_entry = accepted[base_id]
        savestate, input_script, source_capture = sources[base_id]
        for repetition in (1, 2):
            for arm, rom in (("active", active_rom), ("control", control_rom)):
                artifact_dir = output / "runs" / arm / base_id / f"r{repetition}"
                status = run_mode0_capture(
                    arm=arm,
                    base_id=base_id,
                    repetition=repetition,
                    rom=rom,
                    pair_manifest=pair_manifest_path,
                    savestate=savestate,
                    input_script=input_script,
                    source_capture=source_capture,
                    output_dir=artifact_dir,
                    total_frames=int(accepted_entry["total_frames"]),
                    expected_terminal_entry_frame=int(
                        accepted_entry["expected_terminal_entry_frame"]
                    ),
                    expected_results_scene_frame=int(
                        accepted_entry["expected_results_scene_frame"]
                    ),
                )
                if status != 0:
                    raise ValueError(
                        f"{arm}/{base_id}/r{repetition} frontend exited {status}"
                    )
                artifacts = {
                    name: sha256_file(artifact_dir / name)
                    for name in (
                        "run.json",
                        "frames.csv",
                        "watch.csv",
                        "caller.csv",
                        "write.csv",
                        "checkpoint.txt",
                        "frontend.log",
                    )
                }
                runs.append(
                    {
                        "arm": arm,
                        "base_id": base_id,
                        "repetition": repetition,
                        "artifact_dir": str(artifact_dir),
                        "savestate": pinned(savestate),
                        "input_script": pinned(input_script),
                        "source_capture": pinned(source_capture),
                        "total_frames": int(accepted_entry["total_frames"]),
                        "expected_terminal_entry_frame": int(
                            accepted_entry["expected_terminal_entry_frame"]
                        ),
                        "expected_results_scene_frame": int(
                            accepted_entry["expected_results_scene_frame"]
                        ),
                        "artifacts": artifacts,
                    }
                )

    manifest = {
        "schema": SCHEMA_VERSION,
        "policy_id": POLICY_ID,
        "diagnostic": False,
        "rom_pair_manifest": pinned(pair_manifest_path),
        "preflight_control": pinned(preflight_control),
        "accepted_evidence": pinned(accepted_archive_path),
        "frontend": {
            "path": str(CANONICAL_FRONTEND.resolve()),
            "sha256": CANONICAL_FRONTEND_SHA256,
        },
        "core": {
            "path": str(CANONICAL_CORE.resolve()),
            "sha256": CANONICAL_CORE_SHA256,
        },
        "capture_environment": {
            "watch_spec": MODE0_WATCH_SPEC,
            "preflight_command_script": str(PREFLIGHT_COMMANDS.resolve()),
            "preflight_command_script_sha256": EXPECTED_PREFLIGHT_COMMANDS_SHA256,
        },
        "preflights": preflights,
        "source_stages": source_stages,
        "runs": runs,
    }
    # Keep the root validator schema exact; capture-only metadata lives beside it.
    capture_environment = manifest.pop("capture_environment")
    manifest_path = output / "manifest.json"
    write_json(manifest_path, manifest)
    write_json(output / "capture-environment.json", capture_environment)
    report = analyze_gate(manifest_path)
    write_json(output / "result.json", report.to_json())
    if not report.passed:
        codes = [item["code"] for item in report.findings]
        codes.extend(
            finding.code
            for run in report.runs
            for finding in run.fixture.findings
        )
        raise ValueError("captured mode-0 suite failed: " + ", ".join(codes))
    print(f"PASS [{POLICY_ID}] manifest={manifest_path}")
    return 0


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--rom-pair-manifest", required=True, type=Path)
    parser.add_argument("--preflight-control", required=True, type=Path)
    parser.add_argument("--accepted-evidence", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    try:
        return capture_suite(parse_args(argv))
    except (OSError, ValueError, KeyError, json.JSONDecodeError, csv.Error) as error:
        print(f"FAIL [{POLICY_ID}] {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
