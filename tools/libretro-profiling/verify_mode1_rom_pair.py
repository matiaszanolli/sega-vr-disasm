#!/usr/bin/env python3
"""Fail-closed static verifier for the isolated Q-020 mode-1 CMDINT pair."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import struct
import tempfile
from pathlib import Path

SCHEMA = "vrd-vr60-mode1-cmdint-pair-v2"
EXPECTED_SIZE = 0x3F0000
EXPECTED_DEFAULT_SHA256 = (
    "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900"
)
EXPECTED_ACTIVE_SHA256 = (
    "963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470"
)
EXPECTED_CONTROL_SHA256 = (
    "391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd"
)

ROUTE_OFFSETS = (0x00E0D4, 0x011822)
DEFAULT_ROUTE = bytes.fromhex("23fc00884a3e00ff0002")
MODE1_ROUTE = bytes.fromhex("23fc0089c91400ff0002")

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
EXPECTED_PAIR_DIFFERENCES = [
    PAIR_SLOT_OFFSET + index
    for index, (active, control) in enumerate(zip(PAIR_SLOT_ACTIVE, PAIR_SLOT_CONTROL))
    if active != control
]

M68K_OFFSET = 0x01C914
M68K_BYTES = bytes.fromhex(
    "4e714239ffff7b404ef900884a3e48e7e0600839000000a1510366f608390002"
    "00a1510766f64a7900a1511066f833fc000000a1510c33fcf30c00a1510e33fc"
    "002000a1511013fc000400a151070039000100a151030839000000a1510366f6"
    "43f900ff6b0045f900a1511274070839000700a1510766f67003349951c8fffc"
    "51caffec4a7900a1511066f80839000200a1510766f60839000000a1510366f6"
    "0039000100a151030839000000a1510366f64cdf06074e75"
)
M68K_END = M68K_OFFSET + len(M68K_BYTES)

VECTOR_OFFSET = 0x020100
VECTOR_COUNT = 16
DEFAULT_VECTOR = bytes.fromhex("060006ac")
MODE1_VECTOR = bytes.fromhex("02303b00")

STARTUP_LITERAL_OFFSET = 0x020480
DEFAULT_STARTUP_LITERAL = bytes.fromhex("060045cc")
MODE1_STARTUP_LITERAL = bytes.fromhex("02303e60")
EXPECTED_STARTUP_LITERAL_USERS = [(0x020438, STARTUP_LITERAL_OFFSET)]

CMD3E_JUMP_OFFSET = 0x020878
CMD3E_JUMP = bytes.fromhex("023016b0")
CMD3F_JUMP_OFFSET = 0x02087C
CMD3F_JUMP = bytes.fromhex("02301500")
ORIGINAL_HANDLER_OFFSET = 0x3016B0
ORIGINAL_HANDLER_END = 0x301760
ORIGINAL_HANDLER_SHA256 = "d4bfc7747d0805ef508413f6a2fb3d1073a7ec2d735abe1fe02b3a7f2f3f41a8"

ISR_OFFSET = 0x303B00
ISR_END = 0x303F1C
ISR_SIZE = ISR_END - ISR_OFFSET
ISR_SHA256 = "6316a0d228dc3db8a48ecdef3b34e0962e04db35c4ef085ec17aea8873146916"
ISR_ENTRY_SYMBOL = "cmd3e_mode1_validation"
ISR_ENTRY_ADDRESS = 0x02303B00
SHIM_SYMBOL = "q020_mode1_cmdint_init"
SHIM_ADDRESS = 0x02303E60
EXTERNAL_LITERAL_USER = (0x3039FC, 0x303CB4)
EXTERNAL_LITERAL_USER_BYTES = bytes.fromhex("deadbeef")
EXTERNAL_LITERAL_BYTES = bytes.fromhex("ffffffff")
EXPECTED_LITERAL_USERS = [
    (0x3039FC, 0x303CB4), (0x303B12, 0x303EA8), (0x303B2E, 0x303EAC),
    (0x303B52, 0x303F08), (0x303B58, 0x303EAC), (0x303B74, 0x303EB4),
    (0x303B7E, 0x303EC0), (0x303BA8, 0x303EC0), (0x303BCA, 0x303ED8),
    (0x303BD0, 0x303EFC), (0x303BD4, 0x303EF8), (0x303BF6, 0x303EC8),
    (0x303BF8, 0x303ECC), (0x303BFC, 0x303ED0), (0x303BFE, 0x303EE8),
    (0x303C02, 0x303ED4), (0x303C08, 0x303ED8), (0x303C0A, 0x303EF0),
    (0x303C0E, 0x303EDC), (0x303C32, 0x303ED8), (0x303C36, 0x303EF4),
    (0x303C3C, 0x303EF0), (0x303C4A, 0x303ED4), (0x303C56, 0x303ED0),
    (0x303C5A, 0x303EEC), (0x303C64, 0x303ED8), (0x303C66, 0x303EF8),
    (0x303C94, 0x303EB0), (0x303C96, 0x303F0C), (0x303CB8, 0x303EB0),
    (0x303CD0, 0x303EC4), (0x303CD8, 0x303EB0), (0x303CF0, 0x303EB8),
    (0x303CF6, 0x303EE0), (0x303CFC, 0x303EBC), (0x303D02, 0x303EE4),
    (0x303D1A, 0x303EC8), (0x303D1E, 0x303ECC), (0x303D24, 0x303ED0),
    (0x303D28, 0x303EE8), (0x303D2E, 0x303EEC), (0x303D34, 0x303ED4),
    (0x303D3E, 0x303ED8), (0x303D42, 0x303EF0), (0x303D48, 0x303EF4),
    (0x303D4E, 0x303EDC), (0x303D68, 0x303F00), (0x303D8C, 0x303F04),
    (0x303DA4, 0x303ED4), (0x303DB6, 0x303F10), (0x303DBE, 0x303F14),
    (0x303E12, 0x303F18), (0x303E1C, 0x303EAC), (0x303E2C, 0x303F18),
    (0x303E62, 0x303E98), (0x303E66, 0x303E9C), (0x303E6E, 0x303EA0),
    (0x303E82, 0x303E9C), (0x303E86, 0x303EA0), (0x303E92, 0x303EA4),
]

# Exact assembled slices make the safety claims independently inspectable and
# give adversarial tests invariant-specific failures in addition to full hashes.
ISR_PROTOCOL_SLICE_SHA256 = {
    "setup_arm": (0x0C6, 0x130, "a692de74fb8afa7f3f5b3cd8bfa8a267e51013edb88e7a26ab5e4509c2078d26"),
    "completion_terminal": (0x130, 0x186, "91739a474c5e396079a76e401fe4e08a57dee1fffc4973254a2ee5561b48ac5c"),
    "completion_identity": (0x20E, 0x25C, "056a8b84c276b309956b2e2bcfc67d14fdda11b215821c5de2de21cc84cec209"),
    "setup_ownership": (0x25C, 0x2B2, "a4c0642d0f2afa4b1e5b8e0e00f290b301a2ab9a0d1f5ce5ce6c0a47f31c1f5b"),
    "accepted_setup_spc": (0x0A4, 0x0C8, "578925f23a03d3ffcab4d05d2b78b34023f0bc020d70d083f8c6aa2ab61d08fb"),
    "captured_completion_spc": (0x0C2, 0x132, "0c76df8e9ab7ea4cd7a7f6c3236fb0cd85a6651896fe9bda931140a5fe141fbc"),
}

ALLOWED_DIFF_RANGES = (
    (ROUTE_OFFSETS[0], ROUTE_OFFSETS[0] + len(MODE1_ROUTE)),
    (ROUTE_OFFSETS[1], ROUTE_OFFSETS[1] + len(MODE1_ROUTE)),
    (HOOK_OFFSET, HOOK_OFFSET + len(ACTIVE_HOOK)),
    (M68K_OFFSET, M68K_END),
    (VECTOR_OFFSET, VECTOR_OFFSET + VECTOR_COUNT * 4),
    (STARTUP_LITERAL_OFFSET, STARTUP_LITERAL_OFFSET + 4),
    (ISR_OFFSET, ISR_END),
)

SAFE_IDLE_SPCS = (
    0x06000460, 0x06000462, 0x06000464,
    0x06000466, 0x06000474, 0x06000476,
)
SAFE_QUIESCENT_SPCS = tuple(range(0x06004438, 0x06004444, 2))
SAFE_SETUP_SPCS = SAFE_IDLE_SPCS + SAFE_QUIESCENT_SPCS
GATE_B_PC_POLICY = {
    "m68k_setup_intm_precondition": ["0x0001C92E"],
    "m68k_dreq_idle_precondition": ["0x0001C938"],
    "m68k_prior_length_zero": ["0x0001C940"],
    "m68k_dreq_destination": ["0x0001C94A", "0x0001C952"],
    "m68k_dreq_length": ["0x0001C95A"],
    "m68k_dreq_68s": ["0x0001C962"],
    "m68k_setup_trigger": ["0x0001C96A"],
    "m68k_setup_ack": ["0x0001C972"],
    "m68k_full_read": ["0x0001C98A"],
    "m68k_fifo_write": ["0x0001C990"],
    "m68k_dreq_length_zero": ["0x0001C99E"],
    "m68k_dreq_68s_auto_clear": ["0x0001C9A8"],
    "m68k_completion_precondition": ["0x0001C9B2"],
    "m68k_completion_trigger": ["0x0001C9BC"],
    "m68k_completion_ack": ["0x0001C9C4"],
    "master_dreq_control_read": ["0x02303B76"],
    "master_dreq_length_reads": ["0x02303B80", "0x02303BAA"],
    "master_dreq_destination_reads": ["0x02303CF2", "0x02303CFE"],
    "master_prior_chcr_read_write_read": ["0x02303BCC", "0x02303BEA", "0x02303BEC"],
    "master_dmac0_arm": ["0x02303BFA", "0x02303C00", "0x02303C06", "0x02303C0C"],
    "master_dmaor_write_read": ["0x02303C12", "0x02303C14"],
    "master_completion_chcr_poll": ["0x02303C34"],
    "master_completion_tcr_dar": ["0x02303C4C", "0x02303C58"],
    "master_completion_te_clear_read": ["0x02303C68", "0x02303C6A"],
    "master_cmd_mask_write_read": ["0x02303CC4", "0x02303CC6"],
    "master_cmd_clear_read": ["0x02303CD4", "0x02303CD6"],
    "master_mask_restore_read": ["0x02303CDC", "0x02303CDE"],
    "master_safe_setup_saved_spc": [f"0x{pc:08X}" for pc in SAFE_SETUP_SPCS],
    "master_completion_saved_spc": "unrestricted after exact in-flight ownership proof",
}


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def differences_outside_ranges(candidate: bytes, reference: bytes) -> list[int]:
    if len(candidate) != len(reference):
        return [min(len(candidate), len(reference))]
    return [
        offset
        for offset, (left, right) in enumerate(zip(candidate, reference, strict=True))
        if left != right
        and not any(start <= offset < end for start, end in ALLOWED_DIFF_RANGES)
    ]


def movl_pc_users_in_range(image: bytes, start: int, end: int) -> list[tuple[int, int]]:
    """Return every aligned SH2 MOV.L-PC user resolving into [start,end)."""
    users: list[tuple[int, int]] = []
    for offset in range(0, len(image) - 1, 2):
        opcode = int.from_bytes(image[offset : offset + 2], "big")
        if opcode >> 12 != 0xD:
            continue
        pc = 0x02000000 + offset
        target = ((pc + 4) & ~3) + (opcode & 0xFF) * 4 - 0x02000000
        if start <= target < end:
            users.append((offset, target))
    return users


def elf32_symbol_value(image: bytes, symbol_name: str) -> int | None:
    """Read one symbol from a big- or little-endian ELF32 symbol table."""
    if image[:4] != b"\x7fELF" or image[4] != 1 or image[5] not in (1, 2):
        raise ValueError("isr_elf_format")
    endian = "<" if image[5] == 1 else ">"
    e_shoff = struct.unpack_from(endian + "I", image, 32)[0]
    e_shentsize, e_shnum = struct.unpack_from(endian + "HH", image, 46)
    if e_shentsize < 40 or e_shoff + e_shentsize * e_shnum > len(image):
        raise ValueError("isr_elf_sections")
    sections = [
        struct.unpack_from(endian + "IIIIIIIIII", image, e_shoff + i * e_shentsize)
        for i in range(e_shnum)
    ]
    for section in sections:
        sh_type, sh_offset, sh_size, sh_link, sh_entsize = (
            section[1], section[4], section[5], section[6], section[9]
        )
        if sh_type != 2 or not sh_entsize or sh_link >= len(sections):
            continue
        strings = sections[sh_link]
        names = image[strings[4] : strings[4] + strings[5]]
        for offset in range(sh_offset, sh_offset + sh_size, sh_entsize):
            st_name, st_value = struct.unpack_from(endian + "II", image, offset)
            if st_name >= len(names):
                continue
            end = names.find(b"\0", st_name)
            if end >= 0 and names[st_name:end].decode(errors="replace") == symbol_name:
                return st_value
    return None


def source_policy_errors(repo_root: Path) -> list[str]:
    errors: list[str] = []
    vrd = (repo_root / "disasm/vrd.asm").read_text()
    if not all(fragment in vrd for fragment in (
        "ifd     VR60_Q020_CMDINT_PROBE",
        "ifd     VR60_MODE1_VALIDATION",
        "ifd     VR60_MODE1_STAGE_CONTROL",
        "assert  0,",
        "mutually exclusive",
    )):
        errors.append("source_mutual_exclusion_guard")

    for relative in (
        "disasm/modules/68k/game/scene/scene_setup_game_mode_transition.asm",
        "disasm/modules/68k/game/menu/sh2_scene_reset_name_entry_mode_disp.asm",
    ):
        text = (repo_root / relative).read_text()
        if "VR60_MODE1_VALIDATION" not in text or "#$0089C914,$00FF0002" not in text:
            errors.append(f"source_mode1_route:{Path(relative).name}")

    producer = (repo_root / "disasm/modules/68k/sh2/vr60_mode1_validation.asm").read_text()
    required_producer = (
        ".wait_setup_intm_low:",
        ".wait_prior_len_zero:",
        "move.w  #$0000,MARS_DREQ_DST_H",
        "move.w  #$F30C,MARS_DREQ_DST_L",
        "move.w  #$0020,MARS_DREQ_LEN",
        "move.b  #$04,MARS_DREQ_CTRL+1",
        "moveq   #7,d2",
        "moveq   #3,d0",
        "move.w  (a1)+,(a2)",
        "ori.b   #$01,MARS_SYS_INTMASK+1",
    )
    if any(fragment not in producer for fragment in required_producer):
        errors.append("source_producer_protocol")
    if producer.count("ori.b   #$01,MARS_SYS_INTMASK+1") != 2:
        errors.append("source_two_cmd_edges")
    for forbidden in (
        "COMM0_HI", "COMM0_LO", "COMM1", "COMM2", "COMM3",
        "COMM4", "COMM5", "COMM6", "COMM7",
    ):
        if forbidden in producer:
            errors.append(f"source_forbidden_{forbidden.lower()}")

    isr = (repo_root / "disasm/sh2/expansion/cmd3e_mode1_validation.asm").read_text()
    required_isr = (
        "xor     #2,r0",
        "cmp/eq  #0x20,r0",
        "cmp/eq  #0x38,r0",
        ".L_stock_reset_cmd:",
        "mov.l   @(.L_stock_vres,pc),r0",
        "mov.l   @(.L_stock_cmd_boot,pc),r0",
        "tst     #4,r0",
        ".L_require_destination_signature:",
        ".L_require_active_dmac_identity:",
        ".L_require_idle_spc:",
        "mov.l   r0,@(52,r3)              /* retain accepted setup boundary */",
        "mov.l   @(36,r3),r0              /* delay slot: accepted completion SPC */",
        "mov.l   r0,@(56,r3)              /* completion owns +$38 exclusively */",
        "nop                               /* +$38 changes only on accepted completion */",
        "mov.l   @(12,r3),r0",
        "mov.l   @(16,r3),r1",
        "cmp/eq  #1,r0",
        ".L_quiescent_438:",
        "same-address DMAOR synchronization",
        "mov.l   r5,@r1                  /* prior read observed TE=1; write TE=0 */",
        "mov.w   r0,@r1",
        "mov.w   @r1,r0",
        ".L_bridge_literal:",
        ".long   0xFFFFFFFF",
        "rte\n    nop",
        ".org 0x360",
    )
    if any(fragment not in isr for fragment in required_isr):
        errors.append("source_isr_protocol")
    if "generic stock" in isr.lower() or "all non-mode1 cmd" in isr.lower():
        errors.append("source_false_stock_delegation_claim")

    expansion = (repo_root / "disasm/sections/expansion_300000.asm").read_text()
    if not all(fragment in expansion for fragment in (
        "ifd     VR60_MODE1_VALIDATION",
        "dcb.b   ($303B00 - *), $FF",
        'assert  *=$303F1C,"Q-020 mode-1 CMDINT ISR must end at file $303F1C"',
    )):
        errors.append("source_isr_placement")
    master = (repo_root / "disasm/sections/code_20200.asm").read_text()
    if not all(fragment in master for fragment in (
        "ifd     VR60_MODE1_VALIDATION",
        "dc.l    $02303E60",
        "dc.w    $16B0        ; $02087A",
        "dc.w    $1500        ; $02087E",
    )):
        errors.append("source_master_literals")
    vectors = (repo_root / "disasm/sections/code_1e200.asm").read_text()
    if vectors.count("dc.l    $02303B00") < VECTOR_COUNT:
        errors.append("source_external_vectors")
    return errors


def verify_pair(
    active_path: Path,
    control_path: Path,
    default_path: Path,
    isr_bin_path: Path | None = None,
    isr_elf_path: Path | None = None,
    repo_root: Path | None = None,
) -> dict[str, object]:
    repo_root = repo_root or Path(__file__).resolve().parents[2]
    isr_bin_path = isr_bin_path or repo_root / "build/sh2/cmd3e_mode1_validation.bin"
    isr_elf_path = isr_elf_path or repo_root / "build/sh2/cmd3e_mode1_validation.elf"
    images = {
        "active": active_path.read_bytes(),
        "control": control_path.read_bytes(),
        "default": default_path.read_bytes(),
    }
    isr_bin = isr_bin_path.read_bytes()
    isr_elf = isr_elf_path.read_bytes()
    expected_hashes = {
        "active": EXPECTED_ACTIVE_SHA256,
        "control": EXPECTED_CONTROL_SHA256,
        "default": EXPECTED_DEFAULT_SHA256,
        "isr_bin": ISR_SHA256,
    }
    hashes = {name: sha256(image) for name, image in images.items()}
    hashes["isr_bin"] = sha256(isr_bin)
    findings: list[str] = []
    for name, image in images.items():
        if len(image) != EXPECTED_SIZE:
            findings.append(f"{name}_size:{len(image)}")
        if hashes[name] != expected_hashes[name]:
            findings.append(f"{name}_sha256:{hashes[name]}")
    if len(isr_bin) != ISR_SIZE:
        findings.append(f"isr_bin_size:{len(isr_bin)}")
    if hashes["isr_bin"] != ISR_SHA256:
        findings.append(f"isr_bin_sha256:{hashes['isr_bin']}")

    active, control, default = images["active"], images["control"], images["default"]
    for offset in ROUTE_OFFSETS:
        for name, image, expected in (
            ("active", active, MODE1_ROUTE),
            ("control", control, MODE1_ROUTE),
            ("default", default, DEFAULT_ROUTE),
        ):
            if image[offset : offset + len(expected)] != expected:
                findings.append(f"{name}_route_0x{offset:X}")

    for name, image, hook in (
        ("active", active, ACTIVE_HOOK),
        ("control", control, CONTROL_HOOK),
    ):
        if image[HOOK_OFFSET : HOOK_OFFSET + len(hook)] != hook:
            findings.append(f"{name}_hook")
        if image[M68K_OFFSET:M68K_END] != M68K_BYTES:
            findings.append(f"{name}_producer")
        if image[VECTOR_OFFSET : VECTOR_OFFSET + VECTOR_COUNT * 4] != MODE1_VECTOR * VECTOR_COUNT:
            findings.append(f"{name}_vectors")
        if image[STARTUP_LITERAL_OFFSET : STARTUP_LITERAL_OFFSET + 4] != MODE1_STARTUP_LITERAL:
            findings.append(f"{name}_startup_literal")
        if image[ISR_OFFSET:ISR_END] != isr_bin:
            findings.append(f"{name}_isr_binary")
        if image[CMD3E_JUMP_OFFSET : CMD3E_JUMP_OFFSET + 4] != CMD3E_JUMP:
            findings.append(f"{name}_cmd3e_jump")
        if image[CMD3F_JUMP_OFFSET : CMD3F_JUMP_OFFSET + 4] != CMD3F_JUMP:
            findings.append(f"{name}_cmd3f_jump")
        if sha256(image[ORIGINAL_HANDLER_OFFSET:ORIGINAL_HANDLER_END]) != ORIGINAL_HANDLER_SHA256:
            findings.append(f"{name}_original_cmd3e_changed")
        outside = differences_outside_ranges(image, default)
        if outside:
            findings.append(
                f"{name}_difference_outside_allowed_ranges:"
                + ",".join(f"0x{offset:X}" for offset in outside[:16])
            )

    if default[VECTOR_OFFSET : VECTOR_OFFSET + VECTOR_COUNT * 4] != DEFAULT_VECTOR * VECTOR_COUNT:
        findings.append("default_vectors")
    if default[STARTUP_LITERAL_OFFSET : STARTUP_LITERAL_OFFSET + 4] != DEFAULT_STARTUP_LITERAL:
        findings.append("default_startup_literal")
    if default[CMD3E_JUMP_OFFSET : CMD3E_JUMP_OFFSET + 4] != CMD3E_JUMP:
        findings.append("default_cmd3e_jump")
    if default[CMD3F_JUMP_OFFSET : CMD3F_JUMP_OFFSET + 4] != CMD3F_JUMP:
        findings.append("default_cmd3f_jump")

    differences = [
        offset
        for offset, (left, right) in enumerate(zip(active, control, strict=True))
        if left != right
    ]
    if active[PAIR_SLOT_OFFSET : PAIR_SLOT_OFFSET + 6] != PAIR_SLOT_ACTIVE:
        findings.append("active_pair_slot")
    if control[PAIR_SLOT_OFFSET : PAIR_SLOT_OFFSET + 6] != PAIR_SLOT_CONTROL:
        findings.append("control_pair_slot")
    if differences != EXPECTED_PAIR_DIFFERENCES:
        findings.append("pair_delta_not_exact_slot")

    helper = active[M68K_OFFSET:M68K_END]
    trigger = bytes.fromhex("0039000100a15103")
    if helper.count(trigger) != 2:
        findings.append("producer_two_cmd_edges")
    if any(bytes.fromhex(f"00a151{suffix:02x}") in helper for suffix in range(0x20, 0x30)):
        findings.append("producer_forbidden_comm_access")
    required_m68k_order = [
        bytes.fromhex("0839000000a15103"),
        bytes.fromhex("0839000200a15107"),
        bytes.fromhex("4a7900a15110"),
        bytes.fromhex("33fc000000a1510c"),
        bytes.fromhex("33fcf30c00a1510e"),
        bytes.fromhex("33fc002000a15110"),
        bytes.fromhex("13fc000400a15107"),
        trigger,
        bytes.fromhex("45f900a15112"),
        bytes.fromhex("4a7900a15110"),
        trigger,
    ]
    positions: list[int] = []
    start = 0
    for needle in required_m68k_order:
        position = helper.find(needle, start)
        positions.append(position)
        if position >= 0:
            start = position + len(needle)
    if any(position < 0 for position in positions):
        findings.append("producer_mmio_order")
    if helper.count(bytes.fromhex("0839000700a15107")) != 1:
        findings.append("producer_full_check")
    if helper.count(bytes.fromhex("3499")) != 1 or bytes.fromhex("7003349951c8fffc51caffec") not in helper:
        findings.append("producer_eight_four_word_groups")

    literal_users = movl_pc_users_in_range(active, ISR_OFFSET, ISR_END)
    if literal_users != EXPECTED_LITERAL_USERS:
        findings.append(
            "isr_literal_users:"
            + ",".join(f"0x{pc:X}->0x{target:X}" for pc, target in literal_users)
        )
    startup_users = movl_pc_users_in_range(active, STARTUP_LITERAL_OFFSET, STARTUP_LITERAL_OFFSET + 4)
    if startup_users != EXPECTED_STARTUP_LITERAL_USERS:
        findings.append(
            "startup_literal_users:"
            + ",".join(f"0x{pc:X}->0x{target:X}" for pc, target in startup_users)
        )
    for name, image in (("active", active), ("control", control), ("default", default)):
        if image[EXTERNAL_LITERAL_USER[0] : EXTERNAL_LITERAL_USER[0] + 4] != EXTERNAL_LITERAL_USER_BYTES:
            findings.append(f"{name}_external_literal_user_bytes")
    for name, image in (("active", active), ("control", control)):
        if image[EXTERNAL_LITERAL_USER[1] : EXTERNAL_LITERAL_USER[1] + 4] != EXTERNAL_LITERAL_BYTES:
            findings.append(f"{name}_external_literal_value")

    isr = active[ISR_OFFSET:ISR_END]
    for name, (start, end, expected) in ISR_PROTOCOL_SLICE_SHA256.items():
        if sha256(isr[start:end]) != expected:
            findings.append(f"isr_protocol_slice:{name}")
    rte_offsets = [offset for offset in range(0, len(isr) - 1, 2) if isr[offset : offset + 2] == b"\x00\x2b"]
    if rte_offsets != [0x348] or any(isr[offset + 2 : offset + 4] != b"\x00\x09" for offset in rte_offsets):
        findings.append("isr_rte_explicit_nop_delay")
    for comm_address in range(0x20004020, 0x20004030):
        if comm_address.to_bytes(4, "big") in isr:
            findings.append(f"isr_forbidden_comm_literal:0x{comm_address:08X}")
    if bytes.fromhex("2000401a") not in isr:
        findings.append("isr_cmd_clear_missing")
    if not all(value in isr for value in (
        bytes.fromhex("000044e1"), bytes.fromhex("000044e3"), bytes.fromhex("000044e0"),
    )):
        findings.append("isr_chcr_lifecycle_literals")
    if not all(value in isr for value in (
        bytes.fromhex("0600f30c"), bytes.fromhex("0600f34c"),
    )):
        findings.append("isr_destination_range_literals")

    try:
        entry_symbol = elf32_symbol_value(isr_elf, ISR_ENTRY_SYMBOL)
        shim_symbol = elf32_symbol_value(isr_elf, SHIM_SYMBOL)
    except ValueError as error:
        findings.append(str(error))
        entry_symbol = shim_symbol = None
    if entry_symbol != ISR_ENTRY_ADDRESS:
        findings.append(f"isr_entry_symbol:{entry_symbol!r}")
    if shim_symbol != SHIM_ADDRESS:
        findings.append(f"isr_shim_symbol:{shim_symbol!r}")
    findings.extend(source_policy_errors(repo_root))

    return {
        "schema": SCHEMA,
        "static_eligible": not findings,
        "eligible": False,
        "promotable": False,
        "runtime_evidence": "COMPOSED_BY_MODE1_GATE_MANIFEST",
        "status": "STATIC_VALIDATION_PASS_NON_PROMOTABLE",
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
            "wrapper_helper": f"0x{M68K_OFFSET:X}-0x{M68K_END - 1:X}",
            "external_vectors": "0x20100-0x2013F",
            "startup_literal": "0x20480-0x20483",
            "cmdint_isr_and_shim": f"0x{ISR_OFFSET:X}-0x{ISR_END - 1:X}",
            "preserved_original_cmd3e": "0x3016B0-0x30175F",
        },
        "symbols": {
            ISR_ENTRY_SYMBOL: f"0x{entry_symbol:08X}" if entry_symbol is not None else None,
            SHIM_SYMBOL: f"0x{shim_symbol:08X}" if shim_symbol is not None else None,
        },
        "literal_pool_users": [
            {"instruction": f"0x{pc:X}", "literal": f"0x{target:X}"}
            for pc, target in literal_users
        ],
        "startup_literal_users": [
            {"instruction": f"0x{pc:X}", "literal": f"0x{target:X}"}
            for pc, target in startup_users
        ],
        "external_literal_ownership": {
            "instruction": "0x3039FC",
            "instruction_bytes": EXTERNAL_LITERAL_USER_BYTES.hex(),
            "literal": "0x303CB4",
            "literal_bytes": EXTERNAL_LITERAL_BYTES.hex(),
        },
        "gate_b_pc_policy": GATE_B_PC_POLICY,
        "gate_b_requirements": {
            "transport": "two Master CMD edges; zero mode-1 COMM0-7 reads or writes",
            "setup_signature": "setup_count==completion_count,68S=1,LEN=0x20,DST=00:F30C,TCR0=0,saved SPC in exact idle/quiescent set",
            "completion_signature": "setup_count==completion_count+1,68S=0,LEN=0,SAR=0x20004012,DAR/TCR bounded then terminal,CHCR=0x44E1/0x44E3,DMAOR=1; no SPC restriction",
            "payload": "exactly 64 bytes FF6B00->0600F30C",
            "fifo_groups": "eight groups of four words; FULL checked before each group",
            "dmac0_active_chcr": "0x000044E1",
            "dmac0_completion_chcr": "0x000044E3",
            "dmac0_ack_idle_chcr": "0x000044E0 (TE read-1/write-0, DE=0, IE=0)",
            "dmac0_rearm_order": ["SAR0", "DAR0", "TCR0", "CHCR0", "DMAOR write", "DMAOR same-address read"],
            "cmd_ack_order": ["mask CMD", "mask readback", "clear CMD", "same-address read", "restore exact mask", "mask readback"],
            "safe_setup_saved_spcs": [f"0x{pc:08X}" for pc in SAFE_SETUP_SPCS],
            "completion_saved_spc": "not restricted after exact in-flight ownership proof",
            "stock_delegation": "VRES and phase-pinned reset-flow CMD only",
            "unexpected_policy": "fail-stop",
            "forbidden_comm_registers": [f"COMM{index}" for index in range(8)],
            "default_unchanged": True,
            "mode2_disabled": True,
            "cmd3f_disabled": True,
            "fresh_runs_per_arm_per_route": 2,
            "routes": ["normal entry", "name-entry re-entry"],
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
    parser.add_argument("--isr-bin", type=Path, required=True)
    parser.add_argument("--isr-elf", type=Path, required=True)
    parser.add_argument("--repo-root", type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args()
    payload = verify_pair(
        args.active, args.control, args.default,
        args.isr_bin, args.isr_elf, args.repo_root,
    )
    if not payload["static_eligible"]:
        print("FAIL: " + ", ".join(payload["findings"]))
        return 1
    write_manifest(args.manifest, payload)
    print("PASS: isolated CMDINT pair static validation; non-promotable by policy")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
