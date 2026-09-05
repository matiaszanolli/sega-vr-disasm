"""Actual source-bound DT mutations; never modify the original passing capture.

Each case is read from sequence zero by the unmodified production reader. EOF
mutants are explicitly constructed truncated artifacts, not acceptance fixtures.
Run only after competing full-map/reader work has finished.
The 29 cases include premature SRAM fetches; unobserved CPU/view combinations
are reported rather than fabricated.
"""
import argparse
from collections import Counter
import copy
import csv
import hashlib
import json
import os
from pathlib import Path
import re
import resource
import shutil
import time

import q028_access_v8 as access


def metadata_fields(fields):
    return None if fields is None else {str(field):value for field,value in fields.items()}


def counters(records):
    result=Counter()
    for row in records:
        if row[10]==255: result[("agent",access.AGENTS[row[11]])]+=1
        else:
            result[(access.CPU_NAMES[row[10]],"fetch" if row[12]&1 else "write" if row[12]&4 else "read")]+=1
    return result


def verify_tail(target, original, header_template, previous, operation, selected_index,
                insertion_index, remove_index, stop_index, replacement=None):
    """Independent inverse-index comparison of serialized records, not writer buffer."""
    paths=access.chunks(target)
    ordinal0=header_template[3]; sequence0=header_template[5]
    count0=len(original)//48
    expected_count=(stop_index if stop_index is not None else count0+int(operation=="duplicate")-int(operation=="missing"))
    target_index=0; selected_occurrences=0
    last_frame=previous[1] if previous else None
    last_order=previous[2] if previous else -1
    for ordinal,path in enumerate(paths[ordinal0-1:],ordinal0):
        with path.open("rb") as stream:
            header=access.HEADER.unpack(stream.read(64))
            count=(path.stat().st_size-64)//48
            assert header[:3]==header_template[:3] and header[3]==ordinal
            assert header[4]==count and header[5]==sequence0+target_index
            assert header[6:]==header_template[6:]
            assert (path.stat().st_size-64)%48==0 and 0<count<=access.CHUNK_RECORDS
            if ordinal<len(paths): assert count==access.CHUNK_RECORDS
            for _ in range(count):
                row=access.RECORD.unpack(stream.read(48))
                # Inverse mapping is deliberately separate from writer iteration.
                index=target_index
                inserted=False
                if operation=="duplicate":
                    inserted=index==insertion_index
                    index=selected_index if inserted else index-int(index>insertion_index)
                elif operation=="missing": index+=int(index>=remove_index)
                elif operation=="reordered":
                    if index==insertion_index: index=selected_index
                    elif insertion_index<index<=selected_index: index-=1
                assert 0<=index<count0
                before=access.RECORD.unpack_from(original,index*48)
                allowed={0,2}
                if operation in ("wrong-value","wrong-address","premature-fetch"):
                    assert row[0]==before[0] and row[2]==before[2]
                if operation=="wrong-value" and index==selected_index:
                    allowed.add(7); assert row[7]==before[7]^1
                if operation=="wrong-address" and index==selected_index:
                    allowed.update((5,6)); assert row[5]==before[5]+2 and row[6]==before[6]+2
                if inserted:
                    allowed.add(9); assert row[9]==before[9]+1
                if operation=="premature-fetch" and index==selected_index:
                    assert set(replacement)=={3,4,5,6,7,8,9,12,13}
                    assert replacement[3]==replacement[5]==replacement[6]==0xC0000000
                    assert replacement[9]==0xFFFF and replacement[12]==25 and replacement[13]==2
                    allowed.update(replacement)
                    assert all(row[field]==value for field,value in replacement.items())
                assert all(row[field]==before[field] for field in range(16) if field not in allowed)
                assert row[0]==sequence0+target_index
                assert row[2]==(last_order+1 if row[1]==last_frame else 0)
                last_frame,last_order=row[1],row[2]
                target_index+=1; selected_occurrences+=int(index==selected_index)
            assert not stream.read(1)
    assert target_index==expected_count
    expected_occurrences=(2 if operation=="duplicate" else 0 if operation in ("missing","eof-before-final-dt") else 1)
    assert selected_occurrences==expected_occurrences
    return {"verified":True,"source_tail_records":count0,"target_tail_records":target_index,
            "selected_source_record_occurrences":selected_occurrences,
            "unchanged_fields":"all except exact declared transformation fields; sequence/order only rederived for structural mutations",
            "method":"serialized target records independently inverse-mapped to original source records"}


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
    site_map=access.load_canonical(args.site_map,"vrd-vr60-q028-static-site-map-v6")
    copies={row["dt_pc"]:row for row in site_map["auxiliary_images"]["sram_copies"]}
    source_paths=access.chunks(args.root)
    # Diagnostic mutation targeting only. Exhaustiveness is checked against the
    # independent full-stream installation counts, not assumed from this window.
    assert len(source_paths)>=4
    tail_paths=source_paths[-4:]
    tail=b"".join(path.read_bytes()[64:] for path in tail_paths)
    tail_header=access.HEADER.unpack(tail_paths[0].read_bytes()[:64])
    first_sequence=tail_header[5]
    assert first_sequence+len(tail)//48==footer["events"]
    groups={}
    for row in access.RECORD.iter_unpack(tail):
        if row[10] not in (1,2) or row[3] not in copies or not row[12]&2: continue
        image=copies[row[3]]
        assert not row[12]&4 and row[13]==2 and row[7]==image["dt_opcode"]
        assert row[5]==image["dt_pc"]&image["dt_address_mask"]
        groups.setdefault((row[10],image["view"]),[]).append(row[0])
    observed_installs=[0,0,0]
    inventory=[]
    for (cpu,view),seqs in sorted(groups.items()):
        image=next(row for row in copies.values() if row["view"]==view)
        assert len(seqs)==image["size"]//4 # One actual install per CPU/view here.
        observed_installs[cpu]+=1
        inventory.append({"cpu":cpu,"view":view,"dt_pc":image["dt_pc"],"records":len(seqs),
                          "first_sequence":seqs[0],"final_sequence":seqs[-1]})
    assert observed_installs==receipt["sram_installs"]==[0,2,2]
    assert {view for _,view in groups}=={2,3,4}
    fetch_candidates={}
    for row in site_map["sites"]:
        if row["site_kind"]!="fetch" or int(row["pc"],16)!=0xC0000000: continue
        for key in groups:
            cpu,view=key
            if row["cpu"]==access.CPU_NAMES[cpu] and row.get("image_view")==view:
                assert key not in fetch_candidates
                image=next(image for image in copies.values() if image["view"]==view)
                assert row["width"]==2 and row["opcode"]==image["bytes"][:4]
                fetch_candidates[key]=row
    assert set(fetch_candidates)==set(groups)
    with (args.root/"host-rewrites-v10.csv").open(newline="") as stream: ledger=list(csv.reader(stream))
    assert ledger[-1][0]=="# COMPLETE"
    assert all(int(row[1])<first_sequence for row in ledger[1:-1])
    all_cases={"unchanged-full-stream-control":("control",None,None,None)}
    for key,seqs in sorted(groups.items()):
        cpu,view=key; prefix=f"cpu{cpu}-view{view}"
        for operation,expected in (("wrong-value","SRAM exact DT reread phase"),
                                   ("wrong-address","SRAM exact DT reread phase"),
                                   ("duplicate","SRAM source-copy transaction/order/value"),
                                   ("missing","SRAM exact DT reread phase"),
                                   ("reordered","cpu instruction context/slot"),
                                   ("premature-fetch","SRAM fetch lacks complete current byte-provenance install"),
                                   ("eof-before-final-dt","incomplete SRAM installation at EOF")):
            all_cases[f"{prefix}-{operation}"]=(operation,key,seqs[-1] if operation.startswith("eof") else seqs[0],expected)
    selected=args.case or list(all_cases)
    assert len(set(selected))==len(selected) and all(name in all_cases for name in selected)
    args.output.mkdir(parents=True,exist_ok=False)
    source_manifest=[]
    for path in source_paths:
        before=path.stat(); digest=access.sha256(path); after=path.stat()
        assert (before.st_ino,before.st_size,before.st_mtime_ns)==(after.st_ino,after.st_size,after.st_mtime_ns)
        source_manifest.append({"path":path.name,"sha256":digest,"device":after.st_dev,
                                "inode":after.st_ino,"bytes":after.st_size,"mtime_ns":after.st_mtime_ns})
    (args.output/"source-chunks.json").write_bytes(access.canonical(source_manifest))
    (args.output/"target-inventory.json").write_bytes(access.canonical({"groups":inventory,
        "full_stream_installs":observed_installs,
        "unobserved_cpu_view_pairs":[[cpu,view] for cpu in (1,2) for view in (2,3,4) if (cpu,view) not in groups],
        "scope":"actual mutation targeting; unobserved combinations covered by standalone parity only"}))
    old_counts=counters(access.RECORD.iter_unpack(tail))
    previous=access.RECORD.unpack(source_paths[-5].read_bytes()[-48:]) if len(source_paths)>4 else None
    results=[]
    for name in selected:
        operation,key,sequence,expected=all_cases[name]
        target=args.output/name; target.mkdir()
        changed=copy.deepcopy(footer); expected_files={}
        if operation=="control":
            for path in source_paths: os.link(path,target/path.name)
            transformation={"operation":"none","constructed_truncation":False}
        else:
            index=sequence-first_sequence
            selected_record=access.RECORD.unpack_from(tail,index*48)
            assert selected_record[0]==sequence and selected_record[10]==key[0]
            image=copies[selected_record[3]]
            assert image["view"]==key[1]
            insertion=None; remove=None; patch=None; stop=None; replacement=None
            if operation in ("wrong-value","wrong-address"):
                patch=list(selected_record)
                if operation=="wrong-value": patch[7]^=1
                else: patch[5]+=2; patch[6]+=2
            elif operation=="premature-fetch":
                candidate=fetch_candidates[key]
                # q028_access_v8.read_events performs static/slot/opcode joins
                # before ImageState.fetch. ImageState.data cleared active at
                # first source read and activates it only at the last DT.
                replacement={3:0xC0000000,4:candidate["opcode_hash32"],5:0xC0000000,6:0xC0000000,
                             7:int(candidate["opcode"],16),8:candidate["runtime_index"],9:0xFFFF,12:25,13:2}
                patch=list(selected_record)
                for field,value in replacement.items(): patch[field]=value
            elif operation=="duplicate":
                extra=list(selected_record); extra[9]+=1
                insertion=(index+1,extra)
            elif operation=="missing": remove=index
            elif operation=="reordered":
                candidates=[]
                for i in range(max(0,index-16),index):
                    row=access.RECORD.unpack_from(tail,i*48)
                    if row[10]==key[0] and row[3]==image["write_pc"] and row[12]&4 and row[5]==image["destination"]:
                        candidates.append(i)
                assert len(candidates)==1
                insertion=(candidates[0],list(selected_record)); remove=index
            elif operation=="eof-before-final-dt": stop=index
            output=bytearray(); next_sequence=first_sequence
            last_frame=previous[1] if previous else None; last_order=previous[2] if previous else -1
            def append(row):
                nonlocal next_sequence,last_frame,last_order
                row=list(row); row[0]=next_sequence
                row[2]=last_order+1 if row[1]==last_frame else 0
                output.extend(access.RECORD.pack(*row))
                next_sequence+=1; last_frame=row[1]; last_order=row[2]
            for i,row in enumerate(access.RECORD.iter_unpack(tail)):
                if stop is not None and i==stop: break
                if insertion is not None and i==insertion[0]: append(insertion[1])
                if remove is not None and i==remove: continue
                append(patch if patch is not None and i==index else row)
            for path in source_paths[:-4]: os.link(path,target/path.name)
            tail_ordinal=len(source_paths)-3
            for offset in range(0,len(output),access.CHUNK_RECORDS*48):
                payload=output[offset:offset+access.CHUNK_RECORDS*48]
                header=list(tail_header); header[3]=tail_ordinal; header[4]=len(payload)//48
                header[5]=first_sequence+offset//48
                path=target/f"access-events-v8-{tail_ordinal:04d}.bin"
                expected_bytes=access.HEADER.pack(*header)+payload
                with path.open("xb") as stream: stream.write(expected_bytes)
                assert path.read_bytes()==expected_bytes
                expected_files[path.name]=hashlib.sha256(expected_bytes).hexdigest()
                tail_ordinal+=1
            changed["events"]=next_sequence; changed["chunks"]=tail_ordinal-1
            if stop is not None: changed["frames"]=last_frame+1
            new_counts=counters(access.RECORD.iter_unpack(output))
            for cpu in ("m68k","master","slave"):
                for kind in ("fetch","read","write"):
                    changed["cpu_counts"][cpu][kind]+=new_counts[cpu,kind]-old_counts[cpu,kind]
            for agent in access.AGENTS.values():
                changed["agent_counts"][agent]["records"]+=new_counts["agent",agent]-old_counts["agent",agent]
            transformation={"operation":operation,"cpu":key[0],"view":key[1],"target_sequence":sequence,
                "original_record":list(selected_record),"patch_record_before_resequence":patch,
                "insert_before_tail_index":insertion[0] if insertion else None,"removed_tail_index":remove,
                "stop_before_tail_index":stop,"constructed_truncation":stop is not None,
                "sequence_and_within_frame_order_recomputed_from":first_sequence,
                "explicit_replacement_fields":metadata_fields(replacement),
                "expected_changed_chunk_sha256":expected_files}
            if replacement is not None:
                transformation["source_static_candidate"]=fetch_candidates[key]
                transformation["expected_rejection_chain"]="static-site/fetch-slot/opcode joins pass; ImageState.fetch rejects active=0 before final DT"
            transformation["independent_record_comparison"]=verify_tail(
                target,tail,tail_header,previous,operation,index,
                insertion[0] if insertion else None,remove,stop,replacement)
            del output
        shutil.copyfile(args.root/"bootstrap-images-v10.json",target/"bootstrap-images-v10.json")
        (target/"access-footer-v8.json").write_bytes(access.canonical(changed))
        with (target/"host-rewrites-v10.csv").open("w",newline="") as stream:
            writer=csv.writer(stream,lineterminator="\n"); writer.writerows(ledger[:-1])
            writer.writerow(["# COMPLETE",f"events={changed['events']}",f"frames={changed['frames']}",
                             f"count={len(ledger)-2}",f"last_boundary={changed['host_rewrites']['last_boundary']}"])
        (target/"transformation.json").write_bytes(access.canonical(transformation))
        print(f"START {name}: production reader from sequence zero, events={changed['events']}",flush=True)
        started=time.monotonic(); failure=None; stats=None
        try: stats,_=access.read_events(target,site_map)
        except access.AccessError as error: failure=str(error)
        passed=failure is None if expected is None else failure is not None and re.search(expected,failure) is not None
        if expected is None and passed:
            passed=stats["event_count"]==footer["events"] and stats["sram_installs"]==receipt["sram_installs"]
        for row in source_manifest:
            st=(args.root/row["path"]).stat()
            assert (st.st_dev,st.st_ino,st.st_size,st.st_mtime_ns)==(row["device"],row["inode"],row["bytes"],row["mtime_ns"])
            target_path=target/row["path"]
            if row["path"] in expected_files: assert access.sha256(target_path)==expected_files[row["path"]]
            elif target_path.exists():
                mt=target_path.stat()
                assert (mt.st_dev,mt.st_ino,mt.st_size,mt.st_mtime_ns)==(st.st_dev,st.st_ino,st.st_size,st.st_mtime_ns)
        result={"case":name,"status":"PASS_DECLARED_ACTUAL_DT_MUTATION" if passed else "FAIL",
                "actual_error":failure,"expected_error_regex":expected,"events":changed["events"],
                "source_events":footer["events"],"wall_seconds":time.monotonic()-started,
                "peak_rss_bytes":resource.getrusage(resource.RUSAGE_SELF).ru_maxrss*1024,
                "constructed_positive_control":expected is None,"eligible":False,
                "source_chunks_manifest_sha256":access.sha256(args.output/"source-chunks.json"),
                "transformation_sha256":access.sha256(target/"transformation.json")}
        (target/"mutation-result.json").write_bytes(access.canonical(result))
        print(json.dumps(result,sort_keys=True),flush=True); results.append(result)
        if not passed: raise AssertionError(result)
    (args.output/"results.json").write_bytes(access.canonical({
        "status":"PASS_SELECTED_ACTUAL_DT_MUTATIONS_ONLY","results":results,
        "unobserved_cpu_view_pairs":[[cpu,view] for cpu in (1,2) for view in (2,3,4) if (cpu,view) not in groups]}))


if __name__=="__main__": main()
