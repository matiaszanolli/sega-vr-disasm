#!/usr/bin/env python3
"""Shared Q-028 v8 binary access reader and resource-pilot validator."""

from __future__ import annotations

import argparse
import csv
import gzip
import hashlib
import json
import os
import re
import resource
import struct
import tarfile
import time
from collections import Counter
from pathlib import Path

from q028_image_state import ImageState, ImageStateError, CommState, IdleState
import prepare_q028_picodrive as prepare
import q028_image_domains as image_domains


HEADER = struct.Struct("<8sIIIIQ8s8s8s8s")
RECORD = struct.Struct("<QIIIIIIIIHBBBBBB")
MAGIC = b"VRDQA8\0\0"
CHUNK_RECORDS = 250_000
PILOT_EVENT_CAP = 1_500_000_000
PILOT_CHUNK_CAP = 6_000
PILOT_CHUNK_BYTES = 12_000_064
PILOT_UNCOMPRESSED_CAP = 85_899_345_920
PILOT_COMPRESSED_CAP = 85_899_345_920
PILOT_MEMBER_CAP = 20_000
QUARANTINE_TOKEN = "Q028_RESOURCE_PILOT_V9"
CPU_NAMES = {0:"m68k",1:"master",2:"slave",255:"noncpu"}
AGENTS = {1:"idl",2:"master_dmac0",3:"master_dmac1",4:"slave_dmac0",
          5:"slave_dmac1",6:"master_dreq0",7:"slave_dreq0",
          8:"master_dreq1",9:"slave_dreq1",10:"bridge"}


class AccessError(RuntimeError): pass


def canonical(value: object) -> bytes:
    return (json.dumps(value,sort_keys=True,separators=(",",":"))+"\n").encode()


def sha256(path: Path) -> str:
    h=hashlib.sha256()
    with path.open("rb") as f:
        for b in iter(lambda:f.read(1024*1024),b""): h.update(b)
    return h.hexdigest()


def load_canonical(path: Path, schema: str | None=None) -> dict:
    raw=path.read_bytes(); value=json.loads(raw)
    if raw!=canonical(value): raise AccessError(f"noncanonical JSON: {path.name}")
    if schema and value.get("schema")!=schema: raise AccessError(f"schema: {path.name}")
    return value


def chunks(root: Path) -> list[Path]:
    paths=sorted(root.glob("access-events-v8-*.bin"))
    if not paths or len(paths)>PILOT_CHUNK_CAP: raise AccessError("chunk cardinality")
    if paths != [root/f"access-events-v8-{i:04d}.bin" for i in range(1,len(paths)+1)]:
        raise AccessError("chunk ordinal/path sequence")
    return paths


