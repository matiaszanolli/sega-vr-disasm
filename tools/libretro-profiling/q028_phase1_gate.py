#!/usr/bin/env python3
"""Q-028 v9 offline clean-build gate and one-shot resource-pilot producer."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
import threading
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import q028_access_v8 as access
import q028_materialize_picodrive as materialize
import prepare_q028_picodrive as prepare

COMMIT = "26ecb2b6358fefba24e3d68b9eb2efba7f10d5ee"
PROPOSAL_V9 = "33ae273ba8854569c57b494dfd1ac34d33e7608c681cbfaf2be4ee4f028058c9"
PACK_SHA = "745cfa19aaca095412fa33e3b402bc471ba70fbe7185328a322325dd06b85c18"
FREE_FLOOR = 240_518_168_576
RESERVE = 68_719_476_736
STAGING_CAP = 171_798_691_840
ALLOWED_ENV = {"LC_ALL":"C","TZ":"UTC","PATH":os.environ.get("PATH","")}


class GateError(RuntimeError): pass


def canonical(value: object) -> bytes:
    return (json.dumps(value,sort_keys=True,separators=(",",":"))+"\n").encode()


def sha256(path: Path) -> str:
    h=hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda:f.read(1024*1024),b""): h.update(block)
    return h.hexdigest()


def inventory(root: Path) -> list[dict]:
    rows=[]
    for path in sorted((p for p in root.rglob("*") if p.is_file()),key=lambda p:p.relative_to(root).as_posix().encode()):
        rows.append({"path":path.relative_to(root).as_posix(),"bytes":path.stat().st_size,"sha256":sha256(path)})
    return rows


def run(argv: list[str], cwd: Path, log: Path, env: dict[str,str]|None=None) -> dict:
    started=time.monotonic()
    with log.open("xb") as stream:
        with subprocess.Popen(argv,cwd=cwd,env=env or ALLOWED_ENV,stdout=stream,stderr=subprocess.STDOUT) as process:
            _,status,usage=os.wait4(process.pid,0)
            process.returncode=os.waitstatus_to_exitcode(status)
    row={"argv":argv,"cwd_role":cwd.name,"exit":process.returncode,"log":log.name,
         "log_sha256":sha256(log),"wall_seconds":time.monotonic()-started,
         "peak_rss_bytes":usage.ru_maxrss*1024}
    if process.returncode: raise GateError(f"command failed ({process.returncode}); see {log}")
    return row


def build_pair(repo: Path, pack: Path, manifest: Path, output: Path) -> dict:
    if output.exists(): raise GateError("build-pair output must not exist")
    output.mkdir(parents=True); commands=[]; builds=[]
    inputs_dir=output/"tool-inputs"; inputs_dir.mkdir()
    tool_inputs=[]
    for name in ("q028_owner_analysis.py","q028_image_domains.py","q028_image_state.py",
                 "q028_access_v8.py","q028_phase1_gate.py","prepare_q028_picodrive.py",
                 "q028_materialize_picodrive.py","q028_all_access_observer.inc",
                 "q028_static_site_map.inc","profiling_frontend.c"):
        source=repo/"tools/libretro-profiling"/name
        target=inputs_dir/name; shutil.copyfile(source,target)
        tool_inputs.append({"path":f"tools/libretro-profiling/{name}",
                            "snapshot":f"tool-inputs/{name}","sha256":sha256(target),
                            "bytes":target.stat().st_size})
    import q028_image_domains as images
    for relative in [str(images.FINITE_INVENTORY.relative_to(repo))] + sorted(images.PRESENTATION_POSTIMAGES):
        source=repo/relative; target=inputs_dir/source.name
        shutil.copyfile(source,target)
        tool_inputs.append({"path":relative,"snapshot":f"tool-inputs/{source.name}",
                            "sha256":sha256(target),"bytes":target.stat().st_size})
    if sha256(pack)!=PACK_SHA: raise GateError("source-pack digest")
    closure=materialize.verify_pack(pack,manifest); summary=closure["aggregate"]
    if summary!={"regular_files":1633,"regular_file_bytes":27554071,"symlinks":0,"gitlink_edges":6}:
        raise GateError(f"recursive source closure: {summary}")
    for label in ("a","b"):
        root=output/f"build-{label}"; source=root/"source"
        root.mkdir()
        materialize.materialize(pack,source,manifest)
        for patch_name in ("libretro_vrd_profiling_v4.patch","libretro_q020_cmdint_irq_parity.patch"):
            commands.append(run(["git","apply",str(HERE/patch_name)],source,output/f"{label}-{patch_name}.log"))
        commands.append(run([sys.executable,str(HERE/"prepare_q028_picodrive.py"),
            "--source-root",str(source),"--tool-root",str(HERE)],repo,output/f"{label}-overlay.log"))
        commands.append(run(["make","-f","Makefile.libretro","platform=unix",
            "GIT_REVISION=-26ecb2b-q028v8","-j4"],source,output/f"{label}-core-build.log",
            {**ALLOWED_ENV,"CCACHE_DISABLE":"1"}))
        frontend=root/"profiling_frontend"
        commands.append(run(["cc","-O2","-Wall","-Wextra","-Werror","-o",str(frontend),
            str(repo/"tools/libretro-profiling/profiling_frontend.c"),"-ldl"],repo,output/f"{label}-frontend-build.log"))
        source_rows=[]
        for relative in prepare.FILES:
            source_rows.append({"path":relative,"sha256":sha256(source/relative)})
        source_rows.extend([
            {"path":"platform/libretro/q028_all_access_observer.inc","sha256":sha256(source/"platform/libretro/q028_all_access_observer.inc")},
            {"path":"platform/libretro/q028_static_site_map.inc","sha256":sha256(source/"platform/libretro/q028_static_site_map.inc")}])
        builds.append({"label":label,"core":str(source/"picodrive_libretro.so"),
            "core_sha256":sha256(source/"picodrive_libretro.so"),"core_bytes":(source/"picodrive_libretro.so").stat().st_size,
            "frontend":str(frontend),"frontend_sha256":sha256(frontend),"frontend_bytes":frontend.stat().st_size,
            "postimages":source_rows})
    for field in ("core_sha256","core_bytes","frontend_sha256","frontend_bytes","postimages"):
        if builds[0][field]!=builds[1][field]: raise GateError(f"A/B build divergence: {field}")
    versions={}
    for name,argv in (("cc",["cc","--version"]),("make",["make","--version"]),("ld",["ld","--version"])):
        log=output/f"version-{name}.txt"; commands.append(run(argv,repo,log)); versions[name]={"sha256":sha256(log),"bytes":log.stat().st_size}
    result={"schema":"vrd-vr60-q028-clean-build-pair-v9","proposal_sha256":PROPOSAL_V9,
        "picodrive_commit":COMMIT,"source_pack_sha256":PACK_SHA,"source_closure":summary,
        "builds":builds,"commands":commands,"versions":versions,"clean_build_pair_equal":True,
        "tool_inputs":tool_inputs,
        "offline_source_pack_verified":True,"recursive_git_closure_complete":True}
    (output/"clean-build-pair-v9.json").write_bytes(canonical(result)); return result


class PeakSampler:
    def __init__(self,root:Path): self.root=root; self.stop=False; self.peak=0
    def size(self)->int: return sum(p.stat().st_size for p in self.root.rglob("*") if p.is_file())
    def run(self)->None:
        while not self.stop:
            self.peak=max(self.peak,self.size()); time.sleep(.25)


def quarantine_manifest(root: Path, repo: Path) -> dict:
    st=root.stat(); value={"schema":"vrd-vr60-q028-resource-pilot-quarantine-v9",
        "eligible":False,"quarantined":True,"purpose":"resource_capacity_only",
        "schedule_use_forbidden":True,"family_use_forbidden":True,"outcome_use_forbidden":True,
        "campaign_reuse_forbidden":True,"run_identity":access.QUARANTINE_TOKEN,
        "proposal_sha256":PROPOSAL_V9,"resolved_root":str(root),"repo_root":str(repo),
        "device":st.st_dev,"inode":st.st_ino}
    (root/"quarantine-manifest-v9.json").write_bytes(canonical(value)); return value


def pilot(repo:Path,pack:Path,manifest:Path,pilot_root:Path,frames:int,rom_id:str,input_path:Path)->dict:
    if frames!=1340 or rom_id!="ordinary": raise GateError("resource pilot identity")
    repo=repo.resolve(); pilot_root=pilot_root.resolve()
    if pilot_root==repo or repo in pilot_root.parents or pilot_root==Path("/tmp") or Path("/tmp") in pilot_root.parents:
        raise GateError("pilot root must be absolute, external, and outside /tmp")
    if pilot_root.exists(): raise GateError("pilot root must not exist")
    stat=os.statvfs(pilot_root.parent); free0=stat.f_bavail*stat.f_frsize
    if free0<FREE_FLOOR: raise GateError(f"launch free space {free0} < {FREE_FLOOR}")
    if sha256(input_path)!="2df0ffe53cad0c7d7a5d70c1819051685905a60ff96727a6256e6a300116fbbf" or input_path.stat().st_size!=14981:
        raise GateError("fixture identity")
    pilot_root.mkdir(mode=0o700); quarantine_manifest(pilot_root,repo)
    sampler=PeakSampler(pilot_root); thread=threading.Thread(target=sampler.run,daemon=True); thread.start()
    try:
        builds=build_pair(repo,pack,manifest,pilot_root/"clean-build-pair")
        for name,source in (("static-site-map-v6.json",repo/"analysis/evidence/vr60-q028-renderer-descriptor-probe/pre-capture/static-site-map-v6.json"),
                            ("owner-domain-v6.json",repo/"analysis/evidence/vr60-q028-renderer-descriptor-probe/pre-capture/owner-domain-v6.json"),
                            ("constructed-owner-report-v6.json",repo/"analysis/evidence/vr60-q028-renderer-descriptor-probe/pre-capture/constructed-owner-report-v6.json")):
            shutil.copyfile(source,pilot_root/name)
        agent_inventory={"schema":"vrd-vr60-q028-agent-inventory-v9","agents":{
            "idl":{"applicable":True},"master_dmac0":{"applicable":False,"reviewed_reason":"fixture path does not enable master DMAC channel 0"},
            "master_dmac1":{"applicable":False,"reviewed_reason":"fixture path does not enable master DMAC channel 1"},
            "slave_dmac0":{"applicable":False,"reviewed_reason":"fixture path does not enable slave DMAC channel 0"},
            "slave_dmac1":{"applicable":False,"reviewed_reason":"fixture path does not enable slave DMAC channel 1"},
            "master_dreq0":{"applicable":True,"reviewed_reason":"pinned FIFO-to-SDRAM DREQ hook executes in the ordinary fixture; independent of DMAC enable bits"},
            "slave_dreq0":{"applicable":False,"reviewed_reason":"fixture path does not enable slave DREQ channel 0"},
            "master_dreq1":{"applicable":False,"reviewed_reason":"fixture path does not enable master DREQ channel 1"},
            "slave_dreq1":{"applicable":False,"reviewed_reason":"fixture path does not enable slave DREQ channel 1"},
            "bridge":{"applicable":False,"reviewed_reason":"ordinary ROM has bridge disabled"}}}
        (pilot_root/"agent-inventory-v9.json").write_bytes(canonical(agent_inventory))
        access.validate_toolchain(pilot_root/"clean-build-pair/clean-build-pair-v9.json")
        build=builds["builds"][0]; env={**ALLOWED_ENV,
            "VRD_LIBRETRO_CORE":build["core"],"VRD_INPUT_SCRIPT":str(input_path),
            "VRD_PROFILE_LOG":str(pilot_root/"profile.csv"),
            "VRD_Q028_APPLIED_INPUT_LOG":str(pilot_root/"applied-input.csv"),
            "VRD_Q028_DRC_COMMAND_LOG":str(pilot_root/"drc-command.csv"),
            "VRD_Q028_ACCESS_LOG":str(pilot_root),"VRD_Q028_RUN_KIND":access.QUARANTINE_TOKEN}
        forbidden=("VRD_Q028_FAMILY","VRD_Q028_ARM","VRD_Q028_CAPTURE_DIR","VRD_Q028_TERMINAL_DIR",
                   "VRD_VIDEO_DUMP_DIR","VRD_RECORD_INPUT","VRD_LOAD_STATE")
        if any(name in os.environ for name in forbidden): raise GateError("inherited capture/family environment")
        before=os.statvfs(pilot_root); started=time.monotonic()
        producer=run([build["frontend"],str(repo/"build/vr_rebuild.32x"),"1340"],repo,pilot_root/"producer.log",env)
        producer_wall=time.monotonic()-started
        footer=access.load_canonical(pilot_root/"access-footer-v8.json","vrd-vr60-q028-access-footer-v8")
        if footer.get("resource_limit") or footer.get("reason")=="RESOURCE_LIMIT": raise GateError("producer RESOURCE_LIMIT")
        validation=access.validate_pilot(pilot_root,pilot_root/"clean-build-pair/clean-build-pair-v9.json",
                                         pilot_root/"resource-pilot-validation-v9.json")
        after_validation=os.statvfs(pilot_root); pre_archive_inventory=inventory(pilot_root)
        archive=access.deterministic_archive(pilot_root,pilot_root.parent/(pilot_root.name+".tar.gz"))
        after_archive=os.statvfs(pilot_root)
        nonaccess=[r for r in pre_archive_inventory if not r["path"].startswith("access-events-v8-")]
        measurement={"schema":"vrd-vr60-q028-resource-measurement-v9","proposal_sha256":PROPOSAL_V9,
            "event_count":validation["event_count"],"counts":validation["counts"],"chunk_count":validation["chunk_count"],
            "chunks":validation["chunks"],"record_bytes":validation["record_bytes"],
            "nonaccess_regular_member_count":len(nonaccess),"nonaccess_regular_member_bytes":sum(r["bytes"] for r in nonaccess),
            "pilot_package_uncompressed_bytes":sum(r["bytes"] for r in pre_archive_inventory),
            "pilot_package_member_count":len(pre_archive_inventory),"archive":archive,
            "compression_ratio":archive["uncompressed_bytes"]/max(1,archive["gzip_bytes"]),
            "producer_wall_seconds":producer_wall,"producer_peak_rss_bytes":producer["peak_rss_bytes"],
            "validator_wall_seconds":validation["validator_wall_seconds"],"validator_peak_rss_bytes":validation["validator_peak_rss_bytes"],
            "staging_peak_bytes":sampler.peak,"statvfs":{"before":{"total":before.f_blocks*before.f_frsize,"free":before.f_bfree*before.f_frsize,"available":before.f_bavail*before.f_frsize},
            "after_validation":{"total":after_validation.f_blocks*after_validation.f_frsize,"free":after_validation.f_bfree*after_validation.f_frsize,"available":after_validation.f_bavail*after_validation.f_frsize},
            "after_archive":{"total":after_archive.f_blocks*after_archive.f_frsize,"free":after_archive.f_bfree*after_archive.f_frsize,"available":after_archive.f_bavail*after_archive.f_frsize}},
            "bindings":{"rom_sha256":sha256(repo/"build/vr_rebuild.32x"),"input_sha256":sha256(input_path),
                "site_map_sha256":sha256(pilot_root/"static-site-map-v6.json"),"footer_sha256":sha256(pilot_root/"access-footer-v8.json"),
                "core_sha256":build["core_sha256"],"frontend_sha256":build["frontend_sha256"],"source_pack_sha256":PACK_SHA,
                "archive_sha256":archive["sha256"]},"eligible":False,"quarantined":True}
        (pilot_root/"resource-measurement-v9.json").write_bytes(canonical(measurement))
        return measurement
    finally:
        sampler.stop=True; thread.join(timeout=2)


def main()->int:
    p=argparse.ArgumentParser(description=__doc__); sub=p.add_subparsers(dest="command",required=True)
    b=sub.add_parser("build-pair"); b.add_argument("--repo-root",type=Path,required=True); b.add_argument("--source-pack",type=Path,required=True); b.add_argument("--manifest",type=Path); b.add_argument("--output",type=Path,required=True)
    q=sub.add_parser("producer-pilot"); q.add_argument("--repo-root",type=Path,required=True); q.add_argument("--source-pack",type=Path,required=True); q.add_argument("--manifest",type=Path); q.add_argument("--pilot-root",type=Path,required=True); q.add_argument("--frames",type=int,required=True); q.add_argument("--rom-id",required=True); q.add_argument("--input",type=Path,required=True)
    args=p.parse_args()
    try:
        manifest=(args.manifest or HERE/"q028_picodrive_git_closure_v9.json").resolve()
        if args.command=="build-pair": result=build_pair(args.repo_root.resolve(),args.source_pack.resolve(),manifest,args.output.resolve())
        else: result=pilot(args.repo_root,args.source_pack,manifest,args.pilot_root,args.frames,args.rom_id,args.input.resolve())
        print(json.dumps(result,sort_keys=True,separators=(",",":"))); return 0
    except (OSError,ValueError,KeyError,subprocess.SubprocessError,GateError,access.AccessError) as e:
        print(f"Q-028 Phase-1 gate FAILED: {e}"); return 1


if __name__=="__main__": raise SystemExit(main())
