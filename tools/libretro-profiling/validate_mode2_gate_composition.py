#!/usr/bin/env python3
"""Fail-closed composition validator for the isolated Q-021 mode-2 gate."""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from typing import Any

import mode2_cmdint_runtime
import validate_mode1_gate_composition
import verify_mode1_rom_pair
import verify_mode2_rom_pair


SCHEMA = "vrd-vr60-q021-mode2-gate-composition-v1"
DEFAULT_MANIFEST = "analysis/evidence/vr60-q021-mode2-cmdint-gate/composition.json"
EXPECTED_COMPONENTS = {
    "static_pair": "tools/libretro-profiling/mode2_rom_pair.json",
    "runtime_capture": "analysis/evidence/vr60-q021-mode2-cmdint-gate/runtime/run.json",
    "runtime_result": "analysis/evidence/vr60-q021-mode2-cmdint-gate/runtime/result.json",
    "accepted_mode1_gate": "analysis/evidence/vr60-q020-mode1-cmdint-gate/composition.json",
}
BUILD_INPUTS = {
    "active": "build/vr60_mode2_active.32x",
    "control": "build/vr60_mode2_stage_control.32x",
    "default": "build/vr_rebuild.32x",
    "mode1_active": "build/vr60_mode1_active.32x",
    "mode1_control": "build/vr60_mode1_stage_control.32x",
    "isr_bin": "build/sh2/cmd3e_mode2_validation.bin",
    "isr_elf": "build/sh2/cmd3e_mode2_validation.elf",
}


class CompositionValidationError(ValueError):
    """A component is missing, stale, mismatched, or overclaims scope."""


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def load_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise CompositionValidationError(f"cannot load {path}: {exc}") from exc


def require_exact_keys(value: Any, expected: set[str], label: str) -> dict[str, Any]:
    if not isinstance(value, dict) or set(value) != expected:
        actual = set(value) if isinstance(value, dict) else set()
        raise CompositionValidationError(
            f"{label} keys mismatch: missing={sorted(expected - actual)} "
            f"extra={sorted(actual - expected)}"
        )
    return value


def resolve(repo_root: Path, relative_name: str, label: str) -> Path:
    relative = Path(relative_name)
    if relative.is_absolute() or ".." in relative.parts:
        raise CompositionValidationError(f"{label} escapes repository root")
    root = repo_root.resolve()
    path = (root / relative).resolve()
    if path == root or root not in path.parents or not path.is_file():
        raise CompositionValidationError(f"{label} is not a repository file: {path}")
    return path


