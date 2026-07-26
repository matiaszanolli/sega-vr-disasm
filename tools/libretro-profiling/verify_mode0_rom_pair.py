#!/usr/bin/env python3
"""Verify the source-built VR60 cmd $3E mode-0 ACTIVE/STAGE-CONTROL ROM pair.

This is a fail-closed static gate.  It binds the pair delta, the complete
isolated 1P hook body, the 68K staging/FIFO code, the Master jump-table entry,
and the complete SH2 cmd $3E handler to exact assembled bytes.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import tempfile
from collections.abc import Sequence
from pathlib import Path

SCHEMA = "vrd-vr60-mode0-rom-pair-v2"
SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_MANIFEST = SCRIPT_DIR / "mode0_rom_pair.json"

EXPECTED_ROM_SIZE = 4_128_768
EXPECTED_DEFAULT_SHA256 = "14632a23804b6043921f0e66d3f9ff84cf2ae58c66c04617d933fd7874b93183"
EXPECTED_ACTIVE_SHA256 = "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900"
EXPECTED_CONTROL_SHA256 = "75b5691a9dc11d39b19093e221a566cdd8a2d014520b1d7d88908122a94c4021"

HOOK_SITE_OFFSET = 0x004D62
HOOK_SITE_BYTES = bytes.fromhex("4ef90001c8b04e71")

ENTITY_STAGE_OFFSET = 0x01C494
ENTITY_STAGE_BYTES = bytes.fromhex(
    "48e7ffc041f900ff900043f900ff6a004cd800ff48d100ff43e90020"
    "4cd800ff48d100ff43e900204cd800ff48d100ff43e900204cd800ff"
    "48d100ff43e900204cd800ff48d100ff43e900204cd800ff48d100ff"
    "43e900204cd800ff48d100ff43e900204cd800ff48d100ff4cdf03ff"
    "4e75"
)

GLOBALS_STAGE_OFFSET = 0x01C506
GLOBALS_STAGE_BYTES = bytes.fromhex(
    "48e780c043f900ff6b003038c0ac32c03038c0e632c03038c0f832c0"
    "3038c0fa32c02038c27c22c02038c04822c01038c0d412c01038c31b"
    "12c01038c82612c01038c97112c03038c00032c03038c00a32c01038"
    "c01012c01038c01812c03038c8c832c03038c8cc32c041f9ffffbba0"
    "301832c0301832c0301832c0301832c0301832c041f9ffffbbb03018"
    "32c0301832c01038c8a412c01038bfc012c01038bf7b12c042194299"
    "3038c83e32c03038c84032c03038c8a032c02038c268d0bc01780000"
    "22c042594cdf03014e75"
)

ENTITY_TRANSFER_OFFSET = 0x01C6FE
ENTITY_TRANSFER_BYTES = bytes.fromhex(
    "48e7c06033fc00a000a1511013fc000400a15107720f700013c000a15120"
    "13fc003e00a1512113fc000100a15120303c006351c8fffe0839000100a1"
    "5123660651c9ffd4602208b9000100a1512343f900ff6a0045f900a15112"
    "4eb9008988ec701f349951c8fffc4cdf06034e75"
)

HOOK_OFFSET = 0x01C8B0
ACTIVE_HOOK_BYTES = bytes.fromhex(
    "4a39ffff7b40664a4eb90001c4944eb90001c5064eb90001c8d4"
    "13fc0001ffff7b40602e13fc000000a151266000fe20"
    "11f900a1512cc8a4423900a1512c33f900a1512800ff617a"
    "33f900a1512a00ff618e4eb90000b6da4eb90000b6844ef900884d6a"
)
CONTROL_HOOK_BYTES = bytes.fromhex(
    "4a39ffff7b40664a4eb90001c4944eb90001c5064e714e714e71"
    "13fc0001ffff7b40602e13fc000000a151266000fe20"
    "11f900a1512cc8a4423900a1512c33f900a1512800ff617a"
    "33f900a1512a00ff618e4eb90000b6da4eb90000b6844ef900884d6a"
)
DEFAULT_HOOK_BYTES = bytes.fromhex(
    "4a39ffff7b40661c4eb90001c4944eb90001c5064eb90001c6fe"
    "13fc0001ffff7b40600c4eb90001c5064eb90001c7e0"
    "11f900a1512cc8a4423900a1512c33f900a1512800ff617a"
    "33f900a1512a00ff618e4eb90000b6da4eb90000b6844ef900004d6a"
)
TRANSFER_CALL_OFFSET = HOOK_OFFSET + 20
ACTIVE_TRANSFER_CALL = bytes.fromhex("4eb90001c8d4")
CONTROL_TRANSFER_CALL = bytes.fromhex("4e714e714e71")

MASTER_CMD3E_JUMP_OFFSET = 0x020878
MASTER_CMD3E_JUMP_BYTES = bytes.fromhex("023016b0")
CMD3E_HANDLER_OFFSET = 0x3016B0
CMD3E_HANDLER_BYTES = bytes.fromhex(
    "d12a21824f22848620088b0ad119d01a2102d11ad01a2102d11bd01c2102"
    "a0170009e10130108b0ad112d0132102d113d0142102d114d0162102a009"
    "0009d10dd00d2102d10dd0132102d10fd0122102d112d0132102d113e001"
    "21028483cb028083d111601120088bfce00080804f26000b0009"
    "ffffff8020004012ffffff840600f20c0600f30cffffff88000000a0"
    "000000200601000000000780ffffff8c000044e5ffffffb0200040102600fc00"
)


def signed_word(value: int) -> int:
    return value - 0x10000 if value & 0x8000 else value


def verify_hook_control_flow(image: bytes, *, active: bool) -> list[str]:
    """Machine-check all edges that make the legacy relay unreachable."""
    hook = image[HOOK_OFFSET : HOOK_OFFSET + len(ACTIVE_HOOK_BYTES)]
    findings: list[str] = []
    branch_targets = {
        "flag_already_set": HOOK_OFFSET + 8 + int.from_bytes(hook[7:8], signed=True),
        "after_first_hook": HOOK_OFFSET + 36 + int.from_bytes(hook[35:36], signed=True),
        "mode0_tail": HOOK_OFFSET + 46 + signed_word(int.from_bytes(hook[46:48], "big")),
    }
    expected_targets = {
        "flag_already_set": HOOK_OFFSET + 0x52,
        "after_first_hook": HOOK_OFFSET + 0x52,
        "mode0_tail": ENTITY_TRANSFER_OFFSET,
    }
    if hook[6] != 0x66:
        findings.append("flag_branch_opcode")
    if hook[34] != 0x60:
        findings.append("post_flag_branch_opcode")
    if hook[44:46] != bytes.fromhex("6000"):
        findings.append("mode0_tail_branch_opcode")
    for name, target in branch_targets.items():
        if target != expected_targets[name]:
            findings.append(f"{name}_target")
    if active:
        if hook[20:22] != bytes.fromhex("4eb9"):
            findings.append("active_call_opcode")
        elif int.from_bytes(hook[22:26], "big") != HOOK_OFFSET + 0x24:
            findings.append("active_call_target")
    elif hook[20:26] != CONTROL_TRANSFER_CALL:
        findings.append("control_slot_not_nops")
    if hook[36:44] != bytes.fromhex("13fc000000a15126"):
        findings.append("mode_not_zero")
    if hook[82:100] != bytes.fromhex(
        "4eb90000b6da4eb90000b6844ef900884d6a"
    ):
        findings.append("original_calls_or_tail")
    # The interval [48,82) is the physically preserved mode-1/relay code.
    # The two local branch targets are 82 and the mode-0 stub exits the hook;
    # no accepted edge may enter that interval.
    if any(HOOK_OFFSET + 48 <= target < HOOK_OFFSET + 82 for target in branch_targets.values()):
        findings.append("relay_reachable")
    return findings


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def slice_hex(image: bytes, offset: int, size: int) -> str:
    return image[offset : offset + size].hex()


def write_manifest(path: Path, payload: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary_path: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            "w",
            encoding="utf-8",
            dir=path.parent,
            prefix=f".{path.name}.",
            delete=False,
        ) as stream:
            temporary_path = Path(stream.name)
            json.dump(payload, stream, indent=2, sort_keys=True)
            stream.write("\n")
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temporary_path, path)
    finally:
        if temporary_path is not None and temporary_path.exists():
            temporary_path.unlink()


def verify_pair(active_path: Path, control_path: Path, default_path: Path) -> dict[str, object]:
    active = active_path.read_bytes()
    control = control_path.read_bytes()
    default = default_path.read_bytes()
    findings: list[str] = []

    images = {"active": active, "control": control, "default_reference": default}
    expected_hashes = {
        "active": EXPECTED_ACTIVE_SHA256,
        "control": EXPECTED_CONTROL_SHA256,
        "default_reference": EXPECTED_DEFAULT_SHA256,
    }
    hashes = {name: sha256_bytes(image) for name, image in images.items()}
    for name, image in images.items():
        if len(image) != EXPECTED_ROM_SIZE:
            findings.append(f"{name}_size:{len(image)}")
        if hashes[name] != expected_hashes[name]:
            findings.append(f"{name}_sha256:{hashes[name]}")

    expected_hook_bodies = {
        "active": ACTIVE_HOOK_BYTES,
        "control": CONTROL_HOOK_BYTES,
        "default_reference": DEFAULT_HOOK_BYTES,
    }
    for name, image in images.items():
        if image[HOOK_SITE_OFFSET : HOOK_SITE_OFFSET + len(HOOK_SITE_BYTES)] != HOOK_SITE_BYTES:
            findings.append(f"{name}_hook_site")
        expected = expected_hook_bodies[name]
        if image[HOOK_OFFSET : HOOK_OFFSET + len(expected)] != expected:
            findings.append(f"{name}_complete_hook_body")
    for finding in verify_hook_control_flow(active, active=True):
        findings.append(f"active_flow_{finding}")
    for finding in verify_hook_control_flow(control, active=False):
        findings.append(f"control_flow_{finding}")

    if active[TRANSFER_CALL_OFFSET : TRANSFER_CALL_OFFSET + 6] != ACTIVE_TRANSFER_CALL:
        findings.append("active_transfer_call")
    if control[TRANSFER_CALL_OFFSET : TRANSFER_CALL_OFFSET + 6] != CONTROL_TRANSFER_CALL:
        findings.append("control_transfer_nops")

    pair_differences = [
        offset for offset, (left, right) in enumerate(zip(active, control, strict=True))
        if left != right
    ]
    transfer_region = range(TRANSFER_CALL_OFFSET, TRANSFER_CALL_OFFSET + 6)
    if any(offset not in transfer_region for offset in pair_differences):
        findings.append("pair_difference_outside_transfer_slot")
    if active[:TRANSFER_CALL_OFFSET] != control[:TRANSFER_CALL_OFFSET]:
        findings.append("pair_prefix")
    if active[TRANSFER_CALL_OFFSET + 6 :] != control[TRANSFER_CALL_OFFSET + 6 :]:
        findings.append("pair_suffix")

    hook_end = HOOK_OFFSET + len(ACTIVE_HOOK_BYTES)
    if active[:HOOK_OFFSET] != default[:HOOK_OFFSET] or active[hook_end:] != default[hook_end:]:
        findings.append("active_difference_outside_hook")
    if control[:HOOK_OFFSET] != default[:HOOK_OFFSET] or control[hook_end:] != default[hook_end:]:
        findings.append("control_difference_outside_hook")

    static_regions = {
        "entity_stage": (ENTITY_STAGE_OFFSET, ENTITY_STAGE_BYTES),
        "globals_stage": (GLOBALS_STAGE_OFFSET, GLOBALS_STAGE_BYTES),
        "entity_transfer": (ENTITY_TRANSFER_OFFSET, ENTITY_TRANSFER_BYTES),
        "master_cmd3e_jump": (MASTER_CMD3E_JUMP_OFFSET, MASTER_CMD3E_JUMP_BYTES),
        "cmd3e_handler": (CMD3E_HANDLER_OFFSET, CMD3E_HANDLER_BYTES),
    }
    static_evidence: dict[str, object] = {}
    for region_name, (offset, expected) in static_regions.items():
        for image_name, image in images.items():
            if image[offset : offset + len(expected)] != expected:
                findings.append(f"{image_name}_{region_name}")
        static_evidence[region_name] = {
            "offset": f"0x{offset:X}",
            "size": len(expected),
            "sha256": sha256_bytes(expected),
        }

    return {
        "schema": SCHEMA,
        "eligible": not findings,
        "findings": findings,
        "active_path": str(active_path),
        "control_path": str(control_path),
        "default_reference_path": str(default_path),
        "active_sha256": hashes["active"],
        "control_sha256": hashes["control"],
        "default_reference_sha256": hashes["default_reference"],
        "rom_size": len(active),
        "pair_delta": {
            "offset": f"0x{TRANSFER_CALL_OFFSET:X}",
            "size": 6,
            "active_bytes": slice_hex(active, TRANSFER_CALL_OFFSET, 6),
            "control_bytes": slice_hex(control, TRANSFER_CALL_OFFSET, 6),
            "different_byte_offsets": [f"0x{offset:X}" for offset in pair_differences],
        },
        "hook_site": {
            "offset": f"0x{HOOK_SITE_OFFSET:X}",
            "bytes": HOOK_SITE_BYTES.hex(),
        },
        "complete_hook": {
            "offset": f"0x{HOOK_OFFSET:X}",
            "size": len(ACTIVE_HOOK_BYTES),
            "active_sha256": sha256_bytes(ACTIVE_HOOK_BYTES),
            "control_sha256": sha256_bytes(CONTROL_HOOK_BYTES),
            "default_reference_sha256": sha256_bytes(DEFAULT_HOOK_BYTES),
            "first_or_subsequent_target": "0x1C902",
            "mode0_stub": "0x1C8D4",
            "relay_unreachable_range": "0x1C8E0-0x1C901",
            "machine_checked_edges": {
                "flag_already_set": "0x1C8B6->0x1C902",
                "first_hook_after_flag": "0x1C8D2->0x1C902",
                "active_call": "0x1C8C4->0x1C8D4->0x1C6FE",
                "control_slot": "0x1C8C4-0x1C8C9 NOP",
            },
        },
        "static_evidence": static_evidence,
        "semantics": {
            "entity_stage": "$FF9000->$FF6A00:0x100",
            "globals_stage": "$FF6B00:0x40",
            "fifo_source": "$FF6A00:0x140",
            "command": "$3E",
            "master_jump_target": "$023016B0",
            "mode": 0,
            "sar0": "$20004012",
            "dar0": "$0600F20C",
            "tcr0": "$000000A0",
            "chcr0": "$000044E5",
            "sentinel": "$2600FC00",
        },
    }


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Verify exact VR60 mode-0 ACTIVE/STAGE-CONTROL ROM semantics."
    )
    parser.add_argument("--active", required=True, type=Path)
    parser.add_argument("--control", required=True, type=Path)
    parser.add_argument("--default-reference", required=True, type=Path)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    try:
        payload = verify_pair(args.active, args.control, args.default_reference)
        write_manifest(args.manifest, payload)
    except (OSError, ValueError) as error:
        print(f"FAIL [mode0_rom_pair] {error}")
        return 1
    verdict = "PASS" if payload["eligible"] else "FAIL"
    print(f"{verdict} [mode0_rom_pair]")
    for finding in payload["findings"]:
        print(f"  finding={finding}")
    print(f"  active_sha256={payload['active_sha256']}")
    print(f"  control_sha256={payload['control_sha256']}")
    print(f"  default_reference_sha256={payload['default_reference_sha256']}")
    print(f"  manifest={args.manifest}")
    return 0 if payload["eligible"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