def validate_toolchain(path: Path) -> dict:
    """Join retained build inputs and both compiled outputs to actual files."""
    toolchain=load_canonical(path,"vrd-vr60-q028-clean-build-pair-v9")
    if (toolchain.get("source_pack_sha256") != "745cfa19aaca095412fa33e3b402bc471ba70fbe7185328a322325dd06b85c18"
            or toolchain.get("picodrive_commit") != "26ecb2b6358fefba24e3d68b9eb2efba7f10d5ee"
            or toolchain.get("offline_source_pack_verified") is not True
            or toolchain.get("recursive_git_closure_complete") is not True):
        raise AccessError("toolchain pinned source closure identity")
    repo=Path(__file__).resolve().parents[2]
    required={"q028_owner_analysis.py","q028_image_domains.py","q028_image_state.py",
              "q028_access_v8.py","q028_phase1_gate.py","prepare_q028_picodrive.py",
              "q028_materialize_picodrive.py","q028_all_access_observer.inc",
              "q028_static_site_map.inc","profiling_frontend.c"}
    required_paths={f"tools/libretro-profiling/{name}" for name in required}
    required_paths.update(image_domains.PRESENTATION_POSTIMAGES)
    required_paths.add(str(image_domains.FINITE_INVENTORY.relative_to(repo)))
    required={Path(name).name for name in required_paths}
    rows=toolchain.get("tool_inputs",[])
    if len(rows)!=len(required) or {Path(row["path"]).name for row in rows}!=required:
        raise AccessError("toolchain input dependency cardinality")
    for row in rows:
        name=Path(row["path"]).name
        if row["path"] not in required_paths or row["snapshot"]!=f"tool-inputs/{name}":
            raise AccessError("toolchain input dependency path")
        for actual in (repo/row["path"],path.parent/row["snapshot"]):
            if actual.stat().st_size!=row["bytes"] or sha256(actual)!=row["sha256"]:
                raise AccessError("actual tool/snapshot identity join")
    builds=toolchain.get("builds",[])
    if len(builds)!=2 or not toolchain.get("clean_build_pair_equal"):
        raise AccessError("toolchain clean build pair")
    for index,build in enumerate(builds):
        for kind in ("core","frontend"):
            actual=Path(build[kind])
            if actual.stat().st_size!=build[f"{kind}_bytes"] or sha256(actual)!=build[f"{kind}_sha256"]:
                raise AccessError("actual compiled output identity")
        source=Path(build["core"]).parent
        expected_postimages={**prepare.SOURCE_SHA256,
            "platform/libretro/q028_all_access_observer.inc":prepare.OBSERVER_SHA256,
            "platform/libretro/q028_static_site_map.inc":prepare.SITE_MAP_SHA256}
        if (len(build["postimages"])!=len(expected_postimages) or
                {row["path"]:row["sha256"] for row in build["postimages"]}!=expected_postimages):
            raise AccessError("toolchain reviewed overlay postimage bijection")
        for row in build["postimages"]:
            relative=Path(row["path"])
            if relative.is_absolute() or ".." in relative.parts or sha256(source/relative)!=row["sha256"]:
                raise AccessError("actual core source postimage identity")
        if index and any(build[field]!=builds[0][field] for field in
                ("core_sha256","core_bytes","frontend_sha256","frontend_bytes","postimages")):
            raise AccessError("actual clean build pair mismatch")
    return toolchain


def read_host_ledger(path: Path, footer: dict):
    with path.open(newline="") as stream:
        reader=csv.reader(stream)
        if next(reader,None)!=["ordinal","before_sequence","frame","cpu","pc","old_word","new_word","operation","source"]:
            raise AccessError("host ledger CSV header")
        count=0; boundary=0
        for row in reader:
            if row and row[0]=="# COMPLETE":
                if (row!=["# COMPLETE",f"events={footer['events']}",f"frames={footer['frames']}",
                          f"count={count}",f"last_boundary={boundary}"] or next(reader,None) is not None):
                    raise AccessError("host ledger terminal/cardinality")
                return
            if len(row)!=9: raise AccessError("host ledger row shape")
            try: values=tuple(int(value,16 if i in (4,5,6) else 10) for i,value in enumerate(row[:7]))
            except ValueError as error: raise AccessError("host ledger number") from error
            if any(value<0 for value in values) or values[5]>65535 or values[6]>65535:
                raise AccessError("host ledger numeric range")
            count+=1; boundary=values[1]
            yield (*values,row[7],row[8])
        raise AccessError("host ledger missing terminal")


def terminal_frames(footer: dict) -> int:
    frames=footer.get("frames")
    if type(frames) is not int or not 1<=frames<=1340:
        raise AccessError("footer terminal frame interval")
    return frames


