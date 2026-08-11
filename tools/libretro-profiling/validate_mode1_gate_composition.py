#!/usr/bin/env python3
"""Fail-closed composition validator for the isolated mode-1 Gate B archive."""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from typing import Any

import mode1_cmdint_runtime
import validate_mode1_reset_fixtures
import verify_mode1_rom_pair


SCHEMA = "vrd-vr60-q020-mode1-gate-composition-v1"
DEFAULT_MANIFEST = (
    "analysis/evidence/vr60-q020-mode1-cmdint-gate/composition.json"
)
EXPECTED_COMPONENTS = {
    "static_pair": "tools/libretro-profiling/mode1_rom_pair.json",
    "lifecycle": "tools/libretro-profiling/mode1_reset_fixtures.json",
    "runtime_capture": (
        "analysis/evidence/vr60-q020-mode1-cmdint-gate/runtime/run.json"
    ),
    "runtime_result": (
        "analysis/evidence/vr60-q020-mode1-cmdint-gate/runtime/result.json"
    ),
    "busy_reset_diagnostic": (
        "analysis/evidence/vr60-q020-mode1-cmdint-gate/reset-diagnostics/run.json"
    ),
}
BUILD_INPUTS = {
    "active": "build/vr60_mode1_active.32x",
    "control": "build/vr60_mode1_stage_control.32x",
    "default": "build/vr_rebuild.32x",
    "isr_bin": "build/sh2/cmd3e_mode1_validation.bin",
    "isr_elf": "build/sh2/cmd3e_mode1_validation.elf",
}


class CompositionValidationError(ValueError):
    """A gate component is missing, stale, mismatched, or overclaims scope."""


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
    if (
        manifest["schema"] != SCHEMA
        or manifest["status"] != "VALIDATION_STAGE_PASS"
        or manifest["evidence_scope"] != "isolated_mode1_active_stage_control"
    ):
        raise CompositionValidationError("composition status/scope")
    expected_claims = {
        "validation_stage_pass": True,
        "non_promotable": True,
        "ordinary_default": False,
        "promoted": False,
        "real_hardware_proven": False,
        "organic_gameplay": False,
        "authority_transferred": False,
        "mode2_enabled": False,
        "cmd3f_enabled": False,
    }
    if manifest["claims"] != expected_claims:
        raise CompositionValidationError("composition scope/promotion claims")
    expected_identities = {
        "active": mode1_cmdint_runtime.ACTIVE_SHA256,
        "control": mode1_cmdint_runtime.CONTROL_SHA256,
        "default": mode1_cmdint_runtime.DEFAULT_SHA256,
        "frontend": mode1_cmdint_runtime.FRONTEND_SHA256,
        "core": mode1_cmdint_runtime.CORE_SHA256,
        "canonical_core": mode1_cmdint_runtime.CANONICAL_CORE_SHA256,
    }
    if manifest["identities"] != expected_identities:
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
        static.get("schema") != verify_mode1_rom_pair.SCHEMA
        or static.get("static_eligible") is not True
        or static.get("eligible") is not False
        or static.get("promotable") is not False
        or static.get("runtime_evidence") != "COMPOSED_BY_MODE1_GATE_MANIFEST"
        or static.get("status") != "STATIC_VALIDATION_PASS_NON_PROMOTABLE"
        or static.get("findings") != []
        or static.get("hashes") != {
            "active": expected_identities["active"],
            "control": expected_identities["control"],
            "default": expected_identities["default"],
            "isr_bin": verify_mode1_rom_pair.ISR_SHA256,
        }
    ):
        raise CompositionValidationError("static pair policy/identity")
    try:
        rebuilt_static = verify_mode1_rom_pair.verify_pair(
            resolve(root, BUILD_INPUTS["active"], "active build"),
            resolve(root, BUILD_INPUTS["control"], "control build"),
            resolve(root, BUILD_INPUTS["default"], "default build"),
            resolve(root, BUILD_INPUTS["isr_bin"], "ISR build"),
            resolve(root, BUILD_INPUTS["isr_elf"], "ISR ELF"),
            root,
        )
    except (OSError, ValueError) as exc:
        raise CompositionValidationError(f"static rebuild verification: {exc}") from exc
    if rebuilt_static != static:
        raise CompositionValidationError("static manifest is stale versus rebuilt pair")

    try:
        validate_mode1_reset_fixtures.validate_manifest(
            resolved["lifecycle"], root
        )
    except (validate_mode1_reset_fixtures.FixtureValidationError, OSError) as exc:
        raise CompositionValidationError(f"lifecycle component: {exc}") from exc

    run = load_json(resolved["runtime_capture"])
    result = load_json(resolved["runtime_result"])
    diagnostic = load_json(resolved["busy_reset_diagnostic"])
    if run.get("status") != "CAPTURE_COMPLETE" or run.get("roms") != {
        "active": expected_identities["active"],
        "control": expected_identities["control"],
        "default": expected_identities["default"],
    }:
        raise CompositionValidationError("runtime capture composition identity")
    if (
        result.get("status") != "VALIDATION_STAGE_PASS"
        or result.get("capture_manifest_sha256") != sha256_file(resolved["runtime_capture"])
        or any(result.get(key) is not False for key in (
            "promotable", "ordinary_default", "promoted", "real_hardware_proven",
        ))
        or result.get("non_promotable") is not True
        or result.get("organic_gameplay") is not False
    ):
        raise CompositionValidationError("runtime result scope/binding")
    if (
        diagnostic.get("status") != "NON_ACCEPTANCE_DIAGNOSTIC"
        or diagnostic.get("accepted_by_runtime_validator") is not False
    ):
        raise CompositionValidationError("busy reset diagnostic entered acceptance")
    return {
        "schema": SCHEMA,
        "status": "VALIDATION_STAGE_PASS",
        "components_verified": len(EXPECTED_COMPONENTS),
        "lifecycle_runs_verified": 8,
        "non_promotable": True,
        "ordinary_default": False,
        "promoted": False,
        "real_hardware_proven": False,
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
