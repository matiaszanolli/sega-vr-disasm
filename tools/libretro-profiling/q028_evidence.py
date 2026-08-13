#!/usr/bin/env python3
"""Fail-closed Q-028 v3-v7 contract, archive, and real-index tooling."""

from __future__ import annotations

import argparse
import gzip
import hashlib
import json
import os
import re
import stat
import subprocess
import tarfile
import zlib
from pathlib import Path, PurePosixPath
from typing import Iterable


STATUS = "BLOCKED / INCONCLUSIVE_ENGINE_SCHEDULE"
SCHEMA = "vrd-vr60-q028-contract-v7"
ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "analysis/evidence/vr60-q028-renderer-descriptor-probe"
CONTRACT_PATH = Path(__file__).with_name("q028_contract_v7.json")
DOCS = (
    ROOT / "VR60_STATUS.md",
    ROOT / "VR60_ROADMAP.md",
    ROOT / "analysis/agent-scratch/oracle/index.md",
    EVIDENCE / "README.md",
)
ARCHIVE_NAMES = (
    "q028-interpreter-v5.tar.gz",
    "q028-drc-v5.tar.gz",
    "q028-equivalence-v5.tar.gz",
    "q028-toolchain-v5.tar.gz",
)
ARCHIVE_ROOTS = ("interpreter", "drc", "equivalence", "toolchain")
PROPOSALS = {
    "v3": "2e06bd11cf86a54e172ed754e0252311f1286ee5592e9eaa1961ddccdc561ba6",
    "v4": "ee83dbb39b5277a340db5208357cff8e1e5f3bff7f0b9e02d4f5dfe76921824a",
    "v5": "a7b6017d9c73b586af778e8dcccc8dfe804c648b4549d40b75db8c70d8ea726e",
    "v6": "09c4f459789c37d358a8b9cb1955071f95866fc7adfa830d9272515225929cb1",
    "v7": "efb422fdd801e42299d81294731ebef04095352356076383ef799602df757372",
}
IDENTITIES = {
    "ordinary": "6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900",
    "A": ("4b9ec3de4d3daba011bed3cf33cccbd401d8f56a972be299ad327c94cddc98b7",
          "864279c45ef98a3402e8a974452d5b00e422580d46b10f12295aefdf18ca4ab9"),
    "B": ("53da1a380aed2d27ee0be283fefdcf71c617f72e0d8536b3dfe716fac3d68c98",
          "658348fc47be50525766312114bef835dea636765ce8b7e5a34fa0d802c9123b"),
    "C": ("cabd40d2c177dcb55106d46ce1682d8c4f67f7e4dd52fd97045a15a39fc94eff",
          "01bd49c96b00fa1fb7ef5840e9656578bba2adbe62f7ffd3e15d03e3341778e7"),
}
CATEGORIES = tuple([f"v3-{i}" for i in range(1, 15)] +
                   [f"v4-{i}" for i in range(1, 15)])
HEX64 = re.compile(r"[0-9a-f]{64}\Z")
RENDER_MEMBER = re.compile(
    r"(?:interpreter|drc)/([^/]+)/render-(1298|1299|1300|1301|1302|1303|1304|1305)-page-([01])\.bin\Z")


class Q028Error(RuntimeError):
    pass


def require(condition: bool, category: str, detail: str) -> None:
    if not condition:
        raise Q028Error(f"{category}: {detail}")


def canonical_json(value: object) -> bytes:
    return (json.dumps(value, sort_keys=True, separators=(",", ":")) + "\n").encode()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_canonical_json(path: Path, *, eligible: bool = True) -> object:
    raw = path.read_bytes()
    if eligible:
        require(b"/tmp" not in raw, "v4-14", f"eligible JSON names /tmp: {path}")
    value = json.loads(raw)
    require(raw == canonical_json(value), "v3-13", f"noncanonical JSON: {path}")
    return value


