"""Probe independent WRAM EOF rejection using actual boot-copy prefixes.

This is a diagnostic mutation, never a complete fixture or pilot acceptance.
No captured raw record is rewritten; the two mutants end after an actual copy
read and after the matching entire boot installation respectively.
"""
import argparse
from collections import Counter
import csv
import json
from pathlib import Path
import shutil

import q028_access_v8 as access


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root",required=True,type=Path)
    parser.add_argument("--site-map",required=True,type=Path)
    parser.add_argument("--output",required=True,type=Path)
    parser.add_argument("--expect-rejection",action="store_true")
    args=parser.parse_args()
    receipt=access.load_canonical(args.root/"actual-binary-validation.json")
    assert receipt["status"]=="PASS_DIAGNOSTIC_STREAM_ONLY"
    assert receipt["site_map_sha256"]==access.sha256(args.site_map)
    site_map=access.load_canonical(args.site_map,"vrd-vr60-q028-static-site-map-v6")
    image=next(row for row in site_map["auxiliary_images"]["wram_copies"] if row["view"]==5)
    first=access.chunks(args.root)[0].read_bytes()
    header=list(access.HEADER.unpack(first[:64]))
    records=list(access.RECORD.iter_unpack(first[64:]))
    starts=[i for i,r in enumerate(records) if r[10]==0 and r[3]==image["copy_pcs"][0]
            and r[5]==image["source"] and r[13]==4 and r[12]&2 and not r[12]&4]
    assert len(starts)==1
    start=starts[0]
    ends=[i for i,r in enumerate(records) if i>start and r[10]==0 and r[3]==image["copy_pcs"][-1]
          and r[5]==image["destination"]+image["copy_size"]-4 and r[13]==4 and r[12]&4]
    assert len(ends)==1
    args.output.mkdir(parents=True,exist_ok=False)
    results=[]
    for name,end,expected_installs in (("interrupted-after-source-read",start+1,0),
                                      ("complete-boot-copy-control",ends[0]+1,1)):
        target=args.output/name; target.mkdir()
        subset=records[:end]
        patched_header=list(header); patched_header[4]=end
        (target/"access-events-v8-0001.bin").write_bytes(access.HEADER.pack(*patched_header)+first[64:64+48*end])
        retained_payload=(target/"access-events-v8-0001.bin").read_bytes()[64:]
        original_prefix=first[64:64+48*end]
        same_records=retained_payload==original_prefix
        assert same_records and len(retained_payload)==48*end
        shutil.copyfile(args.root/"bootstrap-images-v10.json",target/"bootstrap-images-v10.json")
        footer=access.load_canonical(args.root/"access-footer-v8.json")
        footer.update(events=end,chunks=1,frames=subset[-1][1]+1,host_rewrites={"count":0,"last_boundary":0})
        counts=Counter((access.CPU_NAMES[r[10]],"fetch" if r[12]&1 else "write" if r[12]&4 else "read") for r in subset)
        for cpu in ("m68k","master","slave"):
            footer["cpu_counts"][cpu]={kind:counts[cpu,kind] for kind in ("fetch","read","write")}
        agent_counts=Counter(r[11] for r in subset if r[10]==255)
        for agent,label in access.AGENTS.items(): footer["agent_counts"][label]["records"]=agent_counts[agent]
        footer.update(idl_reads=sum(r[10]==255 and r[11]==1 and not r[12]&4 for r in subset),
                      idl_writes=sum(r[10]==255 and r[11]==1 and bool(r[12]&4) for r in subset))
        # The forged completion assertion is precisely what the independent state
        # must not trust. Neither prefix is presented as a complete IDL fixture.
        footer["no_open_context"]=True
        (target/"access-footer-v8.json").write_bytes(access.canonical(footer))
        with (target/"host-rewrites-v10.csv").open("w",newline="") as stream:
            writer=csv.writer(stream,lineterminator="\n")
            writer.writerow(["ordinal","before_sequence","frame","cpu","pc","old_word","new_word","operation","source"])
            writer.writerow(["# COMPLETE",f"events={end}",f"frames={footer['frames']}","count=0","last_boundary=0"])
        error=None; stats=None
        try: stats,_=access.read_events(target,site_map)
        except access.AccessError as failure: error=str(failure)
        if stats is not None:
            assert stats["event_count"]==end and stats["wram_installs"]==expected_installs
            footer["comm"]=stats["comm"]
            (target/"access-footer-v8.json").write_bytes(access.canonical(footer))
            # Recheck the final retained structurally consistent artifact.
            stats,_=access.read_events(target,site_map)
            assert stats["event_count"]==end
        result={"case":name,"events":end,"error":error,"reader_returned":stats is not None,
                "wram_installs":stats["wram_installs"] if stats else None,
                "source_raw_sha256":access.sha256(access.chunks(args.root)[0]),
                "record_bytes_unchanged":same_records,
                "record_proof":"exact target record payload equals original prefix",
                "constructed_prefix_control":True,"forged_no_open_context":True,"eligible":False}
        (target/"diagnostic-result.json").write_bytes(access.canonical(result))
        results.append(result); print(json.dumps(result,sort_keys=True),flush=True)
        if name=="complete-boot-copy-control": assert error is None
        elif args.expect_rejection: assert error=="incomplete WRAM installation at EOF"
    status="DEMONSTRATED_INDEPENDENT_WRAM_EOF_GAP" if results[0]["reader_returned"] else "INDEPENDENT_WRAM_EOF_REJECTED"
    (args.output/"result.json").write_bytes(access.canonical({"status":status,"eligible":False,"results":results}))
    print(status,flush=True)


if __name__=="__main__": main()
