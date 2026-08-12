#!/usr/bin/env python3
"""Fail-closed verifier for the isolated Q-023 cmd-$3F mailbox pair."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import tempfile
from collections.abc import Sequence
from pathlib import Path


SCHEMA = "vrd-vr60-q023-mailbox-pair-v1"
EXPECTED_SIZE = 0x3F0000
HANDLER_OFFSET = 0x301500
HANDLER_SIZE = 428
HANDLER_END = HANDLER_OFFSET + HANDLER_SIZE
LOAD_RELATIVE_OFFSET = 0x12
LOAD_OFFSET = HANDLER_OFFSET + LOAD_RELATIVE_OFFSET
LOAD_OPCODE = bytes.fromhex("D449")
LITERAL_RELATIVE_OFFSET = 0x138
LITERAL_OFFSET = HANDLER_OFFSET + LITERAL_RELATIVE_OFFSET
LEGACY_LITERAL = bytes.fromhex("2200BC00")
CORRECTED_LITERAL = bytes.fromhex("2600BC00")
EXPECTED_ROM_DIFFERENCES = [LITERAL_OFFSET]
EXPECTED_HANDLER_DIFFERENCES = [LITERAL_RELATIVE_OFFSET]
CMD3F_JUMP_OFFSET = 0x02087C
CMD3F_JUMP = bytes.fromhex("02301500")

EXPECTED_ACTIVE_SHA256 = "8709aed4fc16d548b06694a92361a240537fbae7f987ee5f00a62c3c995a59ef"
EXPECTED_DEFAULT_SHA256 = "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900"
EXPECTED_CONTROL_SHA256 = EXPECTED_DEFAULT_SHA256
EXPECTED_MODE1_ACTIVE_SHA256 = "963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470"
EXPECTED_MODE1_CONTROL_SHA256 = "391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd"
EXPECTED_MODE1_ISR_SHA256 = "6316a0d228dc3db8a48ecdef3b34e0962e04db35c4ef085ec17aea8873146916"
EXPECTED_MODE2_ACTIVE_SHA256 = "96d79e3fb4d2df8a69852917ac811f860935ae950fc87222d008fa45d47ee276"
EXPECTED_MODE2_CONTROL_SHA256 = "da5ce4ec9ef8e050c7babeb113e26aa7335a3ff5285285e55a6606d2f96309b8"
EXPECTED_MODE2_ISR_SHA256 = "b7fc5726dd503f35f08625a6159bed2cff06720ea85a89848bc2e70e64eaaaa7"
EXPECTED_LEGACY_HANDLER_SHA256 = "1927dd8fb011634913888e9d250abbb202a530e22ccf059e53cb28570e9a69e5"
EXPECTED_CORRECTED_HANDLER_SHA256 = "ec64257c82b599508b428b515e22d3090a24894964c046b7d636ef87b6b2c163"


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def differing_offsets(left: bytes, right: bytes) -> list[int]:
    if len(left) != len(right):
        return [min(len(left), len(right))]
    return [
        offset
        for offset, (lhs, rhs) in enumerate(zip(left, right, strict=True))
        if lhs != rhs
    ]


def literal_users(handler: bytes, target: int) -> list[dict[str, int]]:
    """Return every executable MOV.L @(disp,PC),Rn resolving to target."""
    users: list[dict[str, int]] = []
    for pc in range(0, target, 2):
        opcode = int.from_bytes(handler[pc : pc + 2], "big")
        if opcode & 0xF000 != 0xD000:
            continue
        resolved = ((pc + 4) & ~3) + (opcode & 0xFF) * 4
        if resolved == target:
            users.append(
                {
                    "pc": pc,
                    "opcode": opcode,
                    "register": (opcode >> 8) & 0xF,
                    "target": resolved,
                }
            )
    return users


def uncommented_assembly(source: str) -> str:
    return "\n".join(
        line for line in source.splitlines() if not line.lstrip().startswith(";")
    )


def source_policy_errors(repo_root: Path) -> list[str]:
    errors: list[str] = []
    handler = (
        repo_root / "disasm/sh2/expansion/cmd3f_vr60_gameframe.asm"
    ).read_text(encoding="utf-8")
    for fragment in (
        ".ifdef VR60_Q023_MAILBOX_CORRECTED",
        ".long   0x2600BC00",
        ".else\n    .long   0x2200BC00",
        ".endif",
    ):
        if fragment not in handler:
            errors.append(f"handler_source:{fragment}")

    expansion = (
        repo_root / "disasm/sections/expansion_300000.asm"
    ).read_text(encoding="utf-8")
    for fragment in (
        "ifd     VR60_Q023_MAILBOX_VALIDATION",
        "ifd     VR60_Q023_STAGE_CONTROL",
        'include "sh2/generated/cmd3f_vr60_gameframe_q023_corrected.inc"',
        'include "sh2/generated/cmd3f_vr60_gameframe.inc"',
    ):
        if fragment not in expansion:
            errors.append(f"expansion_source:{fragment}")

    vrd = (repo_root / "disasm/vrd.asm").read_text(encoding="utf-8")
    for fragment in (
        "VR60_Q023_STAGE_CONTROL requires VR60_Q023_MAILBOX_VALIDATION",
        "Q-023 and mode-1 validation are mutually exclusive",
        "Q-023 and mode-2 validation are mutually exclusive",
    ):
        if fragment not in vrd:
            errors.append(f"vrd_guard:{fragment}")

    hook_paths = (
        repo_root / "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm",
        repo_root / "disasm/modules/68k/game/scene/game_frame_orch_013.asm",
    )
    for path in hook_paths:
        source = path.read_text(encoding="utf-8")
        if "VR60_Q023" in source:
            errors.append(f"q023_flag_leaked_to_hook:{path.relative_to(repo_root)}")
    hook_code = uncommented_assembly(hook_paths[0].read_text(encoding="utf-8"))
    if "jsr     vr60_1p_comm_trigger" in hook_code:
        errors.append("cmd3f_trigger_enabled")

    makefile = (repo_root / "Makefile").read_text(encoding="utf-8")
    for fragment in (
        "-D VR60_MODE0_ONLY=1 -D VR60_Q023_MAILBOX_VALIDATION=1 -o $@",
        "-D VR60_Q023_STAGE_CONTROL=1 -o $@",
        "--defsym VR60_Q023_MAILBOX_CORRECTED=1",
    ):
        if fragment not in makefile:
            errors.append(f"make_policy:{fragment}")
    return errors


def verify_pair(
    active_path: Path,
    control_path: Path,
    default_path: Path,
    mode1_active_path: Path,
    mode1_control_path: Path,
    mode1_isr_path: Path,
    mode2_active_path: Path,
    mode2_control_path: Path,
    mode2_isr_path: Path,
    legacy_handler_path: Path,
    corrected_handler_path: Path,
    repo_root: Path,
) -> dict[str, object]:
    paths = {
        "active": active_path,
        "control": control_path,
        "default": default_path,
        "mode1_active": mode1_active_path,
        "mode1_control": mode1_control_path,
        "mode1_isr": mode1_isr_path,
        "mode2_active": mode2_active_path,
        "mode2_control": mode2_control_path,
        "mode2_isr": mode2_isr_path,
        "legacy_handler": legacy_handler_path,
        "corrected_handler": corrected_handler_path,
    }
    images = {name: path.read_bytes() for name, path in paths.items()}
    hashes = {name: sha256(image) for name, image in images.items()}
    expected_hashes = {
        "active": EXPECTED_ACTIVE_SHA256,
        "control": EXPECTED_CONTROL_SHA256,
        "default": EXPECTED_DEFAULT_SHA256,
        "mode1_active": EXPECTED_MODE1_ACTIVE_SHA256,
        "mode1_control": EXPECTED_MODE1_CONTROL_SHA256,
        "mode1_isr": EXPECTED_MODE1_ISR_SHA256,
        "mode2_active": EXPECTED_MODE2_ACTIVE_SHA256,
        "mode2_control": EXPECTED_MODE2_CONTROL_SHA256,
        "mode2_isr": EXPECTED_MODE2_ISR_SHA256,
        "legacy_handler": EXPECTED_LEGACY_HANDLER_SHA256,
        "corrected_handler": EXPECTED_CORRECTED_HANDLER_SHA256,
    }
    findings: list[str] = []
    for name, digest in hashes.items():
        if digest != expected_hashes[name]:
            findings.append(f"{name}_sha256:{digest}")

    for name in (
        "active",
        "control",
        "default",
        "mode1_active",
        "mode1_control",
        "mode2_active",
        "mode2_control",
    ):
        if len(images[name]) != EXPECTED_SIZE:
            findings.append(f"{name}_size:{len(images[name])}")
    for name in ("legacy_handler", "corrected_handler"):
        if len(images[name]) != HANDLER_SIZE:
            findings.append(f"{name}_size:{len(images[name])}")

    active = images["active"]
    control = images["control"]
    default = images["default"]
    legacy = images["legacy_handler"]
    corrected = images["corrected_handler"]
    rom_differences = differing_offsets(active, control)
    handler_differences = differing_offsets(corrected, legacy)
    if rom_differences != EXPECTED_ROM_DIFFERENCES:
        findings.append(
            "active_control_differences:"
            + ",".join(f"0x{offset:X}" for offset in rom_differences[:16])
        )
    if handler_differences != EXPECTED_HANDLER_DIFFERENCES:
        findings.append(
            "handler_differences:"
            + ",".join(f"0x{offset:X}" for offset in handler_differences[:16])
        )
    if control != default:
        findings.append("control_not_accepted_default")
    if active[HANDLER_OFFSET:HANDLER_END] != corrected:
        findings.append("active_handler_not_corrected_source")
    if control[HANDLER_OFFSET:HANDLER_END] != legacy:
        findings.append("control_handler_not_legacy_source")
    if default[HANDLER_OFFSET:HANDLER_END] != legacy:
        findings.append("default_handler_not_legacy_source")

    for name, image, literal in (
        ("active", active, CORRECTED_LITERAL),
        ("control", control, LEGACY_LITERAL),
        ("default", default, LEGACY_LITERAL),
    ):
        if image[LITERAL_OFFSET : LITERAL_OFFSET + 4] != literal:
            findings.append(f"{name}_mailbox_literal")
        if image[LOAD_OFFSET : LOAD_OFFSET + 2] != LOAD_OPCODE:
            findings.append(f"{name}_mailbox_load_opcode")
        if image[CMD3F_JUMP_OFFSET : CMD3F_JUMP_OFFSET + 4] != CMD3F_JUMP:
            findings.append(f"{name}_cmd3f_jump")

    for name, handler in (("legacy", legacy), ("corrected", corrected)):
        users = literal_users(handler, LITERAL_RELATIVE_OFFSET)
        expected_users = [
            {
                "pc": LOAD_RELATIVE_OFFSET,
                "opcode": int.from_bytes(LOAD_OPCODE, "big"),
                "register": 4,
                "target": LITERAL_RELATIVE_OFFSET,
            }
        ]
        if users != expected_users:
            findings.append(f"{name}_literal_users:{users}")

    findings.extend(source_policy_errors(repo_root))
    static_eligible = not findings
    return {
        "schema": SCHEMA,
        "static_eligible": static_eligible,
        "eligible": static_eligible,
        "promotable": False,
        "scope": "inactive_mailbox_literal_correction_only",
        "cmd3f_enabled": False,
        "runtime_evidence": "NOT_APPLICABLE_CMD3F_UNREACHABLE",
        "findings": findings,
        "paths": {name: str(path) for name, path in paths.items()},
        "sha256": hashes,
        "rom_size": len(active),
        "handler_size": len(corrected),
        "mailbox": {
            "native": "0x0600BC00",
            "cache_through": "0x2600BC00",
            "active_literal_offset": f"0x{LITERAL_OFFSET:06X}",
            "control_literal": "0x2200BC00",
            "active_literal": "0x2600BC00",
        },
        "active_control_differences": [
            f"0x{offset:06X}" for offset in rom_differences
        ],
        "handler_differences": [
            f"0x{offset:03X}" for offset in handler_differences
        ],
        "literal_users": literal_users(corrected, LITERAL_RELATIVE_OFFSET),
        "cmd3f_jump": "0x02301500",
        "accepted_identities_unchanged": all(
            hashes[name] == expected_hashes[name]
            for name in (
                "default",
                "mode1_active",
                "mode1_control",
                "mode1_isr",
                "mode2_active",
                "mode2_control",
                "mode2_isr",
            )
        ),
    }


def write_manifest(path: Path, payload: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            "w",
            encoding="utf-8",
            dir=path.parent,
            prefix=f".{path.name}.",
            delete=False,
        ) as stream:
            temporary = Path(stream.name)
            json.dump(payload, stream, indent=2, sort_keys=True)
            stream.write("\n")
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temporary, path)
    finally:
        if temporary is not None and temporary.exists():
            temporary.unlink()


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--active", required=True, type=Path)
    parser.add_argument("--control", required=True, type=Path)
    parser.add_argument("--default", required=True, type=Path)
    parser.add_argument("--mode1-active", required=True, type=Path)
    parser.add_argument("--mode1-control", required=True, type=Path)
    parser.add_argument("--mode1-isr", required=True, type=Path)
    parser.add_argument("--mode2-active", required=True, type=Path)
    parser.add_argument("--mode2-control", required=True, type=Path)
    parser.add_argument("--mode2-isr", required=True, type=Path)
    parser.add_argument("--legacy-handler", required=True, type=Path)
    parser.add_argument("--corrected-handler", required=True, type=Path)
    parser.add_argument("--repo-root", type=Path, default=Path("."))
    parser.add_argument("--manifest", required=True, type=Path)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    try:
        payload = verify_pair(
            args.active,
            args.control,
            args.default,
            args.mode1_active,
            args.mode1_control,
            args.mode1_isr,
            args.mode2_active,
            args.mode2_control,
            args.mode2_isr,
            args.legacy_handler,
            args.corrected_handler,
            args.repo_root.resolve(),
        )
        write_manifest(args.manifest, payload)
    except (OSError, ValueError) as error:
        print(f"FAIL [q023_mailbox_pair] {error}")
        return 1
    verdict = "PASS" if payload["static_eligible"] else "FAIL"
    print(f"{verdict} [q023_mailbox_pair]")
    for finding in payload["findings"]:
        print(f"  finding={finding}")
    for name, digest in payload["sha256"].items():
        print(f"  {name}_sha256={digest}")
    print(f"  manifest={args.manifest}")
    return 0 if payload["static_eligible"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