def read_events(root: Path, site_map: dict) -> tuple[dict,list[str]]:
    state = ImageState(site_map["auxiliary_images"])
    idle=IdleState(state,site_map["sites"])
    footer=load_canonical(root/"access-footer-v8.json","vrd-vr60-q028-access-footer-v8")
    frame_limit=terminal_frames(footer)
    ledger=read_host_ledger(root/"host-rewrites-v10.csv",footer)
    pending=next(ledger,None); previous_event=None
    comm = CommState(); command_rows = []
    bios = load_canonical(root/"bootstrap-images-v10.json", "vrd-vr60-q028-bootstrap-images-v10")
    if (bios.get("bios_null") is not True or bios.get("cartridge") is not True or
            bios.get("images") != {cpu: row["bytes"] for cpu, row in site_map["auxiliary_images"]["images"].items()}):
        raise AccessError("runtime bootstrap image/recipe mismatch")
    actual_rom = sha256(Path(__file__).resolve().parents[2]/"build/vr_rebuild.32x")
    actual_analyzer = sha256(Path(__file__).with_name("q028_owner_analysis.py"))
    if site_map["ordinary_rom_sha256"] != actual_rom or site_map["analyzer_sha256"] != actual_analyzer:
        raise AccessError("actual ROM/analyzer/site-map identity join")
    dependencies=[{"path":"tools/libretro-profiling/q028_image_domains.py",
                   "sha256":sha256(Path(image_domains.__file__))},
                  {"path":str(image_domains.FINITE_INVENTORY.relative_to(Path(__file__).resolve().parents[2])),
                   "sha256":image_domains.FINITE_INVENTORY_SHA256}] + [
                  {"path":path,"sha256":expected} for path,expected in
                  sorted(image_domains.PRESENTATION_POSTIMAGES.items())]
    if site_map.get("analyzer_dependencies") != dependencies:
        raise AccessError("actual analyzer helper dependency join")
    for dependency in dependencies:
        if sha256(Path(__file__).resolve().parents[2]/dependency["path"]) != dependency["sha256"]:
            raise AccessError("actual analyzer dependency artifact identity")
    expected_prefixes = (bytes.fromhex(actual_rom)[:8], bytes.fromhex(actual_analyzer)[:8],
                         hashlib.sha256(canonical(site_map)).digest()[:8])
    site_count=site_map["site_count"]
    sequence=0; counts=Counter(); seen_dynamic=set(); dynamic=set(site_map["dynamic_site_ids"])
    site_rows=site_map["sites"]
    if len(site_rows)!=site_count or any(row.get("runtime_index")!=i for i,row in enumerate(site_rows,1)):
        raise AccessError("static site-map dense-index bijection")
    paths=chunks(root); chunk_rows=[]; prior_order=None; cpu_instances=[0,0,0]
    cpu_live=[False]*3; cpu_pc=[0]*3; cpu_next_slot=[0]*3; cpu_view=[0]*3; cpu_hash=[0]*3
    idl=[]; identity_prefixes=None
    for ordinal,path in enumerate(paths,1):
        size=path.stat().st_size
        if size> PILOT_CHUNK_BYTES or size<64 or (size-64)%48: raise AccessError(f"chunk size: {path.name}")
        with path.open("rb") as stream:
            header=HEADER.unpack(stream.read(64))
            magic,version,record_size,stored_ordinal,declared,first,*header_prefixes=header
            if (magic,version,record_size,stored_ordinal,first)!=(MAGIC,8,48,ordinal,sequence):
                raise AccessError(f"chunk header: {path.name}")
            actual=(size-64)//48
            if actual!=declared or actual>(CHUNK_RECORDS): raise AccessError(f"chunk record count: {path.name}")
            current_prefixes=tuple(header_prefixes[:3])
            if current_prefixes != expected_prefixes: raise AccessError("chunk actual-input identity prefix")
            if any(prefix==b"\0"*8 for prefix in current_prefixes): raise AccessError("zero header identity prefix")
            if identity_prefixes is None: identity_prefixes=current_prefixes
            elif identity_prefixes!=current_prefixes: raise AccessError("chunk identity prefix drift")
            if header[-1]!=b"\0"*8: raise AccessError("nonzero chunk reserved bytes")
            if ordinal<len(paths) and actual!=CHUNK_RECORDS: raise AccessError("short interior chunk")
            for _ in range(actual):
                row=RECORD.unpack(stream.read(48))
                (seq,frame,order,pc,opcode_hash,raw,normalized,value,site,slot,
                 cpu,agent,flags,width,irq,reserved)=row
                if seq!=sequence: raise AccessError("sequence gap/duplicate")
                while pending is not None and pending[1]==sequence:
                    try: idle.apply(pending,previous_event,frame)
                    except ImageStateError as error: raise AccessError(str(error)) from error
                    pending=next(ledger,None)
                if pending is not None and pending[1]<sequence: raise AccessError("unconsumed host ledger boundary")
                if frame>=frame_limit: raise AccessError("event frame outside declared terminal interval")
                if prior_order is not None and frame<prior_order[0]: raise AccessError("frame regression")
                if prior_order is not None and frame==prior_order[0] and order!=prior_order[1]+1: raise AccessError("within-frame order")
                if prior_order is None or frame!=prior_order[0]:
                    if order!=0: raise AccessError("frame order reset")
                prior_order=(frame,order)
                if reserved or flags & ~31: raise AccessError("record reserved field/flag")
                is_fetch=bool(flags&1); is_data=bool(flags&2); write=bool(flags&4); read=bool(flags&8); attributed=bool(flags&16)
                if is_fetch==is_data or write==read: raise AccessError("kind flags")
                if (is_data and width not in (1,2,4)) or (is_fetch and not 1<=width<=10):
                    raise AccessError("record width")
                if cpu==255:
                    if site or slot!=0xffff or agent not in AGENTS or not attributed:
                        raise AccessError("noncpu site/agent contract")
                    counts[f"agent:{AGENTS[agent]}"]+=1
                    counts[f"agent:{AGENTS[agent]}:{'write' if write else 'read'}"]+=1
                    if agent==1: idl.append((raw,normalized,value,width,write))
                elif cpu in (0,1,2):
                    if agent or not (1<=site<=site_count) or not attributed: raise AccessError("cpu site contract")
                    site_row=site_rows[site-1]
                    if site_row["classification"] == "synthetic-reserved":
                        raise AccessError("synthetic reserved site")
                    if (site_row["cpu"]!=CPU_NAMES[cpu] or int(site_row["pc"],16)!=pc or
                        site_row["site_kind"]!=("fetch" if is_fetch else "data") or
                        site_row["access"]!=("write" if write else "read") or
                        site_row["width"]!=width or site_row["opcode_hash32"]!=opcode_hash):
                        raise AccessError("CPU record/static-site join")
                    if is_fetch:
                        if slot!=0xffff: raise AccessError("fetch slot")
                        if value != int(site_row["opcode"][:4],16): raise AccessError("actual fetch opcode/static bytes")
                        try:
                            if cpu==0: idle.fetch(pc,value,site_row)
                            else: state.fetch(cpu,pc,value,site_row.get("image_view",0),site_row)
                        except ImageStateError as error: raise AccessError(str(error)) from error
                        cpu_instances[cpu]+=1; cpu_live[cpu]=True; cpu_pc[cpu]=pc; cpu_next_slot[cpu]=0
                        cpu_view[cpu]=site_row.get("image_view",0); cpu_hash[cpu]=opcode_hash
                        counts[f"cpu:{CPU_NAMES[cpu]}:fetch"]+=1
                    else:
                        if site_row["classification"] == "synthetic-reset-vector":
                            try: state.reset_read(cpu,pc,raw,width,value,slot,write)
                            except ImageStateError as error: raise AccessError(str(error)) from error
                        else:
                            if (not cpu_live[cpu] or pc!=cpu_pc[cpu] or slot!=cpu_next_slot[cpu]
                                    or site_row.get("image_view",0)!=cpu_view[cpu] or opcode_hash!=cpu_hash[cpu]):
                                raise AccessError("cpu instruction context/slot")
                            cpu_next_slot[cpu]+=1
                            try:
                                idle.before_data(cpu,raw,width,write)
                                state.data(cpu,pc,raw,width,value,write)
                                idle.after_data()
                            except ImageStateError as error: raise AccessError(str(error)) from error
                        counts[f"cpu:{CPU_NAMES[cpu]}:{'write' if write else 'read'}"]+=1
                    if site_row["stable_id"] in dynamic:
                        seen_dynamic.add(site_row["stable_id"])
                    if is_data:
                        try: fact=comm.event(seq,frame,cpu,pc,raw,width,value,write)
                        except ImageStateError as error: raise AccessError(str(error)) from error
                        if fact is not None: command_rows.append(fact)
                else: raise AccessError("cpu enum")
                previous_event=(seq,frame,pc,value,cpu,is_fetch)
                counts[f"width:{width}"]+=1; sequence+=1
        chunk_rows.append({"path":path.name,"records":actual,"size":size,"sha256":sha256(path),
                           "first_sequence":first,"image_prefix":header[6].hex(),
                           "tool_prefix":header[7].hex(),"site_prefix":header[8].hex()})
    if sequence>PILOT_EVENT_CAP: raise AccessError("pilot event cap")
    while pending is not None and pending[1]==sequence:
        try: idle.apply(pending,previous_event,footer["frames"],terminal=True)
        except ImageStateError as error: raise AccessError(str(error)) from error
        pending=next(ledger,None)
    if pending is not None: raise AccessError("host ledger beyond EOF/unconsumed entry")
    if footer.get("host_rewrites")!=idle.summary(): raise AccessError("host ledger/footer reconciliation")
    try: state.finish()
    except ImageStateError as error: raise AccessError(str(error)) from error
    return {"event_count":sequence,"counts":dict(sorted(counts.items())),
            "chunks":chunk_rows,"record_bytes":sum(x["size"] for x in chunk_rows),
            "idl":idl,"cpu_instruction_instances":cpu_instances,
            "sram_installs":state.installs,"wram_installs":state.wram.installs,
            "host_rewrites":idle.summary(),"comm":comm.summary(),
            "command_rows":command_rows},sorted(dynamic-seen_dynamic)


