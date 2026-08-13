#!/usr/bin/env python3
"""Fail-closed static verifier for the isolated Q-027 cmd-$3F pair."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import struct
import tempfile
from collections.abc import Sequence
from pathlib import Path


SCHEMA = "vrd-vr60-q027-cmd3f-transport-pair-v1"
EXPECTED_SIZE = 0x3F0000
EXPECTED_HASHES = {
    "active": "50c20e1a82ff8f1f6df49a86dfc51bdef8b2b435f365a16cab3dec0bf7834097",
    "control": "33bfdd8c0e4b44187f25b40bfb540e4d7aebcb5dda55cbebf51c7e674834e511",
    "default": "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900",
    "mode1_active": "963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470",
    "mode1_control": "391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd",
    "mode2_active": "96d79e3fb4d2df8a69852917ac811f860935ae950fc87222d008fa45d47ee276",
    "mode2_control": "da5ce4ec9ef8e050c7babeb113e26aa7335a3ff5285285e55a6606d2f96309b8",
    "q023_active": "8709aed4fc16d548b06694a92361a240537fbae7f987ee5f00a62c3c995a59ef",
    "q023_control": "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900",
    "q026_active": "c9358ad4ff04d7420c7bef1f45c163afb4506efae4990c4b48a475188e0b76f8",
    "q026_control": "240dfd0a8df87a8118982849f354bc720b0011d480221f2031e3ceeb6dc1a66d",
    "handler_bin": "d2f4d2cd1e7494be885aca5ffeef6437e7ad9ea2d14960ab63f5caf98005bfa9",
    "active_isr": "ee4fc19302ac06c7299c51beae8c32afdf55cef3c20e6dc6e4108d91265a7ab8",
    "control_isr": "4e1c00ef088af29babe4d95332633186f4665306ad7f4896b560ca800d3f7700",
    "park_bin": "274e095396a1210a97a83b7b7deb7cb6e4dc80bd53af878321cc4d05b52e5425",
    "init_bin": "028dae982c9183d04196222c36dc763a95c840eec3bbdd0ebf517e3ef475eccd",
}

ROUTE_OFFSETS = (0x00E0D4, 0x011822)
ROUTE_BYTES = bytes.fromhex("23fc0089cb0000ff0002")
HELPER_START, HELPER_END = 0x01C930, 0x01C9A2
WRAPPER_START, WRAPPER_END = 0x01CB00, 0x01CB0E
HELPER_BYTES = bytes.fromhex(
    "40e746fc27000839000000a1510366f60839000200a1510766f6"
    "4a7900a1511066f84a3900a1512066f813fc0002ffff7b400039"
    "000100a151030839000000a1510366f6427900a151204a7900a1"
    "5120661e33fc013f00a151200039000100a151030839000000a1"
    "510366f646df4e7560fe"
)
WRAPPER_BYTES = bytes.fromhex("4e714239ffff7b404ef900884a3e")
VECTOR_START, VECTOR_END = 0x020100, 0x020140
VECTOR_BYTES = bytes.fromhex("02304000")
STARTUP_LITERAL, STARTUP_BYTES = 0x020480, bytes.fromhex("02304600")
CMD3F_JUMP, CMD3F_BYTES = 0x02087C, bytes.fromhex("02301500")
HANDLER_START, HANDLER_END = 0x301500, 0x3016B0
ISR_START, ISR_CORE_END = 0x304000, 0x304314
PARK_START, PARK_END = 0x304500, 0x304504
INIT_START, INIT_END, ISR_END = 0x304600, 0x30466C, 0x304700
PAIR_BRANCH = 0x3041A2
ACTIVE_BRANCH, CONTROL_BRANCH = bytes.fromhex("0009"), bytes.fromhex("a007")

EXPECTED_MAILBOX = bytes.fromhex("5132374d000127113f01a55a51323743")
EXPECTED_CALL_TABLE = b"".join(value.to_bytes(4, "big") for value in (
    0x023017C0, 0x02301D94, 0x02301E00, 0x02301E20,
    0x02301D40, 0x02301820, 0x0230189C, 0x023017F2,
    0x02301B40, 0x02301CBC, 0x02301F20, 0x02302158,
    0x02301E2E, 0x02301E60,
))
HANDLER_CALL_TABLE = 0x301678

EXPECTED_HANDLER_LITERAL_USERS = (
    (0x301502, 0x301638), (0x30151C, 0x30163C),
    (0x301540, 0x301640), (0x301542, 0x301644),
    (0x30157C, 0x301650), (0x301588, 0x301654),
    (0x30158C, 0x301658), (0x301592, 0x30165C),
    (0x301598, 0x301660), (0x3015A0, 0x301664),
    (0x3015A4, 0x301668), (0x3015AC, 0x301658),
    (0x3015B8, 0x30163C), (0x3015BA, 0x301650),
    (0x3015C8, 0x30166C), (0x3015D8, 0x301670),
    (0x3015E8, 0x301664), (0x3015EC, 0x301668),
    (0x301618, 0x301674), (0x30162C, 0x30163C),
)
EXPECTED_ISR_LITERAL_USERS = (
    (0x304026, 0x3042A8), (0x30404C, 0x3042AC),
    (0x304050, 0x3042B0), (0x304068, 0x3042F0),
    (0x304072, 0x3042D8), (0x304082, 0x304308),
    (0x304088, 0x3042AC), (0x30408C, 0x3042B0),
    (0x3040AC, 0x3042B4), (0x3040BA, 0x3042B8),
    (0x3040D0, 0x3042F0), (0x3040DA, 0x3042D8),
    (0x3040E0, 0x3042DC), (0x3040E6, 0x3042E0),
    (0x3040EC, 0x3042E4), (0x3040F2, 0x3042E8),
    (0x3040F8, 0x3042EC), (0x304102, 0x3042BC),
    (0x304106, 0x3042C0), (0x304110, 0x3042C4),
    (0x30413C, 0x3042F4), (0x304148, 0x3042F0),
    (0x30414E, 0x3042F4), (0x304154, 0x3042F8),
    (0x304160, 0x3042C4), (0x30416E, 0x3042C8),
    (0x304170, 0x3042CC), (0x30417A, 0x3042D0),
    (0x30419C, 0x3042F0), (0x3041AC, 0x3042D8),
    (0x3041B4, 0x3042C4), (0x3041C0, 0x304300),
    (0x3041CC, 0x3042D4), (0x3041D8, 0x3042D0),
    (0x3041E4, 0x3042D8), (0x3041EC, 0x3042D0),
    (0x304200, 0x3042D4), (0x30420C, 0x3042D0),
    (0x30421C, 0x304304), (0x304222, 0x3042F0),
    (0x30422E, 0x30430C), (0x304270, 0x3042AC),
    (0x304272, 0x304310), (0x304602, 0x304650),
    (0x304606, 0x304654), (0x30461E, 0x304650),
    (0x304620, 0x304654), (0x304626, 0x304658),
    (0x304634, 0x30465C), (0x304636, 0x304660),
    (0x30463C, 0x304664), (0x30464A, 0x304668),
)

ALLOWED_DEFAULT_DIFF_RANGES = (
    *((offset, offset + len(ROUTE_BYTES)) for offset in ROUTE_OFFSETS),
    (0x01C8B0, WRAPPER_END), (VECTOR_START, VECTOR_END),
    (STARTUP_LITERAL, STARTUP_LITERAL + 4), (CMD3F_JUMP, CMD3F_JUMP + 4),
    (HANDLER_START, HANDLER_END), (ISR_START, ISR_END),
)


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def differing_offsets(left: bytes, right: bytes) -> list[int]:
    if len(left) != len(right):
        return [min(len(left), len(right))]
    return [index for index, values in enumerate(zip(left, right, strict=True))
            if values[0] != values[1]]


def differences_outside_ranges(candidate: bytes, reference: bytes) -> list[int]:
    return [offset for offset in differing_offsets(candidate, reference)
            if not any(start <= offset < end for start, end in ALLOWED_DEFAULT_DIFF_RANGES)]


def movl_pc_users_into(image: bytes, start: int, end: int) -> tuple[tuple[int, int], ...]:
    users: list[tuple[int, int]] = []
    for offset in range(0, len(image) - 1, 2):
        opcode = int.from_bytes(image[offset:offset + 2], "big")
        if opcode >> 12 != 0xD:
            continue
        pc = 0x02000000 + offset
        target = ((pc + 4) & ~3) + (opcode & 0xFF) * 4 - 0x02000000
        if start <= target < end:
            users.append((offset, target))
    return tuple(users)


def elf32_symbol_value(image: bytes, name: str) -> int | None:
    if image[:4] != b"\x7fELF" or image[4] != 1 or image[5] not in (1, 2):
        raise ValueError("elf_format")
    endian = "<" if image[5] == 1 else ">"
    shoff = struct.unpack_from(endian + "I", image, 32)[0]
    entsize, count = struct.unpack_from(endian + "HH", image, 46)
    sections = [struct.unpack_from(endian + "IIIIIIIIII", image, shoff + i * entsize)
                for i in range(count)]
    for section in sections:
        if section[1] != 2 or not section[9] or section[6] >= len(sections):
            continue
        strings = sections[section[6]]
        names = image[strings[4]:strings[4] + strings[5]]
        for offset in range(section[4], section[4] + section[5], section[9]):
            string_offset, value = struct.unpack_from(endian + "II", image, offset)
            end = names.find(b"\0", string_offset)
            if end >= 0 and names[string_offset:end].decode(errors="replace") == name:
                return value
    return None


def source_policy_errors(repo_root: Path) -> list[str]:
    errors: list[str] = []
    paths = {
        "vrd": "disasm/vrd.asm",
        "hook": "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm",
        "helper": "disasm/modules/68k/sh2/q027_cmd3f_transport.asm",
        "handler": "disasm/sh2/expansion/q027_player_stock_dispatch.s",
        "isr": "disasm/sh2/expansion/q027_external_isr.s",
        "expansion": "disasm/sections/expansion_300000.asm",
        "make": "Makefile",
    }
    text = {name: (repo_root / path).read_text() for name, path in paths.items()}
    for fragment in (
        "Q-027 and ordinary VR60_MODE0_ONLY are mutually exclusive",
        "Q-027 and Q-020 CMDINT probe are mutually exclusive",
        "Q-027 and mode-1 validation are mutually exclusive",
        "Q-027 and mode-2 validation are mutually exclusive",
        "Q-027 and Q-023 mailbox validation are mutually exclusive",
        "Q-027 and Q-026 validation are mutually exclusive",
    ):
        if fragment not in text["vrd"]:
            errors.append("source_mutual_exclusion:" + fragment)
    for fragment in ("jsr     vr60_entity_stage", "jsr     vr60_globals_stage",
                     "move.b  #$00,COMM3", "jsr     vr60_1p_entity_transfer",
                     "jsr     q027_cmd3f_transport"):
        if fragment not in text["hook"]:
            errors.append("source_hook:" + fragment)
    helper_code = "\n".join(line.split(";", 1)[0] for line in text["helper"].splitlines())
    helper_order = ("move.w  sr,-(a7)", "move.w  #$2700,sr",
                    "btst    #0,MARS_SYS_INTMASK+1", "btst    #2,MARS_DREQ_CTRL+1",
                    "tst.w   MARS_DREQ_LEN", "tst.b   COMM0_HI",
                    "clr.w   COMM0_HI", "tst.w   COMM0_HI",
                    "move.w  #$013F,COMM0_HI", "move.w  (a7)+,sr")
    positions = [helper_code.find(fragment) for fragment in helper_order]
    if any(position < 0 for position in positions) or positions != sorted(positions):
        errors.append("source_helper_order")
    if helper_code.count("COMM0_HI") != 4 or "COMM0_LO" in helper_code:
        errors.append("source_helper_comm0_widths")
    if any(lane in helper_code for lane in ("COMM1", "COMM2", "COMM3", "COMM4", "COMM5", "COMM6", "COMM7")):
        errors.append("source_helper_shared_comm")
    handler_code = "\n".join(line.split("/*", 1)[0] for line in text["handler"].splitlines())
    for forbidden in ("0x20004022", "0x20004024", "0x20004026", "0x20004028",
                      "0x2000402a", "0x2000402c", "0x2000402e", "0x06010000",
                      "0x26010000", "0x24000000", "0x04000000"):
        if forbidden in handler_code.lower():
            errors.append("source_handler_forbidden:" + forbidden)
    for fragment in ("sts.l   pr,@-r15", "stc.l   gbr,@-r15", "sts.l   mach,@-r15",
                     "sts.l   macl,@-r15", "mov.l   r8,@-r15", "mov.l   r14,@-r15",
                     "mov.l   @r15+,r14", "ldc.l   @r15+,gbr", "lds.l   @r15+,pr",
                     "mov.l   @r15,r15", "mov.w   r0,@r1\n    mov.w   @r1,r0"):
        if fragment not in text["handler"]:
            errors.append("source_handler:" + fragment)
    for forbidden in ("06004438", "0600443a", "0600443c", "0600443e",
                      "06004440", "06004442", "0600ff78"):
        if forbidden in text["isr"].lower():
            errors.append("source_finalization_forbidden:" + forbidden)
    for fragment in ("0x06000460", "0x06000462", "0x06000464", "0x06000466",
                     "0x06000474", "0x06000476", "0x0600ff80",
                     ".section .q027_park", "bra     q027_master_park", "nop",
                     "#ifdef Q027_STAGE_CONTROL".replace("#", ".")):
        if fragment not in text["isr"]:
            errors.append("source_isr:" + fragment)
    edge1 = text["isr"].split(".L_edge1:", 1)[-1].split(".L_edge2:", 1)[0]
    for fragment in ("mov.l   @(.L_comm0,pc),r1", "mov.b   @r1,r0",
                     "extu.b  r0,r0", "tst     r0,r0"):
        if fragment not in edge1:
            errors.append("source_edge1_comm0_hi:" + fragment)
    comm0_window = edge1.split("@(.L_comm0,pc)", 1)[-1].split("mov.l   @(8,r3)", 1)[0]
    if any(fragment in comm0_window for fragment in (
            "mov.w   @r1", "mov.l   @r1", "mov.b   r0,@r1",
            "mov.w   r0,@r1", "mov.l   r0,@r1")):
        errors.append("source_edge1_comm0_width")
    for fragment in ("assert  *=$3016B0", "assert  *=$304314", "assert  *=$304504",
                     "assert  *=$30466C", "assert  *=$304700"):
        if fragment not in text["expansion"]:
            errors.append("source_expansion:" + fragment)
    if "-D VR60_Q027_STAGE_CONTROL=1" not in text["make"]:
        errors.append("source_make_pair")
    return errors


def verify_pair(paths: dict[str, Path], repo_root: Path) -> dict[str, object]:
    images = {name: path.read_bytes() for name, path in paths.items()}
    hashes = {name: sha256(image) for name, image in images.items()}
    findings: list[str] = []
    for name, expected in EXPECTED_HASHES.items():
        if hashes.get(name) != expected:
            findings.append(f"{name}_sha256:{hashes.get(name)}")
    rom_names = ("active", "control", "default", "mode1_active", "mode1_control",
                 "mode2_active", "mode2_control", "q023_active", "q023_control",
                 "q026_active", "q026_control")
    for name in rom_names:
        if len(images[name]) != EXPECTED_SIZE:
            findings.append(f"{name}_size:{len(images[name])}")
    for name, size in (("handler_bin", 432), ("active_isr", 788),
                       ("control_isr", 788), ("park_bin", 4), ("init_bin", 108)):
        if len(images[name]) != size:
            findings.append(f"{name}_size:{len(images[name])}")

    active, control, default = images["active"], images["control"], images["default"]
    pair_diff = differing_offsets(active, control)
    if pair_diff != [PAIR_BRANCH, PAIR_BRANCH + 1]:
        findings.append("active_control_delta")
    if active[PAIR_BRANCH:PAIR_BRANCH + 2] != ACTIVE_BRANCH:
        findings.append("active_branch")
    if control[PAIR_BRANCH:PAIR_BRANCH + 2] != CONTROL_BRANCH:
        findings.append("control_branch")
    if differing_offsets(images["active_isr"], images["control_isr"]) != [0x1A2, 0x1A3]:
        findings.append("isr_pair_delta")

    for name, image, isr in (("active", active, images["active_isr"]),
                             ("control", control, images["control_isr"])):
        for route in ROUTE_OFFSETS:
            if image[route:route + len(ROUTE_BYTES)] != ROUTE_BYTES:
                findings.append(f"{name}_route_{route:06x}")
        if image[HELPER_START:HELPER_END] != HELPER_BYTES:
            findings.append(f"{name}_helper_sequence")
        if image[HELPER_END:WRAPPER_START] != b"\xff" * (WRAPPER_START - HELPER_END):
            findings.append(f"{name}_helper_padding")
        if image[WRAPPER_START:WRAPPER_END] != WRAPPER_BYTES:
            findings.append(f"{name}_wrapper")
        if image[VECTOR_START:VECTOR_END] != VECTOR_BYTES * 16:
            findings.append(f"{name}_vectors")
        if image[STARTUP_LITERAL:STARTUP_LITERAL + 4] != STARTUP_BYTES:
            findings.append(f"{name}_startup")
        if image[CMD3F_JUMP:CMD3F_JUMP + 4] != CMD3F_BYTES:
            findings.append(f"{name}_cmd3f_target")
        if image[HANDLER_START:HANDLER_END] != images["handler_bin"]:
            findings.append(f"{name}_handler")
        if image[ISR_START:ISR_CORE_END] != isr:
            findings.append(f"{name}_isr_core")
        if image[ISR_CORE_END:PARK_START] != b"\xff" * (PARK_START - ISR_CORE_END):
            findings.append(f"{name}_core_padding")
        if image[PARK_START:PARK_END] != images["park_bin"]:
            findings.append(f"{name}_park")
        if image[PARK_END:INIT_START] != b"\xff" * (INIT_START - PARK_END):
            findings.append(f"{name}_park_padding")
        if image[INIT_START:INIT_END] != images["init_bin"]:
            findings.append(f"{name}_init")
        if image[INIT_END:ISR_END] != b"\xff" * (ISR_END - INIT_END):
            findings.append(f"{name}_init_padding")
        outside = differences_outside_ranges(image, default)
        if outside:
            findings.append(f"{name}_outside_scope:{outside[0]:06x}")

    mailbox_offset = active.find(EXPECTED_MAILBOX, HANDLER_START, HANDLER_END)
    if mailbox_offset != 0x301644:
        findings.append(f"mailbox_image:{mailbox_offset:06x}")
    if active[HANDLER_CALL_TABLE:HANDLER_CALL_TABLE + len(EXPECTED_CALL_TABLE)] != EXPECTED_CALL_TABLE:
        findings.append("player_call_table")
    handler_users = movl_pc_users_into(active, HANDLER_START, HANDLER_END)
    isr_users = movl_pc_users_into(active, ISR_START, ISR_END)
    if handler_users != EXPECTED_HANDLER_LITERAL_USERS:
        findings.append("handler_literal_ownership")
    if isr_users != EXPECTED_ISR_LITERAL_USERS:
        findings.append("isr_literal_ownership")
    if active.find(bytes.fromhex("06004438"), ISR_START, ISR_END) >= 0 \
            or active.find(bytes.fromhex("0600ff78"), ISR_START, ISR_END) >= 0:
        findings.append("finalization_admission")
    if active.find(bytes.fromhex("2600fb64"), ISR_START, ISR_END) < 0 \
            or active.find(bytes.fromhex("0600fc00"), HANDLER_START, HANDLER_END) < 0:
        findings.append("dedicated_stack_literals")

    try:
        symbols = {
            "handler": elf32_symbol_value(images["handler_elf"], "q027_player_stock_dispatch"),
            "handler_end": elf32_symbol_value(images["handler_elf"], "q027_player_stock_dispatch_end"),
            "active_isr": elf32_symbol_value(images["active_isr_elf"], "q027_external_entry"),
            "active_core_end": elf32_symbol_value(images["active_isr_elf"], "q027_external_core_end"),
            "active_park": elf32_symbol_value(images["active_isr_elf"], "q027_master_park"),
            "active_init": elf32_symbol_value(images["active_isr_elf"], "q027_init"),
            "control_isr": elf32_symbol_value(images["control_isr_elf"], "q027_external_entry"),
        }
    except (IndexError, struct.error, ValueError) as error:
        findings.append("elf:" + str(error))
        symbols = {}
    expected_symbols = {
        "handler": 0x02301500, "handler_end": 0x023016B0,
        "active_isr": 0x02304000, "active_core_end": 0x02304314,
        "active_park": 0x02304500, "active_init": 0x02304600,
        "control_isr": 0x02304000,
    }
    if symbols != expected_symbols:
        findings.append(f"symbols:{symbols}")
    findings.extend(source_policy_errors(repo_root))

    accepted_names = ("default", "mode1_active", "mode1_control", "mode2_active",
                      "mode2_control", "q023_active", "q023_control",
                      "q026_active", "q026_control")
    accepted = all(hashes[name] == EXPECTED_HASHES[name] for name in accepted_names)
    return {
        "schema": SCHEMA,
        "static_eligible": not findings,
        "eligible": False,
        "promotable": False,
        "non_promotable": True,
        "scope": "master_comm0_stock_dispatch_player_shadow_gate",
        "authority_transferred": False,
        "cmd3f_stock_dispatch_exercised": True,
        "shared_comm_lanes_published": False,
        "collision_enabled": False,
        "bridge_enabled": False,
        "cadence_changed": False,
        "fps_claimed": False,
        "findings": findings,
        "sha256": hashes,
        "paths": {name: str(path) for name, path in paths.items()},
        "active_control_differences": [f"0x{offset:06X}" for offset in pair_diff],
        "handler_literal_users": [[f"0x{a:06X}", f"0x{b:06X}"] for a, b in handler_users],
        "isr_literal_users": [[f"0x{a:06X}", f"0x{b:06X}"] for a, b in isr_users],
        "allocations": {
            "handler": "0x02301500-0x023016AF", "isr_core": "0x02304000-0x02304313",
            "park": "0x02304500-0x02304503", "init": "0x02304600-0x0230466B",
            "stack": "0x0600FB68-0x0600FBFF", "canary": "0x2600FB64-0x2600FB67",
            "mailbox": "0x2600BC00-0x2600BC0F", "trace": "0x2600BC60-0x2600BC9F",
        },
        "stack_arithmetic": {
            "persistent_saves_bytes": 48, "player_deepest_bytes": 20,
            "nested_external_bytes": 84, "low_water": "0x0600FB68",
        },
        "mailbox_final_hex": EXPECTED_MAILBOX.hex(),
        "player_call_table": [f"0x{value:08X}" for value in (
            0x023017C0, 0x02301D94, 0x02301E00, 0x02301E20,
            0x02301D40, 0x02301820, 0x0230189C, 0x023017F2,
            0x02301B40, 0x02301CBC, 0x02301F20, 0x02302158,
            0x02301E2E, 0x02301E60,
        )],
        "accepted_identities_unchanged": accepted,
    }


def write_manifest(path: Path, payload: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile("w", dir=path.parent, prefix=f".{path.name}.",
                                     delete=False) as stream:
        temporary = Path(stream.name)
        json.dump(payload, stream, indent=2, sort_keys=True)
        stream.write("\n")
        stream.flush()
        os.fsync(stream.fileno())
    os.replace(temporary, path)


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ("active", "control", "default", "mode1-active", "mode1-control",
                 "mode2-active", "mode2-control", "q023-active", "q023-control",
                 "q026-active", "q026-control", "handler-bin", "handler-elf",
                 "active-isr", "control-isr", "active-isr-elf", "control-isr-elf",
                 "park-bin", "init-bin"):
        parser.add_argument(f"--{name}", required=True, type=Path)
    parser.add_argument("--repo-root", type=Path, default=Path("."))
    parser.add_argument("--manifest", required=True, type=Path)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    names = ("active", "control", "default", "mode1_active", "mode1_control",
             "mode2_active", "mode2_control", "q023_active", "q023_control",
             "q026_active", "q026_control", "handler_bin", "handler_elf",
             "active_isr", "control_isr", "active_isr_elf", "control_isr_elf",
             "park_bin", "init_bin")
    paths = {name: getattr(args, name) for name in names}
    try:
        payload = verify_pair(paths, args.repo_root.resolve())
        write_manifest(args.manifest, payload)
    except (OSError, ValueError, json.JSONDecodeError) as error:
        print(f"Q-027 verifier FAILED: {error}")
        return 1
    if not payload["static_eligible"]:
        print("Q-027 verifier FAILED: " + "; ".join(payload["findings"]))
        return 1
    print("Q-027 static validation PASS (non-promotable Master-COMM0 stock-dispatch gate)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
