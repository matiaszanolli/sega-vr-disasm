#!/usr/bin/env python3
"""Fail-closed validator for VR60 mode-1 reset/re-entry fixture evidence."""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from typing import Any

SCHEMA_VERSION = 1
SCENE_POINTER_ADDRESS = 0x00FF0002
FLAG_ADDRESS = 0x00FF7B40
RACING_HANDLER_PC = 0x00884CBC
ROUTE_POLICY = {
    "normal_entry": {
        "pointer_writer_pc": 0x0000E0D4,
        "required_initial_flag": None,
    },
    "name_entry_reentry": {
        "pointer_writer_pc": 0x00011822,
        "required_initial_flag": 1,
    },
}
ARMS = ("active", "control")
REPETITIONS = (1, 2)
EXPECTED_EVENT_KINDS = (
    "pointer_write",
    "wrapper_entry",
    "flag_reset_write",
    "racing_handler_entry",
    "hook_flag_write",
)
SHA256_LENGTH = 64
EXPECTED_MODE1_PCS = {
    "wrapper_entry_pc": 0x0089C914,
    "flag_reset_writer_pc": 0x0089C916,
    "hook_flag_writer_pc": 0x0001C8CA,
}
EXPECTED_ROM_SHA256 = {
    "active": "844543609366dd76925865c89d848306ff7a619cda637275143c60fbb3066402",
    "control": "715f11de6478b3d96239ff54b7e38ce6ec3dc9e321b5d392bd660323e4ebbd17",
}


class FixtureValidationError(ValueError):
    """The reset fixture is incomplete, malformed, or ineligible."""


def _reject_duplicate_keys(pairs: list[tuple[str, Any]]) -> dict[str, Any]:
    result: dict[str, Any] = {}
    for key, value in pairs:
        if key in result:
            raise FixtureValidationError(f"duplicate JSON key: {key}")
        result[key] = value
    return result


def load_json(path: Path) -> Any:
    try:
        return json.loads(
            path.read_text(encoding="utf-8"),
            object_pairs_hook=_reject_duplicate_keys,
        )
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise FixtureValidationError(f"cannot load {path}: {exc}") from exc


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    try:
        with path.open("rb") as stream:
            for block in iter(lambda: stream.read(1024 * 1024), b""):
                digest.update(block)
    except OSError as exc:
        raise FixtureValidationError(f"cannot hash {path}: {exc}") from exc
    return digest.hexdigest()


def _require_exact_keys(value: Any, keys: set[str], label: str) -> dict[str, Any]:
    if not isinstance(value, dict):
        raise FixtureValidationError(f"{label} must be an object")
    actual = set(value)
    if actual != keys:
        raise FixtureValidationError(
            f"{label} keys mismatch: missing={sorted(keys - actual)} "
            f"extra={sorted(actual - keys)}"
        )
    return value


def _require_uint(value: Any, label: str, maximum: int = 0xFFFFFFFF) -> int:
    if isinstance(value, bool) or not isinstance(value, int):
        raise FixtureValidationError(f"{label} must be an integer")
    if value < 0 or value > maximum:
        raise FixtureValidationError(f"{label} is outside the allowed range")
    return value


def _require_pc(value: Any, label: str) -> int:
    pc = _require_uint(value, label, 0x00FFFFFF)
    if pc == 0 or pc & 1:
        raise FixtureValidationError(f"{label} must be a non-zero even 68K PC")
    return pc


def _require_sha256(value: Any, label: str) -> str:
    if (
        not isinstance(value, str)
        or len(value) != SHA256_LENGTH
        or any(character not in "0123456789abcdef" for character in value)
    ):
        raise FixtureValidationError(f"{label} must be a lowercase SHA-256")
    return value


def _resolve_artifact(root: Path, value: Any, label: str) -> Path:
    if not isinstance(value, str) or not value:
        raise FixtureValidationError(f"{label} must name a relative artifact")
    relative = Path(value)
    if relative.is_absolute() or ".." in relative.parts:
        raise FixtureValidationError(f"{label} escapes the fixture root")
    root = root.resolve()
    path = (root / relative).resolve()
    if path == root or root not in path.parents:
        raise FixtureValidationError(f"{label} escapes the fixture root")
    if not path.is_file():
        raise FixtureValidationError(f"{label} does not exist: {path}")
    return path