def validate_command_facts(path: Path, stats: dict, footer: dict) -> None:
    with path.open(newline="") as stream:
        reader=csv.reader(stream)
        if next(reader,None)!=["sequence","frame","cpu","pc","address","width","value","game","tags","lane_mask"]:
            raise AccessError("command fact CSV header")
        for expected in stats["command_rows"]:
            row=next(reader,None)
            if row is None or len(row)!=10:
                raise AccessError("command fact CSV cardinality")
            try: actual=tuple(int(value,16 if index in (3,4,6) else 10) for index,value in enumerate(row))
            except ValueError as error: raise AccessError("command fact CSV value") from error
            if actual!=expected: raise AccessError("command fact/raw sequence bijection")
        if next(reader,None)!=["# COMPLETE",f"frames={footer['frames']}",f"writes={stats['comm']['writes']}"] or next(reader,None) is not None:
            raise AccessError("command fact terminal/cardinality")
    if footer.get("comm")!=stats["comm"]:
        raise AccessError("command fact footer/raw recomputation")


def idl_source_bounds(rom: bytes) -> tuple[int,int,int]:
    """Pinned p32x_reset_sh2s derives bases from the cartridge IDL header."""
    if len(rom)<0x3E0 or struct.unpack_from(">III",rom,0x3D4)!=(0x20000,0,0xC000):
        raise AccessError("IDL accepted header source/destination/extent")
    if hashlib.sha256(rom).hexdigest()!="6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900":
        raise AccessError("IDL accepted ROM identity")
    source,destination,size=struct.unpack_from(">III",rom,0x3D4)
    return (source&0x0FFFFFFF)+0x02000000,(destination&0x0FFFFFFF)+0x06000000,size


