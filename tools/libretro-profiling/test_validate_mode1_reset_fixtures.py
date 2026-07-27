#!/usr/bin/env python3
"""Unit tests for the frozen VR60 mode-1 reset fixture contract."""

from __future__ import annotations

import hashlib
import json
import tempfile
import unittest
from collections.abc import Callable
from pathlib import Path
from typing import Any

from validate_mode1_reset_fixtures import (
    EXPECTED_MODE1_PCS,
    EXPECTED_ROM_SHA256,
    FLAG_ADDRESS,
    RACING_HANDLER_PC,
    ROUTE_POLICY,
    SCENE_POINTER_ADDRESS,
    FixtureValidationError,
    validate_manifest,
)

EXPECTED_PCS = EXPECTED_MODE1_PCS


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def write_bytes(path: Path, data: bytes) -> str:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)
    return sha256_bytes(data)


def make_trace(route: str, arm: str, repetition: int) -> dict[str, Any]:
    initial_flag = 1 if route == "name_entry_reentry" else repetition - 1
    pointer_pc = ROUTE_POLICY[route]["pointer_writer_pc"]
    start_pc = 0x0000D000 if route == "normal_entry" else 0x00011700
    events = [
        {
            "sequence": 0,
            "frame": 1,
            "kind": "pointer_write",
            "cpu": "m68k",
            "source": "cpu_write_callback",
            "pc": pointer_pc,
            "address": SCENE_POINTER_ADDRESS,
            "width": 4,
            "old_value": 0x00884A3E,
            "new_value": EXPECTED_PCS["wrapper_entry_pc"],
        },
        {
            "sequence": 1,
            "frame": 2,
            "kind": "wrapper_entry",
            "cpu": "m68k",
            "source": "instruction_start",
            "pc": EXPECTED_PCS["wrapper_entry_pc"],
            "address": None,
            "width": None,
            "old_value": None,
            "new_value": None,
        },
        {
            "sequence": 2,
            "frame": 2,
            "kind": "flag_reset_write",
            "cpu": "m68k",
            "source": "cpu_write_callback",
            "pc": EXPECTED_PCS["flag_reset_writer_pc"],
            "address": FLAG_ADDRESS,
            "width": 1,
            "old_value": initial_flag,
            "new_value": 0,
        },
        {
            "sequence": 3,
            "frame": 3,
            "kind": "racing_handler_entry",
            "cpu": "m68k",
            "source": "instruction_start",
            "pc": RACING_HANDLER_PC,
            "address": None,
            "width": None,
            "old_value": None,
            "new_value": None,
        },
        {
            "sequence": 4,
            "frame": 4,
            "kind": "hook_flag_write",
            "cpu": "m68k",
            "source": "cpu_write_callback",
            "pc": EXPECTED_PCS["hook_flag_writer_pc"],
            "address": FLAG_ADDRESS,
            "width": 1,
            "old_value": 0,
            "new_value": 1,
        },
    ]
    return {
        "schema_version": 1,
        "route": route,
        "arm": arm,
        "repetition": repetition,
        "capture_start": {
            "frame": 0,
            "pc": start_pc,
            "flag": initial_flag,
            "scene_pointer": 0x00884A3E,
            "before_pointer_writer": True,
        },
        "events": events,
        "complete": True,
        "dropped": 0,
        "errors": 0,
    }


def make_fixture(root: Path) -> tuple[Path, dict[str, Any]]:
    manifest: dict[str, Any] = {
        "schema_version": 1,
        "eligible": True,
        "status": "VALIDATED",
        "blockers": [],
        "policy": {
            "scene_pointer_address": SCENE_POINTER_ADDRESS,
            "flag_address": FLAG_ADDRESS,
            "racing_handler_pc": RACING_HANDLER_PC,
            "repetitions_per_route_per_arm": 2,
            "routes": ROUTE_POLICY,
        },
        "expected_mode1_pcs": EXPECTED_PCS,
        "arms": {},
    }
    for arm in ("active", "control"):
        arm_entry: dict[str, Any] = {
            "rom_sha256": EXPECTED_ROM_SHA256[arm],
            "routes": {},
        }
        for route in ROUTE_POLICY:
            runs = []
            for repetition in (1, 2):
                prefix = Path("runs") / arm / route / str(repetition)
                state_path = prefix / "state.bin"
                replay_path = prefix / "replay.csv"
                trace_path = prefix / "reset_trace.json"
                state_sha = write_bytes(
                    root / state_path,
                    f"synthetic state {arm} {route} {repetition}".encode(),
                )
                replay_sha = write_bytes(
                    root / replay_path,
                    b"frame,mask\n0,0x0000\n1,0x0100\n",
                )
                trace_data = json.dumps(
                    make_trace(route, arm, repetition),
                    sort_keys=True,
                    indent=2,
                ).encode()
                trace_sha = write_bytes(root / trace_path, trace_data)
                runs.append(
                    {
                        "repetition": repetition,
                        "state_path": str(state_path),
                        "state_sha256": state_sha,
                        "replay_path": str(replay_path),
                        "replay_sha256": replay_sha,
                        "trace_path": str(trace_path),
                        "trace_sha256": trace_sha,
                    }
                )
            arm_entry["routes"][route] = runs
        manifest["arms"][arm] = arm_entry
    manifest_path = root / "manifest.json"
    manifest_path.write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    return manifest_path, manifest


