#!/usr/bin/env python3
"""Fail-closed static verifier for the Q-028 family-all A/B/C triplets."""

from __future__ import annotations

import argparse
import hashlib
import json
import struct
from pathlib import Path


SCHEMA = "vrd-vr60-q028-renderer-descriptor-probe-roms-v1"
ROM_SIZE = 0x3F0000
DEFAULT_SHA256 = "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900"
APPROVED_PROPOSAL_SHA256 = "2e06bd11cf86a54e172ed754e0252311f1286ee5592e9eaa1961ddccdc561ba6"
APPROVED_CAPTURE_DELTA_SHA256 = "ee83dbb39b5277a340db5208357cff8e1e5f3bff7f0b9e02d4f5dfe76921824a"

Q028_HASHES = {
    "family_a_active": "864279c45ef98a3402e8a974452d5b00e422580d46b10f12295aefdf18ca4ab9",
    "family_a_control": "4b9ec3de4d3daba011bed3cf33cccbd401d8f56a972be299ad327c94cddc98b7",
    "family_b_active": "658348fc47be50525766312114bef835dea636765ce8b7e5a34fa0d802c9123b",
    "family_b_control": "53da1a380aed2d27ee0be283fefdcf71c617f72e0d8536b3dfe716fac3d68c98",
    "family_c_active": "01bd49c96b00fa1fb7ef5840e9656578bba2adbe62f7ffd3e15d03e3341778e7",
    "family_c_control": "cabd40d2c177dcb55106d46ce1682d8c4f67f7e4dd52fd97045a15a39fc94eff",
}
WRAPPER_HASHES = {
    "family_a_active": "30309913961329e470ec5ee92b37357f199f44a3dce4425560d126470931b65a",
    "family_a_control": "a052d216f1791407d2fa8bd1ffa93aa666d8772555b97a26d7d4353e0cd74cba",
    "family_b_active": "2141d21b3ada43fac8aabe18253cea6bb2dfeb789a9dcfaea920d14a5a62cebd",
    "family_b_control": "0b7d9312c9bb0d4550e28571714513e53f0a5c4846d88c35a38b1f1eab866d61",
    "family_c_active": "406b9969ee36788636ab3ac7d14e604bba05a8769d38982d8b5c00d170e9b7c7",
    "family_c_control": "810ace847d657db56c7120ed6302e72f163efd827ace76dd872703a560249dd0",
}
PRIOR_HASHES = {
    "vr_rebuild.32x": DEFAULT_SHA256,
    "vr60_mode1_active.32x": "963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470",
    "vr60_mode1_stage_control.32x": "391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd",
    "vr60_mode2_active.32x": "96d79e3fb4d2df8a69852917ac811f860935ae950fc87222d008fa45d47ee276",
    "vr60_mode2_stage_control.32x": "da5ce4ec9ef8e050c7babeb113e26aa7335a3ff5285285e55a6606d2f96309b8",
    "vr60_q023_mailbox_active.32x": "8709aed4fc16d548b06694a92361a240537fbae7f987ee5f00a62c3c995a59ef",
    "vr60_q023_mailbox_stage_control.32x": DEFAULT_SHA256,
    "vr60_q026_player_active.32x": "c9358ad4ff04d7420c7bef1f45c163afb4506efae4990c4b48a475188e0b76f8",
    "vr60_q026_player_stage_control.32x": "240dfd0a8df87a8118982849f354bc720b0011d480221f2031e3ceeb6dc1a66d",
    "vr60_q027_cmd3f_active.32x": "50c20e1a82ff8f1f6df49a86dfc51bdef8b2b435f365a16cab3dec0bf7834097",
    "vr60_q027_cmd3f_stage_control.32x": "33bfdd8c0e4b44187f25b40bfb540e4d7aebcb5dda55cbebf51c7e674834e511",
}