def valid_relative_path(value: str, roots: tuple[str, ...] | None = None) -> bool:
    if not value or "\\" in value or "\x00" in value or value.endswith("/"):
        return False
    path = PurePosixPath(value)
    if path.is_absolute() or any(part in ("", ".", "..") for part in path.parts):
        return False
    return roots is None or bool(path.parts and path.parts[0] in roots)


def package_order() -> list[dict[str, object]]:
    rows: list[dict[str, object]] = []
    for engine in ("INTERPRETER", "NORMAL_DRC"):
        for repeat in (1, 2):
            for family in "ABC":
                for arm in ("BASELINE", "CONTROL", "ACTIVE"):
                    rows.append({"id": f"{engine.lower()}-r{repeat}-{family}-{arm.lower()}",
                                 "engine": engine, "repeat": repeat, "family": family,
                                 "arm": arm, "capture": "on"})
    for engine in ("INTERPRETER", "NORMAL_DRC"):
        for repeat in (1, 2):
            rows.append({"id": f"{engine.lower()}-schedule-r{repeat}",
                         "engine": engine, "repeat": repeat, "family": "A",
                         "arm": "BASELINE", "capture": "off"})
    return rows


def validate_contract(contract: dict) -> None:
    require(contract.get("schema") == SCHEMA, "v3-13", "contract schema")
    require(contract.get("status") == STATUS, "v3-14", "status boundary")
    require(contract.get("proposals") == PROPOSALS, "v3-1", "proposal identities")
    identity = contract.get("identity", {})
    require(identity.get("ordinary") == IDENTITIES["ordinary"], "v3-1", "ordinary identity")
    for family in "ABC":
        row = identity.get("q028", {}).get(family, {})
        require(row.get("baseline") == IDENTITIES["ordinary"], "v3-1", f"{family} baseline")
        require((row.get("control"), row.get("active")) == IDENTITIES[family],
                "v3-1", f"{family} pair")
    require(contract.get("fixture") == {
        "bytes": 14981, "frames": 1340,
        "sha256": "2df0ffe53cad0c7d7a5d70c1819051685905a60ff96727a6256e6a300116fbbf"},
        "v4-5", "fixture/window identity")
    probe = contract.get("probe", {})
    require(probe.get("rom_start") == "0x02BBC0" and probe.get("rom_end") == "0x02BCE7",
            "v3-3", "candidate ROM interval")
    require(probe.get("runtime_start") == "0x0600BBC0" and
            probe.get("runtime_end") == "0x0600BCE7" and probe.get("size") == 296,
            "v3-2", "boot alias/IDL interval")
    require(probe.get("stock_target") == "0x060024DC", "v3-5", "stock target")
    require(probe.get("control_active_delta_file") == "0x02BC3A" and
            probe.get("control_opcode") == "0x6203" and
            probe.get("active_opcode") == "0x222A", "v3-6", "wrapper layout/opcode")
    require(probe.get("call_order") ==
            ["A", "B", "Cg0", "Cg1", "Cg2", "Cg3", "Cg4", "Cg5", "Cg6"],
            "v3-8", "call tuple order")
    owner = contract.get("owner", {})
    require(owner.get("domain_schema") == "vrd-vr60-q028-owner-domain-v6" and
            owner.get("report_schema") == "vrd-vr60-q028-constructed-owner-report-v6" and
            owner.get("forbid_constructed_owners_field") is True,
            "v3-4", "owner domain/report policy")
    campaign = contract.get("campaign", {})
    require(campaign.get("engines") == ["INTERPRETER", "NORMAL_DRC"], "v3-13", "engine order")
    require(campaign.get("families") == ["A", "B", "C"], "v3-7", "family geometry")
    require(campaign.get("frames") == list(range(1298, 1306)), "v4-5", "fixed window")
    require(campaign.get("capture_on_packages") == 36, "v3-13", "capture-on count")
    require(campaign.get("capture_off_packages") == 4, "v4-12", "capture-off count")
    require(campaign.get("package_count") == 40, "v4-11", "package count")
    require(campaign.get("render_page_count") == 640 and
            campaign.get("render_page_bytes") == 131072, "v4-9", "render-page count/size")
    require(campaign.get("capture_on_binary_bytes") == 9076736, "v3-13", "capture-on floor")
    require(campaign.get("capture_off_binary_bytes") == 7929856, "v4-12", "capture-off floor")
    require(campaign.get("required_binary_bytes") == 358481920, "v3-13", "campaign floor")
    display = contract.get("display", {})
    require(display.get("pixel_format") == "RGB565", "v4-1", "pixel format")
    require(display.get("callback_cardinality") == "one-render-one-callback", "v4-2", "callback bijection")
    require(display.get("rgb_bytes") == 143360 and
            display.get("geometry") == [320, 224, 640], "v4-3", "callback geometry")
    require(display.get("authority") == "render_fs_at_direct_dram_selector", "v4-4", "callback authority")
    require(display.get("uniform_frames_forbidden") is True, "v4-6", "uniform callback policy")
    headers = {
        "render_header": "render_ordinal,frame,retro_run,event_order,fbctl,render_fs,offs,lines,sync_line,draw_mode,skip_frame,page_bytes,page0_path,page1_path",
        "post_frame_header": "frame,retro_run,event_order,fbctl,post_frame_fs,fen,page_bytes,page0_path,page1_path",
        "preapply_header": "preapply_ordinal,frame,retro_run,event_order,site,old_fbctl,old_fs,new_fs,fen,page_bytes,page0_path,page1_path",
        "callback_header": "callback_ordinal,frame,retro_run,event_order,render_ordinal,data_nonnull,width,height,pitch",
        "frontend_header": "callback_ordinal,frame,retro_run,callback_in_run,data_nonnull,width,height,pitch,pixel_format,captured,bytes,sha256,path",
    }
    require(all(display.get(key) == value for key, value in headers.items()),
            "v4-7", "render/preapply/post-frame/callback typed schemas")
    require(display.get("baseline_control_equal") is True, "v4-8", "BASELINE/CONTROL equality")
    require(display.get("both_pages_every_checkpoint") is True, "v4-10", "both-page checkpoints")
    require(display.get("legacy_crc_authority") is False, "v4-13", "legacy CRC authority")
    archive = contract.get("archive", {})
    require(archive == {"compressed_each_max": 536870912, "compressed_total_max": 1073741824,
                        "count": 4, "format": "ustar+gzip-n-9", "individual_member_max": 536870912,
                        "member_count_max": 20000, "ratio_max": 10000,
                        "tracked_total_max": 2147483648, "uncompressed_total_max": 17179869184},
            "v4-14", "archive security contract")
    ids = tuple(contract.get("categories", {}).get("v3", []) +
                contract.get("categories", {}).get("v4", []))
    require(ids == CATEGORIES, "v3-13", "28-category matrix")
    require(contract.get("ledger", {}).get("event_count") == 6, "v3-10", "six-event ledger")
    require(contract.get("runtime", {}).get("code_immutable") is True, "v3-11", "runtime code policy")
    require(contract.get("effects", {}).get("forbidden") ==
            ["COMM", "CMD", "DREQ", "state", "framebuffer", "FBCTL", "authority",
             "physics", "AI", "collision"], "v3-12", "forbidden effects")
    require(contract.get("context", {}).get("stack_preserved") is True, "v3-9", "context/stack")
    require(set(contract.get("exclusions", [])) == {
        "bridge", "cmd3f", "shared_lane", "authority", "collision", "cadence",
        "cpu_budget", "fps", "host_presentation", "real_hardware"},
        "v3-14", "claim exclusions")