def _validate_policy(manifest: dict[str, Any]) -> dict[str, int]:
    policy = _require_exact_keys(
        manifest["policy"],
        {
            "scene_pointer_address",
            "flag_address",
            "racing_handler_pc",
            "repetitions_per_route_per_arm",
            "routes",
        },
        "policy",
    )
    expected_scalars = {
        "scene_pointer_address": SCENE_POINTER_ADDRESS,
        "flag_address": FLAG_ADDRESS,
        "racing_handler_pc": RACING_HANDLER_PC,
        "repetitions_per_route_per_arm": len(REPETITIONS),
    }
    for key, expected in expected_scalars.items():
        if policy[key] != expected:
            raise FixtureValidationError(
                f"policy.{key} must be 0x{expected:X}"
                if key != "repetitions_per_route_per_arm"
                else f"policy.{key} must be {expected}"
            )
    routes = _require_exact_keys(
        policy["routes"], set(ROUTE_POLICY), "policy.routes"
    )
    for route, expected in ROUTE_POLICY.items():
        actual = _require_exact_keys(
            routes[route],
            {"pointer_writer_pc", "required_initial_flag"},
            f"policy.routes.{route}",
        )
        if actual != expected:
            raise FixtureValidationError(
                f"policy.routes.{route} does not match the frozen route"
            )

    pcs = _require_exact_keys(
        manifest["expected_mode1_pcs"],
        {"wrapper_entry_pc", "flag_reset_writer_pc", "hook_flag_writer_pc"},
        "expected_mode1_pcs",
    )
    parsed = {key: _require_pc(value, f"expected_mode1_pcs.{key}") for key, value in pcs.items()}
    if parsed != EXPECTED_MODE1_PCS:
        raise FixtureValidationError(
            "expected_mode1_pcs does not match the source-built mode-1 pair"
        )
    if len(set(parsed.values())) != len(parsed):
        raise FixtureValidationError("mode-1 wrapper/reset/hook PCs must be distinct")
    return parsed


def _validate_event_shape(event: Any, label: str) -> dict[str, Any]:
    event = _require_exact_keys(
        event,
        {
            "sequence",
            "frame",
            "kind",
            "cpu",
            "source",
            "pc",
            "address",
            "width",
            "old_value",
            "new_value",
        },
        label,
    )
    _require_uint(event["sequence"], f"{label}.sequence", 4)
    _require_uint(event["frame"], f"{label}.frame")
    _require_pc(event["pc"], f"{label}.pc")
    if event["cpu"] != "m68k":
        raise FixtureValidationError(f"{label}.cpu must be m68k")
    return event


def validate_reset_trace(
    trace: Any,
    *,
    route: str,
    arm: str,
    repetition: int,
    expected_pcs: dict[str, int],
) -> None:
    trace = _require_exact_keys(
        trace,
        {
            "schema_version",
            "route",
            "arm",
            "repetition",
            "capture_start",
            "events",
            "complete",
            "dropped",
            "errors",
        },
        "reset trace",
    )
    if trace["schema_version"] != SCHEMA_VERSION:
        raise FixtureValidationError("reset trace schema_version must be 1")
    if (trace["route"], trace["arm"], trace["repetition"]) != (
        route,
        arm,
        repetition,
    ):
        raise FixtureValidationError("reset trace identity does not match manifest")
    if trace["complete"] is not True or trace["dropped"] != 0 or trace["errors"] != 0:
        raise FixtureValidationError(
            "reset trace must be complete with zero drops/errors"
        )

    start = _require_exact_keys(
        trace["capture_start"],
        {"frame", "pc", "flag", "scene_pointer", "before_pointer_writer"},
        "capture_start",
    )
    if start["frame"] != 0 or start["before_pointer_writer"] is not True:
        raise FixtureValidationError(
            "capture must declare frame-zero start before pointer writer"
        )
    start_pc = _require_pc(start["pc"], "capture_start.pc")
    start_flag = _require_uint(start["flag"], "capture_start.flag", 1)
    _require_pc(start["scene_pointer"], "capture_start.scene_pointer")
    pointer_pc = ROUTE_POLICY[route]["pointer_writer_pc"]
    if start_pc in {pointer_pc, *expected_pcs.values()}:
        raise FixtureValidationError(
            "capture starts at/after a pinned writer or wrapper PC"
        )
    required_flag = ROUTE_POLICY[route]["required_initial_flag"]
    if required_flag is not None and start_flag != required_flag:
        raise FixtureValidationError(
            f"{route} must start with flag={required_flag}"
        )

    events_value = trace["events"]
    if not isinstance(events_value, list) or len(events_value) != 5:
        raise FixtureValidationError("reset trace must contain exactly five events")
    events = [
        _validate_event_shape(event, f"events[{index}]")
        for index, event in enumerate(events_value)
    ]
    if [event["sequence"] for event in events] != list(range(5)):
        raise FixtureValidationError("reset trace sequence must be contiguous")
    if [event["kind"] for event in events] != list(EXPECTED_EVENT_KINDS):
        raise FixtureValidationError("reset route event grammar mismatch")
    frames = [event["frame"] for event in events]
    if frames != sorted(frames):
        raise FixtureValidationError("reset route frames moved backwards")

    expected = (
        (
            pointer_pc,
            "cpu_write_callback",
            SCENE_POINTER_ADDRESS,
            4,
            None,
            expected_pcs["wrapper_entry_pc"],
        ),
        (
            expected_pcs["wrapper_entry_pc"],
            "instruction_start",
            None,
            None,
            None,
            None,
        ),
        (
            expected_pcs["flag_reset_writer_pc"],
            "cpu_write_callback",
            FLAG_ADDRESS,
            1,
            start_flag,
            0,
        ),
        (
            RACING_HANDLER_PC,
            "instruction_start",
            None,
            None,
            None,
            None,
        ),
        (
            expected_pcs["hook_flag_writer_pc"],
            "cpu_write_callback",
            FLAG_ADDRESS,
            1,
            0,
            1,
        ),
    )
    for index, (event, wanted) in enumerate(zip(events, expected, strict=True)):
        actual = (
            event["pc"],
            event["source"],
            event["address"],
            event["width"],
            event["old_value"],
            event["new_value"],
        )
        if index == 0:
            # The prior scene pointer is fixture-dependent; every other field
            # is pinned and the callback PC proves this is the real route writer.
            actual = actual[:4] + (None, actual[5])
        if actual != wanted:
            raise FixtureValidationError(
                f"events[{index}] is not the pinned {EXPECTED_EVENT_KINDS[index]}"
            )