CODE_START, CODE_END = 0x02BBC0, 0x02BCE8
GUARD_START, GUARD_END = 0x02BCE8, 0x02BCEE
STOCK_LITERAL = 0x021080
PAIR_EDGE = 0x02BC3A
FIXED_WORDS = {
    0x02BC0A: 0x6011, 0x02BC12: 0x6021,
    0x02BC18: 0x6011, 0x02BC1E: 0x6021,
    0x02BC32: 0x6011, 0x02BC3E: 0x2121,
    0x02BC40: 0x6011, 0x02BC64: 0x2E01,
    0x02BC66: 0x61E1,
}
EXPECTED_LITERAL_USERS = ((0x020FEE, 0x021080),
                          (0x020FF8, 0x021080),
                          (0x021010, 0x021080))
ZERO_RUNS = (
    (0x28C10, 0x28C64, 85), (0x28C91, 0x28CFD, 109),
    (0x28D3A, 0x28D8B, 82), (0x28DAC, 0x28DF5, 74),
    (0x29394, 0x293E8, 85), (0x29415, 0x29481, 109),
    (0x294BE, 0x2950F, 82), (0x29530, 0x29579, 74),
    (0x29B18, 0x29B6C, 85), (0x29B99, 0x29C05, 109),
    (0x29C42, 0x29C93, 82), (0x29CB4, 0x29CFD, 74),
    (0x29D54, 0x29DEB, 152), (0x2A15C, 0x2A1EB, 144),
    (0x2A55C, 0x2A5EB, 144), (0x2A95C, 0x2A9EB, 144),
    (0x2AD5C, 0x2ADEE, 147), (0x2AE99, 0x2B0EE, 598),
    (0x2B118, 0x2B305, 494), (0x2B342, 0x2B3AE, 109),
    (0x2B3D8, 0x2B413, 60), (0x2B434, 0x2B4BE, 139),
    (0x2B4D9, 0x2B56D, 149), (0x2BA5A, 0x2BCED, 660),
    (0x2BD59, 0x2BDED, 149),
)

FAMILIES = {
    "a": {"count": 4, "calls": 1, "desc": 0x0600C128,
          "state": 0x0600CA60, "pr": 0x06000FF4, "sp": 0x0600FFFC,
          "stack": 44},
    "b": {"count": 8, "calls": 1, "desc": 0x0600C178,
          "state": 0x0600CB20, "pr": 0x06000FFE, "sp": 0x0600FFFC,
          "stack": 60},
    "c": {"count": 3, "calls": 7, "desc": 0x0600C254,
          "state": 0x0600CD30, "pr": 0x06001016, "sp": 0x0600FFF8,
          "stack": 40},
}


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def require(condition: bool, label: str) -> None:
    if not condition:
        raise ValueError(label)


def diffs(left: bytes, right: bytes) -> list[int]:
    require(len(left) == len(right), "ROM size mismatch")
    return [i for i, (a, b) in enumerate(zip(left, right, strict=True)) if a != b]


def zero_runs(image: bytes, start: int, end: int) -> tuple[tuple[int, int, int], ...]:
    found: list[tuple[int, int, int]] = []
    run: int | None = None
    for offset in range(start, end):
        if image[offset] == 0 and run is None:
            run = offset
        elif image[offset] != 0 and run is not None:
            if offset - run >= 32:
                found.append((run, offset - 1, offset - run))
            run = None
    if run is not None and end - run >= 32:
        found.append((run, end - 1, end - run))
    return tuple(found)


def movl_pc_users(image: bytes, target_start: int, target_end: int) -> tuple[tuple[int, int], ...]:
    users: list[tuple[int, int]] = []
    for offset in range(0, len(image) - 1, 2):
        opcode = int.from_bytes(image[offset:offset + 2], "big")
        if opcode >> 12 != 0xD:
            continue
        pc = 0x02000000 + offset
        target = ((pc + 4) & ~3) + (opcode & 0xFF) * 4 - 0x02000000
        if target_start <= target < target_end:
            users.append((offset, target))
    return tuple(users)


