#!/usr/bin/env python3
"""Bind the Gate-A MMIO PC policy to the accepted mode-0 ROM manifest."""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from typing import Any

from validate_mmio_trace import (
    GATE_A_MODE0_PC_POLICY,
    GATE_A_PC_ALLOWLIST,
    PC_ALLOWLIST_TEXT,
    PcRange,
)

SCHEMA = "vrd-vr60-mmio-gate-a-policy-v1"
MODE0_SCHEMA = "vrd-vr60-mode0-rom-pair-v2"
GATE_B_STATUS = "BLOCKED_UNTIL_MODE1_CODE_IS_BUILT"
REQUIRED_GATE_B_FIELDS = (
    "mode1_helper_range",
    "mode1_reset_range",
    "master_alternate_handler_range",
    "trigger_reset_pc",
    "trigger_set_pc",
    "master_ack_pc",
    "ack_clear_pc",
    "fifo_full_read_pcs",
    "fifo_write_pcs",
    "completion_pc",
)
SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_POLICY = SCRIPT_DIR / "mmio_gate_a_policy.json"


class PolicyValidationError(ValueError):
    """The policy is not exactly bound to accepted Gate-A evidence."""


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _load_object(path: Path, label: str) -> dict[str, Any]:
    try:
        payload = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise PolicyValidationError(f"cannot read {label}: {exc}") from exc
    if not isinstance(payload, dict):
        raise PolicyValidationError(f"{label} must be a JSON object")
    return payload


def _hex32(value: object, label: str) -> int:
    if (
        not isinstance(value, str)
        or len(value) != 10
        or not value.startswith("0x")
        or value != f"0x{int(value, 16):08X}"
    ):
        raise PolicyValidationError(
            f"{label} must be canonical 0x plus eight uppercase hex digits"
        )
    return int(value, 16)


def _policy_range(
    policy: dict[str, Any], cpu: str, source: str
) -> PcRange:
    allowlist = policy.get("pc_allowlist")
    if not isinstance(allowlist, dict) or set(allowlist) != {"m68k", "master"}:
        raise PolicyValidationError("pc_allowlist must name only m68k and master")
    ranges = allowlist.get(cpu)
    if not isinstance(ranges, list) or len(ranges) != 1:
        raise PolicyValidationError(f"{cpu} must have exactly one Gate-A range")
    entry = ranges[0]
    if not isinstance(entry, dict) or set(entry) != {"start", "end", "source"}:
        raise PolicyValidationError(f"{cpu} range fields are not exact")
    if entry["source"] != source:
        raise PolicyValidationError(f"{cpu} range source is not {source}")
    start = _hex32(entry["start"], f"{cpu}.start")
    end = _hex32(entry["end"], f"{cpu}.end")
    if start >= end:
        raise PolicyValidationError(f"{cpu} range is empty or reversed")
    return PcRange(start, end)