def validate_docs() -> None:
    paragraph = ("**Q-028 status: BLOCKED / INCONCLUSIVE_ENGINE_SCHEDULE.** The prior\n"
        "`INCONCLUSIVE_COMPOSITE` acceptance is retracted: it was based on interpreter-only completion despite the\n"
        "approved requirement for two uninterrupted normal-DRC repeats of every A/B/C\n"
        "BASELINE/CONTROL/ACTIVE arm. Existing interpreter and DRC-A outputs are diagnostic only and establish no\n"
        "accepted family result. B/C normal-DRC evidence is absent. No exact-index, bridge, authority, cadence,\n"
        "CPU-budget, FPS, host-presentation, or real-hardware claim is accepted. Q-028 remains the active gate until\n"
        "a separately audited immutable DRC schedule, fresh two-engine recapture, complete retained raw evidence,\n"
        "and the repaired fail-closed mutation matrix pass a fresh completed-diff audit.")
    for path in DOCS:
        text = path.read_text()
        require(paragraph in text, "v3-14", f"missing exact rollback paragraph: {path}")


def verify_gzip_single_member(path: Path, compressed_max: int,
                              uncompressed_max: int, ratio_max: int) -> int:
    size = path.stat().st_size
    require(size <= compressed_max, "v4-14", f"archive too large: {path}")
    dec = zlib.decompressobj(16 + zlib.MAX_WBITS)
    total = 0
    with path.open("rb") as stream:
        while chunk := stream.read(1024 * 1024):
            out = dec.decompress(chunk)
            total += len(out)
            require(total <= uncompressed_max, "v4-14", "uncompressed archive limit")
            if dec.eof:
                require(not dec.unused_data and not stream.read(1), "v4-14", "trailing/second gzip member")
                break
    require(dec.eof, "v4-14", "truncated gzip")
    require(total <= max(1, size) * ratio_max, "v4-14", "compression ratio")
    return total


