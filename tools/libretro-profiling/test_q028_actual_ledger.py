"""Retained mutations of a valid actual 400-frame stream, full production reader.

Run explicitly with --root, --site-map and --output; no fabricated raw event and
no shortened/checkpoint replay. Each case gets a fresh production reader state.
"""
import argparse
import csv
import copy
import json
import os
from pathlib import Path
import re
import resource
import shutil
import time

import q028_access_v8 as access


def cases(original, footer):
    result = {}
    def changed(name, column, value, message):
        rows=copy.deepcopy(original); rows[0][column]=str(value)
        result[name]=(rows,message)
    for name,column,value,message in (
        ("install-earlier",1,int(original[0][1])-1,"immediately preceding"),
        ("install-after-other-event",1,int(original[0][1])+1,"immediately preceding"),
        ("install-wrong-frame",2,int(original[0][2])-1,"ordinal/frame/boundary"),
        ("install-wrong-cpu",3,1,"ordinal/frame/boundary"),
        ("install-unregistered-pc",4,"0x00880001","unregistered source/image PC"),
        ("install-wrong-old",5,"0x66F8","immediately preceding"),
        ("install-wrong-new",6,"0xFFFF","immediately preceding"),
        ("install-wrong-source",8,"unreviewed-source","immediately preceding"),
        ("orphan-restore",7,"restore","restore source/current-image")):
        changed(name,column,value,message)
    rows=copy.deepcopy(original); rows.insert(1,copy.deepcopy(rows[0]))
    for index,row in enumerate(rows): row[0]=str(index)
    result["duplicate-install"]=(rows,"immediately preceding")
    rows=copy.deepcopy(original); rows[0],rows[1]=rows[1],rows[0]
    for index,row in enumerate(rows): row[0]=str(index)
    result["reordered-installs"]=(rows,"fake opcode lacks current|ordinal/frame/boundary|unconsumed host ledger boundary")
    rows=copy.deepcopy(original[1:])
    for index,row in enumerate(rows): row[0]=str(index)
    result["missing-install"]=(rows,"fake opcode lacks current")
    # The first installed ROM branch remains active (unlike a mutable WRAM view).
    # Add a source-legal teardown action at EOF, preserving every raw byte.
    restore=[str(len(original)),str(footer["events"]),str(footer["frames"]),"0",
             original[0][4],original[0][6],original[0][5],"restore","sek-finish-idle-after-expression"]
    rows=copy.deepcopy(original)+[restore]
    result["valid-eof-restore"]=(rows,None)
    bad=copy.deepcopy(rows); bad[-1][1]=str(footer["events"]+1)
    result["restore-beyond-eof"]=(bad,"beyond EOF/unconsumed")
    bad=copy.deepcopy(rows); bad[-1][2]=str(footer["frames"]-1)
    result["restore-wrong-eof-frame"]=(bad,"restore source/current-image")
    bad=copy.deepcopy(rows); bad[-1][5]="0x73F8"
    result["restore-wrong-old"]=(bad,"restore source/current-image")
    bad=copy.deepcopy(rows); bad[-1][6]="0x66F8"
    result["restore-wrong-new"]=(bad,"restore source/current-image")
    bad=copy.deepcopy(rows); bad[-1][8]="before-incomplete-expression"
    result["restore-wrong-source"]=(bad,"restore source/current-image")
    return result


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root",type=Path,required=True)
    parser.add_argument("--site-map",type=Path,required=True)
    parser.add_argument("--output",type=Path,required=True)
    parser.add_argument("--case",action="append")
    args=parser.parse_args()
    receipt=access.load_canonical(args.root/"actual-binary-validation.json")
    assert receipt["status"]=="PASS_DIAGNOSTIC_STREAM_ONLY" and receipt["frames"]==400
    assert receipt["site_map_sha256"]==access.sha256(args.site_map)
    footer=access.load_canonical(args.root/"access-footer-v8.json")
    with (args.root/"host-rewrites-v10.csv").open(newline="") as stream:
        ledger=list(csv.reader(stream))
    assert ledger[-1][0]=="# COMPLETE" and len(ledger)>2
    original=ledger[1:-1]
    available=cases(original,footer)
    selected=args.case or list(available)
    assert len(set(selected))==len(selected) and all(name in available for name in selected)
    args.output.mkdir(parents=True,exist_ok=False)
    source_chunks=[]
    for chunk in access.chunks(args.root):
        before=chunk.stat(); digest=access.sha256(chunk); after=chunk.stat()
        assert (before.st_dev,before.st_ino,before.st_size,before.st_mtime_ns)==(after.st_dev,after.st_ino,after.st_size,after.st_mtime_ns)
        source_chunks.append({"path":chunk.name,"bytes":after.st_size,"sha256":digest,
                              "device":after.st_dev,"inode":after.st_ino,"mtime_ns":after.st_mtime_ns})
    (args.output/"source-chunks.json").write_bytes(access.canonical(source_chunks))
    site_map=access.load_canonical(args.site_map,"vrd-vr60-q028-static-site-map-v6")
    results=[]
    for name in selected:
        rows,expected=available[name]
        target=args.output/name; target.mkdir()
        for chunk in source_chunks: os.link(args.root/chunk["path"],target/chunk["path"])
        shutil.copyfile(args.root/"bootstrap-images-v10.json",target/"bootstrap-images-v10.json")
        changed=copy.deepcopy(footer)
        changed["host_rewrites"]={"count":len(rows),"last_boundary":int(rows[-1][1]) if rows else 0}
        (target/"access-footer-v8.json").write_bytes(access.canonical(changed))
        with (target/"host-rewrites-v10.csv").open("w",newline="") as stream:
            writer=csv.writer(stream,lineterminator="\n")
            writer.writerow(ledger[0]); writer.writerows(rows)
            writer.writerow(["# COMPLETE",f"events={footer['events']}",f"frames={footer['frames']}",
                             f"count={len(rows)}",f"last_boundary={changed['host_rewrites']['last_boundary']}"])
        print(f"START {name}: full {footer['events']} event source",flush=True)
        started=time.monotonic(); failure=None; stats=None
        try: stats,_=access.read_events(target,site_map)
        except access.AccessError as error: failure=str(error)
        passed=(failure is None if expected is None else failure is not None and re.search(expected,failure) is not None)
        if expected is None and passed:
            passed=stats["event_count"]==footer["events"] and stats["host_rewrites"]==changed["host_rewrites"]
        same_raw=True
        for chunk in source_chunks:
            source_stat=(args.root/chunk["path"]).stat(); target_stat=(target/chunk["path"]).stat()
            expected_stat=(chunk["device"],chunk["inode"],chunk["bytes"],chunk["mtime_ns"])
            same_raw &= expected_stat==(source_stat.st_dev,source_stat.st_ino,source_stat.st_size,source_stat.st_mtime_ns)
            same_raw &= expected_stat==(target_stat.st_dev,target_stat.st_ino,target_stat.st_size,target_stat.st_mtime_ns)
        assert same_raw
        outcome={"case":name,"status":"PASS_DECLARED_ACTUAL_LEDGER_MUTATION" if passed else "FAIL",
                 "expected_error_regex":expected,"actual_error":failure,"wall_seconds":time.monotonic()-started,
                 "peak_rss_bytes":resource.getrusage(resource.RUSAGE_SELF).ru_maxrss*1024,
                 "raw_source":str(args.root),"raw_events":footer["events"],
                 "raw_bytes_unchanged":same_raw,"raw_proof":"source digest plus exact device/inode/size/mtime bijection",
                 "source_chunks_manifest_sha256":access.sha256(args.output/"source-chunks.json"),
                 "constructed_positive_control":expected is None,"organic_teardown_capture":False,
                 "site_map_sha256":receipt["site_map_sha256"],
                 "ledger_sha256":access.sha256(target/"host-rewrites-v10.csv")}
        (target/"mutation-result.json").write_bytes(access.canonical(outcome))
        print(json.dumps(outcome,sort_keys=True),flush=True)
        results.append(outcome)
        if not passed: raise AssertionError(outcome)
    (args.output/"results.json").write_bytes(access.canonical({"status":"PASS_SELECTED_ACTUAL_LEDGER_MUTATIONS_ONLY","results":results}))


if __name__=="__main__": main()