def elf_symbol(image: bytes, name: str) -> int | None:
    require(image[:4] == b"\x7fELF" and image[4] == 1 and image[5] in (1, 2),
            "ELF format")
    endian = "<" if image[5] == 1 else ">"
    shoff = struct.unpack_from(endian + "I", image, 32)[0]
    entsize, count = struct.unpack_from(endian + "HH", image, 46)
    sections = [struct.unpack_from(endian + "IIIIIIIIII", image,
                                  shoff + i * entsize) for i in range(count)]
    for section in sections:
        if section[1] != 2 or not section[9] or section[6] >= len(sections):
            continue
        strings = sections[section[6]]
        names = image[strings[4]:strings[4] + strings[5]]
        for off in range(section[4], section[4] + section[5], section[9]):
            name_off, value = struct.unpack_from(endian + "II", image, off)
            end = names.find(b"\0", name_off)
            if end >= 0 and names[name_off:end].decode(errors="replace") == name:
                return value
    return None


def pointer_occurrences(image: bytes) -> dict[str, object]:
    ranges = {
        "m68k_rom": (0x008ABBC0, 0x008ABCE7),
        "sh2_rom": (0x0202BBC0, 0x0202BCE7),
        "sh2_rom_ct": (0x2202BBC0, 0x2202BCE7),
        "sdram": (0x0600BBC0, 0x0600BCE7),
        "sdram_ct": (0x2600BBC0, 0x2600BCE7),
    }
    result: dict[str, object] = {}
    all_hits: list[tuple[int, int, str]] = []
    for offset in range(len(image) - 3):
        value = int.from_bytes(image[offset:offset + 4], "big")
        for label, (low, high) in ranges.items():
            if low <= value <= high:
                all_hits.append((offset, value, label))
    result["all"] = all_hits
    result["aligned2"] = [hit for hit in all_hits if hit[0] % 2 == 0]
    result["aligned4"] = [hit for hit in all_hits if hit[0] % 4 == 0]
    return result


def source_policy(repo: Path) -> None:
    vrd = (repo / "disasm/vrd.asm").read_text()
    section = (repo / "disasm/sections/code_2a200.asm").read_text()
    callsites = (repo / "disasm/sections/code_20200.asm").read_text()
    source = (repo / "disasm/sh2/validation/q028_renderer_bridge_probe.s").read_text()
    make = (repo / "Makefile").read_text()
    for fragment in (
        "Q-028 and Q-020 CMDINT probe are mutually exclusive",
        "Q-028 and mode-1 validation are mutually exclusive",
        "Q-028 and mode-2 validation are mutually exclusive",
        "Q-028 and Q-023 mailbox validation are mutually exclusive",
        "Q-028 and Q-026 validation are mutually exclusive",
        "Q-028 and Q-027 validation are mutually exclusive",
    ):
        require(fragment in vrd, "mutual exclusion: " + fragment)
    require(callsites.count("dc.w    $BBC0") == 1 and
            callsites.count("dc.w    $24DC") >= 1, "stock literal condition")
    require(section.count("q028_family_") == 6 and "rept    148" in section,
            "source interval selection")
    for fragment in ("Q028_INDEX=-1", "-Ttext=0x0600BBC0",
                     "Q-028 wrapper must end at file $02BCE8"):
        require(fragment in make or fragment in section, "build policy: " + fragment)
    for fragment in ("0x20004006", "0x20004010", "0x20000000",
                     "0xdfffffff", "0x060024dc"):
        require(fragment in source, "wrapper literal: " + fragment)
    for forbidden in ("0x20004020", "0x20004022", "0x20004024",
                      "0x20004026", "0x20004028", "0x2000402a",
                      "0x2000402c", "0x2000402e", "0x02303a10",
                      "0x0600c218", "0x0600ca00", "0x0600cca0"):
        require(forbidden not in source.lower(), "forbidden wrapper owner: " + forbidden)
    for sr_opcode in ("ldc", "stc sr", "ldc.l", "stc.l sr"):
        require(sr_opcode not in source.lower(), "SR load/store forbidden")


