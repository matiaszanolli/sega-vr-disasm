#!/usr/bin/env python3
"""Validate the frozen mode-1 lifecycle/reset evidence reference."""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from typing import Any

import mode1_cmdint_runtime


SCHEMA = "vrd-vr60-q020-mode1-lifecycle-v2"
ACTIVE_SHA256 = mode1_cmdint_runtime.ACTIVE_SHA256
CONTROL_SHA256 = mode1_cmdint_runtime.CONTROL_SHA256
DEFAULT_SHA256 = mode1_cmdint_runtime.DEFAULT_SHA256
RUNTIME_RUN = "analysis/evidence/vr60-q020-mode1-cmdint-gate/runtime/run.json"
RUNTIME_RESULT = "analysis/evidence/vr60-q020-mode1-cmdint-gate/runtime/result.json"
RESET_DIAGNOSTIC = (
    "analysis/evidence/vr60-q020-mode1-cmdint-gate/reset-diagnostics/run.json"
)
EXPECTED_DIAGNOSTIC_ARTIFACTS = set(
    mode1_cmdint_runtime.BUSY_RESET_DIAGNOSTIC_ARTIFACTS
)


class FixtureValidationError(ValueError):
    """The lifecycle reference or one of its evidence components is invalid."""


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
        raise FixtureValidationError(f"cannot load {path}: {exc}") from exc


def require_exact_keys(value: Any, expected: set[str], label: str) -> dict[str, Any]:
    if not isinstance(value, dict) or set(value) != expected:
        actual = set(value) if isinstance(value, dict) else set()
        raise FixtureValidationError(
            f"{label} keys mismatch: missing={sorted(expected - actual)} "
            f"extra={sorted(actual - expected)}"
        )
    return value


def resolve_repo_path(repo_root: Path, value: Any, label: str) -> Path:
    if not isinstance(value, str) or not value:
        raise FixtureValidationError(f"{label} must be a repository-relative path")
    relative = Path(value)
    if relative.is_absolute() or ".." in relative.parts:
        raise FixtureValidationError(f"{label} escapes repository root")
    root = repo_root.resolve()
    path = (root / relative).resolve()
    if path == root or root not in path.parents or not path.is_file():
        raise FixtureValidationError(f"{label} is not an archived file: {path}")
    return path


def validate_component(
    component: Any, *, expected_path: str, repo_root: Path, label: str
) -> Path:
    component = require_exact_keys(component, {"path", "sha256"}, label)
    if component["path"] != expected_path:
        raise FixtureValidationError(f"{label}.path does not match frozen evidence")
    path = resolve_repo_path(repo_root, component["path"], f"{label}.path")
    if component["sha256"] != sha256_file(path):
        raise FixtureValidationError(f"{label}.sha256 mismatch")
    return path


def validate_diagnostic(path: Path) -> dict[str, Any]:
    payload = require_exact_keys(
        load_json(path),
        {
            "accepted_by_runtime_validator", "artifacts", "fault_cpu", "fault_pc",
            "finding", "frame", "observations", "roms", "schema", "status",
            "toolchain",
        },
        "reset diagnostic",
    )
    if (
        payload["schema"] != mode1_cmdint_runtime.SCHEMA
        or payload["status"] != "NON_ACCEPTANCE_DIAGNOSTIC"
        or payload["accepted_by_runtime_validator"] is not False
        or payload["frame"] != 1280
        or payload["fault_cpu"] != "Slave SH2"
        or payload["fault_pc"] != "0x06000638"
        or payload["finding"] != "baseline_picodrive_busy_slave_reset_defect"
        or payload["roms"] != {
            "active": ACTIVE_SHA256,
            "control": CONTROL_SHA256,
            "default": DEFAULT_SHA256,
        }
    ):
        raise FixtureValidationError("reset diagnostic policy/identity")
    artifacts = payload["artifacts"]
    if not isinstance(artifacts, dict) or set(artifacts) != EXPECTED_DIAGNOSTIC_ARTIFACTS:
        raise FixtureValidationError("reset diagnostic artifact set")
    for name in EXPECTED_DIAGNOSTIC_ARTIFACTS:
        metadata = require_exact_keys(artifacts[name], {"path", "sha256", "size"}, name)
        if metadata["path"] != name:
            raise FixtureValidationError(f"reset diagnostic artifact path: {name}")
        artifact = path.parent / name
        if (
            not artifact.is_file()
            or artifact.stat().st_size != metadata["size"]
            or sha256_file(artifact) != metadata["sha256"]
        ):
            raise FixtureValidationError(f"reset diagnostic artifact identity: {name}")
    return payload


