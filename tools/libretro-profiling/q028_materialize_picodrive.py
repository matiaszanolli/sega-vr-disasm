#!/usr/bin/env python3
"""Create, verify, and safely materialize Q-028's recursive PicoDrive closure.

Pack creation is the quarantined, one-time operation that may read Git object
stores.  Validation and materialization are the production offline operations:
they consume only the immutable pack and its detached digest.
"""

from __future__ import annotations

import argparse
import gzip
import hashlib
import io
import json
import os
import stat
import subprocess
import tarfile
import unicodedata
from pathlib import Path, PurePosixPath


SCHEMA = "vrd-vr60-q028-picodrive-git-closure-v9"
PACK_ROOT = "picodrive-source"
EXPECTED_FILES = 1633
EXPECTED_BYTES = 27_554_071
EXPECTED_EDGES = 6

NODES = (
    ("picodrive", "", "26ecb2b6358fefba24e3d68b9eb2efba7f10d5ee",
     "d7fd228ee5b6c2a1a625dc54d88ce064e526a930", 450, 6_979_385,
     "https://github.com/notaz/picodrive.git", "third_party/picodrive"),
    ("cyclone", "cpu/cyclone", "3ac7cf1bdeecb60e2414980e8dc72ff092f69769",
     "75b964ab062318d749cfff8386d5a2da70088e7a", 29, 245_251,
     "https://github.com/irixxxx/cyclone68000.git", "third_party/picodrive/cpu/cyclone"),
    ("libchdr", "pico/cd/libchdr", "e62ac5995b1c7ef65ece35293914843b8ee57d49",
     "38aaa0fff055550ef4b9ee575345057f73740636", 946, 13_745_641,
     "https://github.com/irixxxx/libchdr.git", "third_party/picodrive/pico/cd/libchdr"),
    ("emu2413", "pico/sound/emu2413", "a2dfc20ff507e4fd075cd325620bcea655e2c1f7",
     "471d6f8692686514021b53317a336a6688e8e913", 9, 60_504,
     "https://github.com/digital-sound-antiques/emu2413.git", "third_party/picodrive/pico/sound/emu2413"),
    ("dr_libs", "platform/common/dr_libs", "dd762b861ecadf5ddd5fb03e9ca1db6707b54fbb",
     "6dc8b927a19ec27c13a6164d9729576dc86ef074", 54, 2_951_226,
     "https://github.com/mackron/dr_libs.git", "third_party/picodrive/platform/common/dr_libs"),
    ("miniaudio", "platform/common/dr_libs/tests/external/miniaudio",
     "d1a166c83ab445b1c14bc83d37c84e18d172e5f5",
     "f420bf6967950511dc2e059741d90f45a512b8ac", 74, 3_193_871,
     "https://github.com/dr-soft/miniaudio.git", "/tmp/q028-miniaudio-git"),
    ("libpicofe", "platform/libpicofe", "c3031dbfda557f7058756583b329b59ea92a72dc",
     "ce40f6feea4a4b1f209bbd587896fe92cfb218d1", 71, 378_193,
     "https://github.com/irixxxx/libpicofe.git", "third_party/picodrive/platform/libpicofe"),
)

EDGES = (
    ("picodrive", "cyclone", "cpu/cyclone"),
    ("picodrive", "libchdr", "pico/cd/libchdr"),
    ("picodrive", "emu2413", "pico/sound/emu2413"),
    ("picodrive", "dr_libs", "platform/common/dr_libs"),
    ("picodrive", "libpicofe", "platform/libpicofe"),
    ("dr_libs", "miniaudio", "tests/external/miniaudio"),
)


class ProvenanceError(RuntimeError):
    pass