def verify(repo: Path) -> dict[str, object]:
    build = repo / "build"
    default = (build / "vr_rebuild.32x").read_bytes()
    require(len(default) == ROM_SIZE and sha256(default) == DEFAULT_SHA256,
            "accepted default identity")
    for name, expected in PRIOR_HASHES.items():
        data = (build / name).read_bytes()
        require(len(data) == ROM_SIZE and sha256(data) == expected,
                "prior identity: " + name)

    require(default[0x3D4:0x3D8] == bytes.fromhex("00020000") and
            default[0x3D8:0x3DC] == bytes.fromhex("00000000") and
            default[0x3DC:0x3E0] == bytes.fromhex("0000c000"), "IDL header")
    require(default[CODE_START:CODE_END] == bytes(296), "ordinary code zeros")
    require(default[GUARD_START:GUARD_END] == bytes(6), "guard zeros")
    require(default[0x02BCEE:0x02BCF0] == bytes.fromhex("0101"), "guard terminator")
    require(zero_runs(default, 0x020000, 0x02C000) == ZERO_RUNS,
            "complete zero-run enumeration")
    # There must be no >=32-byte FF run in the boot source.
    probe = default[0x020000:0x02C000]
    ff_run = 0
    for byte in probe:
        ff_run = ff_run + 1 if byte == 0xFF else 0
        require(ff_run < 32, "unexpected FF run")

    ptrs = pointer_occurrences(default)
    require(ptrs["aligned2"] == [] and ptrs["aligned4"] == [],
            "aligned pre-existing interval owner")
    require(ptrs["all"] == [(0x2018A5, 0x0202BC35, "sh2_rom")],
            "unaligned interval pattern classification")

    source_policy(repo)
    require(movl_pc_users(default, STOCK_LITERAL, STOCK_LITERAL + 4) ==
            EXPECTED_LITERAL_USERS, "stock literal users")

    manifest_families: dict[str, object] = {}
    for family, geometry in FAMILIES.items():
        baseline = (build / f"vr60_q028_family_{family}_baseline.32x").read_bytes()
        control = (build / f"vr60_q028_family_{family}_control.32x").read_bytes()
        active = (build / f"vr60_q028_family_{family}_active.32x").read_bytes()
        require(baseline == default and sha256(baseline) == DEFAULT_SHA256,
                f"family {family} baseline identity")
        for arm, image in (("control", control), ("active", active)):
            label = f"family_{family}_{arm}"
            require(len(image) == ROM_SIZE and sha256(image) == Q028_HASHES[label],
                    label + " identity")
            wrapper = (build / "sh2" / f"q028_family_{family}_{arm}.bin").read_bytes()
            elf = (build / "sh2" / f"q028_family_{family}_{arm}.elf").read_bytes()
            require(len(wrapper) == 296 and sha256(wrapper) == WRAPPER_HASHES[label],
                    label + " wrapper identity")
            require(image[CODE_START:CODE_END] == wrapper,
                    label + " ROM wrapper copy")
            require(elf_symbol(elf, "q028_probe") == 0x0600BBC0 and
                    elf_symbol(elf, "q028_probe_end") == 0x0600BCE8,
                    label + " linked symbols")
            require(image[GUARD_START:GUARD_END] == bytes(6) and
                    image[0x02BCEE:0x02BCF0] == bytes.fromhex("0101"),
                    label + " guard")
            require(image[STOCK_LITERAL:STOCK_LITERAL + 4] ==
                    bytes.fromhex("0600bbc0"), label + " stock target")
            require(movl_pc_users(image, STOCK_LITERAL, STOCK_LITERAL + 4) ==
                    EXPECTED_LITERAL_USERS, label + " literal users")
            expected_ranges = (set(range(STOCK_LITERAL + 2, STOCK_LITERAL + 4)) |
                               {CODE_START + i for i, byte in enumerate(wrapper)
                                if byte != 0})
            require(set(diffs(image, default)) == expected_ranges,
                    label + " sole validation ranges")
            for offset, word in FIXED_WORDS.items():
                require(int.from_bytes(image[offset:offset + 2], "big") == word,
                        f"{label} fixed PC {offset:06x}")
            require(image[0x0303A10:0x0303B00] == default[0x0303A10:0x0303B00],
                    label + " expansion unchanged")
        require(diffs(control, active) == [PAIR_EDGE, PAIR_EDGE + 1],
                f"family {family} sole pair edge")
        require(control[PAIR_EDGE:PAIR_EDGE + 2] == bytes.fromhex("6203") and
                active[PAIR_EDGE:PAIR_EDGE + 2] == bytes.fromhex("222a") and
                control[0x02BC3E:0x02BC40] == active[0x02BC3E:0x02BC40] ==
                bytes.fromhex("2121"), f"family {family} selector/store")
        manifest_families[family] = {
            **geometry,
            "baseline": DEFAULT_SHA256,
            "control": Q028_HASHES[f"family_{family}_control"],
            "active": Q028_HASHES[f"family_{family}_active"],
            "wrapper_control": WRAPPER_HASHES[f"family_{family}_control"],
            "wrapper_active": WRAPPER_HASHES[f"family_{family}_active"],
        }

    c_desc = [0x0600C254 + group * 0x78 + item * 0x14
              for group in range(7) for item in range(3)]
    c_state = [0x0600CD30 + group * 0x120 + item * 0x30
               for group in range(7) for item in range(3)]
    require(c_desc[-1] == 0x0600C54C and c_state[-1] == 0x0600D450,
            "sparse C geometry")
    return {
        "schema": SCHEMA,
        "approved_proposal_sha256": APPROVED_PROPOSAL_SHA256,
        "approved_capture_delta_sha256": APPROVED_CAPTURE_DELTA_SHA256,
        "status": "STATIC_PASS_RUNTIME_REQUIRED",
        "eligible": False,
        "promotable": False,
        "authority_transferred": False,
        "bridge_enabled": False,
        "cadence_changed": False,
        "fps_claim": None,
        "ordinary_identity": DEFAULT_SHA256,
        "allocations": {
            "rom_source": "file 0x02BBC0-0x02BCE7 / m68k 0x008ABBC0-0x008ABCE7 / sh2 0x0202BBC0-0x0202BCE7 / ct 0x2202BBC0-0x2202BCE7",
            "runtime": "0x0600BBC0-0x0600BCE7 / ct 0x2600BBC0-0x2600BCE7",
            "bytes": 296,
        },
        "idl": {"source": "0x00020000", "destination": "0x00000000",
                "bytes": 0xC000, "q028_longword_pairs": 74,
                "external_master_bios": False},
        "ownership": {"direct_aligned_owners": 0,
                      "constructed_owners": 0,
                      "classified_unaligned_pattern": "file 0x2018A5 = 0x0202BC35",
                      "runtime_all_access_proof_required": True},
        "fixed_pcs": {f"0x{offset + 0x05FE0000:08X}": f"0x{word:04X}"
                      for offset, word in FIXED_WORDS.items()},
        "call_order": ["A", "B", "Cg0", "Cg1", "Cg2", "Cg3", "Cg4", "Cg5", "Cg6"],
        "wrapper_entries": 9,
        "stock_entries": 9,
        "families": manifest_families,
        "c_descriptor_map": [f"0x{x:08X}" for x in c_desc],
        "c_state_map": [f"0x{x:08X}" for x in c_state],
        "runtime_required": {
            "fetch_complete": True,
            "cpu_data_complete": True,
            "dma_dreq_bridge_complete": True,
            "repeats_per_arm": 2,
            "interpreter": True,
            "normal_drc": True,
        },
        "claims_excluded": ["bridge", "cmd3f", "shared_lane", "authority",
                            "collision", "cadence", "cpu_budget", "fps",
                            "real_hardware", "host_presentation"],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-root", type=Path,
                        default=Path(__file__).resolve().parents[2])
    parser.add_argument("--manifest", type=Path, required=True)
    args = parser.parse_args()
    try:
        payload = verify(args.repo_root.resolve())
        args.manifest.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    except (OSError, ValueError, struct.error) as error:
        print(f"Q-028 static verification FAILED: {error}")
        return 1
    print("Q-028 static verification PASS: family-all A/B/C triplets; runtime required")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
