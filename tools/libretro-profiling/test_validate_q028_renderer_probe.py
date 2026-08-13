#!/usr/bin/env python3
"""Pre-capture policy checks for the repaired production Q-028 validator."""

from __future__ import annotations

import importlib.util
import json
import tempfile
import unittest
from pathlib import Path


HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]


def load(name:str,path:Path):
    spec=importlib.util.spec_from_file_location(name,path); assert spec and spec.loader
    module=importlib.util.module_from_spec(spec); spec.loader.exec_module(module); return module


VALIDATOR=load("q028_validator_v7",HERE/"validate_q028_renderer_probe.py")
EVIDENCE=load("q028_evidence_v7",HERE/"q028_evidence.py")


class Q028RuntimePolicyTests(unittest.TestCase):
    def test_fixed_window_and_lossless_geometry(self)->None:
        self.assertEqual(VALIDATOR.FRAMES,list(range(1298,1306)))
        contract=json.loads((HERE/"q028_contract_v7.json").read_text())
        self.assertEqual(contract["display"]["geometry"],[320,224,640])
        self.assertEqual(contract["display"]["rgb_bytes"],143360)

    def test_csv_reader_rejects_wrong_header(self)->None:
        with tempfile.TemporaryDirectory(prefix="q028-csv-") as temporary:
            path=Path(temporary)/"bad.csv"; path.write_text("wrong\n")
            with self.assertRaisesRegex(VALIDATOR.ValidationError,"header"):
                VALIDATOR.table(path,"expected")

    def test_package_order_is_exact_36_plus_4(self)->None:
        rows=EVIDENCE.package_order()
        self.assertEqual(len(rows),40)
        self.assertEqual(sum(row["capture"]=="on" for row in rows),36)
        self.assertEqual([row["id"] for row in rows[-4:]],
                         ["interpreter-schedule-r1","interpreter-schedule-r2",
                          "normal_drc-schedule-r1","normal_drc-schedule-r2"])

    def test_runner_has_no_reuse_or_accepted_outcome(self)->None:
        source=(HERE/"q028_runtime_gate.py").read_text()
        self.assertNotIn("--reuse",source)
        self.assertNotIn("EXPECTED_PIXELS",source)
        self.assertNotIn('"INCONCLUSIVE_COMPOSITE"',source)
        self.assertIn("reviewed-schedule-sha256",source)

    def test_all_canonical_documents_are_blocked(self)->None:
        EVIDENCE.validate_docs()


if __name__=="__main__": unittest.main()
