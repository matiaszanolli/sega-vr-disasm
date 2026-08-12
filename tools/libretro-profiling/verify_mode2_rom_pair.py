#!/usr/bin/env python3
"""Fail-closed static verifier for the isolated Q-021 mode-2 CMDINT pair."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

import verify_mode1_rom_pair as mode1


SCHEMA = "vrd-vr60-mode2-cmdint-pair-v1"
EXPECTED_SIZE = 0x3F0000
EXPECTED_DEFAULT_SHA256 = mode1.EXPECTED_DEFAULT_SHA256
EXPECTED_MODE1_ACTIVE_SHA256 = mode1.EXPECTED_ACTIVE_SHA256
EXPECTED_MODE1_CONTROL_SHA256 = mode1.EXPECTED_CONTROL_SHA256
EXPECTED_MODE1_ISR_SHA256 = mode1.ISR_SHA256
EXPECTED_ACTIVE_SHA256 = "96d79e3fb4d2df8a69852917ac811f860935ae950fc87222d008fa45d47ee276"
EXPECTED_CONTROL_SHA256 = "da5ce4ec9ef8e050c7babeb113e26aa7335a3ff5285285e55a6606d2f96309b8"
ISR_SHA256 = "b7fc5726dd503f35f08625a6159bed2cff06720ea85a89848bc2e70e64eaaaa7"

ROUTE_OFFSETS = mode1.ROUTE_OFFSETS
DEFAULT_ROUTE = mode1.DEFAULT_ROUTE
MODE2_ROUTE = mode1.MODE1_ROUTE
HOOK_OFFSET = 0x01C8B0
HOOK_END = 0x01C914
ACTIVE_HOOK = bytes.fromhex(
    "4a39ffff7b40664a4eb90001c6824e714e714e714eb90001c92213fc0001ffff"
    "7b40602e" + "4e71" * 23 +
    "4eb90000b6da4eb90000b6844ef900004d6a"
)
CONTROL_HOOK = bytes.fromhex(
    "4a39ffff7b40664a4eb90001c6824e714e714e714e714e714e7113fc0001ffff"
    "7b40602e" + "4e71" * 23 +
    "4eb90000b6da4eb90000b6844ef900004d6a"
)
PAIR_SLOT_OFFSET = 0x01C8C4
PAIR_SLOT_ACTIVE = bytes.fromhex("4eb90001c922")
PAIR_SLOT_CONTROL = bytes.fromhex("4e714e714e71")
EXPECTED_PAIR_DIFFERENCES = [
    PAIR_SLOT_OFFSET + index
    for index, (active, control) in enumerate(
        zip(PAIR_SLOT_ACTIVE, PAIR_SLOT_CONTROL, strict=True)
    )
    if active != control
]

M68K_OFFSET = 0x01C914
M68K_END = 0x01C9CE
VECTOR_OFFSET = mode1.VECTOR_OFFSET
VECTOR_COUNT = mode1.VECTOR_COUNT
DEFAULT_VECTOR = mode1.DEFAULT_VECTOR
MODE2_VECTOR = mode1.MODE1_VECTOR
STARTUP_LITERAL_OFFSET = mode1.STARTUP_LITERAL_OFFSET
DEFAULT_STARTUP_LITERAL = mode1.DEFAULT_STARTUP_LITERAL
MODE2_STARTUP_LITERAL = mode1.MODE1_STARTUP_LITERAL
EXPECTED_STARTUP_LITERAL_USERS = mode1.EXPECTED_STARTUP_LITERAL_USERS
CMD3E_JUMP_OFFSET = mode1.CMD3E_JUMP_OFFSET
CMD3E_JUMP = mode1.CMD3E_JUMP
CMD3F_JUMP_OFFSET = mode1.CMD3F_JUMP_OFFSET
CMD3F_JUMP = mode1.CMD3F_JUMP
ORIGINAL_HANDLER_OFFSET = mode1.ORIGINAL_HANDLER_OFFSET
ORIGINAL_HANDLER_END = mode1.ORIGINAL_HANDLER_END
ORIGINAL_HANDLER_SHA256 = mode1.ORIGINAL_HANDLER_SHA256
ISR_OFFSET = 0x303B00
ISR_END = 0x303F20
ISR_SIZE = ISR_END - ISR_OFFSET
ISR_ENTRY_SYMBOL = "cmd3e_mode2_validation"
ISR_ENTRY_ADDRESS = 0x02303B00
SHIM_SYMBOL = "q021_mode2_cmdint_init"
SHIM_ADDRESS = 0x02303E60
EXTERNAL_LITERAL_USER = mode1.EXTERNAL_LITERAL_USER
EXTERNAL_LITERAL_USER_BYTES = mode1.EXTERNAL_LITERAL_USER_BYTES
EXTERNAL_LITERAL_BYTES = mode1.EXTERNAL_LITERAL_BYTES
ISR_PROTOCOL_SLICE_SHA256 = {
    "setup_acceptance": (0x06A, 0x0C8, "b4a0096a1d070aad4874f0ef23b66b317fbafc0cf0cf4858d6426e99cd78ca61"),
    "setup_arm": (0x0C8, 0x130, "a8c9b6f3332c023cfea78d63b19262db5c22b365d1051d3710fe53e9b615fe74"),
    "completion_terminal": (0x130, 0x186, "e3846e7fe1837efbe564b32431a83dcc590a7859ce2de3922f75fce20fa92889"),
    "cmd_clear_restore": (0x1B8, 0x1EE, "ce83a2c2312d2a218feede4795fd6a2af03d8bd1609ab135e503c18d756ea135"),
    "destination_signature": (0x1EE, 0x20E, "e01e11951bef34274353c6ee46a50a2eac85c9dd34e25ec60942cbf1980be615"),
    "completion_identity": (0x20E, 0x25C, "dbf89179616d799d0710318ccb7d991b888c45c2e0a48e6afaf09a681c4030c8"),
    "setup_ownership": (0x25C, 0x2B2, "4b1fc20b34ec075224bda3ab818830be74b25753d737c8762dbc93d707d6a66e"),
}

EXPECTED_LITERAL_USERS = [
    (0x3039FC, 0x303CB4), (0x303B12, 0x303EA8), (0x303B2E, 0x303EAC),
    (0x303B52, 0x303F0C), (0x303B58, 0x303EAC), (0x303B74, 0x303EB4),
    (0x303B7E, 0x303EC0), (0x303B84, 0x303EF0), (0x303BAA, 0x303EC0),
    (0x303BCA, 0x303ED8), (0x303BD0, 0x303F00), (0x303BD4, 0x303EFC),
    (0x303BF6, 0x303EC8), (0x303BF8, 0x303ECC), (0x303BFC, 0x303ED0),
    (0x303BFE, 0x303EE8), (0x303C02, 0x303ED4), (0x303C04, 0x303EF0),
    (0x303C08, 0x303ED8), (0x303C0A, 0x303EF4), (0x303C0E, 0x303EDC),
    (0x303C32, 0x303ED8), (0x303C36, 0x303EF8), (0x303C3C, 0x303EF4),
    (0x303C4A, 0x303ED4), (0x303C56, 0x303ED0), (0x303C5A, 0x303EEC),
    (0x303C64, 0x303ED8), (0x303C66, 0x303EFC), (0x303C94, 0x303EB0),
    (0x303C96, 0x303F10), (0x303CB8, 0x303EB0), (0x303CD0, 0x303EC4),
    (0x303CD8, 0x303EB0), (0x303CF0, 0x303EB8), (0x303CF6, 0x303EE0),
    (0x303CFC, 0x303EBC), (0x303D02, 0x303EE4), (0x303D1A, 0x303EC8),
    (0x303D1E, 0x303ECC), (0x303D24, 0x303ED0), (0x303D28, 0x303EE8),
    (0x303D2E, 0x303EEC), (0x303D34, 0x303ED4), (0x303D38, 0x303EF0),
    (0x303D3E, 0x303ED8), (0x303D42, 0x303EF4), (0x303D48, 0x303EF8),
    (0x303D4E, 0x303EDC), (0x303D68, 0x303F04), (0x303D8C, 0x303F08),
    (0x303DA4, 0x303ED4), (0x303DB6, 0x303F14), (0x303DBE, 0x303F18),
    (0x303E12, 0x303F1C), (0x303E1C, 0x303EAC), (0x303E2C, 0x303F1C),
    (0x303E62, 0x303E98), (0x303E66, 0x303E9C), (0x303E6E, 0x303EA0),
    (0x303E82, 0x303E9C), (0x303E86, 0x303EA0), (0x303E92, 0x303EA4),
]

ALLOWED_DIFF_RANGES = (
    (ROUTE_OFFSETS[0], ROUTE_OFFSETS[0] + len(MODE2_ROUTE)),
    (ROUTE_OFFSETS[1], ROUTE_OFFSETS[1] + len(MODE2_ROUTE)),
    (HOOK_OFFSET, HOOK_END), (M68K_OFFSET, M68K_END),
    (VECTOR_OFFSET, VECTOR_OFFSET + VECTOR_COUNT * 4),
    (STARTUP_LITERAL_OFFSET, STARTUP_LITERAL_OFFSET + 4),
    (ISR_OFFSET, ISR_END),
)


def differences_outside_ranges(candidate: bytes, reference: bytes) -> list[int]:
    if len(candidate) != len(reference):
        return [min(len(candidate), len(reference))]
    return [
        offset
        for offset, (left, right) in enumerate(zip(candidate, reference, strict=True))
        if left != right
        and not any(start <= offset < end for start, end in ALLOWED_DIFF_RANGES)
    ]


def source_policy_errors(repo_root: Path) -> list[str]:
    errors: list[str] = []
    vrd = (repo_root / "disasm/vrd.asm").read_text()
    if not all(fragment in vrd for fragment in (
        "ifd     VR60_MODE2_VALIDATION", "ifd     VR60_MODE1_VALIDATION",
        "mutually exclusive",
    )):
        errors.append("source_mutual_exclusion_guard")
    hook = (repo_root / "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm").read_text()
    for fragment in (
        "ifd     VR60_MODE2_VALIDATION", "jsr     vr60_ai_entity_stage",
        "ifd     VR60_MODE2_STAGE_CONTROL",
        "jsr     vr60_1p_ai_transfer_mode2_validation",
        "mode 0/1, relay, cmd $3F absent",
    ):
        if fragment not in hook:
            errors.append(f"source_hook:{fragment}")
    producer = (repo_root / "disasm/modules/68k/sh2/vr60_mode1_validation.asm").read_text()
    for fragment in (
        "move.w  #$0001,MARS_DREQ_DST_H", "move.w  #$0000,MARS_DREQ_DST_L",
        "move.w  #$0780,MARS_DREQ_LEN", "lea     $00FF6B40,a1",
        "move.w  #479,d2", "moveq   #3,d0", "move.w  (a1)+,(a2)",
    ):
        if fragment not in producer:
            errors.append(f"source_producer:{fragment}")
    if producer.count("ori.b   #$01,MARS_SYS_INTMASK+1") != 2:
        errors.append("source_two_cmd_edges")
    for forbidden in (
        "COMM0_HI", "COMM0_LO", "COMM1", "COMM2", "COMM3", "COMM4",
        "COMM5", "COMM6", "COMM7",
    ):
        if forbidden in producer:
            errors.append(f"source_forbidden_{forbidden.lower()}")
    isr = (repo_root / "disasm/sh2/expansion/cmd3e_mode1_validation.asm").read_text()
    for fragment in (
        ".L_transfer_words:   .long 0x00000780",
        ".L_transfer_dst:     .long 0x06010000",
        ".L_transfer_end:     .long 0x06010F00",
        "same-address DMAOR synchronization", "prior read observed TE=1",
        "mov.w   @r1,r0                   /* synchronization; value is unspecified */",
        "rte\n    nop",
    ):
        if fragment not in isr:
            errors.append(f"source_isr:{fragment}")
    return errors


def verify_pair(
    active_path: Path, control_path: Path, default_path: Path,
    mode1_active_path: Path, mode1_control_path: Path,
    isr_bin_path: Path, isr_elf_path: Path, repo_root: Path,
) -> dict[str, object]:
    images = {
        "active": active_path.read_bytes(), "control": control_path.read_bytes(),
        "default": default_path.read_bytes(),
        "mode1_active": mode1_active_path.read_bytes(),
        "mode1_control": mode1_control_path.read_bytes(),
    }
    isr_bin = isr_bin_path.read_bytes()
    isr_elf = isr_elf_path.read_bytes()
    hashes = {name: mode1.sha256(image) for name, image in images.items()}
    hashes["isr_bin"] = mode1.sha256(isr_bin)
    hashes["mode1_isr_bin"] = mode1.sha256(
        (repo_root / "build/sh2/cmd3e_mode1_validation.bin").read_bytes()
    )
    expected_hashes = {
        "active": EXPECTED_ACTIVE_SHA256, "control": EXPECTED_CONTROL_SHA256,
        "default": EXPECTED_DEFAULT_SHA256,
        "mode1_active": EXPECTED_MODE1_ACTIVE_SHA256,
        "mode1_control": EXPECTED_MODE1_CONTROL_SHA256,
        "isr_bin": ISR_SHA256, "mode1_isr_bin": EXPECTED_MODE1_ISR_SHA256,
    }
    findings: list[str] = []
    for name, digest in hashes.items():
        if digest != expected_hashes[name]:
            findings.append(f"{name}_sha256:{digest}")
    for name, image in images.items():
        if len(image) != EXPECTED_SIZE:
            findings.append(f"{name}_size:{len(image)}")
    if len(isr_bin) != ISR_SIZE:
        findings.append(f"isr_bin_size:{len(isr_bin)}")

    active, control, default = images["active"], images["control"], images["default"]
    for offset in ROUTE_OFFSETS:
        for name, image, expected in (
            ("active", active, MODE2_ROUTE), ("control", control, MODE2_ROUTE),
            ("default", default, DEFAULT_ROUTE),
        ):
            if image[offset : offset + len(expected)] != expected:
                findings.append(f"{name}_route_0x{offset:X}")
    for name, image, hook in (
        ("active", active, ACTIVE_HOOK), ("control", control, CONTROL_HOOK),
    ):
        if image[HOOK_OFFSET:HOOK_END] != hook:
            findings.append(f"{name}_hook")
        if image[VECTOR_OFFSET : VECTOR_OFFSET + VECTOR_COUNT * 4] != MODE2_VECTOR * VECTOR_COUNT:
            findings.append(f"{name}_vectors")
        if image[STARTUP_LITERAL_OFFSET : STARTUP_LITERAL_OFFSET + 4] != MODE2_STARTUP_LITERAL:
            findings.append(f"{name}_startup_literal")
        if image[ISR_OFFSET:ISR_END] != isr_bin:
            findings.append(f"{name}_isr_binary")
        if image[CMD3E_JUMP_OFFSET:CMD3E_JUMP_OFFSET + 4] != CMD3E_JUMP:
            findings.append(f"{name}_cmd3e_jump")
        if image[CMD3F_JUMP_OFFSET:CMD3F_JUMP_OFFSET + 4] != CMD3F_JUMP:
            findings.append(f"{name}_cmd3f_jump")
        if mode1.sha256(image[ORIGINAL_HANDLER_OFFSET:ORIGINAL_HANDLER_END]) != ORIGINAL_HANDLER_SHA256:
            findings.append(f"{name}_original_cmd3e_changed")
        outside = differences_outside_ranges(image, default)
        if outside:
            findings.append(
                f"{name}_difference_outside_allowed_ranges:"
                + ",".join(f"0x{offset:X}" for offset in outside[:16])
            )
    if default[VECTOR_OFFSET : VECTOR_OFFSET + VECTOR_COUNT * 4] != DEFAULT_VECTOR * VECTOR_COUNT:
        findings.append("default_vectors")
    if default[STARTUP_LITERAL_OFFSET:STARTUP_LITERAL_OFFSET + 4] != DEFAULT_STARTUP_LITERAL:
        findings.append("default_startup_literal")
    if default[CMD3E_JUMP_OFFSET:CMD3E_JUMP_OFFSET + 4] != CMD3E_JUMP:
        findings.append("default_cmd3e_jump")
    if default[CMD3F_JUMP_OFFSET:CMD3F_JUMP_OFFSET + 4] != CMD3F_JUMP:
        findings.append("default_cmd3f_jump")

    differences = [
        offset for offset, (left, right) in enumerate(zip(active, control, strict=True))
        if left != right
    ]
    if active[PAIR_SLOT_OFFSET:PAIR_SLOT_OFFSET + 6] != PAIR_SLOT_ACTIVE:
        findings.append("active_pair_slot")
    if control[PAIR_SLOT_OFFSET:PAIR_SLOT_OFFSET + 6] != PAIR_SLOT_CONTROL:
        findings.append("control_pair_slot")
    if differences != EXPECTED_PAIR_DIFFERENCES:
        findings.append("pair_delta_not_exact_slot")

    helper = active[M68K_OFFSET:M68K_END]
    trigger = bytes.fromhex("0039000100a15103")
    if helper.count(trigger) != 2:
        findings.append("producer_two_cmd_edges")
    if any(bytes.fromhex(f"00a151{suffix:02x}") in helper for suffix in range(0x20, 0x30)):
        findings.append("producer_forbidden_comm_access")
    required = (
        bytes.fromhex("33fc000100a1510c"), bytes.fromhex("33fc000000a1510e"),
        bytes.fromhex("33fc078000a15110"), bytes.fromhex("43f900ff6b40"),
        bytes.fromhex("343c01df"), bytes.fromhex("7003349951c8fffc51caffec"),
    )
    if any(needle not in helper for needle in required):
        findings.append("producer_mode2_constants_or_group_loop")

    literal_users = mode1.movl_pc_users_in_range(active, ISR_OFFSET, ISR_END)
    if literal_users != EXPECTED_LITERAL_USERS:
        findings.append("isr_literal_users")
    if mode1.movl_pc_users_in_range(
        active, STARTUP_LITERAL_OFFSET, STARTUP_LITERAL_OFFSET + 4
    ) != EXPECTED_STARTUP_LITERAL_USERS:
        findings.append("startup_literal_users")
    for name, image in (("active", active), ("control", control), ("default", default)):
        if image[EXTERNAL_LITERAL_USER[0]:EXTERNAL_LITERAL_USER[0] + 4] != EXTERNAL_LITERAL_USER_BYTES:
            findings.append(f"{name}_external_literal_user_bytes")
    for name, image in (("active", active), ("control", control)):
        if image[EXTERNAL_LITERAL_USER[1]:EXTERNAL_LITERAL_USER[1] + 4] != EXTERNAL_LITERAL_BYTES:
            findings.append(f"{name}_external_literal_value")

    isr = active[ISR_OFFSET:ISR_END]
    for name, (start, end, expected) in ISR_PROTOCOL_SLICE_SHA256.items():
        if mode1.sha256(isr[start:end]) != expected:
            findings.append(f"isr_protocol_slice:{name}")
    rte_offsets = [
        offset for offset in range(0, len(isr) - 1, 2)
        if isr[offset : offset + 2] == b"\x00\x2b"
    ]
    if rte_offsets != [0x348] or any(
        isr[offset + 2 : offset + 4] != b"\x00\x09" for offset in rte_offsets
    ):
        findings.append("isr_rte_explicit_nop_delay")
    for literal in (
        0x00000780, 0x06010000, 0x06010F00, 0x000044E1, 0x000044E3,
        0x000044E0, 0x2000401A, 0x2600BC20,
    ):
        if literal.to_bytes(4, "big") not in isr:
            findings.append(f"isr_literal_missing:0x{literal:08X}")
    for comm_address in range(0x20004020, 0x20004030):
        if comm_address.to_bytes(4, "big") in isr:
            findings.append(f"isr_forbidden_comm_literal:0x{comm_address:08X}")
    try:
        entry = mode1.elf32_symbol_value(isr_elf, ISR_ENTRY_SYMBOL)
        shim = mode1.elf32_symbol_value(isr_elf, SHIM_SYMBOL)
    except ValueError as error:
        findings.append(str(error)); entry = shim = None
    if entry != ISR_ENTRY_ADDRESS:
        findings.append(f"isr_entry_symbol:{entry!r}")
    if shim != SHIM_ADDRESS:
        findings.append(f"isr_shim_symbol:{shim!r}")
    findings.extend(source_policy_errors(repo_root))

    return {
        "schema": SCHEMA, "static_eligible": not findings,
        "eligible": False, "promotable": False,
        "runtime_evidence": "MISSING_FAIL_CLOSED",
        "status": "STATIC_VALIDATION_PASS_RUNTIME_REQUIRED" if not findings else "STATIC_VALIDATION_FAILED",
        "evidence_scope": "isolated_mode2_active_stage_control",
        "payload_bytes": 3840, "fifo_words": 1920,
        "full_checked_groups": 480, "fifo_words_per_group": 4,
        "destination": "0x06010000-0x06010EFF",
        "terminal_dar": "0x06010F00", "source": "0x00FF6B40-0x00FF7A3F",
        "default_unchanged": hashes["default"] == EXPECTED_DEFAULT_SHA256,
        "mode1_evidence_unchanged": (
            hashes["mode1_active"] == EXPECTED_MODE1_ACTIVE_SHA256
            and hashes["mode1_control"] == EXPECTED_MODE1_CONTROL_SHA256
            and hashes["mode1_isr_bin"] == EXPECTED_MODE1_ISR_SHA256
        ),
        "mode0_enabled": False, "mode1_enabled": False, "mode2_enabled": True,
        "cmd3f_enabled": False, "authority_transferred": False,
        "ordinary_default": False, "real_hardware_proven": False,
        "hashes": hashes, "findings": findings,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--active", type=Path, required=True)
    parser.add_argument("--control", type=Path, required=True)
    parser.add_argument("--default", type=Path, required=True)
    parser.add_argument("--mode1-active", type=Path, required=True)
    parser.add_argument("--mode1-control", type=Path, required=True)
    parser.add_argument("--isr-bin", type=Path, required=True)
    parser.add_argument("--isr-elf", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--repo-root", type=Path, default=Path(__file__).resolve().parents[2])
    args = parser.parse_args()
    try:
        result = verify_pair(
            args.active, args.control, args.default, args.mode1_active,
            args.mode1_control, args.isr_bin, args.isr_elf, args.repo_root,
        )
        args.manifest.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
        if result["findings"]:
            raise ValueError("; ".join(result["findings"]))
        print("mode-2 static pair PASS (runtime evidence remains required)")
    except (OSError, ValueError) as error:
        print(f"mode-2 static verification FAILED: {error}")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
