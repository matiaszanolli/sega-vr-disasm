#!/usr/bin/env python3
"""Fail-closed static verifier for the isolated Q-026 player-CMDINT pair."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import struct
import tempfile
from collections.abc import Sequence
from pathlib import Path


SCHEMA = "vrd-vr60-q026-player-cmdint-pair-v1"
EXPECTED_SIZE = 0x3F0000

EXPECTED_HASHES = {
    "active": "c9358ad4ff04d7420c7bef1f45c163afb4506efae4990c4b48a475188e0b76f8",
    "control": "240dfd0a8df87a8118982849f354bc720b0011d480221f2031e3ceeb6dc1a66d",
    "default": "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900",
    "mode1_active": "963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470",
    "mode1_control": "391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd",
    "mode2_active": "96d79e3fb4d2df8a69852917ac811f860935ae950fc87222d008fa45d47ee276",
    "mode2_control": "da5ce4ec9ef8e050c7babeb113e26aa7335a3ff5285285e55a6606d2f96309b8",
    "q023_active": "8709aed4fc16d548b06694a92361a240537fbae7f987ee5f00a62c3c995a59ef",
    "q023_control": "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900",
    "handler_bin": "5f9cf17e9e00faef062c45d21e49971216a06c39b1c628e40928724a883bccdd",
    "isr_bin": "288b56336f79c74cdbb7a53adc7dbae5d1429928cd23ba12173cbbd7ff1e4ee3",
}

ROUTE_OFFSETS = (0x00E0D4, 0x011822)
Q026_ROUTE = bytes.fromhex("23fc0089c93000ff0002")
HOOK_START = 0x01C8B0
WRAPPER_START = 0x01C930
WRAPPER_END = 0x01C93E
WRAPPER_BYTES = bytes.fromhex("4e714239ffff7b404ef900884a3e")
TRIGGER_START = 0x01C8EC
TRIGGER_END = 0x01C8F4
ACTIVE_TRIGGER = bytes.fromhex("0039000100a15103")
CONTROL_TRIGGER = bytes.fromhex("4e714e714e714e71")

VECTOR_START = 0x020100
VECTOR_END = 0x020140
Q026_VECTOR = bytes.fromhex("02304000")
STARTUP_LITERAL = 0x020480
Q026_STARTUP = bytes.fromhex("02304600")
CMD3F_JUMP = 0x02087C
STOCK_INVALID = bytes.fromhex("06000490")

HANDLER_START = 0x301500
HANDLER_PAYLOAD_END = 0x3015C8
HANDLER_END = 0x3016B0
HANDLER_POOL = {
    0x30157C: 0x2600FC00, 0x301580: 0x51323645,
    0x301584: 0x51323643, 0x301588: 0x2600F20C,
    0x30158C: 0x2600F30C, 0x301590: 0x023017C0,
    0x301594: 0x02301820, 0x301598: 0x0230189C,
    0x30159C: 0x023017F2, 0x3015A0: 0x02301B40,
    0x3015A4: 0x02301CBC, 0x3015A8: 0x02301D40,
    0x3015AC: 0x02301D94, 0x3015B0: 0x02301E00,
    0x3015B4: 0x02301E20, 0x3015B8: 0x02301E2E,
    0x3015BC: 0x02301E60, 0x3015C0: 0x02301F20,
    0x3015C4: 0x02302158,
}

ISR_START = 0x304000
ISR_CORE_END = 0x304290
ISR_INIT_START = 0x304600
ISR_INIT_END = 0x304654
ISR_END = 0x304700
HANDLER_SIZE = 200
ISR_LINKED_SIZE = 1620

EXPECTED_HANDLER_LITERAL_USERS = (
    (0x301502, 0x30157C), (0x301504, 0x301580),
    (0x30150A, 0x301588), (0x301510, 0x30158C),
    (0x30151A, 0x301590), (0x301520, 0x3015AC),
    (0x301526, 0x3015B0), (0x30152C, 0x3015B4),
    (0x301532, 0x3015A8), (0x301538, 0x301594),
    (0x30153E, 0x301598), (0x301544, 0x30159C),
    (0x30154A, 0x3015A0), (0x301550, 0x3015A4),
    (0x301556, 0x3015C0), (0x30155C, 0x3015C4),
    (0x301562, 0x3015B8), (0x301568, 0x3015BC),
    (0x30156E, 0x30157C), (0x301570, 0x301584),
)
EXPECTED_ISR_LITERAL_USERS = (
    (0x304026, 0x304224), (0x30404C, 0x304228),
    (0x304050, 0x30422C), (0x304064, 0x304278),
    (0x30406E, 0x30425C), (0x30407E, 0x304284),
    (0x304084, 0x304228), (0x304088, 0x30422C),
    (0x3040A0, 0x304230), (0x3040AE, 0x304234),
    (0x3040BC, 0x30425C), (0x3040C2, 0x304260),
    (0x3040C8, 0x304264), (0x3040CE, 0x304268),
    (0x3040D4, 0x30426C), (0x3040DA, 0x304270),
    (0x3040E0, 0x304274), (0x3040F6, 0x30427C),
    (0x304100, 0x304278), (0x304106, 0x304238),
    (0x30410A, 0x30423C), (0x304120, 0x304248),
    (0x304122, 0x30424C), (0x30412E, 0x304244),
    (0x304132, 0x304250), (0x304138, 0x304238),
    (0x30413C, 0x304240), (0x304142, 0x304248),
    (0x304146, 0x30424C), (0x304150, 0x304228),
    (0x304172, 0x304280), (0x304178, 0x304278),
    (0x304184, 0x304254), (0x304186, 0x304288),
    (0x30418C, 0x304254), (0x3041A0, 0x304258),
    (0x3041A8, 0x304254), (0x3041EC, 0x304228),
    (0x3041EE, 0x30428C), (0x304602, 0x30463C),
    (0x304606, 0x304640), (0x30461A, 0x304640),
    (0x304620, 0x304644), (0x304622, 0x304648),
    (0x304628, 0x30464C), (0x304636, 0x304650),
)

ALLOWED_DEFAULT_DIFF_RANGES = (
    (ROUTE_OFFSETS[0], ROUTE_OFFSETS[0] + len(Q026_ROUTE)),
    (ROUTE_OFFSETS[1], ROUTE_OFFSETS[1] + len(Q026_ROUTE)),
    (HOOK_START, WRAPPER_END), (VECTOR_START, VECTOR_END),
    (STARTUP_LITERAL, STARTUP_LITERAL + 4), (CMD3F_JUMP, CMD3F_JUMP + 4),
    (HANDLER_START, HANDLER_END), (ISR_START, ISR_END),
)

# Word fields in the player record plus globals +$00 and +$2C byte.  This is
# used by the runtime validator; CE/D2/D6/DA are deliberately absent.
ENTITY_ALLOWED_FIELDS = (
    0x02, 0x04, 0x06, 0x0C, 0x0E, 0x10, 0x14, 0x16,
    0x30, 0x34, 0x3C, 0x40, 0x62, 0x6A, 0x6C, 0x6E,
    0x74, 0x76, 0x78, 0x7A, 0x7E, 0x80, 0x82, 0x84,
    0x86, 0x8E, 0x90, 0x92, 0x94, 0x96, 0x98, 0x9A,
    0xAA, 0xBC, 0xE6, 0xE8, 0xEC, 0xEE, 0xF0, 0xF2,
    0xF4, 0xF6, 0xF8, 0xFA,
)
GLOBALS_ALLOWED_FIELDS = ((0x00, 2), (0x2C, 1))


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def differing_offsets(left: bytes, right: bytes) -> list[int]:
    if len(left) != len(right):
        return [min(len(left), len(right))]
    return [i for i, pair in enumerate(zip(left, right, strict=True)) if pair[0] != pair[1]]


def differences_outside_ranges(candidate: bytes, reference: bytes) -> list[int]:
    return [i for i in differing_offsets(candidate, reference)
            if not any(start <= i < end for start, end in ALLOWED_DEFAULT_DIFF_RANGES)]


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
    sources = {
        "vrd": repo_root / "disasm/vrd.asm",
        "hook": repo_root / "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm",
        "handler": repo_root / "disasm/sh2/expansion/q026_player_shadow.s",
        "isr": repo_root / "disasm/sh2/expansion/q026_external_isr.s",
        "expansion": repo_root / "disasm/sections/expansion_300000.asm",
        "master": repo_root / "disasm/sections/code_20200.asm",
        "make": repo_root / "Makefile",
    }
    texts = {name: path.read_text() for name, path in sources.items()}
    for fragment in (
        "Q-026 and ordinary VR60_MODE0_ONLY are mutually exclusive",
        "Q-026 and Q-020 CMDINT probe are mutually exclusive",
        "Q-026 and mode-1 validation are mutually exclusive",
        "Q-026 and mode-2 validation are mutually exclusive",
        "Q-026 and Q-023 mailbox validation are mutually exclusive",
    ):
        if fragment not in texts["vrd"]:
            errors.append("source_mutual_exclusion:" + fragment)
    for fragment in (
        "move.b  #$02,VR60_1P_FLAG", ".q026_wait_intm:",
        ".q026_wait_dreq:", ".q026_wait_len:", ".q026_wait_comm0:",
        "ori.b   #$01,MARS_SYS_INTMASK+1", "jsr     vr60_1p_entity_transfer",
    ):
        if fragment not in texts["hook"]:
            errors.append("source_hook:" + fragment)
    for forbidden in ("COMM", "0401", "06010000", "bridge", "collision"):
        body = "\n".join(line for line in texts["handler"].splitlines()
                         if not line.lstrip().startswith("*"))
        if forbidden in body:
            errors.append("source_handler_forbidden:" + forbidden)
    for fragment in (
        "stc     sr,r4", "cmp/eq  #0x38,r0", "cmp/eq  #0x20,r0",
        "mov.l   @(.L_stack_canary,pc),r1\n"
        "    mov.l   @(.L_stack_magic,pc),r2\n"
        "    mov.l   r2,@r1\n"
        "    mov.l   @r1,r0\n"
        "    cmp/eq  r2,r0\n"
        "    bf      .L_bad_canary",
        "mov.l   @(.L_stack_top,pc),r15", "mov.l   r0,@-r15",
        "mov.w   r0,@r1\n    mov.w   @r1,r0",
        "mov.w   r6,@r1\n    mov.w   @r1,r0", "rte\n    nop",
    ):
        if fragment not in texts["isr"]:
            errors.append("source_isr:" + fragment)
    if "ifd     VR60_Q026_VALIDATION" not in texts["expansion"] \
            or "assert  *=$304700" not in texts["expansion"]:
        errors.append("source_expansion_ownership")
    if "Q-026 direct-only: no cmd $3F registration" not in texts["master"]:
        errors.append("source_cmd3f_registration")
    if "-D VR60_Q026_STAGE_CONTROL=1" not in texts["make"]:
        errors.append("source_make_pair")
    return errors


def verify_pair(paths: dict[str, Path], repo_root: Path) -> dict[str, object]:
    images = {name: path.read_bytes() for name, path in paths.items()}
    hashes = {name: sha256(image) for name, image in images.items()}
    findings: list[str] = []
    for name, expected in EXPECTED_HASHES.items():
        if hashes.get(name) != expected:
            findings.append(f"{name}_sha256:{hashes.get(name)}")
    for name in ("active", "control", "default", "mode1_active", "mode1_control",
                 "mode2_active", "mode2_control", "q023_active", "q023_control"):
        if len(images[name]) != EXPECTED_SIZE:
            findings.append(f"{name}_size:{len(images[name])}")
    if len(images["handler_bin"]) != HANDLER_SIZE:
        findings.append("handler_size")
    if len(images["isr_bin"]) != ISR_LINKED_SIZE:
        findings.append("isr_size")

    active, control, default = images["active"], images["control"], images["default"]
    pair_diff = differing_offsets(active, control)
    expected_pair_diff = list(range(TRIGGER_START, TRIGGER_END))
    if pair_diff != expected_pair_diff:
        findings.append("active_control_delta")
    if active[TRIGGER_START:TRIGGER_END] != ACTIVE_TRIGGER:
        findings.append("active_trigger")
    if control[TRIGGER_START:TRIGGER_END] != CONTROL_TRIGGER:
        findings.append("control_trigger")
    for name, image in (("active", active), ("control", control)):
        for route in ROUTE_OFFSETS:
            if image[route:route + len(Q026_ROUTE)] != Q026_ROUTE:
                findings.append(f"{name}_route_{route:06x}")
        if image[WRAPPER_START:WRAPPER_END] != WRAPPER_BYTES:
            findings.append(f"{name}_wrapper")
        if image[VECTOR_START:VECTOR_END] != Q026_VECTOR * 16:
            findings.append(f"{name}_vectors")
        if image[STARTUP_LITERAL:STARTUP_LITERAL + 4] != Q026_STARTUP:
            findings.append(f"{name}_startup")
        if image[CMD3F_JUMP:CMD3F_JUMP + 4] != STOCK_INVALID:
            findings.append(f"{name}_cmd3f_registered")
        if image[HANDLER_START:HANDLER_PAYLOAD_END] != images["handler_bin"]:
            findings.append(f"{name}_handler")
        if image[HANDLER_PAYLOAD_END:HANDLER_END] != b"\xff" * (HANDLER_END-HANDLER_PAYLOAD_END):
            findings.append(f"{name}_handler_padding")
        if image[ISR_START:ISR_CORE_END] != images["isr_bin"][:0x290]:
            findings.append(f"{name}_isr_core")
        if image[ISR_CORE_END:ISR_INIT_START] != b"\xff" * (ISR_INIT_START-ISR_CORE_END):
            findings.append(f"{name}_isr_middle_padding")
        if image[ISR_INIT_START:ISR_INIT_END] != images["isr_bin"][0x600:0x654]:
            findings.append(f"{name}_isr_init")
        if image[ISR_INIT_END:ISR_END] != b"\xff" * (ISR_END-ISR_INIT_END):
            findings.append(f"{name}_isr_tail_padding")
        outside = differences_outside_ranges(image, default)
        if outside:
            findings.append(f"{name}_outside_scope:{outside[0]:06x}")

    for offset, value in HANDLER_POOL.items():
        if int.from_bytes(active[offset:offset + 4], "big") != value:
            findings.append(f"handler_pool_{offset:06x}")
    handler_users = movl_pc_users_into(active, HANDLER_START, HANDLER_END)
    isr_users = movl_pc_users_into(active, ISR_START, ISR_END)
    if handler_users != EXPECTED_HANDLER_LITERAL_USERS:
        findings.append("handler_literal_ownership")
    if isr_users != EXPECTED_ISR_LITERAL_USERS:
        findings.append("isr_literal_ownership")
    if active[0x3039FC:0x303A00] != default[0x3039FC:0x303A00] \
            or active[0x303CB4:0x303CB8] != b"\xff" * 4:
        findings.append("external_literal_owner")

    try:
        symbols = {
            "handler": elf32_symbol_value(images["handler_elf"], "q026_player_shadow"),
            "isr": elf32_symbol_value(images["isr_elf"], "q026_external_entry"),
            "init": elf32_symbol_value(images["isr_elf"], "q026_init"),
        }
    except (IndexError, struct.error, ValueError) as error:
        findings.append("elf:" + str(error))
        symbols = {}
    if symbols != {"handler": 0x02301500, "isr": 0x02304000, "init": 0x02304600}:
        findings.append(f"symbols:{symbols}")
    findings.extend(source_policy_errors(repo_root))

    accepted = all(hashes[name] == EXPECTED_HASHES[name] for name in (
        "default", "mode1_active", "mode1_control", "mode2_active",
        "mode2_control", "q023_active", "q023_control",
    ))
    return {
        "schema": SCHEMA,
        "static_eligible": not findings,
        "eligible": False,
        "promotable": False,
        "non_promotable": True,
        "scope": "bounded_direct_cmdint_player_physics_precursor",
        "authority_transferred": False,
        "cmd3f_enabled": False,
        "collision_enabled": False,
        "bridge_enabled": False,
        "cadence_changed": False,
        "findings": findings,
        "sha256": hashes,
        "paths": {name: str(path) for name, path in paths.items()},
        "active_control_differences": [f"0x{i:06X}" for i in pair_diff],
        "handler_literal_users": [[f"0x{a:06X}", f"0x{b:06X}"] for a, b in handler_users],
        "isr_literal_users": [[f"0x{a:06X}", f"0x{b:06X}"] for a, b in isr_users],
        "stack_bounds": {
            "stock_write_union": "0x0600FED0-0x0600FF7F",
            "dedicated_write_interval": "0x0600FB94-0x0600FBFF",
            "canary": "0x2600FB90-0x2600FB93",
        },
        "field_allowlist": {
            "entity_word_offsets": [f"0x{x:02X}" for x in ENTITY_ALLOWED_FIELDS],
            "globals": [[f"0x{x:02X}", width] for x, width in GLOBALS_ALLOWED_FIELDS],
            "preserved": ["0xCE", "0xD2", "0xD6", "0xDA"],
        },
        "accepted_identities_unchanged": accepted,
    }


def write_manifest(path: Path, payload: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile("w", dir=path.parent, prefix=f".{path.name}.",
                                     delete=False) as stream:
        temporary = Path(stream.name)
        json.dump(payload, stream, indent=2, sort_keys=True)
        stream.write("\n"); stream.flush(); os.fsync(stream.fileno())
    os.replace(temporary, path)


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ("active", "control", "default", "mode1-active", "mode1-control",
                 "mode2-active", "mode2-control", "q023-active", "q023-control",
                 "handler-bin", "handler-elf", "isr-bin", "isr-elf"):
        parser.add_argument(f"--{name}", required=True, type=Path)
    parser.add_argument("--repo-root", type=Path, default=Path("."))
    parser.add_argument("--manifest", required=True, type=Path)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    names = ("active", "control", "default", "mode1_active", "mode1_control",
             "mode2_active", "mode2_control", "q023_active", "q023_control",
             "handler_bin", "handler_elf", "isr_bin", "isr_elf")
    paths = {name: getattr(args, name) for name in names}
    try:
        payload = verify_pair(paths, args.repo_root.resolve())
        write_manifest(args.manifest, payload)
    except (OSError, ValueError, json.JSONDecodeError) as error:
        print(f"Q-026 verifier FAILED: {error}")
        return 1
    if not payload["static_eligible"]:
        print("Q-026 verifier FAILED: " + "; ".join(payload["findings"]))
        return 1
    print("Q-026 static validation PASS (non-promotable direct-CMDINT precursor)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