def stream_archive(path: Path, expected: dict[str, dict], contract: dict) -> tuple[int, int]:
    limits = contract["archive"]
    verify_gzip_single_member(path, limits["compressed_each_max"],
                              limits["uncompressed_total_max"], limits["ratio_max"])
    seen_files: set[str] = set()
    seen_all: set[str] = set()
    total = 0
    file_count = 0
    prior = ""
    with gzip.open(path, "rb") as raw, tarfile.open(fileobj=raw, mode="r|") as tar:
        for member in tar:
            require(len(seen_all) < limits["member_count_max"], "v4-14", "member count")
            normalized_name = member.name[:-1] if member.isdir() and member.name.endswith("/") else member.name
            require(valid_relative_path(normalized_name, ARCHIVE_ROOTS), "v4-14", f"unsafe member: {member.name}")
            require(normalized_name not in seen_all and normalized_name > prior, "v4-14", "duplicate/unsorted member")
            seen_all.add(normalized_name); prior = normalized_name
            require(not member.pax_headers and member.type not in
                    (tarfile.XHDTYPE, tarfile.XGLTYPE, tarfile.GNUTYPE_SPARSE),
                    "v4-14", f"pax/sparse member: {member.name}")
            require(member.uid == 0 and member.gid == 0 and member.mtime == 0,
                    "v4-14", f"metadata: {member.name}")
            if member.isdir():
                require(stat.S_IMODE(member.mode) == 0o755, "v4-14", "directory mode")
                continue
            require(member.isfile(), "v4-14", f"special/link member: {member.name}")
            require(stat.S_IMODE(member.mode) in (0o644, 0o755), "v4-14", "file mode")
            require(member.size <= limits["individual_member_max"], "v4-14", "member size")
            row = expected.get(member.name)
            require(row is not None and row.get("size") == member.size,
                    "v4-14", f"unindexed/size member: {member.name}")
            require(isinstance(row.get("sha256"), str) and HEX64.fullmatch(row["sha256"]) is not None,
                    "v4-14", f"member digest grammar: {member.name}")
            extracted = tar.extractfile(member)
            require(extracted is not None, "v4-14", f"unreadable member: {member.name}")
            digest = hashlib.sha256(); remaining = member.size
            while remaining:
                chunk = extracted.read(min(1024 * 1024, remaining))
                require(bool(chunk), "v4-14", f"short member: {member.name}")
                digest.update(chunk); remaining -= len(chunk)
            require(not extracted.read(1), "v4-14", f"long member: {member.name}")
            require(digest.hexdigest() == row["sha256"], "v4-14", f"member hash: {member.name}")
            seen_files.add(member.name); total += member.size; file_count += 1
    require(seen_files == set(expected), "v4-14", "missing indexed members")
    return file_count, total