def validate_manifest(manifest_path: Path) -> int:
    fixture_root = manifest_path.resolve().parent
    manifest = _require_exact_keys(
        load_json(manifest_path),
        {
            "schema_version",
            "eligible",
            "status",
            "blockers",
            "policy",
            "expected_mode1_pcs",
            "arms",
        },
        "manifest",
    )
    if manifest["schema_version"] != SCHEMA_VERSION:
        raise FixtureValidationError("manifest schema_version must be 1")
    expected_pcs = _validate_policy(manifest)
    arms = _require_exact_keys(manifest["arms"], set(ARMS), "arms")
    for arm_name in ARMS:
        arm = _require_exact_keys(
            arms[arm_name], {"rom_sha256", "routes"}, f"arms.{arm_name}"
        )
        actual_hash = _require_sha256(
            arm["rom_sha256"], f"arms.{arm_name}.rom_sha256"
        )
        if actual_hash != EXPECTED_ROM_SHA256[arm_name]:
            raise FixtureValidationError(
                f"arms.{arm_name}.rom_sha256 does not match the source-built pair"
            )

    if manifest["eligible"] is not True or manifest["status"] != "VALIDATED":
        blockers = manifest.get("blockers")
        detail = "; ".join(blockers) if isinstance(blockers, list) else "unknown"
        raise FixtureValidationError(f"fixture manifest is ineligible: {detail}")
    if manifest["blockers"] != []:
        raise FixtureValidationError("eligible manifest must have no blockers")
    rom_hashes: set[str] = set()
    trace_paths: set[Path] = set()
    run_count = 0
    for arm_name in ARMS:
        arm = _require_exact_keys(
            arms[arm_name], {"rom_sha256", "routes"}, f"arms.{arm_name}"
        )
        rom_hashes.add(arm["rom_sha256"])
        routes = _require_exact_keys(
            arm["routes"], set(ROUTE_POLICY), f"arms.{arm_name}.routes"
        )
        for route_name in ROUTE_POLICY:
            runs = routes[route_name]
            if not isinstance(runs, list) or len(runs) != len(REPETITIONS):
                raise FixtureValidationError(
                    f"{arm_name}/{route_name} must contain exactly two replays"
                )
            if [run.get("repetition") for run in runs if isinstance(run, dict)] != list(
                REPETITIONS
            ):
                raise FixtureValidationError(
                    f"{arm_name}/{route_name} repetitions must be [1, 2]"
                )
            for run in runs:
                run = _require_exact_keys(
                    run,
                    {
                        "repetition",
                        "state_path",
                        "state_sha256",
                        "replay_path",
                        "replay_sha256",
                        "trace_path",
                        "trace_sha256",
                    },
                    f"{arm_name}/{route_name} run",
                )
                repetition = run["repetition"]
                for kind in ("state", "replay", "trace"):
                    path = _resolve_artifact(
                        fixture_root,
                        run[f"{kind}_path"],
                        f"{arm_name}/{route_name}/{repetition} {kind}",
                    )
                    expected_hash = _require_sha256(
                        run[f"{kind}_sha256"],
                        f"{arm_name}/{route_name}/{repetition} {kind}_sha256",
                    )
                    if sha256_file(path) != expected_hash:
                        raise FixtureValidationError(
                            f"{arm_name}/{route_name}/{repetition} {kind} hash mismatch"
                        )
                    if kind == "trace":
                        if path in trace_paths:
                            raise FixtureValidationError(
                                "each run must use its own reset trace artifact"
                            )
                        trace_paths.add(path)
                        validate_reset_trace(
                            load_json(path),
                            route=route_name,
                            arm=arm_name,
                            repetition=repetition,
                            expected_pcs=expected_pcs,
                        )
                run_count += 1
    if len(rom_hashes) != len(ARMS):
        raise FixtureValidationError("active/control ROM hashes must differ")
    return run_count


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "manifest",
        nargs="?",
        type=Path,
        default=Path(__file__).resolve().with_name("mode1_reset_fixtures.json"),
    )
    args = parser.parse_args(argv)
    try:
        runs = validate_manifest(args.manifest)
    except FixtureValidationError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1
    print(f"PASS: {runs} reset-route runs (2 routes x 2 arms x 2 repetitions)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
