#!/usr/bin/env python3
"""Real-input mutation coverage for the production Q-028 v7 verifier."""

from __future__ import annotations

import copy
import gzip
import hashlib
import importlib.util
import io
import json
import subprocess
import sys
import tarfile
import tempfile
import unittest
from pathlib import Path


HERE = Path(__file__).resolve().parent
SCRIPT = HERE / "q028_evidence.py"
CONTRACT = HERE / "q028_contract_v7.json"
COVERAGE = HERE / "q028_mutation_coverage_v7.json"
SPEC = importlib.util.spec_from_file_location("q028_evidence", SCRIPT)
assert SPEC and SPEC.loader
Q028 = importlib.util.module_from_spec(SPEC); SPEC.loader.exec_module(Q028)


def set_field(value: dict, dotted: str) -> None:
    parent = value
    parts = dotted.split(".")
    for part in parts[:-1]:
        parent = parent[part]
    current = parent[parts[-1]]
    if isinstance(current, bool): parent[parts[-1]] = not current
    elif isinstance(current, int): parent[parts[-1]] = current + 1
    elif isinstance(current, str): parent[parts[-1]] = current + "-MUTATED"
    elif isinstance(current, list):
        parent[parts[-1]] = current + ["MUTATED"] if dotted == "exclusions" else list(reversed(current))
    else: raise AssertionError(type(current))


class ContractMutationTests(unittest.TestCase):
    def test_unmutated_contract_passes(self) -> None:
        run = subprocess.run([sys.executable, str(SCRIPT), "validate-contract", str(CONTRACT)],
                             text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        self.assertEqual(run.returncode, 0, run.stdout)

    def test_all_28_categories_use_production_validator(self) -> None:
        contract = json.loads(CONTRACT.read_text())
        coverage = json.loads(COVERAGE.read_text())
        self.assertEqual(coverage["category_count"], 28)
        self.assertEqual({row["category"] for row in coverage["cases"]}, set(Q028.CATEGORIES))
        with tempfile.TemporaryDirectory(prefix="q028-mutations-") as temporary:
            root = Path(temporary)
            for row in coverage["cases"]:
                mutated = copy.deepcopy(contract)
                set_field(mutated, row["field"])
                path = root / f"{row['category']}.json"
                path.write_bytes(Q028.canonical_json(mutated))
                run = subprocess.run([sys.executable, str(SCRIPT), "validate-contract", str(path)],
                                     text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                self.assertNotEqual(run.returncode, 0, row["category"])
                self.assertIn(f"{row['category']}:", run.stdout, run.stdout)

    def test_archive_reader_hashes_real_member_and_rejects_trailing_gzip(self) -> None:
        payload = b"Q028-production-reader\n"
        member_name = "toolchain/member.bin"
        with tempfile.TemporaryDirectory(prefix="q028-archive-") as temporary:
            archive = Path(temporary) / "fixture.tar.gz"
            raw = io.BytesIO()
            with tarfile.open(fileobj=raw, mode="w", format=tarfile.USTAR_FORMAT) as tar:
                info = tarfile.TarInfo(member_name); info.size = len(payload)
                info.uid = info.gid = info.mtime = 0; info.mode = 0o644
                tar.addfile(info, io.BytesIO(payload))
            archive.write_bytes(gzip.compress(raw.getvalue(), compresslevel=9, mtime=0))
            contract = json.loads(CONTRACT.read_text())
            expected = {member_name: {"path": member_name, "size": len(payload),
                                      "sha256": hashlib.sha256(payload).hexdigest()}}
            self.assertEqual(Q028.stream_archive(archive, expected, contract)[1], len(payload))
            archive.write_bytes(archive.read_bytes() + b"trailing")
            with self.assertRaisesRegex(Q028.Q028Error, "v4-14"):
                Q028.stream_archive(archive, expected, contract)


if __name__ == "__main__":
    unittest.main()
