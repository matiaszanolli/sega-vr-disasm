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
EXPECTED_ACTIVE_SHA256 = "844543609366dd76925865c89d848306ff7a619cda637275143c60fbb3066402"
EXPECTED_CONTROL_SHA256 = "715f11de6478b3d96239ff54b7e38ce6ec3dc9e321b5d392bd660323e4ebbd17"

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
    "51204a3900a1512166f843f900ff6b0045f900a1511274070839000700a15107"
    "66f67003349951c8fffc51caffec4a7900a1511066f84cdf06074e75"
)
JUMP_OFFSET = 0x020878
JUMP_BYTES = bytes.fromhex("02303a10")
ORIGINAL_HANDLER_OFFSET = 0x3016B0
ORIGINAL_HANDLER_END = 0x301760
ORIGINAL_HANDLER_SHA256 = "d4bfc7747d0805ef508413f6a2fb3d1073a7ec2d735abe1fe02b3a7f2f3f41a8"
HANDLER_OFFSET = 0x303A10
HANDLER = bytes.fromhex(
    "d12421824f22848688018b2ad116d0172102d117d0172102d117d0182102d118"
    "d0182102d119e00121026012e0008081848120088b15608088018b12d1146011"
    "20088bfcd10e6012c80289fcd00e21026012c8078b05e000808084804f26000b"
    "0009affe00090009ffffff8020004012ffffff840600f30cffffff8800000020"
    "ffffff8c000044e1000044e0ffffffb0200040102600fc04"
)
LITERAL_START = HANDLER_OFFSET + 0x68
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
    "command_index": ["0x0001C946"],
    "trigger": ["0x0001C94E"],
    "ready_poll": ["0x0001C956"],
    "ready_publish": ["0x02303A3E"],
    "ready_flush": ["0x02303A40"],
    "busy_guard": ["0x02303A46"],
    "full_read": ["0x0001C96C"],
    "fifo_write": ["0x0001C978"],
    "m68k_dreq_read": ["0x0001C982"],
    "master_dreq_read": ["0x02303A4E"],
    "completion": ["0x02303A68"],
    "completion_flush": ["0x02303A6A"],
}

