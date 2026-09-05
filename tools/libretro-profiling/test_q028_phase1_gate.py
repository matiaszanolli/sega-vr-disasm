#!/usr/bin/env python3
"""Regression checks for Q-028 per-process resource measurements."""

import json
import os
import shutil
import sys
import tempfile
import unittest
from contextlib import nullcontext
from pathlib import Path

import q028_phase1_gate as gate
import q028_access_v8 as access


class ChildResourceTests(unittest.TestCase):
    def test_idl_bases_extent_and_actual_source_fixture(self):
        rom=(Path(__file__).resolve().parents[2]/"build/vr_rebuild.32x").read_bytes()
        source,destination,size=access.idl_source_bounds(rom)
        self.assertEqual((source,destination,size),(0x02020000,0x06000000,0xC000))
        rows=[]
        for offset in range(0,size,4):
            value=int.from_bytes(rom[0x20000+offset:0x20004+offset],"big")
            rows.extend(((source+offset,source+offset,value,4,False),
                         (destination+offset,destination+offset,value,4,True)))
        access.validate_idl(rows,rom)
        for offset in (0x3D4,0x3D8,0x3DC):
            mutated=bytearray(rom); mutated[offset+3]^=4
            with self.assertRaisesRegex(access.AccessError,"header"):
                access.validate_idl(rows,bytes(mutated))
        for lane in (0,1):
            mutated=list(rows)
            for index in range(lane,len(mutated),2):
                raw,normalized,value,width,write=mutated[index]
                mutated[index]=(raw+0x200,normalized+0x200,value,width,write)
            with self.assertRaisesRegex(access.AccessError,"coverage"):
                access.validate_idl(mutated,rom)
        with self.assertRaisesRegex(access.AccessError,"cardinality"):
            access.validate_idl(rows[:-2],rom)
        mutated=list(rows)
        for index in (0,1):
            raw,normalized,value,width,write=mutated[index]
            mutated[index]=(raw,normalized,value^1,width,write)
        with self.assertRaisesRegex(access.AccessError,"accepted ROM source bytes"):
            access.validate_idl(mutated,rom)

    def test_declared_terminal_frame_bounds(self):
        for invalid in (None,True,False,0,-1,1341,6.0,"6"):
            with self.assertRaisesRegex(access.AccessError,"terminal frame interval"):
                access.terminal_frames({"frames":invalid})
        for valid in (1,6,400,1340):
            self.assertEqual(access.terminal_frames({"frames":valid}),valid)

    def test_smaller_child_retains_its_own_peak_after_large_child(self):
        with tempfile.TemporaryDirectory(prefix="q028-child-rss-") as directory:
            root = Path(directory)
            large = gate.run([sys.executable, "-c", "data = bytearray(128 * 1024 * 1024)"],
                             root, root / "large.log")
            small = gate.run([sys.executable, "-c", "data = bytearray(1024 * 1024)"],
                             root, root / "small.log")
            repeated = gate.run([sys.executable, "-c", "data = bytearray(1024 * 1024)"],
                                root, root / "repeated.log")
            self.assertGreater(large["peak_rss_bytes"], 128 * 1024 * 1024)
            for row in (small, repeated):
                self.assertEqual(row["exit"], 0)
                self.assertGreater(row["peak_rss_bytes"], 1024 * 1024)
                self.assertLess(row["peak_rss_bytes"], large["peak_rss_bytes"] // 2)

    def test_nonzero_child_status_still_fails_and_preserves_log(self):
        with tempfile.TemporaryDirectory(prefix="q028-child-exit-") as directory:
            root = Path(directory)
            log = root / "failed.log"
            with self.assertRaisesRegex(gate.GateError, r"command failed \(7\)"):
                gate.run([sys.executable, "-c", "print('failure evidence'); raise SystemExit(7)"],
                         root, log)
            self.assertEqual(log.read_text(), "failure evidence\n")

    @unittest.skipUnless(os.environ.get("Q028_TEST_CORE") and os.environ.get("Q028_TEST_FRONTEND"),
                         "set Q028_TEST_CORE and Q028_TEST_FRONTEND for real-core all-binary smoke")
    def test_real_core_all_binary_stream_and_actual_artifact_mutations(self):
        repo = Path(__file__).resolve().parents[2]
        frames=int(os.environ.get("Q028_TEST_FRAMES","6"))
        self.assertIn(frames,(6,400))
        retained=os.environ.get("Q028_TEST_OUTPUT")
        if retained: Path(retained).mkdir(parents=True,exist_ok=False)
        with nullcontext(retained or tempfile.mkdtemp(prefix="q028-binary-regression-")) as directory:
            root = Path(directory)
            print(f"Q028 retained actual-core regression: {root}, frames={frames}",flush=True)
            fixture = repo / "analysis/evidence/vr60-q028-renderer-descriptor-probe/pre-capture/normal-1p-1340.csv"
            # The frontend requires exactly one row per requested frame, even for a smoke run.
            smoke_input = root / f"input-prefix-{frames}.csv"
            smoke_input.write_bytes(b"".join(fixture.read_bytes().splitlines(keepends=True)[:frames+1]))
            env = {**gate.ALLOWED_ENV,
                   "VRD_LIBRETRO_CORE": os.environ["Q028_TEST_CORE"],
                   "VRD_INPUT_SCRIPT": str(smoke_input),
                   "VRD_PROFILE_LOG": str(root / "profile.csv"),
                   "VRD_Q028_DRC_COMMAND_LOG": str(root / "drc-command.csv"),
                   "VRD_Q028_ACCESS_LOG": str(root),
                   "VRD_Q028_RUN_KIND": access.QUARANTINE_TOKEN}
            try:
                producer = gate.run([os.environ["Q028_TEST_FRONTEND"], str(repo / "build/vr_rebuild.32x"), str(frames)],
                                    repo, root / "producer.log", env)
                (root / "producer-resource.json").write_bytes(access.canonical(producer))
            except gate.GateError:
                self.fail((root / "producer.log").read_text())
            footer_path = root / "access-footer-v8.json"
            footer = access.load_canonical(footer_path, "vrd-vr60-q028-access-footer-v8")
            self.assertEqual(footer["frames"], frames)
            self.assertEqual(footer["reason"], "core_deinit")
            self.assertEqual(list(footer["agent_counts"]), sorted(access.AGENTS.values()))
            self.assertEqual(footer["idl_reads"], 12288)
            self.assertEqual(footer["idl_writes"], 12288)
            site_path = Path(os.environ.get("Q028_TEST_SITE_MAP", str(repo /
                "analysis/evidence/vr60-q028-renderer-descriptor-probe/pre-capture/static-site-map-v6.json")))
            site_map = access.load_canonical(site_path, "vrd-vr60-q028-static-site-map-v6")
            stats, _ = access.read_events(root, site_map)
            access.validate_idl(stats["idl"])
            access.validate_command_facts(root/"drc-command.csv", stats, footer)
            if frames==400:
                self.assertGreater(stats["host_rewrites"]["count"],0)
                self.assertGreater(stats["sram_installs"][1],0)
                self.assertGreater(stats["sram_installs"][2],0)
            self.assertEqual(stats["event_count"], footer["events"])
            self.assertEqual(len(stats["chunks"]), footer["chunks"])
            self.assertIn("Q028_OBSERVER_TERMINAL_ERRORS=0\n", (root/"producer.log").read_text())
            for field in ("errors", "unknown", "unattributed", "dropped"):
                self.assertEqual(footer[field], 0)
            for field in ("fetch_complete", "cpu_data_complete", "dma_dreq_bridge_complete", "no_open_context"):
                self.assertIs(footer[field], True)
            for cpu in ("m68k", "master", "slave"):
                expected = {kind: stats["counts"].get(f"cpu:{cpu}:{kind}", 0) for kind in ("fetch", "read", "write")}
                self.assertEqual(footer["cpu_counts"][cpu], expected)
                self.assertGreater(expected["fetch"], 0)
                self.assertGreater(expected["read"]+expected["write"], 0)
            for agent in access.AGENTS.values():
                self.assertEqual(footer["agent_counts"][agent]["records"],stats["counts"].get(f"agent:{agent}",0))
            self.assertEqual(footer["host_rewrites"],stats["host_rewrites"])
            (root/"actual-binary-validation.json").write_bytes(access.canonical({
                "status":"PASS_DIAGNOSTIC_STREAM_ONLY","frames":frames,"events":stats["event_count"],
                "host_rewrites":stats["host_rewrites"],"sram_installs":stats["sram_installs"],
                "core_sha256":access.sha256(Path(os.environ["Q028_TEST_CORE"])),
                "frontend_sha256":access.sha256(Path(os.environ["Q028_TEST_FRONTEND"])),
                "site_map_sha256":access.sha256(site_path)}))
            # Mutations copy the actual freshly emitted files, never r2 evidence.
            # Each test deterministically changes one existing ABI field.
            for name, field, value, message in (
                    ("terminal-frame-event", 1, frames, "outside declared terminal interval"),
                    ("fetch-slot", 9, 0, "fetch slot"),
                    ("reserved-flags", 12, 0x99, "reserved"),
                    ("reserved-byte", 15, 1, "reserved"),
                    ("wrong-fetch-word", 7, 0xFFFF, "opcode")):
                mutant = root/name
                mutant.mkdir()
                for name in ("bootstrap-images-v10.json","access-footer-v8.json","host-rewrites-v10.csv"):
                    shutil.copyfile(root/name,mutant/name)
                for chunk in access.chunks(root):
                    if chunk.name=="access-events-v8-0001.bin": shutil.copyfile(chunk,mutant/chunk.name)
                    else: os.link(chunk,mutant/chunk.name)
                first = mutant/"access-events-v8-0001.bin"
                with first.open("r+b") as stream:
                    stream.seek(64); record = list(access.RECORD.unpack(stream.read(48)))
                    record[field] = value
                    stream.seek(64); stream.write(access.RECORD.pack(*record))
                with self.assertRaisesRegex(access.AccessError, message):
                    access.read_events(mutant, site_map)
            mutant=root/"consistent-wrong-prefix"; mutant.mkdir()
            for name in ("bootstrap-images-v10.json","access-footer-v8.json","host-rewrites-v10.csv"):
                shutil.copyfile(root/name,mutant/name)
            for chunk in access.chunks(root):
                target=mutant/chunk.name; shutil.copyfile(chunk,target)
                with target.open("r+b") as stream:
                    header=list(access.HEADER.unpack(stream.read(64))); header[6]=b"wrongrom"
                    stream.seek(0); stream.write(access.HEADER.pack(*header))
            with self.assertRaisesRegex(access.AccessError,"actual-input identity"):
                access.read_events(mutant,site_map)
            footer["agent_counts"] = dict(reversed(list(footer["agent_counts"].items())))
            malformed = root / "reordered-footer.json"
            malformed.write_text(json.dumps(footer, separators=(",", ":")) + "\n")
            with self.assertRaisesRegex(access.AccessError, "noncanonical JSON"):
                access.load_canonical(malformed, "vrd-vr60-q028-access-footer-v8")
            (root/"actual-mutation-validation.json").write_bytes(access.canonical({
                "status":"PASS_DECLARED_MUTATIONS_ONLY","cases":["terminal-frame-event","fetch-slot","reserved-flags",
                    "reserved-byte","wrong-fetch-word","consistent-wrong-prefix","reordered-footer"]}))


if __name__ == "__main__":
    unittest.main()
