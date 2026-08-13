#!/usr/bin/env python3
"""Production validator for one fresh Q-028 v7 raw run package."""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import re
from pathlib import Path


HERE=Path(__file__).resolve().parent
CONTRACT=json.loads((HERE/"q028_contract_v7.json").read_text())
FRAMES=list(range(1298,1306))
HEX=re.compile(r"[0-9a-f]{64}\Z")


class ValidationError(RuntimeError): pass


def digest(path:Path)->str:
    result=hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda:stream.read(1024*1024),b""): result.update(chunk)
    return result.hexdigest()


def table(path:Path,header:str)->list[dict[str,str]]:
    raw=path.read_bytes()
    if b"\r" in raw or b"\x00" in raw: raise ValidationError(f"non-LF CSV: {path}")
    lines=raw.decode().splitlines()
    if not lines or lines[0]!=header: raise ValidationError(f"header: {path}")
    return list(csv.DictReader(lines))


def regular(root:Path,relative:str,size:int)->Path:
    path=root/relative
    if not path.is_file() or path.is_symlink() or path.stat().st_size!=size:
        raise ValidationError(f"required member/size: {relative}")
    return path


def relative_name(value:str)->str:
    path=Path(value)
    if value in ("","-") or path.is_absolute() or ".." in path.parts or len(path.parts)!=1:
        raise ValidationError(f"non-relative artifact path: {value}")
    return value