def canonical(value: object) -> bytes:
    return (json.dumps(value, sort_keys=True, separators=(",", ":")) + "\n").encode()


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def git_blob(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()


def run_git(repo: Path, *args: str, input_data: bytes | None = None) -> bytes:
    env = {"PATH": os.environ.get("PATH", "/usr/bin:/bin"), "LC_ALL": "C",
           "GIT_CONFIG_NOSYSTEM": "1", "GIT_TERMINAL_PROMPT": "0"}
    result = subprocess.run(["git", "-C", str(repo), *args], input=input_data,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            env=env, check=False)
    if result.returncode:
        raise ProvenanceError(f"git object operation failed ({repo}, {args}): "
                              f"{result.stderr.decode(errors='replace').strip()}")
    return result.stdout


def safe_relative(name: str) -> str:
    if not name or "\\" in name or "\0" in name or name.startswith("/"):
        raise ProvenanceError(f"unsafe path: {name!r}")
    parts = PurePosixPath(name).parts
    if any(part in ("", ".", "..") for part in parts):
        raise ProvenanceError(f"unsafe path component: {name!r}")
    return PurePosixPath(*parts).as_posix()


def parse_tree(repo: Path, commit: str) -> list[tuple[str, str, str, int]]:
    raw = run_git(repo, "ls-tree", "-rz", "-r", "--full-tree", "-l", commit)
    rows: list[tuple[str, str, str, int]] = []
    for record in raw.split(b"\0"):
        if not record:
            continue
        meta, raw_path = record.split(b"\t", 1)
        mode, kind, oid, size = meta.decode("ascii").split()
        path = raw_path.decode("utf-8", "strict")
        rows.append((mode, oid, safe_relative(path), -1 if size == "-" else int(size)))
    return rows


def create_manifest(repo_root: Path) -> tuple[dict, dict[str, bytes]]:
    sources: dict[str, bytes] = {}
    leaves: list[dict] = []
    nodes: list[dict] = []
    by_id = {row[0]: row for row in NODES}
    edge_paths = {(parent, path): child for parent, child, path in EDGES}
    seen_edges: set[tuple[str, str, str]] = set()
    for repo_id, final_root, commit, expected_tree, expected_count, expected_bytes, url, local in NODES:
        repo = Path(local) if local.startswith("/") else repo_root / local
        if run_git(repo, "cat-file", "-t", commit).strip() != b"commit":
            raise ProvenanceError(f"missing commit object: {repo_id}:{commit}")
        tree = run_git(repo, "rev-parse", f"{commit}^{{tree}}").decode().strip()
        if tree != expected_tree:
            raise ProvenanceError(f"tree mismatch: {repo_id}:{tree}")
        rows = parse_tree(repo, commit)
        count = total = gitlinks = symlinks = 0
        for mode, oid, relative, size in rows:
            if mode == "160000":
                child = edge_paths.get((repo_id, relative))
                if not child or by_id[child][2] != oid:
                    raise ProvenanceError(f"undeclared or wrong gitlink: {repo_id}:{relative}:{oid}")
                seen_edges.add((repo_id, child, relative))
                gitlinks += 1
                continue
            if mode not in ("100644", "100755", "120000"):
                raise ProvenanceError(f"unsupported git mode {mode}: {repo_id}:{relative}")
            data = run_git(repo, "cat-file", "blob", oid)
            if size != len(data) or git_blob(data) != oid:
                raise ProvenanceError(f"blob mismatch: {repo_id}:{relative}")
            final = safe_relative(f"{final_root}/{relative}" if final_root else relative)
            if final in sources:
                raise ProvenanceError(f"recursive overlay collision: {final}")
            if mode == "120000":
                target = data.decode("utf-8", "strict")
                joined = PurePosixPath(final).parent.joinpath(target)
                if target.startswith("/") or ".." in joined.parts:
                    raise ProvenanceError(f"unsafe symlink: {final}->{target}")
                symlinks += 1
            sources[final] = data
            leaves.append({"repository_id": repo_id, "repository_commit": commit,
                           "repository_tree": tree, "repository_relative_path": relative,
                           "final_relative_path": final, "git_mode": mode,
                           "git_blob_sha1": oid, "byte_size": len(data),
                           "sha256": sha256(data),
                           "symlink_target_bytes": data.hex() if mode == "120000" else None})
            count += 1; total += len(data)
        if count != expected_count or total != expected_bytes:
            raise ProvenanceError(f"node aggregate mismatch: {repo_id}:{count}:{total}")
        gitmodules = next((leaf for leaf in leaves if leaf["repository_id"] == repo_id and
                           leaf["repository_relative_path"] == ".gitmodules"), None)
        nodes.append({"repository_id": repo_id, "historical_url": url,
                      "commit": commit, "tree": tree, "parent_final_path": final_root,
                      "regular_files": count - symlinks, "symlinks": symlinks,
                      "nested_gitlinks": gitlinks, "blob_bytes": total,
                      "gitmodules_blob_sha1": gitmodules["git_blob_sha1"] if gitmodules else None,
                      "recursive_tree_truncated": False})
    if seen_edges != set(EDGES):
        raise ProvenanceError(f"recursive edge mismatch: {sorted(set(EDGES)-seen_edges)}")
    leaves.sort(key=lambda row: row["final_relative_path"].encode())
    paths = [row["final_relative_path"] for row in leaves]
    if len(paths) != len(set(paths)) or len({p.casefold() for p in paths}) != len(paths):
        raise ProvenanceError("path or case-fold collision")
    if len({unicodedata.normalize("NFC", p) for p in paths}) != len(paths):
        raise ProvenanceError("Unicode normalization collision")
    if len(leaves) != EXPECTED_FILES or sum(x["byte_size"] for x in leaves) != EXPECTED_BYTES:
        raise ProvenanceError("recursive closure aggregate mismatch")
    manifest = {"schema": SCHEMA, "version": 9,
                "root_commit": NODES[0][2], "root_tree": NODES[0][3],
                "nodes": nodes,
                "edges": [{"parent_repository_id": p, "child_repository_id": c,
                           "repository_relative_path": path,
                           "final_relative_path": by_id[c][1], "git_mode": "160000",
                           "commit": by_id[c][2]} for p, c, path in EDGES],
                "leaves": leaves,
                "aggregate": {"regular_files": EXPECTED_FILES,
                              "symlinks": 0, "gitlink_edges": EXPECTED_EDGES,
                              "regular_file_bytes": EXPECTED_BYTES},
                "eligible_network_access": False,
                "creation_input_scope": "quarantined-local-git-object-stores-only"}
    return manifest, sources


def tar_info(name: str, mode: int, size: int) -> tarfile.TarInfo:
    info = tarfile.TarInfo(name)
    info.mode = mode; info.uid = 0; info.gid = 0; info.uname = ""; info.gname = ""
    info.mtime = 0; info.size = size
    return info


def create_pack(repo_root: Path, manifest_path: Path, pack_path: Path,
                digest_path: Path) -> None:
    for output in (manifest_path, pack_path, digest_path):
        if output.exists():
            raise ProvenanceError(f"exclusive output exists: {output}")
    manifest, sources = create_manifest(repo_root)
    manifest_raw = canonical(manifest)
    manifest_path.write_bytes(manifest_raw)
    with pack_path.open("xb") as raw:
        with gzip.GzipFile(filename="", mode="wb", fileobj=raw, compresslevel=9, mtime=0) as gz:
            with tarfile.open(fileobj=gz, mode="w", format=tarfile.USTAR_FORMAT) as tar:
                name = f"{PACK_ROOT}/q028_picodrive_git_closure_v9.json"
                tar.addfile(tar_info(name, 0o644, len(manifest_raw)), io.BytesIO(manifest_raw))
                for leaf in manifest["leaves"]:
                    data = sources[leaf["final_relative_path"]]
                    name = f"{PACK_ROOT}/{leaf['final_relative_path']}"
                    info = tar_info(name, int(leaf["git_mode"][-3:], 8), len(data))
                    if leaf["git_mode"] == "120000":
                        info.type = tarfile.SYMTYPE; info.linkname = data.decode(); info.size = 0
                        tar.addfile(info)
                    else:
                        tar.addfile(info, io.BytesIO(data))
    digest_path.write_bytes((sha256(pack_path.read_bytes()) + "  " + pack_path.name + "\n").encode())
    verify_pack(pack_path, manifest_path)


def load_manifest(path: Path) -> dict:
    raw = path.read_bytes()
    value = json.loads(raw)
    if raw != canonical(value) or value.get("schema") != SCHEMA:
        raise ProvenanceError("noncanonical or wrong closure manifest")
    agg = value.get("aggregate", {})
    if (agg.get("regular_files"), agg.get("symlinks"), agg.get("gitlink_edges"),
            agg.get("regular_file_bytes")) != (EXPECTED_FILES, 0, EXPECTED_EDGES, EXPECTED_BYTES):
        raise ProvenanceError("closure aggregate mismatch")
    return value


def verify_pack(pack_path: Path, manifest_path: Path | None = None) -> dict:
    expected = load_manifest(manifest_path) if manifest_path else None
    seen: dict[str, tuple[tarfile.TarInfo, bytes]] = {}
    with pack_path.open("rb") as raw:
        with gzip.GzipFile(fileobj=raw, mode="rb") as gz:
            with tarfile.open(fileobj=gz, mode="r|") as tar:
                for info in tar:
                    name = safe_relative(info.name)
                    if not name.startswith(PACK_ROOT + "/") or name in seen:
                        raise ProvenanceError(f"wrong root or duplicate pack member: {name}")
                    if not (info.isreg() or info.issym()):
                        raise ProvenanceError(f"forbidden pack member type: {name}")
                    if (info.uid, info.gid, info.mtime, info.uname, info.gname) != (0, 0, 0, "", ""):
                        raise ProvenanceError(f"nondeterministic pack metadata: {name}")
                    stream = tar.extractfile(info)
                    data = stream.read() if stream else (info.linkname.encode() if info.issym() else b"")
                    seen[name] = (info, data)
        trailing = raw.read(1)
        if trailing:
            raise ProvenanceError("trailing gzip data")
    manifest_name = f"{PACK_ROOT}/q028_picodrive_git_closure_v9.json"
    if manifest_name not in seen:
        raise ProvenanceError("pack manifest missing")
    embedded_raw = seen.pop(manifest_name)[1]
    embedded = json.loads(embedded_raw)
    if embedded_raw != canonical(embedded) or embedded.get("schema") != SCHEMA:
        raise ProvenanceError("embedded manifest invalid")
    if expected is not None and embedded != expected:
        raise ProvenanceError("detached/embedded manifest mismatch")
    expected_names = {f"{PACK_ROOT}/{leaf['final_relative_path']}": leaf
                      for leaf in embedded["leaves"]}
    if set(seen) != set(expected_names):
        raise ProvenanceError("pack leaf bijection mismatch")
    for name, leaf in expected_names.items():
        info, data = seen[name]
        if leaf["git_mode"] == "120000":
            data = info.linkname.encode()
            if not info.issym(): raise ProvenanceError(f"symlink type mismatch: {name}")
        elif not info.isreg():
            raise ProvenanceError(f"regular type mismatch: {name}")
        if (len(data), sha256(data), git_blob(data)) != (
                leaf["byte_size"], leaf["sha256"], leaf["git_blob_sha1"]):
            raise ProvenanceError(f"pack member identity mismatch: {name}")
    return embedded


def materialize(pack_path: Path, destination: Path, manifest_path: Path | None = None) -> dict:
    if destination.exists():
        raise ProvenanceError("materialization destination must not exist")
    manifest = verify_pack(pack_path, manifest_path)
    destination.mkdir(mode=0o700)
    leaves = {leaf["final_relative_path"]: leaf for leaf in manifest["leaves"]}
    with tarfile.open(pack_path, "r:gz") as tar:
        for info in tar:
            if info.name.endswith("/q028_picodrive_git_closure_v9.json"):
                continue
            relative = safe_relative(info.name[len(PACK_ROOT) + 1:])
            leaf = leaves[relative]
            target = destination.joinpath(*PurePosixPath(relative).parts)
            target.parent.mkdir(parents=True, exist_ok=True)
            if info.isreg():
                stream = tar.extractfile(info)
                if stream is None: raise ProvenanceError(f"missing body: {relative}")
                with target.open("xb") as output:
                    output.write(stream.read())
                os.chmod(target, int(leaf["git_mode"][-3:], 8))
            else:
                os.symlink(info.linkname, target)
    actual: set[str] = set()
    for path in destination.rglob("*"):
        if path.is_dir(): continue
        relative = path.relative_to(destination).as_posix(); actual.add(relative)
        leaf = leaves.get(relative)
        if leaf is None: raise ProvenanceError(f"extra materialized leaf: {relative}")
        data = os.readlink(path).encode() if path.is_symlink() else path.read_bytes()
        mode = "120000" if path.is_symlink() else ("100755" if path.stat().st_mode & stat.S_IXUSR else "100644")
        if (mode, len(data), sha256(data), git_blob(data)) != (
                leaf["git_mode"], leaf["byte_size"], leaf["sha256"], leaf["git_blob_sha1"]):
            raise ProvenanceError(f"materialized identity mismatch: {relative}")
    if actual != set(leaves):
        raise ProvenanceError("materialized leaf bijection mismatch")
    return manifest


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    create = sub.add_parser("create-pack")
    create.add_argument("--repo-root", type=Path, required=True)
    create.add_argument("--manifest", type=Path, required=True)
    create.add_argument("--pack", type=Path, required=True)
    create.add_argument("--sha256", type=Path, required=True)
    verify = sub.add_parser("verify-pack")
    verify.add_argument("--pack", type=Path, required=True)
    verify.add_argument("--manifest", type=Path)
    unpack = sub.add_parser("materialize")
    unpack.add_argument("--pack", type=Path, required=True)
    unpack.add_argument("--manifest", type=Path)
    unpack.add_argument("--destination", type=Path, required=True)
    args = parser.parse_args()
    try:
        if args.command == "create-pack":
            create_pack(args.repo_root.resolve(), args.manifest.resolve(),
                        args.pack.resolve(), args.sha256.resolve())
        elif args.command == "verify-pack":
            manifest = verify_pack(args.pack.resolve(), args.manifest.resolve() if args.manifest else None)
            print(json.dumps(manifest["aggregate"], sort_keys=True, separators=(",", ":")))
        else:
            manifest = materialize(args.pack.resolve(), args.destination.resolve(),
                                   args.manifest.resolve() if args.manifest else None)
            print(json.dumps(manifest["aggregate"], sort_keys=True, separators=(",", ":")))
    except (OSError, ValueError, KeyError, json.JSONDecodeError, tarfile.TarError,
            subprocess.SubprocessError, ProvenanceError) as error:
        print(f"Q-028 PicoDrive provenance FAILED: {error}")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
