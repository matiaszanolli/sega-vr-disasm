#!/usr/bin/env python3
"""Build Q-028's four deterministic lossless archives and v7 artifact index."""

from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import os
import shutil
import subprocess
import tempfile
from pathlib import Path


HERE=Path(__file__).resolve().parent
SPEC=importlib.util.spec_from_file_location("q028_evidence",HERE/"q028_evidence.py")
assert SPEC and SPEC.loader
E=importlib.util.module_from_spec(SPEC); SPEC.loader.exec_module(E)


class ArchiveError(RuntimeError): pass


def copy_tree(source:Path,destination:Path)->None:
    if not source.is_dir() or source.is_symlink(): raise ArchiveError(f"source tree: {source}")
    destination.mkdir(parents=True,mode=0o755)
    for path in sorted(source.rglob("*"),key=lambda item:item.relative_to(source).as_posix().encode()):
        relative=path.relative_to(source)
        target=destination/relative
        if path.is_symlink(): raise ArchiveError(f"symlink forbidden: {path}")
        if path.is_dir(): target.mkdir(mode=0o755)
        elif path.is_file():
            target.parent.mkdir(parents=True,exist_ok=True)
            shutil.copyfile(path,target); target.chmod(0o755 if os.access(path,os.X_OK) else 0o644)
        else: raise ArchiveError(f"special file: {path}")


def members(root:Path,top:str)->list[dict]:
    rows=[]
    for path in sorted((item for item in root.rglob("*") if item.is_file()),
                       key=lambda item:item.relative_to(root.parent).as_posix().encode()):
        relative=path.relative_to(root.parent).as_posix()
        role="render_page" if "/render-" in relative and relative.endswith(("-page-0.bin","-page-1.bin")) else "artifact"
        rows.append({"path":relative,"size":path.stat().st_size,"sha256":E.sha256_file(path),"role":role})
    if not rows: raise ArchiveError(f"empty archive root: {top}")
    return rows


def create_archive(staging:Path,top:str,output:Path)->dict:
    tar_path=output.with_suffix("").with_suffix("")
    subprocess.run(["tar","--format=ustar","--sort=name","--mtime=@0","--owner=0","--group=0",
                    "--numeric-owner","--mode=u+rwX,go+rX,go-w","-cf",str(tar_path),"-C",str(staging),top],check=True)
    with output.open("xb") as stream:
        subprocess.run(["gzip","-n","-9","-c",str(tar_path)],stdout=stream,check=True)
    tar_path.unlink()
    listed=members(staging/top,top)
    return {"name":output.name,"compressed_size":output.stat().st_size,
            "sha256":E.sha256_file(output),"uncompressed_size":sum(row["size"] for row in listed),
            "members":listed}


def package_source(row:dict,schedule:Path,matrix:Path)->Path:
    return (matrix if row["capture"]=="on" else schedule)/row["id"]


def main()->int:
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--schedule-root",type=Path,required=True); parser.add_argument("--matrix-root",type=Path,required=True)
    parser.add_argument("--equivalence-root",type=Path,required=True); parser.add_argument("--toolchain-root",type=Path,required=True)
    parser.add_argument("--output",type=Path,required=True); args=parser.parse_args()
    try:
        if args.output.exists(): raise ArchiveError("archive output must not exist")
        args.output.mkdir(parents=True)
        artifacts=args.output/"artifacts"; artifacts.mkdir()
        packages=E.package_order()
        with tempfile.TemporaryDirectory(prefix="q028-archive-build-") as temporary:
            staging=Path(temporary)
            for top in ("interpreter","drc","equivalence","toolchain"): (staging/top).mkdir()
            for row in packages:
                source=package_source(row,args.schedule_root.resolve(),args.matrix_root.resolve())
                top="interpreter" if row["engine"]=="INTERPRETER" else "drc"
                copy_tree(source,staging/top/row["id"])
            copy_tree(args.equivalence_root.resolve(),staging/"equivalence"/"composition")
            copy_tree(args.toolchain_root.resolve(),staging/"toolchain"/"pinned")
            archive_rows=[]
            for name,top in zip(E.ARCHIVE_NAMES,("interpreter","drc","equivalence","toolchain")):
                archive_rows.append(create_archive(staging,top,artifacts/name))
        package_rows=[]
        for row in packages:
            package_rows.append({**row,"render_page_count":16,
                                 "required_binary_bytes":9076736 if row["capture"]=="on" else 7929856})
        index={"schema":"vrd-vr60-q028-artifact-index-v7","package_count":40,"render_page_count":640,
               "required_binary_bytes":358481920,"packages":package_rows,"archives":archive_rows,
               "tracked_compressed_bytes":sum(row["compressed_size"] for row in archive_rows),
               "uncompressed_bytes":sum(row["uncompressed_size"] for row in archive_rows)}
        index_path=args.output/"artifact-index.json"; index_path.write_bytes(E.canonical_json(index))
        E.validate_artifact_index(index_path)
    except (OSError,ValueError,KeyError,ArchiveError,E.Q028Error,subprocess.CalledProcessError) as error:
        print(f"Q-028 archive build FAILED: {error}"); return 1
    print("Q-028 deterministic four-archive build PASS"); return 0


if __name__=="__main__": raise SystemExit(main())
