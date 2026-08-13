#!/usr/bin/env python3
"""Freeze Q-028 engine schedules without reading any outcome artifact."""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import os
from pathlib import Path


ALLOWED = (
    "applied-input.csv", "drc-command.csv", "capture/render-select.csv",
    "capture/fs-preapply.csv", "capture/post-frame.csv",
    "capture/callback-bind.csv", "capture/capture-session.csv",
)
HEADERS = {
    "applied-input.csv": "frame,mask",
    "drc-command.csv": "ordinal,frame,event,agent,pc,address,width,value,engine_drc",
    "capture/render-select.csv": "render_ordinal,frame,retro_run,event_order,fbctl,render_fs,offs,lines,sync_line,draw_mode,skip_frame,page_bytes,page0_path,page1_path",
    "capture/fs-preapply.csv": "preapply_ordinal,frame,retro_run,event_order,site,old_fbctl,old_fs,new_fs,fen,page_bytes,page0_path,page1_path",
    "capture/post-frame.csv": "frame,retro_run,event_order,fbctl,post_frame_fs,fen,page_bytes,page0_path,page1_path",
    "capture/callback-bind.csv": "callback_ordinal,frame,retro_run,event_order,render_ordinal,data_nonnull,width,height,pitch",
    "capture/capture-session.csv": "observer_version,start,end,fs_snapshots,fs_errors,sh2_interpreter",
}


class FreezeError(RuntimeError): pass


def canonical(value: object) -> bytes:
    return (json.dumps(value, sort_keys=True, separators=(",", ":")) + "\n").encode()


def normalized_csv(root: Path, relative: str) -> tuple[str, list[dict[str, str]]]:
    path = root / relative
    if not path.is_file() or path.is_symlink(): raise FreezeError(f"missing/unsafe schedule member: {relative}")
    raw = path.read_bytes()
    if b"\r" in raw or b"\x00" in raw: raise FreezeError(f"non-LF schedule member: {relative}")
    lines = raw.decode("utf-8").splitlines()
    if not lines or lines[0] != HEADERS[relative]: raise FreezeError(f"header: {relative}")
    rows = list(csv.DictReader(lines))
    for row in rows:
        for key in ("path", "page0_path", "page1_path"):
            if key in row and row[key] != "-": row[key] = Path(row[key]).name
    normalized = canonical(rows)
    return hashlib.sha256(normalized).hexdigest(), rows


def read_schedule_run(root: Path, engine: str, repeat: int) -> dict:
    # This allowlist is the entire reader surface. It deliberately has no
    # result, RGB565, framebuffer-page, WRAM, SDRAM, terminal, or profile path.
    if not root.is_dir() or root.is_symlink(): raise FreezeError(f"run root: {root}")
    hashes = {}; sequences = {}
    for relative in ALLOWED:
        value_hash, rows = normalized_csv(root, relative)
        hashes[relative] = value_hash
        if relative != "applied-input.csv": sequences[relative] = rows
    render = sequences["capture/render-select.csv"]
    callback = sequences["capture/callback-bind.csv"]
    fixed_render = [row for row in render if 1298 <= int(row["frame"]) <= 1305]
    fixed_callback = [row for row in callback if 1298 <= int(row["frame"]) <= 1305]
    if len(fixed_render) != 8 or len(fixed_callback) != 8: raise FreezeError("not one render/callback per fixed frame")
    for render_row, callback_row in zip(fixed_render, fixed_callback):
        if (render_row["frame"] != callback_row["frame"] or
                render_row["render_ordinal"] != callback_row["render_ordinal"] or
                int(render_row["event_order"]) >= int(callback_row["event_order"])):
            raise FreezeError("render/callback bijection")
    return {"engine":engine,"repeat":repeat,"metadata_hashes":hashes,"sequences":sequences}


def build(args: argparse.Namespace) -> dict:
    ordered = [("INTERPRETER",1,args.interpreter_repeat1),
               ("INTERPRETER",2,args.interpreter_repeat2),
               ("NORMAL_DRC",1,args.drc_repeat1),("NORMAL_DRC",2,args.drc_repeat2)]
    rows = [read_schedule_run(path.resolve(), engine, repeat) for engine, repeat, path in ordered]
    for offset in (0, 2):
        left, right = rows[offset], rows[offset+1]
        if left["metadata_hashes"] != right["metadata_hashes"] or left["sequences"] != right["sequences"]:
            raise FreezeError(f"{left['engine']} repeats differ")
    return {"schema":"vrd-vr60-q028-engine-schedule-v6","status":"PROSPECTIVE_UNREVIEWED",
            "reader_allowlist":list(ALLOWED),
            "outcome_members_read":0,
            "INTERPRETER":[rows[0],rows[1]],"NORMAL_DRC":[rows[2],rows[3]]}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--interpreter-repeat1",type=Path,required=True)
    parser.add_argument("--interpreter-repeat2",type=Path,required=True)
    parser.add_argument("--drc-repeat1",type=Path,required=True)
    parser.add_argument("--drc-repeat2",type=Path,required=True)
    parser.add_argument("--output",type=Path,required=True)
    args=parser.parse_args()
    try:
        value=build(args)
        fd=os.open(args.output,os.O_WRONLY|os.O_CREAT|os.O_EXCL,0o644)
        with os.fdopen(fd,"wb") as stream: stream.write(canonical(value)); stream.flush(); os.fsync(stream.fileno())
    except (OSError,ValueError,FreezeError) as error:
        print(f"Q-028 schedule freeze FAILED: {error}"); return 1
    print("Q-028 schedule freeze PASS (prospective; Auditor hash approval required)"); return 0


if __name__ == "__main__": raise SystemExit(main())