def validate_idl(rows: list[tuple[int,int,int,int,bool]], rom: bytes | None=None) -> None:
    if rom is None: rom=(Path(__file__).resolve().parents[2]/"build/vr_rebuild.32x").read_bytes()
    expected_source,expected_destination,size=idl_source_bounds(rom)
    if len(rows)!=24576: raise AccessError("IDL record cardinality")
    if len(rows)!=size//4*2: raise AccessError("IDL source extent/cardinality")
    source0,dest0=None,None
    target_reads=target_writes=0
    for i in range(12288):
        read,write=rows[i*2],rows[i*2+1]
        if read[3:]!=(4,False) or write[3:]!=(4,True) or read[2]!=write[2]:
            raise AccessError("IDL ordered read/write/value pair")
        file_offset=expected_source-0x02000000+i*4
        if read[2]!=int.from_bytes(rom[file_offset:file_offset+4],"big"):
            raise AccessError("IDL read value differs from accepted ROM source bytes")
        if i==0: source0,dest0=read[0],write[0]
        if read[0]!=source0+i*4 or write[0]!=dest0+i*4:
            raise AccessError("IDL address order")
        if read[1]!=read[0] or write[1]!=write[0]: raise AccessError("IDL normalization")
        if read[0] < 0x0202BCE8 and read[0]+4 > 0x0202BBC0: target_reads+=1
        if write[0] < 0x0600BCE8 and write[0]+4 > 0x0600BBC0: target_writes+=1
    if (source0,dest0)!=(expected_source,expected_destination) or (target_reads,target_writes)!=(74,74):
        raise AccessError("IDL source/destination/target coverage")