def validate_composition(composition_path: Path, repo_root: Path) -> dict[str, Any]:
    root = repo_root.resolve()
    manifest = require_exact_keys(
        load_json(composition_path),
        {"schema", "status", "evidence_scope", "claims", "identities", "components"},
        "composition",
    )
    if manifest.get("schema") != SCHEMA \
            or manifest.get("status") != "VALIDATION_STAGE_PASS" \
            or manifest.get("evidence_scope") != "isolated_mode2_active_stage_control":
        raise CompositionValidationError("composition status/scope")
    expected_claims = {
        "validation_stage_pass": True, "non_promotable": True,
        "ordinary_default": False, "promoted": False,
        "real_hardware_proven": False, "organic_gameplay": False,
        "authority_transferred": False, "mode0_enabled": False,
        "mode1_enabled": False, "mode2_enabled": True, "cmd3f_enabled": False,
    }
    if manifest.get("claims") != expected_claims:
        raise CompositionValidationError("composition scope/promotion claims")
    expected_identities = {
        "active": mode2_cmdint_runtime.ACTIVE_SHA256,
        "control": mode2_cmdint_runtime.CONTROL_SHA256,
        "default": mode2_cmdint_runtime.DEFAULT_SHA256,
        "mode1_active": verify_mode1_rom_pair.EXPECTED_ACTIVE_SHA256,
        "mode1_control": verify_mode1_rom_pair.EXPECTED_CONTROL_SHA256,
        "mode1_isr": verify_mode1_rom_pair.ISR_SHA256,
        "frontend": mode2_cmdint_runtime.FRONTEND_SHA256,
        "core": mode2_cmdint_runtime.CORE_SHA256,
        "canonical_core": mode2_cmdint_runtime.CANONICAL_CORE_SHA256,
    }
    if manifest.get("identities") != expected_identities:
        raise CompositionValidationError("composition binary identities")

    components = require_exact_keys(
        manifest["components"], set(EXPECTED_COMPONENTS), "composition.components"
    )
    resolved: dict[str, Path] = {}
    for name, expected_path in EXPECTED_COMPONENTS.items():
        component = require_exact_keys(components[name], {"path", "sha256"}, name)
        if component["path"] != expected_path:
            raise CompositionValidationError(f"{name} path mismatch")
        path = resolve(root, expected_path, name)
        if component["sha256"] != sha256_file(path):
            raise CompositionValidationError(f"{name} hash mismatch")
        resolved[name] = path

    static = load_json(resolved["static_pair"])
    if (
        static.get("schema") != verify_mode2_rom_pair.SCHEMA
        or static.get("static_eligible") is not True
        or static.get("eligible") is not False
        or static.get("promotable") is not False
        or static.get("runtime_evidence") != "MISSING_FAIL_CLOSED"
        or static.get("findings") != []
        or static.get("payload_bytes") != 3840
        or static.get("fifo_words") != 1920
        or static.get("full_checked_groups") != 480
        or static.get("fifo_words_per_group") != 4
        or static.get("mode1_evidence_unchanged") is not True
    ):
        raise CompositionValidationError("static pair policy/identity")
    try:
        rebuilt = verify_mode2_rom_pair.verify_pair(
            *(resolve(root, BUILD_INPUTS[name], f"{name} build") for name in (
                "active", "control", "default", "mode1_active", "mode1_control",
                "isr_bin", "isr_elf",
            )),
            root,
        )
    except (OSError, ValueError) as exc:
        raise CompositionValidationError(f"static rebuild verification: {exc}") from exc
    if rebuilt != static:
        raise CompositionValidationError("static manifest is stale versus rebuilt pair")

    try:
        mode1_result = validate_mode1_gate_composition.validate_composition(
            resolved["accepted_mode1_gate"], root
        )
    except (validate_mode1_gate_composition.CompositionValidationError, OSError) as exc:
        raise CompositionValidationError(f"accepted mode1 component: {exc}") from exc
    if mode1_result.get("status") != "VALIDATION_STAGE_PASS":
        raise CompositionValidationError("accepted mode1 gate status")

    try:
        rebuilt_runtime = mode2_cmdint_runtime.validate(resolved["runtime_capture"])
    except (OSError, ValueError, json.JSONDecodeError) as exc:
        raise CompositionValidationError(f"runtime component: {exc}") from exc
    archived_runtime = load_json(resolved["runtime_result"])
    if rebuilt_runtime != archived_runtime:
        raise CompositionValidationError("runtime result is stale versus capture")
    if (
        archived_runtime.get("status") != "VALIDATION_STAGE_PASS"
        or archived_runtime.get("source_fifo_destination_full_equality") is not True
        or archived_runtime.get("stage_control_transport_events") != 0
        or archived_runtime.get("authority_transferred") is not False
        or archived_runtime.get("cmd3f_enabled") is not False
        or any(archived_runtime.get(key) is not False for key in (
            "promotable", "ordinary_default", "promoted", "real_hardware_proven",
        ))
    ):
        raise CompositionValidationError("runtime result scope/binding")
    return {
        "schema": SCHEMA, "status": "VALIDATION_STAGE_PASS",
        "components_verified": len(EXPECTED_COMPONENTS),
        "capture_runs_verified": 8, "payload_bytes": 3840,
        "fifo_words": 1920, "fifo_groups": 480,
        "non_promotable": True, "ordinary_default": False,
        "promoted": False, "authority_transferred": False,
        "cmd3f_enabled": False, "real_hardware_proven": False,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "composition", nargs="?", type=Path,
        default=Path(__file__).resolve().parents[2] / DEFAULT_MANIFEST,
    )
    parser.add_argument(
        "--repo-root", type=Path, default=Path(__file__).resolve().parents[2]
    )
    args = parser.parse_args(argv)
    try:
        result = validate_composition(args.composition, args.repo_root)
    except (CompositionValidationError, OSError) as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1
    print(json.dumps(result, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