def rewrite_trace(
    root: Path,
    manifest: dict[str, Any],
    *,
    arm: str = "active",
    route: str = "normal_entry",
    repetition: int = 1,
    mutate: Callable[[dict[str, Any]], None],
) -> None:
    run = manifest["arms"][arm]["routes"][route][repetition - 1]
    path = root / run["trace_path"]
    trace = json.loads(path.read_text(encoding="utf-8"))
    mutate(trace)
    data = json.dumps(trace, sort_keys=True, indent=2).encode()
    run["trace_sha256"] = write_bytes(path, data)
    (root / "manifest.json").write_text(
        json.dumps(manifest, indent=2), encoding="utf-8"
    )


class Mode1ResetFixtureTests(unittest.TestCase):
    def test_complete_two_replay_fixture_is_accepted(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            manifest_path, _ = make_fixture(Path(temp))
            self.assertEqual(validate_manifest(manifest_path), 8)

    def test_checked_in_placeholder_is_ineligible(self) -> None:
        placeholder = (
            Path(__file__).resolve().parent / "mode1_reset_fixtures.json"
        )
        with self.assertRaisesRegex(FixtureValidationError, "ineligible"):
            validate_manifest(placeholder)
        manifest = json.loads(placeholder.read_text(encoding="utf-8"))
        self.assertFalse(manifest["eligible"])
        self.assertEqual(manifest["expected_mode1_pcs"], EXPECTED_MODE1_PCS)
        self.assertEqual(
            {
                arm: manifest["arms"][arm]["rom_sha256"]
                for arm in ("active", "control")
            },
            EXPECTED_ROM_SHA256,
        )
        self.assertEqual(len(manifest["blockers"]), 1)
        self.assertIn("captured twice per arm", manifest["blockers"][0])

    def test_post_writer_capture_start_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            manifest_path, manifest = make_fixture(root)
            rewrite_trace(
                root,
                manifest,
                mutate=lambda trace: trace["capture_start"].update(
                    pc=ROUTE_POLICY["normal_entry"]["pointer_writer_pc"]
                ),
            )
            with self.assertRaisesRegex(FixtureValidationError, "starts at/after"):
                validate_manifest(manifest_path)

    def test_synthetic_direct_pointer_write_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            manifest_path, manifest = make_fixture(root)
            rewrite_trace(
                root,
                manifest,
                mutate=lambda trace: trace["events"][0].update(pc=0x0000E000),
            )
            with self.assertRaisesRegex(FixtureValidationError, "pinned pointer_write"):
                validate_manifest(manifest_path)

    def test_reentry_must_start_with_flag_one(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            manifest_path, manifest = make_fixture(root)

            def clear_initial_flag(trace: dict[str, Any]) -> None:
                trace["capture_start"]["flag"] = 0
                trace["events"][2]["old_value"] = 0

            rewrite_trace(
                root,
                manifest,
                route="name_entry_reentry",
                mutate=clear_initial_flag,
            )
            with self.assertRaisesRegex(FixtureValidationError, "must start with flag=1"):
                validate_manifest(manifest_path)

    def test_wrong_wrapper_reset_or_hook_pc_is_rejected(self) -> None:
        cases = ((1, "wrapper_entry"), (2, "flag_reset_write"), (4, "hook_flag_write"))
        for event_index, kind in cases:
            with self.subTest(kind=kind), tempfile.TemporaryDirectory() as temp:
                root = Path(temp)
                manifest_path, manifest = make_fixture(root)
                rewrite_trace(
                    root,
                    manifest,
                    mutate=lambda trace, index=event_index: trace["events"][
                        index
                    ].update(pc=0x00300200),
                )
                with self.assertRaisesRegex(FixtureValidationError, f"pinned {kind}"):
                    validate_manifest(manifest_path)

    def test_exactly_two_replays_per_route_per_arm_are_required(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            manifest_path, manifest = make_fixture(root)
            manifest["arms"]["control"]["routes"]["normal_entry"].pop()
            manifest_path.write_text(
                json.dumps(manifest, indent=2), encoding="utf-8"
            )
            with self.assertRaisesRegex(FixtureValidationError, "exactly two replays"):
                validate_manifest(manifest_path)


if __name__ == "__main__":
    unittest.main()