def validate_pilot(root: Path, toolchain: Path, output: Path) -> dict:
    started=time.monotonic(); before_rss=resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
    validate_toolchain(toolchain)
    manifest=load_canonical(root/"quarantine-manifest-v9.json","vrd-vr60-q028-resource-pilot-quarantine-v9")
    required={"eligible":False,"quarantined":True,"purpose":"resource_capacity_only",
              "schedule_use_forbidden":True,"family_use_forbidden":True,
              "outcome_use_forbidden":True,"campaign_reuse_forbidden":True,
              "run_identity":QUARANTINE_TOKEN}
    if any(manifest.get(k)!=v for k,v in required.items()): raise AccessError("quarantine identity")
    forbidden=("engine-schedule","capture-eligibility","decision-tree","family-result","rgb565","render-select","fs-preapply")
    if any(any(token in p.name.lower() for token in forbidden) for p in root.rglob("*")):
        raise AccessError("pilot contains schedule/family/outcome artifact")
    site_path=root/"static-site-map-v6.json"; site_map=load_canonical(site_path,"vrd-vr60-q028-static-site-map-v6")
    stats,unseen=read_events(root,site_map)
    validate_idl(stats.pop("idl"))
    footer=load_canonical(root/"access-footer-v8.json","vrd-vr60-q028-access-footer-v8")
    markers=re.findall(r"^Q028_OBSERVER_TERMINAL_ERRORS=([0-9]+)$", (root/"producer.log").read_text(), re.M)
    if markers != ["0"]: raise AccessError("observer final close/error marker")
    validate_command_facts(root/"drc-command.csv",stats,footer)
    if footer["events"]!=stats["event_count"] or footer["chunks"]!=len(stats["chunks"]): raise AccessError("footer event/chunk recomputation")
    if any(footer.get(k)!=0 for k in ("errors","unknown","dropped","unattributed")): raise AccessError("footer loss/error")
    if footer.get("frames")!=1340 or footer.get("resource_limit") or footer.get("reason")!="core_deinit": raise AccessError("terminal completion")
    if not all(footer.get(k) is True for k in ("fetch_complete","cpu_data_complete","dma_dreq_bridge_complete","no_open_context")):
        raise AccessError("footer completeness")
    if footer.get("sh2_interpreter")!=1: raise AccessError("resource pilot did not use SH2 interpreter")
    for cpu in ("m68k","master","slave"):
        if stats["counts"].get(f"cpu:{cpu}:fetch",0)==0 or sum(stats["counts"].get(f"cpu:{cpu}:{k}",0) for k in ("read","write"))==0:
            raise AccessError(f"missing {cpu} fetch/data")
        expected={k:stats["counts"].get(f"cpu:{cpu}:{k}",0) for k in ("fetch","read","write")}
        if footer["cpu_counts"][cpu]!=expected: raise AccessError(f"CPU footer mismatch: {cpu}")
    if (footer.get("idl_complete"),footer.get("bios_null"),footer.get("idl_reads"),footer.get("idl_writes"),
        footer.get("idl_target_reads"),footer.get("idl_target_writes"))!=(1,1,12288,12288,74,74):
        raise AccessError("IDL completeness/counts")
    agent_inventory=load_canonical(root/"agent-inventory-v9.json","vrd-vr60-q028-agent-inventory-v9")
    if set(agent_inventory["agents"]) != set(AGENTS.values()) or set(footer["agent_counts"]) != set(AGENTS.values()):
        raise AccessError("agent inventory/footer key bijection")
    for name,row in agent_inventory["agents"].items():
        if name not in AGENTS.values(): raise AccessError(f"unknown inventory agent: {name}")
        records=stats["counts"].get(f"agent:{name}",0); footer_row=footer["agent_counts"][name]
        if records!=footer_row["records"]: raise AccessError(f"agent footer mismatch: {name}")
        if row["applicable"]:
            if footer_row["hook_entries"]==0 or records==0: raise AccessError(f"applicable agent absent: {name}")
        elif records or footer_row["hook_entries"] or not row.get("reviewed_reason"):
            raise AccessError(f"N/A agent activity/reason: {name}")
    coverage={"schema":"vrd-vr60-q028-dynamic-runtime-coverage-v6",
              "static_site_map_sha256":sha256(site_path),"full_dynamic_site_count":len(site_map["dynamic_site_ids"]),
              "seen_count":len(site_map["dynamic_site_ids"])-len(unseen),"unseen_site_ids":unseen,
              "coverage_scope":"pinned-1340-frame-fixture","global_dynamic_coverage":False,
              "unseen_sites_proven_safe":False,"unattributed_events":0}
    coverage_path=root/"dynamic-runtime-coverage-v6.json"
    if coverage_path.exists() and coverage_path.read_bytes()!=canonical(coverage): raise AccessError("dynamic coverage mismatch")
    elif not coverage_path.exists(): coverage_path.write_bytes(canonical(coverage))
    applied=root/"applied-input.csv"
    if applied.stat().st_size!=14981 or sha256(applied)!="2df0ffe53cad0c7d7a5d70c1819051685905a60ff96727a6256e6a300116fbbf": raise AccessError("applied input")
    result={"schema":"vrd-vr60-q028-resource-pilot-validation-v9","status":"PASS_RESOURCE_PILOT_ONLY",
            "eligible":False,"quarantined":True,"event_count":stats["event_count"],
            "counts":stats["counts"],"cpu_instruction_instances":stats["cpu_instruction_instances"],
            "chunk_count":len(stats["chunks"]),"chunks":stats["chunks"],
            "record_bytes":stats["record_bytes"],"unseen_dynamic_sites":len(unseen),
            "footer_sha256":sha256(root/"access-footer-v8.json"),"site_map_sha256":sha256(site_path),
            "toolchain_sha256":sha256(toolchain),"validator_wall_seconds":time.monotonic()-started,
            "validator_peak_rss_bytes":max(before_rss,resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)*1024,
            **required}
    if output.exists(): raise AccessError("exclusive validator output exists")
    output.write_bytes(canonical(result)); return result