def validate_artifact_index(index_path: Path, contract_path: Path = CONTRACT_PATH) -> None:
    contract = read_canonical_json(contract_path)
    require(isinstance(contract, dict), "v3-13", "contract object")
    validate_contract(contract)
    index = read_canonical_json(index_path)
    require(isinstance(index, dict) and index.get("schema") == "vrd-vr60-q028-artifact-index-v7",
            "v4-14", "artifact index schema")
    require(index.get("package_count") == 40, "v4-11", "artifact package count")
    require(index.get("render_page_count") == 640, "v4-9", "artifact render-page count")
    require(index.get("required_binary_bytes") == 358481920, "v3-13", "artifact binary floor")
    packages = index.get("packages", [])
    expected_packages = package_order()
    require(len(packages) == 40, "v4-11", "40 package rows")
    for actual, expected in zip(packages, expected_packages):
        for field, value in expected.items():
            require(actual.get(field) == value, "v4-11", f"package order/identity: {expected['id']}")
        require(actual.get("render_page_count") == 16, "v4-9", f"package pages: {expected['id']}")
        floor = 9076736 if expected["capture"] == "on" else 7929856
        require(actual.get("required_binary_bytes") == floor, "v4-12", f"package floor: {expected['id']}")
    archives = index.get("archives", [])
    require([row.get("name") for row in archives] == list(ARCHIVE_NAMES), "v4-14", "archive set/order")
    compressed_total = 0; full_total = 0; render_rows: list[tuple[str, str, str, str]] = []
    for archive in archives:
        path = index_path.parent / "artifacts" / archive["name"]
        require(path.is_file() and path.stat().st_size == archive.get("compressed_size"),
                "v4-14", f"archive missing/size: {path}")
        require(sha256_file(path) == archive.get("sha256"), "v4-14", f"archive hash: {path}")
        members = archive.get("members", [])
        expected = {row["path"]: row for row in members}
        require(len(expected) == len(members), "v4-14", "duplicate index member")
        _, uncompressed = stream_archive(path, expected, contract)
        require(uncompressed == archive.get("uncompressed_size"), "v4-14", "archive uncompressed total")
        compressed_total += path.stat().st_size; full_total += uncompressed
        for row in members:
            if row.get("role") == "render_page":
                match = RENDER_MEMBER.fullmatch(row["path"])
                require(match is not None and row.get("size") == 131072, "v4-9", "render-page path/size")
                render_rows.append((match.group(1), match.group(2), match.group(3), row["path"]))
    require(len(render_rows) == 640 and len(set(render_rows)) == 640, "v4-9", "640 distinct render pages")
    package_ids = {row["id"] for row in packages}
    require({row[0] for row in render_rows} == package_ids, "v4-9", "render-page package references")
    require(compressed_total == index.get("tracked_compressed_bytes") and
            compressed_total <= contract["archive"]["compressed_total_max"] and
            compressed_total <= contract["archive"]["tracked_total_max"],
            "v4-14", "compressed total/cap")
    require(full_total == index.get("uncompressed_bytes") and
            full_total <= contract["archive"]["uncompressed_total_max"],
            "v4-14", "uncompressed total/cap")


def inventory_path(path: Path) -> str:
    resolved = path.resolve()
    try:
        return resolved.relative_to(ROOT).as_posix()
    except ValueError:
        return str(resolved)