def validate(package:Path)->dict:
    metadata=json.loads((package/"package.json").read_text())
    engine=metadata["engine"]; capture=metadata["capture"]
    if engine not in ("INTERPRETER","NORMAL_DRC") or capture not in ("on","off"):
        raise ValidationError("package engine/capture")
    if metadata.get("eligible") is not False or metadata.get("status")!="RAW_UNVALIDATED":
        raise ValidationError("premature eligibility/status")
    applied=regular(package,"applied-input.csv",14981)
    if digest(applied)!=CONTRACT["fixture"]["sha256"]: raise ValidationError("applied input differs from fixture")
    capture_root=package/"capture"; video_root=package/"video"
    render=table(capture_root/"render-select.csv",CONTRACT["display"]["render_header"])
    post=table(capture_root/"post-frame.csv",CONTRACT["display"]["post_frame_header"])
    pre=table(capture_root/"fs-preapply.csv",CONTRACT["display"]["preapply_header"])
    bind=table(capture_root/"callback-bind.csv",CONTRACT["display"]["callback_header"])
    front=table(video_root/"video-frames.csv",CONTRACT["display"]["frontend_header"])
    state=table(capture_root/"state-images.csv","frame,space,bytes,path")
    session=table(capture_root/"capture-session.csv","observer_version,start,end,fs_snapshots,fs_errors,sh2_interpreter")
    video_session=table(video_root/"video-session.csv","pixel_format,requests,start,end,errors")
    fixed_render=[row for row in render if int(row["frame"]) in FRAMES]
    if [int(row["frame"]) for row in fixed_render]!=FRAMES: raise ValidationError("v4-7 render cardinality/order")
    if [int(row["frame"]) for row in post]!=FRAMES: raise ValidationError("v4-7 post-frame cardinality/order")
    if [int(row["frame"]) for row in bind if int(row["frame"]) in FRAMES]!=FRAMES: raise ValidationError("v4-2 callback cardinality")
    if [int(row["frame"]) for row in front]!=FRAMES: raise ValidationError("v4-2 frontend callback cardinality")
    page_total=0; binary_total=0; rgb_hashes=[]
    for index,frame in enumerate(FRAMES):
        rr,pr,br,fr=fixed_render[index],post[index],bind[index],front[index]
        if not (rr["retro_run"]==pr["retro_run"]==br["retro_run"]==fr["retro_run"]==str(frame)):
            raise ValidationError("retro_run/frame join")
        if rr["render_ordinal"]!=br["render_ordinal"] or br["callback_ordinal"]!=fr["callback_ordinal"]:
            raise ValidationError("v4-7 render/callback token")
        if not (int(rr["event_order"])<int(pr["event_order"])<int(br["event_order"])):
            raise ValidationError("v4-7 render/post/callback event order")
        if (br["data_nonnull"],br["width"],br["height"],br["pitch"])!=("1","320","224","640"):
            raise ValidationError("v4-3 callback geometry")
        if (fr["data_nonnull"],fr["width"],fr["height"],fr["pitch"],fr["pixel_format"])!=("1","320","224","640","RGB565"):
            raise ValidationError("v4-1/v4-3 frontend geometry")
        for row,prefix in ((rr,"render"),(pr,"post-frame")):
            if row["page_bytes"]!="131072": raise ValidationError("v4-9 page bytes")
            for page in (0,1):
                name=relative_name(row[f"page{page}_path"])
                expected=f"{prefix}-{frame:04d}-page-{page}.bin"
                if name!=expected: raise ValidationError(f"v4-9 page name: {name}")
                regular(capture_root,name,131072); page_total+=1; binary_total+=131072
        if capture=="on":
            if fr["captured"]!="1" or fr["bytes"]!="143360" or not HEX.fullmatch(fr["sha256"]):
                raise ValidationError("v4-3 capture-on metadata")
            name=relative_name(fr["path"]); rgb=regular(video_root,name,143360)
            if digest(rgb)!=fr["sha256"]: raise ValidationError("v4-4 callback hash")
            data=rgb.read_bytes()
            if not data or data==data[:2]*(len(data)//2): raise ValidationError("v4-6 uniform callback")
            binary_total+=143360; rgb_hashes.append(fr["sha256"])
        elif (fr["captured"],fr["bytes"],fr["sha256"],fr["path"])!=("0","0","-","-"):
            raise ValidationError("v4-12 capture-off metadata")
    if len(pre)!=3 or [int(row["frame"]) for row in pre] != [1298,1301,1304]:
        raise ValidationError("v4-7 preapply chronology")
    for ordinal,row in enumerate(pre,1):
        if row["preapply_ordinal"]!=str(ordinal) or row["fen"]!="0" or row["old_fs"]==row["new_fs"]:
            raise ValidationError("v4-7 FS preapply semantics")
        for page in (0,1):
            name=relative_name(row[f"page{page}_path"])
            regular(capture_root,name,131072); page_total+=1; binary_total+=131072
    if page_total!=38: raise ValidationError("both render/post/preapply page cardinality")
    if len(state)!=16: raise ValidationError("state cardinality")
    for row in state:
        size=65536 if row["space"]=="wram" else 262144 if row["space"]=="sdram" else 0
        if not size or int(row["bytes"])!=size: raise ValidationError("state size")
        regular(capture_root,relative_name(row["path"]),size); binary_total+=size
    binary_total+=regular(package,"terminal/terminal-wram.bin",65536).stat().st_size
    binary_total+=regular(package,"terminal/terminal-sdram.bin",262144).stat().st_size
    if len(session)!=1 or session[0]["start"]!="1298" or session[0]["end"]!="1305" or session[0]["fs_snapshots"]!="3" or session[0]["fs_errors"]!="0":
        raise ValidationError("capture session")
    expected_interpreter="1" if engine=="INTERPRETER" else "0"
    if session[0]["sh2_interpreter"]!=expected_interpreter: raise ValidationError("engine flag")
    if len(video_session)!=1 or video_session[0]["pixel_format"]!="RGB565" or video_session[0]["start"]!="1298" or video_session[0]["end"]!="1305" or video_session[0]["errors"]!="0":
        raise ValidationError("video session")
    command_raw=(package/"drc-command.csv").read_text().splitlines()
    if not command_raw or command_raw[0]!="ordinal,frame,event,agent,pc,address,width,value,engine_drc": raise ValidationError("command header")
    command_rows=list(csv.DictReader(row for row in command_raw if not row.startswith("#")))
    commands=[row for row in command_rows if row["event"]=="cmd02"]
    submits=[row for row in command_rows if row["event"]=="submit"]
    acknowledgements=[row for row in command_rows if row["event"]=="ack"]
    if (len(commands)!=67 or len(submits)!=67 or len(acknowledgements)<67 or
            commands[53]["frame"]!="1300" or
            [row["ordinal"] for row in commands] != [str(value) for value in range(1,68)] or
            [row["ordinal"] for row in submits] != [str(value) for value in range(1,68)] or
            any(int(row["ordinal"])<1 or int(row["ordinal"])>67 for row in acknowledgements)):
        raise ValidationError("v4-11 cmd02/ack chronology")
    expected_floor=9076736 if capture=="on" else 7929856
    if binary_total!=expected_floor: raise ValidationError(f"v7 binary floor {binary_total}!={expected_floor}")
    return {"schema":"vrd-vr60-q028-run-validation-v7","status":"PASS_RAW",
            "eligible":False,"package":metadata,"required_binary_bytes":binary_total,
            "render_page_count":16,"all_page_count":38,"rgb_sha256":rgb_hashes,
            "input_equal":"computed-byte-identical"}


def canonical(value:object)->bytes:
    return (json.dumps(value,sort_keys=True,separators=(",",":"))+"\n").encode()


def main()->int:
    parser=argparse.ArgumentParser(description=__doc__); parser.add_argument("package",type=Path)
    parser.add_argument("--output",type=Path,required=True); args=parser.parse_args()
    try:
        result=validate(args.package.resolve())
        with args.output.open("xb") as stream: stream.write(canonical(result))
    except (OSError,ValueError,KeyError,ValidationError) as error:
        print(f"Q-028 run validation FAILED: {error}"); return 1
    print("Q-028 run validation PASS_RAW (not eligible until complete composition audit)"); return 0


if __name__=="__main__": raise SystemExit(main())