def deterministic_archive(root: Path, archive: Path) -> dict:
    if archive.exists(): raise AccessError("exclusive archive exists")
    members=sorted((p for p in root.rglob("*") if p.is_file()),key=lambda p:p.relative_to(root).as_posix().encode())
    if len(members)>PILOT_MEMBER_CAP: raise AccessError("pilot member cap")
    uncompressed=sum(p.stat().st_size for p in members)
    if uncompressed>PILOT_UNCOMPRESSED_CAP: raise AccessError("pilot uncompressed cap")
    with archive.open("xb") as raw:
        with gzip.GzipFile(filename="",mode="wb",fileobj=raw,compresslevel=9,mtime=0) as gz:
            with tarfile.open(fileobj=gz,mode="w",format=tarfile.USTAR_FORMAT) as tar:
                for path in members:
                    rel="resource-pilot/"+path.relative_to(root).as_posix(); info=tar.gettarinfo(path,arcname=rel)
                    info.uid=info.gid=0; info.uname=info.gname=""; info.mtime=0; info.mode=0o644
                    with path.open("rb") as f: tar.addfile(info,f)
    if archive.stat().st_size>PILOT_COMPRESSED_CAP: raise AccessError("pilot compressed cap")
    with tarfile.open(archive,"r:gz") as tar:
        actual=tar.getmembers()
        if len(actual)!=len(members) or any(not m.isfile() or not m.name.startswith("resource-pilot/") for m in actual):
            raise AccessError("pilot archive member bijection/type")
    return {"member_count":len(members),"uncompressed_bytes":uncompressed,
            "gzip_bytes":archive.stat().st_size,"sha256":sha256(archive),
            "largest_member":max((p.stat().st_size for p in members),default=0)}


def main()->int:
    p=argparse.ArgumentParser(description=__doc__); sub=p.add_subparsers(dest="command",required=True)
    v=sub.add_parser("validate-resource-pilot"); v.add_argument("--root",type=Path,required=True)
    v.add_argument("--toolchain",type=Path,required=True); v.add_argument("--output",type=Path,required=True)
    a=sub.add_parser("archive-resource-pilot"); a.add_argument("--root",type=Path,required=True); a.add_argument("--archive",type=Path,required=True)
    args=p.parse_args()
    try:
        if args.command=="validate-resource-pilot": print(json.dumps(validate_pilot(args.root.resolve(),args.toolchain.resolve(),args.output.resolve()),sort_keys=True,separators=(",",":")))
        else: print(json.dumps(deterministic_archive(args.root.resolve(),args.archive.resolve()),sort_keys=True,separators=(",",":")))
    except (OSError,ValueError,KeyError,json.JSONDecodeError,tarfile.TarError,AccessError) as e:
        print(f"Q-028 access validation FAILED: {e}"); return 1
    return 0


if __name__=="__main__": raise SystemExit(main())