def write_diagnostic_inventory(output: Path, roots: Iterable[Path]) -> None:
    rows = []
    for root in roots:
        if not root.exists():
            continue
        candidates = [root] if root.is_file() else [p for p in root.rglob("*") if p.is_file()]
        for path in sorted(candidates,
                           key=lambda p: inventory_path(p).encode()):
            rows.append({"path": inventory_path(path), "bytes": path.stat().st_size,
                         "sha256": sha256_file(path), "eligible": False,
                         "reuse_forbidden": True})
    value = {"schema": "vrd-vr60-q028-diagnostic-inventory-v7", "eligible": False,
             "reuse_forbidden": True, "files": rows}
    fd = os.open(output, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o644)
    with os.fdopen(fd, "wb") as stream:
        stream.write(canonical_json(value)); stream.flush(); os.fsync(stream.fileno())


def git(*args: str) -> bytes:
    return subprocess.run(["git", *args], cwd=ROOT, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE, check=True).stdout


def read_stage_list(path: Path) -> list[str]:
    raw = path.read_bytes()
    require(b"\r" not in raw and raw.endswith(b"\n"), "v3-13", "stage list LF")
    rows = raw.decode().splitlines()
    require(rows == sorted(set(rows), key=lambda value: value.encode()), "v3-13", "stage list sorted/unique")
    require(bool(rows) and all(valid_relative_path(row) for row in rows), "v3-13", "stage path")
    return rows


def status_path(record: str) -> str:
    if record.startswith("? ") or record.startswith("! "):
        return record[2:]
    fields = record.split(" ")
    return fields[-1]


def index_receipt(stage_list: Path, output: Path, blocked_base: str) -> None:
    rows = read_stage_list(stage_list)
    base = git("rev-parse", blocked_base).decode().strip()
    cached = [row.decode() for row in git("diff", "--cached", "--name-only", "-z", base).split(b"\0")[:-1]]
    require(cached == rows, "v3-13", "cached paths differ from exact stage list")
    staged = []
    for path in rows:
        entries = git("ls-files", "--stage", "-z", "--", path).split(b"\0")[:-1]
        require(len(entries) == 1, "v3-13", f"single index entry: {path}")
        meta, indexed_path = entries[0].decode().split("\t", 1)
        mode, blob, stage = meta.split()
        require(indexed_path == path and stage == "0" and mode in ("100644", "100755"),
                "v3-13", f"stage-0/mode: {path}")
        work = ROOT / path
        require(work.is_file() and not work.is_symlink(), "v3-13", f"regular worktree file: {path}")
        content = work.read_bytes()
        work_blob = hashlib.sha1(b"blob " + str(len(content)).encode() + b"\0" + content).hexdigest()
        require(work_blob == blob, "v3-13", f"worktree/index mismatch: {path}")
        staged.append({"path": path, "mode": mode, "blob": blob, "size": len(content)})
    records = [row.decode() for row in git("status", "--porcelain=v2", "-z", "--untracked-files=all").split(b"\0")[:-1]]
    namespace = "analysis/evidence/vr60-q028-renderer-descriptor-probe/"
    q028_dirty = [record for record in records if
                  (status_path(record).startswith(namespace) or "q028" in status_path(record).lower()) and
                  status_path(record) not in rows]
    require(not q028_dirty, "v3-13", "unstaged/untracked Q-028 namespace entries")
    bindings = {"v3": PROPOSALS["v3"], "v4": PROPOSALS["v4"], "v5": PROPOSALS["v5"],
                "v6": PROPOSALS["v6"], "v7": PROPOSALS["v7"]}
    binding_paths = {
        "manifest_sha256": EVIDENCE / "manifest.sha256",
        "artifact_index": EVIDENCE / "artifact-index.json",
        "suite_result": EVIDENCE / "suite-result.json",
        "owner_domain": EVIDENCE / "pre-capture/owner-domain-v6.json",
        "owner_report": EVIDENCE / "pre-capture/constructed-owner-report-v6.json",
        "schedule": EVIDENCE / "engine-schedule-v6.json",
    }
    for name, path in binding_paths.items():
        bindings[name] = sha256_file(path) if path.is_file() else "ABSENT_PHASE1"
    bindings["canonical_postimages"] = {path.relative_to(ROOT).as_posix(): sha256_file(path) for path in DOCS}
    receipt = {"schema": "vrd-vr60-q028-index-audit-receipt-v6", "blocked_base": base,
               "branch": git("branch", "--show-current").decode().strip(),
               "created_utc": subprocess.run(["date", "-u", "+%Y-%m-%dT%H:%M:%SZ"],
                                                stdout=subprocess.PIPE, text=True, check=True).stdout.strip(),
               "repository": str(ROOT), "stage_list_sha256": sha256_file(stage_list),
               "stage_list_bytes": stage_list.stat().st_size,
               "staged": staged, "index_tree": git("write-tree").decode().strip(),
               "outside_list_staged": [], "q028_dirty": [],
               "bindings": bindings,
               "cached_name_status": git("diff", "--cached", "--name-status", "-z", base).hex(),
               "porcelain_v2": sorted(records, key=lambda value: value.encode())}
    fd = os.open(output, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o644)
    with os.fdopen(fd, "wb") as stream:
        stream.write(canonical_json(receipt)); stream.flush(); os.fsync(stream.fileno())


