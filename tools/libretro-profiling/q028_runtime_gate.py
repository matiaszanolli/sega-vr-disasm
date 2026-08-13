#!/usr/bin/env python3
"""Fail-closed fresh-process Q-028 v7 schedule and 36-run matrix launcher."""

from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import os
import subprocess
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
CONTRACT = json.loads((HERE / "q028_contract_v7.json").read_text())
FIXTURE_HASH = CONTRACT["fixture"]["sha256"]
EVIDENCE_SPEC = importlib.util.spec_from_file_location("q028_evidence", HERE / "q028_evidence.py")
FREEZER_SPEC = importlib.util.spec_from_file_location("q028_freezer", HERE / "q028_schedule_freezer.py")
assert EVIDENCE_SPEC and EVIDENCE_SPEC.loader and FREEZER_SPEC and FREEZER_SPEC.loader
EVIDENCE = importlib.util.module_from_spec(EVIDENCE_SPEC); EVIDENCE_SPEC.loader.exec_module(EVIDENCE)
FREEZER = importlib.util.module_from_spec(FREEZER_SPEC); FREEZER_SPEC.loader.exec_module(FREEZER)


class RunError(RuntimeError): pass


def digest(path: Path) -> str:
    result=hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda:stream.read(1024*1024),b""): result.update(chunk)
    return result.hexdigest()


def clean_environment() -> dict[str,str]:
    if any(key.startswith("VRD_Q028_") or key == "VRD_RECORD_INPUT" for key in os.environ):
        raise RunError("inherited Q-028/VRD_RECORD_INPUT environment is forbidden")
    return {"PATH":os.environ.get("PATH","/usr/bin:/bin"),"LC_ALL":"C","TZ":"UTC"}


def rom_path(family: str, arm: str) -> Path:
    if arm == "BASELINE": return ROOT / f"build/vr60_q028_family_{family.lower()}_baseline.32x"
    return ROOT / f"build/vr60_q028_family_{family.lower()}_{arm.lower()}.32x"


def run_one(frontend: Path, core: Path, fixture: Path, target: Path,
            engine: str, repeat: int, family: str, arm: str, capture: str) -> None:
    target.mkdir(parents=False)
    for directory in ("capture","video","terminal"): (target/directory).mkdir()
    rom=rom_path(family,arm)
    expected=CONTRACT["identity"]["q028"][family][arm.lower()]
    if digest(rom)!=expected: raise RunError(f"ROM identity: {rom}")
    env=clean_environment()
    env.update({"VRD_LIBRETRO_CORE":str(core),"VRD_INPUT_SCRIPT":str(fixture),
                "VRD_PROFILE_LOG":str(target/"profile.csv"),
                "VRD_Q028_FAMILY":family,"VRD_Q028_ARM":arm.lower(),
                "VRD_Q028_CAPTURE_DIR":str(target/"capture"),
                "VRD_Q028_CAPTURE_START":"1298","VRD_Q028_CAPTURE_END":"1305",
                "VRD_Q028_TERMINAL_DIR":str(target/"terminal"),
                "VRD_Q028_APPLIED_INPUT_LOG":str(target/"applied-input.csv"),
                "VRD_Q028_DRC_COMMAND_LOG":str(target/"drc-command.csv"),
                "VRD_VIDEO_DUMP_DIR":str(target/"video"),
                "VRD_VIDEO_DUMP_START":"1298","VRD_VIDEO_DUMP_END":"1305"})
    if engine=="INTERPRETER": env["VRD_Q028_ACCESS_LOG"]=str(target/"access.csv")
    if capture=="off": env["VRD_Q028_VIDEO_CAPTURE"]="0"
    run_log=(target/"run.log").open("xb")
    try:
        subprocess.run([str(frontend),str(rom),"1340"],cwd=ROOT,env=env,
                       stdout=run_log,stderr=subprocess.STDOUT,check=True)
    finally: run_log.close()
    metadata={"schema":"vrd-vr60-q028-run-package-v7","engine":engine,"repeat":repeat,
              "family":family,"arm":arm,"capture":capture,"rom_sha256":expected,
              "fixture_sha256":FIXTURE_HASH,"core_sha256":digest(core),
              "frontend_sha256":digest(frontend),"eligible":False,
              "status":"RAW_UNVALIDATED"}
    (target/"package.json").write_bytes(EVIDENCE.canonical_json(metadata))


