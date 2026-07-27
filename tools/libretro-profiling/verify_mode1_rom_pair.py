#!/usr/bin/env python3
"""Fail-closed static verifier for the Q-020 mode-1 validation ROM pair."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import tempfile
from pathlib import Path

SCHEMA = "vrd-vr60-mode1-validation-pair-v1"
EXPECTED_SIZE = 4_128_768
EXPECTED_DEFAULT_SHA256 = "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900"
EXPECTED_ACTIVE_SHA256 = "f0cdb1a71e1a39e247e19355da8f1a3f62a5b67efd4f8ef09b2ec1119f7e4c3c"
EXPECTED_CONTROL_SHA256 = "2a958af78bf5643d808b3cb07517c8936aef3b082be14967ec8003f8f22ada10"

ROUTE_BYTES = bytes.fromhex("23fc0089c914")
ROUTE_OFFSETS = (0x00E0D4, 0x011822)
HOOK_OFFSET = 0x01C8B0
ACTIVE_HOOK = bytes.fromhex(
    "4a39ffff7b40661c4eb90001c4944eb90001c5064e714e714e7113fc0001ffff"
    "7b40602e4eb90001c5064eb90001c92260204e714e714e714e714e714e714e71"
    "4e714e714e714e714e714e714e714e714e714eb90000b6da4eb90000b6844ef9"
    "00004d6a"
)
CONTROL_HOOK = bytes.fromhex(
    "4a39ffff7b40661c4eb90001c4944eb90001c5064e714e714e7113fc0001ffff"
    "7b40602e4eb90001c5064e714e714e7160204e714e714e714e714e714e714e71"
    "4e714e714e714e714e714e714e714e714e714eb90000b6da4eb90000b6844ef9"
    "00004d6a"
)
PAIR_SLOT_OFFSET = 0x01C8DA
PAIR_SLOT_ACTIVE = bytes.fromhex("4eb90001c922")
PAIR_SLOT_CONTROL = bytes.fromhex("4e714e714e71")
WRAPPER_HELPER_OFFSET = 0x01C914
WRAPPER_HELPER = bytes.fromhex(
    "4e714239ffff7b404ef900884a3e48e7e0604a3900a1512066f833fc002000a1"
    "511013fc000400a1510713fc000100a1512613fc003e00a1512113fc000100a1"
    "51200839000100a1512367f608b9000100a1512343f900ff6b0045f900a15112"
    "74070839000700a1510766f67003349951c8fffc51caffec4a7900a1511066f8"
    "4cdf06074e75"
)
JUMP_OFFSET = 0x020878
JUMP_BYTES = bytes.fromhex("02303a10")
ORIGINAL_HANDLER_OFFSET = 0x3016B0
ORIGINAL_HANDLER_END = 0x301760
ORIGINAL_HANDLER_SHA256 = "d4bfc7747d0805ef508413f6a2fb3d1073a7ec2d735abe1fe02b3a7f2f3f41a8"
HANDLER_OFFSET = 0x303A10
HANDLER = bytes.fromhex(
    "d11e21824f22848688018b20d111d0122102d112d0122102d112d0132102d113"
    "d0132102d113e001210260128483cb0280838483d110601120088bfc8483c802"
    "8bfce000808084804f26000b0009affe00090009ffffff8020004012ffffff84"
    "0600f30cffffff8800000020ffffff8c000044e5ffffffb0200040102600fc04"
)
LITERAL_START = HANDLER_OFFSET + 0x54
LITERAL_END = HANDLER_OFFSET + len(HANDLER)
CANDIDATE_DEFAULT_ALLOWED_RANGES = (
    (0x00E0D4, 0x00E0DA),
    (0x011822, 0x011828),
    (HOOK_OFFSET, HOOK_OFFSET + len(ACTIVE_HOOK)),
    (WRAPPER_HELPER_OFFSET, WRAPPER_HELPER_OFFSET + len(WRAPPER_HELPER)),
    (JUMP_OFFSET, JUMP_OFFSET + len(JUMP_BYTES)),
    (HANDLER_OFFSET, HANDLER_OFFSET + len(HANDLER)),
)

GATE_B_PC_POLICY = {
    "trigger": ["0x0001C94E"],
    "master_ack": ["0x02303A40"],
    "ack_flush": ["0x02303A42"],
    "ack_observe": ["0x0001C956"],
    "ack_clear": ["0x0001C960"],
    "full_read": ["0x0001C976"],
    "fifo_write": ["0x0001C982"],
    "m68k_dreq_read": ["0x0001C98C"],
    "master_dreq_read": ["0x02303A46"],
    "ack_wait": ["0x02303A4C"],
    "completion": ["0x02303A54"],
    "completion_flush": ["0x02303A56"],
}


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def literal_users_in_handler_allocation(image: bytes) -> list[tuple[int, int]]:
    """Return SH2 MOV.L-PC users resolving anywhere in the handler allocation."""
    users: list[tuple[int, int]] = []
    for offset in range(0x0300000, len(image) - 1, 2):
        opcode = int.from_bytes(image[offset : offset + 2], "big")
        if opcode >> 12 != 0xD:
            continue
        pc = 0x02000000 + offset
        target = ((pc + 4) & ~3) + (opcode & 0xFF) * 4
        target_offset = target - 0x02000000
        if HANDLER_OFFSET <= target_offset < HANDLER_OFFSET + len(HANDLER):
            users.append((offset, target_offset))
    return users


def differences_outside_ranges(
    candidate: bytes,
    reference: bytes,
    allowed_ranges: tuple[tuple[int, int], ...] = CANDIDATE_DEFAULT_ALLOWED_RANGES,
) -> list[int]:
    """Return candidate/reference differences outside the explicit allocation."""
    if len(candidate) != len(reference):
        return [min(len(candidate), len(reference))]
    return [
        offset
        for offset, (left, right) in enumerate(zip(candidate, reference, strict=True))
        if left != right
        and not any(start <= offset < end for start, end in allowed_ranges)
    ]


def verify_pair(
    active_path: Path, control_path: Path, default_path: Path
) -> dict[str, object]:
    images = {
        "active": active_path.read_bytes(),
        "control": control_path.read_bytes(),
        "default": default_path.read_bytes(),
    }
    expected_hashes = {
        "active": EXPECTED_ACTIVE_SHA256,
        "control": EXPECTED_CONTROL_SHA256,
        "default": EXPECTED_DEFAULT_SHA256,
    }
    findings: list[str] = []
    hashes = {name: sha256(image) for name, image in images.items()}
    for name, image in images.items():
        if len(image) != EXPECTED_SIZE:
            findings.append(f"{name}_size:{len(image)}")
        if hashes[name] != expected_hashes[name]:
            findings.append(f"{name}_sha256:{hashes[name]}")

    active, control, default = (
        images["active"],
        images["control"],
        images["default"],
    )
    for offset in ROUTE_OFFSETS:
        if active[offset : offset + len(ROUTE_BYTES)] != ROUTE_BYTES:
            findings.append(f"active_route_0x{offset:X}")
        if control[offset : offset + len(ROUTE_BYTES)] != ROUTE_BYTES:
            findings.append(f"control_route_0x{offset:X}")
    for name, image, expected in (
        ("active", active, ACTIVE_HOOK),
        ("control", control, CONTROL_HOOK),
    ):
        if image[HOOK_OFFSET : HOOK_OFFSET + len(expected)] != expected:
            findings.append(f"{name}_hook")
        if image[
            WRAPPER_HELPER_OFFSET : WRAPPER_HELPER_OFFSET + len(WRAPPER_HELPER)
        ] != WRAPPER_HELPER:
            findings.append(f"{name}_wrapper_helper")
        if image[JUMP_OFFSET : JUMP_OFFSET + 4] != JUMP_BYTES:
            findings.append(f"{name}_jump")
        if image[HANDLER_OFFSET : HANDLER_OFFSET + len(HANDLER)] != HANDLER:
            findings.append(f"{name}_handler")
        if sha256(image[ORIGINAL_HANDLER_OFFSET:ORIGINAL_HANDLER_END]) != ORIGINAL_HANDLER_SHA256:
            findings.append(f"{name}_original_handler_changed")
        outside_default = differences_outside_ranges(image, default)
        if outside_default:
            findings.append(
                f"{name}_difference_outside_allowed_ranges:"
                + ",".join(f"0x{offset:X}" for offset in outside_default[:16])
            )

    differences = [
        offset
        for offset, (left, right) in enumerate(zip(active, control, strict=True))
        if left != right
    ]
    if active[PAIR_SLOT_OFFSET : PAIR_SLOT_OFFSET + 6] != PAIR_SLOT_ACTIVE:
        findings.append("active_pair_slot")
    if control[PAIR_SLOT_OFFSET : PAIR_SLOT_OFFSET + 6] != PAIR_SLOT_CONTROL:
        findings.append("control_pair_slot")
    if any(offset not in range(PAIR_SLOT_OFFSET, PAIR_SLOT_OFFSET + 6) for offset in differences):
        findings.append("pair_delta_outside_slot")

    expected_literal_users = [
        (HANDLER_OFFSET + offset, HANDLER_OFFSET + target)
        for offset, target in (
            (0x00, 0x7C),
            (0x0C, 0x54),
            (0x0E, 0x58),
            (0x12, 0x5C),
            (0x14, 0x60),
            (0x18, 0x64),
            (0x1A, 0x68),
            (0x1E, 0x6C),
            (0x20, 0x70),
            (0x24, 0x74),
            (0x34, 0x78),
        )
    ]
    literal_users = literal_users_in_handler_allocation(active)
    if literal_users != expected_literal_users:
        findings.append(
            "literal_pool_users:"
            + ",".join(f"0x{pc:X}->0x{target:X}" for pc, target in literal_users)
        )

    return {
        "schema": SCHEMA,
        "static_eligible": not findings,
        "eligible": False,
        "promotable": False,
        "runtime_evidence": "MISSING",
        "status": "BLOCKED_NO_RUNTIME_GATE_B_OR_RESET_EVIDENCE",
        "findings": findings,
        "hashes": hashes,
        "rom_size": len(active),
        "pair_delta": {
            "offset": f"0x{PAIR_SLOT_OFFSET:X}",
            "size": 6,
            "active_bytes": PAIR_SLOT_ACTIVE.hex(),
            "control_bytes": PAIR_SLOT_CONTROL.hex(),
            "different_offsets": [f"0x{offset:X}" for offset in differences],
        },
        "ranges": {
            "hook": "0x1C8B0-0x1C913",
            "wrapper_helper": "0x1C914-0x1C999",
            "dedicated_handler": "0x303A10-0x303A8F",
            "handler_literal_pool": "0x303A64-0x303A8F",
            "preserved_original_handler": "0x3016B0-0x30175F",
        },
        "literal_pool_users": [
            {"instruction": f"0x{pc:X}", "literal": f"0x{target:X}"}
            for pc, target in literal_users
        ],
        "gate_b_pc_policy": GATE_B_PC_POLICY,
        "gate_b_requirements": {
            "one_trigger_per_transaction": True,
            "ack_transition": "normally 0x03 -> 0x01; bit1 set/clear relationally",
            "ack_clear_before_fifo": True,
            "eight_full_checked_groups": True,
            "four_fifo_words_per_group": True,
            "both_cpus_observe_dreq_len_zero_before_master_ack_check": True,
            "same_address_flush_reads": ["master_ack", "completion"],
            "reset_routes_required": 2,
        },
    }


def write_manifest(path: Path, payload: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(
        "w", encoding="utf-8", dir=path.parent, prefix=f".{path.name}.", delete=False
    ) as stream:
        temporary = Path(stream.name)
        json.dump(payload, stream, indent=2, sort_keys=True)
        stream.write("\n")
        stream.flush()
        os.fsync(stream.fileno())
    os.replace(temporary, path)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--active", type=Path, required=True)
    parser.add_argument("--control", type=Path, required=True)
    parser.add_argument("--default", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args()
    payload = verify_pair(args.active, args.control, args.default)
    if not payload["static_eligible"]:
        print("FAIL: " + ", ".join(payload["findings"]))
        return 1
    write_manifest(args.manifest, payload)
    print("PASS: static candidate verified; runtime promotion remains blocked")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
