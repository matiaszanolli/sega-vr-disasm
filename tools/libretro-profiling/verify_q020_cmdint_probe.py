#!/usr/bin/env python3
"""Fail-closed static verifier for the Q-020 Master CMD interrupt probe ROM."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import struct
import tempfile
from pathlib import Path

SCHEMA = "vrd-vr60-q020-cmdint-probe-v2"
EXPECTED_SIZE = 0x3F0000
EXPECTED_DEFAULT_SHA256 = (
    "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900"
)
EXPECTED_PROBE_SHA256 = (
    "8766714e5bdfc4cb9a8dcecb1a0ce23e1d3e67a54cdfc7473e3b9cbecb6a91e7"
)

ROUTE_OFFSETS = (0x00E0D4, 0x011822)
DEFAULT_ROUTE = bytes.fromhex("23fc00884a3e00ff0002")
PROBE_ROUTE = bytes.fromhex("23fc0089c91400ff0002")

M68K_OFFSET = 0x01C914
M68K_BYTES = bytes.fromhex(
    "4a3900ff7b41660a13fc000100ff7b4161064ef900884a3e"
    "0839000000a1510366f60039000100a151030839000000a1510366f64e75"
)
ONESHOT_ADDRESS = bytes.fromhex("00ff7b41")
ONESHOT_OPERAND_OFFSETS = (0x01C916, 0x01C920)

VECTOR_OFFSET = 0x020100
VECTOR_COUNT = 16
DEFAULT_VECTOR = bytes.fromhex("060006ac")
PROBE_VECTOR = bytes.fromhex("02303b00")

ISR_OFFSET = 0x303B00
ISR_END = 0x303CC4
ISR_SIZE = ISR_END - ISR_OFFSET
ISR_LITERAL_START = 0x303C88
ISR_SHA256 = "be3e5a944ad46b48533bc80f76452e768fad0f3a929d1dcbb54b4caf30b621c3"
EXPECTED_ISR_LITERAL_USERS = 21
EXTERNAL_LITERAL_USER = (0x3039FC, 0x303CB4)
SHIM_SYMBOL = "q020_cmdint_probe_init"
SHIM_ADDRESS = 0x02303C50

STARTUP_LITERAL_OFFSET = 0x020480
DEFAULT_STARTUP_LITERAL = bytes.fromhex("060045cc")
PROBE_STARTUP_LITERAL = bytes.fromhex("02303c50")
EXPECTED_STARTUP_LITERAL_USERS = [(0x020438, STARTUP_LITERAL_OFFSET)]

ALLOWED_DIFF_RANGES = (
    (ROUTE_OFFSETS[0], ROUTE_OFFSETS[0] + len(PROBE_ROUTE)),
    (ROUTE_OFFSETS[1], ROUTE_OFFSETS[1] + len(PROBE_ROUTE)),
    (M68K_OFFSET, M68K_OFFSET + len(M68K_BYTES)),
    (VECTOR_OFFSET, VECTOR_OFFSET + VECTOR_COUNT * 4),
    (STARTUP_LITERAL_OFFSET, STARTUP_LITERAL_OFFSET + 4),
    (ISR_OFFSET, ISR_END),
)


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def occurrences(image: bytes, needle: bytes) -> list[int]:
    found: list[int] = []
    offset = 0
    while True:
        offset = image.find(needle, offset)
        if offset < 0:
            return found
        found.append(offset)
        offset += 1


def differences_outside_ranges(candidate: bytes, reference: bytes) -> list[int]:
    if len(candidate) != len(reference):
        return [min(len(candidate), len(reference))]
    return [
        offset
        for offset, (left, right) in enumerate(zip(candidate, reference, strict=True))
        if left != right
        and not any(start <= offset < end for start, end in ALLOWED_DIFF_RANGES)
    ]


def literal_users_in_isr_allocation(image: bytes) -> list[tuple[int, int]]:
    """Return aligned SH2 MOV.L-PC users resolving into the ISR allocation."""
    users: list[tuple[int, int]] = []
    for offset in range(0, len(image) - 1, 2):
        opcode = int.from_bytes(image[offset : offset + 2], "big")
        if opcode >> 12 != 0xD:
            continue
        pc = 0x02000000 + offset
        target = ((pc + 4) & ~3) + (opcode & 0xFF) * 4
        target_offset = target - 0x02000000
        if ISR_OFFSET <= target_offset < ISR_END:
            users.append((offset, target_offset))
    return users


def movl_pc_users_of(image: bytes, target_offset: int) -> list[tuple[int, int]]:
    """Return every aligned SH2 MOV.L-PC resolving to one file offset."""
    users: list[tuple[int, int]] = []
    for offset in range(0, len(image) - 1, 2):
        opcode = int.from_bytes(image[offset : offset + 2], "big")
        if opcode >> 12 != 0xD:
            continue
        pc = 0x02000000 + offset
        resolved = ((pc + 4) & ~3) + (opcode & 0xFF) * 4 - 0x02000000
        if resolved == target_offset:
            users.append((offset, resolved))
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
    sections = []
    for index in range(e_shnum):
        base = e_shoff + index * e_shentsize
        sections.append(struct.unpack_from(endian + "IIIIIIIIII", image, base))
    for section in sections:
        sh_type, sh_offset, sh_size, sh_link, sh_entsize = (
            section[1], section[4], section[5], section[6], section[9]
        )
        if sh_type != 2 or not sh_entsize or sh_link >= len(sections):
            continue
        strings = sections[sh_link]
        string_data = image[strings[4] : strings[4] + strings[5]]
        for offset in range(sh_offset, sh_offset + sh_size, sh_entsize):
            st_name, st_value = struct.unpack_from(endian + "II", image, offset)
            if st_name >= len(string_data):
                continue
            end = string_data.find(b"\0", st_name)
            if end < 0:
                continue
            if string_data[st_name:end].decode(errors="replace") == symbol_name:
                return st_value
    return None


def source_policy_errors(repo_root: Path) -> list[str]:
    errors: list[str] = []
    vrd = (repo_root / "disasm/vrd.asm").read_text()
    if (
        "ifd     VR60_Q020_CMDINT_PROBE" not in vrd
        or "ifd     VR60_MODE1_VALIDATION" not in vrd
        or "ifd     VR60_MODE1_STAGE_CONTROL" not in vrd
        or "assert  0," not in vrd
        or "mutually exclusive" not in vrd
    ):
        errors.append("source_mutual_exclusion_guard")

    route_paths = (
        repo_root
        / "disasm/modules/68k/game/scene/scene_setup_game_mode_transition.asm",
        repo_root
        / "disasm/modules/68k/game/menu/sh2_scene_reset_name_entry_mode_disp.asm",
    )
    for path in route_paths:
        text = path.read_text()
        if "VR60_Q020_CMDINT_PROBE" not in text or "#$0089C914,$00FF0002" not in text:
            errors.append(f"source_probe_route:{path.name}")
        if "7B41" in text.upper():
            errors.append(f"source_route_rearms_oneshot:{path.name}")

    wrapper = (
        repo_root / "disasm/modules/68k/sh2/q020_cmdint_probe.asm"
    ).read_text()
    required_wrapper_fragments = (
        "Q020_CMDINT_ONESHOT    equ     $00FF7B41",
        ".wait_for_boot_ack:",
        "ori.b   #1,$00A15103",
        "btst    #0,$00A15103",
        "jmp     $00884A3E",
    )
    if any(fragment not in wrapper for fragment in required_wrapper_fragments):
        errors.append("source_wrapper_policy")

    expansion = (repo_root / "disasm/sections/expansion_300000.asm").read_text()
    if (
        "dcb.b   ($303B00 - *), $FF" not in expansion
        or 'assert  *=$303CC4,"Q-020 CMDINT probe must end at file $303CC4"' not in expansion
    ):
        errors.append("source_isr_placement")
    master = (repo_root / "disasm/sections/code_20200.asm").read_text()
    if (
        "ifd     VR60_Q020_CMDINT_PROBE" not in master
        or "dc.l    $02303C50" not in master
        or "dc.w    $0600        ; $020480" not in master
        or "dc.w    $45CC        ; $020482" not in master
    ):
        errors.append("source_startup_shim")
    return errors


def verify(
    probe_path: Path,
    default_path: Path,
    isr_bin_path: Path,
    isr_elf_path: Path,
    repo_root: Path,
) -> dict[str, object]:
    probe = probe_path.read_bytes()
    default = default_path.read_bytes()
    isr_bin = isr_bin_path.read_bytes()
    isr_elf = isr_elf_path.read_bytes()
    findings: list[str] = []

    hashes = {
        "probe": sha256(probe),
        "default": sha256(default),
        "isr_bin": sha256(isr_bin),
    }
    for name, image in (("probe", probe), ("default", default)):
        if len(image) != EXPECTED_SIZE:
            findings.append(f"{name}_size:{len(image)}")
    if hashes["default"] != EXPECTED_DEFAULT_SHA256:
        findings.append(f"default_sha256:{hashes['default']}")
    if hashes["probe"] != EXPECTED_PROBE_SHA256:
        findings.append(f"probe_sha256:{hashes['probe']}")
    if len(isr_bin) != ISR_SIZE:
        findings.append(f"isr_bin_size:{len(isr_bin)}")
    if hashes["isr_bin"] != ISR_SHA256:
        findings.append(f"isr_bin_sha256:{hashes['isr_bin']}")

    for offset in ROUTE_OFFSETS:
        if default[offset : offset + len(DEFAULT_ROUTE)] != DEFAULT_ROUTE:
            findings.append(f"default_route_0x{offset:X}")
        if probe[offset : offset + len(PROBE_ROUTE)] != PROBE_ROUTE:
            findings.append(f"probe_route_0x{offset:X}")

    default_vectors = DEFAULT_VECTOR * VECTOR_COUNT
    probe_vectors = PROBE_VECTOR * VECTOR_COUNT
    if default[VECTOR_OFFSET : VECTOR_OFFSET + len(default_vectors)] != default_vectors:
        findings.append("default_external_vectors")
    if probe[VECTOR_OFFSET : VECTOR_OFFSET + len(probe_vectors)] != probe_vectors:
        findings.append("probe_external_vectors")

    if default[M68K_OFFSET : M68K_OFFSET + len(M68K_BYTES)] != b"\xFF" * len(
        M68K_BYTES
    ):
        findings.append("default_m68k_reserve")
    if probe[M68K_OFFSET : M68K_OFFSET + len(M68K_BYTES)] != M68K_BYTES:
        findings.append("probe_m68k_wrapper_helper")

    if default[ISR_OFFSET:ISR_END] != b"\xFF" * ISR_SIZE:
        findings.append("default_isr_reserve")
    if probe[ISR_OFFSET:ISR_END] != isr_bin:
        findings.append("probe_isr_rom_mismatch")

    if default[STARTUP_LITERAL_OFFSET : STARTUP_LITERAL_OFFSET + 4] != DEFAULT_STARTUP_LITERAL:
        findings.append("default_startup_literal")
    if probe[STARTUP_LITERAL_OFFSET : STARTUP_LITERAL_OFFSET + 4] != PROBE_STARTUP_LITERAL:
        findings.append("probe_startup_literal")
    startup_users = movl_pc_users_of(probe, STARTUP_LITERAL_OFFSET)
    if startup_users != EXPECTED_STARTUP_LITERAL_USERS:
        findings.append(
            "startup_literal_users:"
            + ",".join(f"0x{user:X}->0x{target:X}" for user, target in startup_users)
        )
    try:
        shim_value = elf32_symbol_value(isr_elf, SHIM_SYMBOL)
    except ValueError as error:
        findings.append(str(error))
        shim_value = None
    if shim_value != SHIM_ADDRESS:
        findings.append(f"isr_shim_symbol:{shim_value!r}")

    default_oneshot = occurrences(default, ONESHOT_ADDRESS)
    probe_oneshot = occurrences(probe, ONESHOT_ADDRESS)
    if default_oneshot:
        findings.append(
            "default_oneshot_address:" + ",".join(f"0x{x:X}" for x in default_oneshot)
        )
    if tuple(probe_oneshot) != ONESHOT_OPERAND_OFFSETS:
        findings.append(
            "probe_oneshot_address:" + ",".join(f"0x{x:X}" for x in probe_oneshot)
        )

    outside = differences_outside_ranges(probe, default)
    if outside:
        findings.append(
            "difference_outside_allowed_ranges:"
            + ",".join(f"0x{offset:X}" for offset in outside[:32])
        )

    literal_users = literal_users_in_isr_allocation(probe)
    private_users = [item for item in literal_users if item != EXTERNAL_LITERAL_USER]
    external_users = [item for item in literal_users if item[0] < ISR_OFFSET]
    if len(private_users) != EXPECTED_ISR_LITERAL_USERS:
        findings.append(f"isr_literal_user_count:{len(private_users)}")
    if external_users != [EXTERNAL_LITERAL_USER]:
        findings.append(
            "isr_external_literal_users:"
            + ",".join(f"0x{user:X}->0x{target:X}" for user, target in external_users)
        )
    external_target = EXTERNAL_LITERAL_USER[1]
    if (
        probe[external_target : external_target + 4] != b"\xFF" * 4
        or default[external_target : external_target + 4] != b"\xFF" * 4
    ):
        findings.append("external_literal_target_modified")
    for user, target in literal_users:
        if user < ISR_OFFSET:
            continue
        if not (ISR_LITERAL_START <= target < ISR_END):
            findings.append(f"nonprivate_literal:0x{user:X}->0x{target:X}")

    findings.extend(source_policy_errors(repo_root))
    if findings:
        raise ValueError("; ".join(findings))

    changed_bytes = sum(
        left != right for left, right in zip(probe, default, strict=True)
    )
    return {
        "schema": SCHEMA,
        "status": "verified",
        "non_promotable": True,
        "build_defines": ["VR60_MODE0_ONLY=1", "VR60_Q020_CMDINT_PROBE=1"],
        "images": {
            "default": {
                "path": str(default_path),
                "size": len(default),
                "sha256": hashes["default"],
            },
            "probe": {
                "path": str(probe_path),
                "size": len(probe),
                "sha256": hashes["probe"],
            },
            "isr_bin": {
                "path": str(isr_bin_path),
                "size": len(isr_bin),
                "sha256": hashes["isr_bin"],
            },
            "isr_elf": {
                "path": str(isr_elf_path),
                "sha256": sha256(isr_elf),
            },
        },
        "allowed_diff_ranges": [
            {"start": f"0x{start:06X}", "end_exclusive": f"0x{end:06X}"}
            for start, end in ALLOWED_DIFF_RANGES
        ],
        "changed_bytes": changed_bytes,
        "external_vectors": {
            "file_range": "0x020100-0x02013F",
            "count": VECTOR_COUNT,
            "target": "0x02303B00",
        },
        "m68k_wrapper_helper": {
            "file_range": "0x01C914-0x01C949",
            "oneshot_wram": "0xFFFF7B41",
            "oneshot_operand_offsets": [
                f"0x{offset:06X}" for offset in ONESHOT_OPERAND_OFFSETS
            ],
        },
        "isr": {
            "file_range": "0x303B00-0x303CC3",
            "sh2_range": "0x02303B00-0x02303CC3",
            "literal_pool_file_range": "0x303C88-0x303CC3",
            "literal_users": [
                {"user": f"0x{user:06X}", "target": f"0x{target:06X}"}
                for user, target in literal_users
            ],
        },
        "master_startup_shim": {
            "literal_file_offset": "0x020480",
            "literal_users": [
                {"user": f"0x{user:06X}", "target": f"0x{target:06X}"}
                for user, target in startup_users
            ],
            "symbol": SHIM_SYMBOL,
            "sh2_address": f"0x{shim_value:08X}",
            "vres_init_count_delta": 2,
        },
        "route_installers": [f"0x{offset:06X}" for offset in ROUTE_OFFSETS],
        "mode1_enabled": False,
        "cmd3f_enabled": False,
    }


def write_manifest(path: Path, manifest: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    handle, temporary_name = tempfile.mkstemp(
        prefix=f".{path.name}.", suffix=".tmp", dir=path.parent
    )
    try:
        with os.fdopen(handle, "w") as temporary:
            json.dump(manifest, temporary, indent=2, sort_keys=True)
            temporary.write("\n")
        os.replace(temporary_name, path)
    except BaseException:
        Path(temporary_name).unlink(missing_ok=True)
        raise


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--probe", type=Path, required=True)
    parser.add_argument("--default", type=Path, required=True)
    parser.add_argument("--isr-bin", type=Path, required=True)
    parser.add_argument("--isr-elf", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument(
        "--repo-root",
        type=Path,
        default=Path(__file__).resolve().parents[2],
    )
    args = parser.parse_args()

    try:
        manifest = verify(
            args.probe,
            args.default,
            args.isr_bin,
            args.isr_elf,
            args.repo_root.resolve(),
        )
    except (OSError, ValueError) as error:
        print(f"Q-020 CMDINT probe verification FAILED: {error}")
        return 1

    write_manifest(args.manifest, manifest)
    print(
        "Q-020 CMDINT probe verification PASS: "
        f"probe={manifest['images']['probe']['sha256']} "
        f"changed_bytes={manifest['changed_bytes']}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