def validate_manifest(manifest_path: Path, repo_root: Path | None = None) -> int:
    if repo_root is None:
        repo_root = Path(__file__).resolve().parents[2]
    manifest = require_exact_keys(
        load_json(manifest_path),
        {
            "schema", "status", "validation_stage_eligible", "non_promotable",
            "organic_gameplay", "roms", "capture_matrix", "routes", "safe_vres",
            "busy_slave_vres", "runtime_capture", "runtime_result",
            "reset_diagnostic",
        },
        "lifecycle manifest",
    )
    if (
        manifest["schema"] != SCHEMA
        or manifest["status"] != "VALIDATION_STAGE_PASS"
        or manifest["validation_stage_eligible"] is not True
        or manifest["non_promotable"] is not True
        or manifest["organic_gameplay"] is not False
    ):
        raise FixtureValidationError("lifecycle status/scope")
    if manifest["roms"] != {
        "active": ACTIVE_SHA256,
        "control": CONTROL_SHA256,
        "default": DEFAULT_SHA256,
    }:
        raise FixtureValidationError("lifecycle ROM identity")
    if manifest["capture_matrix"] != {
        "arms": ["active", "control"],
        "routes": ["normal", "name"],
        "repeats_per_arm_route": 2,
        "independent_run_count": 8,
    }:
        raise FixtureValidationError("lifecycle capture matrix")
    if manifest["routes"] != {
        "normal": {
            "chain": "0088E0D4->0089C914->00884C6A->00884CBC",
            "hook_flag_writer": "0001C8CA:0->1",
            "transport": "ACTIVE_ONLY",
        },
        "name": {
            "chain": "00891822->0089C914->C80E_bit3->00884C98->00885618",
            "wrapper_flag_writer": "0089C916:1->0",
            "hook_flag_writer": "FORBIDDEN",
            "transport": "FORBIDDEN",
            "fixture": "SEEDED_DIAGNOSTIC_NOT_ORGANIC",
        },
    }:
        raise FixtureValidationError("lifecycle route contract")
    if manifest["safe_vres"] != {
        "frame": 1241, "vres_count": 1, "init_count": "1->3",
        "scope": "PINNED_STOCK_SAFE_BOUNDARY_ONLY",
    }:
        raise FixtureValidationError("safe VRES contract")
    if manifest["busy_slave_vres"] != {
        "frame": 1280,
        "status": "UNPROVEN_BASELINE_PICODRIVE_RESET_DEFECT",
        "accepted": False,
    }:
        raise FixtureValidationError("busy-Slave VRES scope")

    run_path = validate_component(
        manifest["runtime_capture"], expected_path=RUNTIME_RUN,
        repo_root=repo_root, label="runtime_capture",
    )
    result_path = validate_component(
        manifest["runtime_result"], expected_path=RUNTIME_RESULT,
        repo_root=repo_root, label="runtime_result",
    )
    diagnostic_path = validate_component(
        manifest["reset_diagnostic"], expected_path=RESET_DIAGNOSTIC,
        repo_root=repo_root, label="reset_diagnostic",
    )
    try:
        computed_result = mode1_cmdint_runtime.validate(run_path)
    except (OSError, ValueError, json.JSONDecodeError) as exc:
        raise FixtureValidationError(f"runtime evidence: {exc}") from exc
    archived_result = load_json(result_path)
    if computed_result != archived_result:
        raise FixtureValidationError("archived runtime result is stale or mismatched")
    if archived_result.get("capture_manifest_sha256") != sha256_file(run_path):
        raise FixtureValidationError("runtime result does not bind capture manifest")
    validate_diagnostic(diagnostic_path)
    return 8


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "manifest", nargs="?", type=Path,
        default=Path(__file__).resolve().with_name("mode1_reset_fixtures.json"),
    )
    parser.add_argument("--repo-root", type=Path)
    args = parser.parse_args(argv)
    try:
        count = validate_manifest(args.manifest, args.repo_root)
    except (FixtureValidationError, OSError) as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1
    print(f"PASS: {count} lifecycle runs plus scoped VRES/reset evidence")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