def schedule(args: argparse.Namespace) -> None:
    if args.output.exists(): raise RunError("schedule output root must not exist")
    args.output.mkdir()
    actual=[]
    for engine in ("INTERPRETER","NORMAL_DRC"):
        for repeat in (1,2):
            package=f"{engine.lower()}-schedule-r{repeat}"
            actual.append(package)
            run_one(args.frontend,args.core,args.fixture,args.output/package,
                    engine,repeat,"A","BASELINE","off")
    (args.output/"actual-order.json").write_bytes(EVIDENCE.canonical_json(actual))


def matrix(args: argparse.Namespace) -> None:
    schedule_raw=args.schedule.read_bytes()
    if hashlib.sha256(schedule_raw).hexdigest()!=args.reviewed_schedule_sha256:
        raise RunError("schedule hash is not the reviewed hash")
    frozen=json.loads(schedule_raw)
    if frozen.get("schema")!="vrd-vr60-q028-engine-schedule-v6" or frozen.get("outcome_members_read")!=0:
        raise RunError("schedule schema/reader boundary")
    if args.output.exists(): raise RunError("matrix output root must not exist")
    args.output.mkdir()
    actual=[]
    for engine in ("INTERPRETER","NORMAL_DRC"):
        expected_schedule=frozen[engine][0]
        for repeat in (1,2):
            for family in "ABC":
                for arm in ("BASELINE","CONTROL","ACTIVE"):
                    package=f"{engine.lower()}-r{repeat}-{family}-{arm.lower()}"
                    actual.append(package)
                    target=args.output/package
                    run_one(args.frontend,args.core,args.fixture,target,
                            engine,repeat,family,arm,"on")
                    observed=FREEZER.read_schedule_run(target,engine,repeat)
                    if (observed["metadata_hashes"]!=expected_schedule["metadata_hashes"] or
                            observed["sequences"]!=expected_schedule["sequences"]):
                        raise RunError(f"immutable engine schedule mismatch: {package}")
    (args.output/"actual-order.json").write_bytes(EVIDENCE.canonical_json(actual))


def main() -> int:
    parser=argparse.ArgumentParser(description=__doc__)
    sub=parser.add_subparsers(dest="command",required=True)
    plan=sub.add_parser("plan")
    for name in ("schedule","matrix"):
        command=sub.add_parser(name); command.add_argument("--frontend",type=Path,required=True)
        command.add_argument("--core",type=Path,required=True); command.add_argument("--fixture",type=Path,required=True)
        command.add_argument("--output",type=Path,required=True)
        if name=="matrix":
            command.add_argument("--schedule",type=Path,required=True)
            command.add_argument("--reviewed-schedule-sha256",required=True)
    args=parser.parse_args()
    try:
        EVIDENCE.pre_capture()
        if args.command=="plan":
            print(json.dumps(EVIDENCE.package_order(),sort_keys=True,separators=(",",":"))); return 0
        args.frontend=args.frontend.resolve(); args.core=args.core.resolve(); args.fixture=args.fixture.resolve()
        args.output=args.output.resolve()
        if digest(args.fixture)!=FIXTURE_HASH or args.fixture.stat().st_size!=14981: raise RunError("fixture identity")
        if args.command=="schedule": schedule(args)
        else: args.schedule=args.schedule.resolve(); matrix(args)
    except (OSError,ValueError,KeyError,RunError,subprocess.CalledProcessError,EVIDENCE.Q028Error,FREEZER.FreezeError) as error:
        print(f"Q-028 {args.command} FAILED: {error}"); return 1
    print(f"Q-028 {args.command} raw completion; validation/audit required"); return 0


if __name__=="__main__": raise SystemExit(main())