def validate_policy(path: Path = DEFAULT_POLICY) -> None:
    policy = _load_object(path, "Gate-A policy")
    if policy.get("schema") != SCHEMA:
        raise PolicyValidationError("wrong Gate-A policy schema")
    if policy.get("eligible") is not True or policy.get("findings") != []:
        raise PolicyValidationError("Gate-A policy is not eligible and finding-free")
    if policy.get("range_semantics") != "end-exclusive":
        raise PolicyValidationError("PC ranges must be explicitly end-exclusive")

    source = policy.get("source_manifest")
    if not isinstance(source, dict) or set(source) != {"path", "schema", "sha256"}:
        raise PolicyValidationError("source_manifest fields are not exact")
    if source["schema"] != MODE0_SCHEMA:
        raise PolicyValidationError("wrong source manifest schema declaration")
    source_path = path.parent / source["path"]
    if _sha256(source_path) != source["sha256"]:
        raise PolicyValidationError("source mode-0 manifest hash mismatch")
    mode0 = _load_object(source_path, "source mode-0 manifest")
    if (
        mode0.get("schema") != MODE0_SCHEMA
        or mode0.get("eligible") is not True
        or mode0.get("findings") != []
    ):
        raise PolicyValidationError("source mode-0 manifest is not accepted")

    static = mode0.get("static_evidence")
    if not isinstance(static, dict):
        raise PolicyValidationError("source manifest lacks static_evidence")
    entity = static.get("entity_transfer")
    handler = static.get("cmd3e_handler")
    if not isinstance(entity, dict) or not isinstance(handler, dict):
        raise PolicyValidationError("source manifest lacks required code regions")
    expected_m68k = PcRange(
        int(entity["offset"], 0),
        int(entity["offset"], 0) + int(entity["size"]),
    )
    expected_master = PcRange(
        0x02000000 + int(handler["offset"], 0),
        0x02000000 + int(handler["offset"], 0) + int(handler["size"]),
    )
    actual_m68k = _policy_range(
        policy, "m68k", "static_evidence.entity_transfer"
    )
    actual_master = _policy_range(
        policy, "master", "static_evidence.cmd3e_handler"
    )
    if actual_m68k != expected_m68k or actual_master != expected_master:
        raise PolicyValidationError(
            "PC allowlist does not match accepted manifest offsets/sizes"
        )
    if (
        GATE_A_PC_ALLOWLIST.m68k != (actual_m68k,)
        or GATE_A_PC_ALLOWLIST.master != (actual_master,)
    ):
        raise PolicyValidationError("parser constants differ from policy manifest")
    canonical = (
        f"m68k:0x{actual_m68k.start:08X}-0x{actual_m68k.end:08X};"
        f"master:0x{actual_master.start:08X}-0x{actual_master.end:08X}"
    )
    if canonical != PC_ALLOWLIST_TEXT:
        raise PolicyValidationError("canonical header policy differs from manifest")

    witness = policy.get("gate_a_mode0_witness")
    if not isinstance(witness, dict):
        raise PolicyValidationError("missing Gate-A mode-0 witness")
    expected_pcs = {
        "trigger_reset_pc": GATE_A_MODE0_PC_POLICY.trigger_reset,
        "trigger_set_pc": GATE_A_MODE0_PC_POLICY.trigger_set,
        "master_ack_pc": GATE_A_MODE0_PC_POLICY.master_ack,
        "ack_clear_pc": GATE_A_MODE0_PC_POLICY.ack_clear,
        "fifo_tail_writer_pc": GATE_A_MODE0_PC_POLICY.fifo_write,
        "completion_pc": GATE_A_MODE0_PC_POLICY.completion,
    }
    for field, expected in expected_pcs.items():
        if _hex32(witness.get(field), field) != expected:
            raise PolicyValidationError(f"{field} differs from parser policy")
    if (
        witness.get("fifo_words_visible_in_allowlist") != 32
        or witness.get("expected_active_transactions") != 1
        or witness.get("expected_control_transactions") != 0
    ):
        raise PolicyValidationError("mode-0 witness counts are not exact")

    gate_b = policy.get("gate_b_manifest_dependency")
    if not isinstance(gate_b, dict):
        raise PolicyValidationError("missing Gate-B manifest dependency")
    if gate_b.get("status") != GATE_B_STATUS:
        raise PolicyValidationError("Gate-B dependency is not fail-closed")
    if gate_b.get("required_fields") != list(REQUIRED_GATE_B_FIELDS):
        raise PolicyValidationError("Gate-B required PC fields are not exact")
    if gate_b.get("note") != (
        "Gate A must not broaden its ranges to discover mode-1 acquisition PCs."
    ):
        raise PolicyValidationError("Gate-B non-broadening rule is missing")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("policy", nargs="?", type=Path, default=DEFAULT_POLICY)
    args = parser.parse_args(argv)
    try:
        validate_policy(args.policy)
    except (OSError, TypeError, ValueError, PolicyValidationError) as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1
    print(f"PASS: {args.policy}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