DMAC0_ACTIVE_LITERAL_OFFSET = 0x84
DMAC0_IDLE_LITERAL_OFFSET = 0x88
DMAC0_ACTIVE_CHCR = 0x000044E1
DMAC0_IDLE_CHCR = 0x000044E0
READINESS_SEQUENCE = bytes.fromhex("e0008081848120088b15608088018b12")
COMPLETION_SEQUENCE = bytes.fromhex("e00080808480")


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def dmac0_rearm_policy_errors(
    active_chcr: int, idle_chcr: int, *, repetitions: int = 2
) -> list[str]:
    """Model the pinned CHCR low-bit lifecycle across repeated transactions."""
    errors: list[str] = []
    if active_chcr != DMAC0_ACTIVE_CHCR:
        errors.append(f"active_chcr:0x{active_chcr:08X}")
    if active_chcr & 0x04:
        errors.append("active_dei_enabled")
    if active_chcr & 0x03 != 0x01:
        errors.append("active_not_te0_de1")
    if idle_chcr != DMAC0_IDLE_CHCR:
        errors.append(f"idle_chcr:0x{idle_chcr:08X}")
    if idle_chcr & 0x07:
        errors.append("idle_not_ie0_te0_de0")

    state = idle_chcr
    for repetition in range(repetitions):
        if state & 0x03:
            errors.append(f"cycle_{repetition}_prematurely_enabled")
            break
        state = active_chcr
        if state & 0x03 != 0x01:
            errors.append(f"cycle_{repetition}_cannot_arm")
            break
        state |= 0x02  # Normal TCR=0 completion sets TE.
        if state & 0x02 == 0:
            errors.append(f"cycle_{repetition}_te_not_set")
            break
        state = idle_chcr  # Read TE=1, then write TE=0 and DE=0.
    return errors


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
        helper = image[
            WRAPPER_HELPER_OFFSET : WRAPPER_HELPER_OFFSET + len(WRAPPER_HELPER)
        ]
        for register, addresses in {
            "comm1": ("00a15122", "00a15123"),
            "comm2": ("00a15124", "00a15125"),
            "comm7": ("00a1512e", "00a1512f"),
        }.items():
            if any(bytes.fromhex(address) in helper for address in addresses):
                findings.append(f"{name}_m68k_{register}_access")
        handler = image[HANDLER_OFFSET : HANDLER_OFFSET + len(HANDLER)]
        opcodes = {
            int.from_bytes(handler[offset : offset + 2], "big")
            for offset in range(0, len(handler), 2)
        }
        for register, forbidden_opcodes in {
            "comm1": {0x8082, 0x8482, 0x8083, 0x8483},
            "comm2": {0x8084, 0x8484, 0x8085, 0x8485},
            "comm7": {0x808E, 0x848E, 0x808F, 0x848F},
        }.items():
            if opcodes & forbidden_opcodes:
                findings.append(f"{name}_master_{register}_access")
        command_index = bytes.fromhex("13fc003e00a15121")
        trigger = bytes.fromhex("13fc000100a15120")
        ready_poll = bytes.fromhex("4a3900a15121")
        fifo_base = bytes.fromhex("45f900a15112")
        helper_positions = [
            helper.find(sequence)
            for sequence in (command_index, trigger, ready_poll, fifo_base)
        ]
        if (
            any(position < 0 for position in helper_positions)
            or helper_positions != sorted(helper_positions)
            or helper.count(command_index) != 1
            or helper.count(trigger) != 1
        ):
            findings.append(f"{name}_m68k_readiness_order")
        if handler.count(READINESS_SEQUENCE) != 1:
            findings.append(f"{name}_master_readiness_sequence")
        if handler.count(COMPLETION_SEQUENCE) != 1:
            findings.append(f"{name}_master_completion_flush_sequence")
        if bytes.fromhex("000044e5") in handler:
            findings.append(f"{name}_dmac0_interrupt_enabled")
        if bytes.fromhex("000044e1") not in handler:
            findings.append(f"{name}_dmac0_noninterrupt_active_missing")
        if bytes.fromhex("000044e0") not in handler:
            findings.append(f"{name}_dmac0_disabled_idle_missing")
        te_sequence = bytes.fromhex("d10e6012c80289fcd00e21026012c8078b05")
        if te_sequence not in handler:
            findings.append(f"{name}_dmac0_te_ack_sequence")
        active_chcr = int.from_bytes(
            handler[
                DMAC0_ACTIVE_LITERAL_OFFSET : DMAC0_ACTIVE_LITERAL_OFFSET + 4
            ],
            "big",
        )
        idle_chcr = int.from_bytes(
            handler[
                DMAC0_IDLE_LITERAL_OFFSET : DMAC0_IDLE_LITERAL_OFFSET + 4
            ],
            "big",
        )
        findings.extend(
            f"{name}_dmac0_rearm_{finding}"
            for finding in dmac0_rearm_policy_errors(active_chcr, idle_chcr)
        )
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
            (0x00, 0x94),
            (0x0C, 0x68),
            (0x0E, 0x6C),
            (0x12, 0x70),
            (0x14, 0x74),
            (0x18, 0x78),
            (0x1A, 0x7C),
            (0x1E, 0x80),
            (0x20, 0x84),
            (0x24, 0x8C),
            (0x3C, 0x90),
            (0x44, 0x80),
            (0x4C, 0x88),
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
            "wrapper_helper": "0x1C914-0x1C98F",
            "dedicated_handler": "0x303A10-0x303AA7",
            "handler_literal_pool": "0x303A78-0x303AA7",
            "preserved_original_handler": "0x3016B0-0x30175F",
        },
        "literal_pool_users": [
            {"instruction": f"0x{pc:X}", "literal": f"0x{target:X}"}
            for pc, target in literal_users
        ],
        "gate_b_pc_policy": GATE_B_PC_POLICY,
        "gate_b_requirements": {
            "command_index_before_trigger": True,
            "one_trigger_per_transaction": True,
            "no_fifo_before_trigger": True,
            "readiness_signal": "COMM0_LO:0x3E->0x00",
            "readiness_publish_after_dmac0_arm_and_dmaor_sync": True,
            "readiness_same_byte_readback_zero": True,
            "comm0_hi_busy_guard_one": True,
            "no_fifo_before_readiness_zero": True,
            "eight_full_checked_groups": True,
            "four_fifo_words_per_group": True,
            "both_cpus_observe_dreq_len_zero_before_completion": True,
            "dmac0_active_chcr": "0x000044E1",
            "dmac0_interrupt_enable": False,
            "dmac0_wait_te_before_completion": True,
            "dmac0_te_acknowledge": "read-1 then write-0",
            "dmac0_post_completion_chcr": "0x000044E0",
            "dmac0_post_completion_state": "IE=0,TE=0,DE=0",
            "dmac0_rearm_order": [
                "SAR0",
                "DAR0",
                "TCR0",
                "CHCR0=0x000044E1",
                "DMAOR.DME=1",
                "DMAOR same-address read",
                "COMM0_LO=0x00",
                "COMM0_LO same-byte read",
                "COMM0_HI==0x01 guard",
            ],
            "forbidden_comm_registers": ["COMM1", "COMM2", "COMM7"],
            "same_address_flush_reads": ["DMAOR", "readiness", "completion"],
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