def pre_capture() -> None:
    contract = read_canonical_json(CONTRACT_PATH)
    require(isinstance(contract, dict), "v3-13", "contract object")
    validate_contract(contract); validate_docs()
    fixture = EVIDENCE / "pre-capture/normal-1p-1340.csv"
    require(fixture.is_file() and fixture.stat().st_size == 14981 and
            sha256_file(fixture) == contract["fixture"]["sha256"], "v4-5", "pinned fixture")
    frontend = (ROOT / "tools/libretro-profiling/profiling_frontend.c").read_text()
    require("VRD_Q028_APPLIED_INPUT_LOG" in frontend, "v4-12", "applied-input source")
    require("const char *record_input_path = getenv(\"VRD_RECORD_INPUT\")" not in frontend,
            "v4-12", "automatic VRD_RECORD_INPUT remains")
    prepare = (ROOT / "tools/libretro-profiling/prepare_q028_picodrive.py").read_text()
    require("transform_draw" in prepare and "vrd_q028_render_select" in prepare and
            "vrd_q028_callback_dispatch" in prepare, "v4-7", "direct render/callback transforms")
    observer = (ROOT / "tools/libretro-profiling/q028_all_access_observer.inc").read_text()
    require("post-frame.csv" in observer and "raw-pages.csv" not in observer,
            "v4-7", "separate post-frame schema")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    sub.add_parser("pre-capture")
    contract = sub.add_parser("validate-contract"); contract.add_argument("path", type=Path, nargs="?", default=CONTRACT_PATH)
    artifacts = sub.add_parser("validate-artifacts"); artifacts.add_argument("index", type=Path)
    artifacts.add_argument("--contract", type=Path, default=CONTRACT_PATH)
    inventory = sub.add_parser("diagnostic-inventory")
    inventory.add_argument("output", type=Path); inventory.add_argument("roots", nargs="+", type=Path)
    receipt = sub.add_parser("index-receipt")
    receipt.add_argument("stage_list", type=Path); receipt.add_argument("output", type=Path)
    receipt.add_argument("--blocked-base", required=True)
    args = parser.parse_args()
    try:
        if args.command == "pre-capture": pre_capture()
        elif args.command == "validate-contract":
            value = read_canonical_json(args.path.resolve())
            require(isinstance(value, dict), "v3-13", "contract object"); validate_contract(value)
        elif args.command == "validate-artifacts": validate_artifact_index(args.index.resolve(), args.contract.resolve())
        elif args.command == "diagnostic-inventory": write_diagnostic_inventory(args.output.resolve(), args.roots)
        elif args.command == "index-receipt": index_receipt(args.stage_list.resolve(), args.output.resolve(), args.blocked_base)
    except (OSError, ValueError, KeyError, Q028Error, subprocess.CalledProcessError, tarfile.TarError, zlib.error) as error:
        print(f"Q-028 {args.command} FAILED: {error}")
        return 1
    print(f"Q-028 {args.command} PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
