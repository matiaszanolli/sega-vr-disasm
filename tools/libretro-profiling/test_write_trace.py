#!/usr/bin/env python3
"""Real-core acceptance tests for the VR60-009 68K write tracer."""

from __future__ import annotations

import csv
import io
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


TOOL_DIR = Path(__file__).resolve().parent
REPO_ROOT = TOOL_DIR.parents[1]
DEFAULT_FRONTEND = TOOL_DIR / "profiling_frontend"
DEFAULT_CORE = TOOL_DIR / "picodrive_libretro.so"
DEFAULT_ROM = REPO_ROOT / "build" / "vr60_control_bypass.32x"
TRACE_SPEC = "0xFFC87E:2,0xFF0002:4"
BYTE_EXERCISE_SPEC = f"{TRACE_SPEC},0xFFC822:1"


class WriteTraceIntegrationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.frontend = Path(
            os.environ.get("VRD_TEST_FRONTEND", DEFAULT_FRONTEND)
        ).resolve()
        cls.core = Path(os.environ.get("VRD_TEST_CORE", DEFAULT_CORE)).resolve()
        cls.rom = Path(os.environ.get("VRD_TEST_ROM", DEFAULT_ROM)).resolve()
        for label, path in (
            ("frontend", cls.frontend),
            ("instrumented core", cls.core),
            ("control ROM", cls.rom),
        ):
            if not path.is_file():
                raise RuntimeError(f"{label} is missing: {path}")

    def run_frontend(
        self,
        directory: Path,
        frames: int,
        *,
        trace_spec: str = TRACE_SPEC,
        trace_frames: int | None = None,
        output_name: str = "write.csv",
    ) -> tuple[subprocess.CompletedProcess[str], Path]:
        shutil.copy2(self.frontend, directory / "profiling_frontend")
        shutil.copy2(self.core, directory / "picodrive_libretro.so")
        trace = directory / output_name
        env = os.environ.copy()
        for name in tuple(env):
            if name.startswith("VRD_"):
                env.pop(name)
        env.update(
            VRD_WRITE_TRACE=trace_spec,
            VRD_WRITE_TRACE_LOG=str(trace),
            VRD_PROFILE_FRAMES=str(trace_frames if trace_frames is not None else frames),
        )
        result = subprocess.run(
            ["./profiling_frontend", str(self.rom), str(frames)],
            cwd=directory,
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            timeout=120,
            check=False,
        )
        return result, trace

    def test_boot_trace_captures_overlaps_and_completes(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            result, trace = self.run_frontend(
                Path(temp), 30, trace_spec=BYTE_EXERCISE_SPEC
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            lines = trace.read_text().splitlines()
            self.assertEqual(
                lines[:5],
                [
                    "".join(
                        (
                            "# VRD_WRITE_TRACE version=3 sh2_drc=1 profile_pc=0 ",
                            "profile_pc_env=0 m68k_batching=normal ",
                            "instruction_start_hook=1 composed=1 ",
                            "caller_addr=0xFFFFFFFF caller_max=0 targets=3",
                        )
                    ),
                    "# TARGET index=0 addr=0xFFC87E size=2",
                    "# TARGET index=1 addr=0xFF0002 size=4",
                    "# TARGET index=2 addr=0xFFC822 size=1",
                    "frame,pc,target_addr,target_size,access_addr,access_size,old_value,new_value",
                ],
            )
            self.assertRegex(
                lines[-1], r"^# COMPLETE frames=30 events=\d+ errors=0$"
            )
            csv_lines = [line for line in lines if not line.startswith("#")]
            rows = list(csv.DictReader(io.StringIO("\n".join(csv_lines))))
            self.assertTrue(rows)

            targets = {int(row["target_addr"], 0) for row in rows}
            widths = {int(row["access_size"], 0) for row in rows}
            self.assertEqual(targets, {0xFFC87E, 0xFF0002, 0xFFC822})
            self.assertTrue(
                {1, 2, 4}.issubset(widths),
                "real-core coverage must exercise byte, word, and long callbacks",
            )
            self.assertTrue(
                any(row["old_value"] == row["new_value"] for row in rows),
                "same-value writes must not be filtered",
            )
            self.assertTrue(
                any(
                    int(row["access_addr"], 0) != int(row["target_addr"], 0)
                    for row in rows
                ),
                "an overlapping write need not begin at the target address",
            )
            for row in rows:
                target = int(row["target_addr"], 0)
                target_size = int(row["target_size"], 0)
                access = int(row["access_addr"], 0)
                access_size = int(row["access_size"], 0)
                self.assertLess(access, target + target_size)
                self.assertLess(target, access + access_size)
                self.assertNotEqual(int(row["pc"], 0), 0xFFFFFFFF)

    def test_missing_required_target_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            result, trace = self.run_frontend(
                Path(temp), 1, trace_spec="0xFFC87E:2"
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(trace.exists())
            self.assertIn(
                "required targets are 0xFFC87E:2 and 0xFF0002:4",
                result.stdout + result.stderr,
            )

    def test_existing_output_is_refused_without_modification(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            trace = directory / "write.csv"
            sentinel = b"VR60 existing trace sentinel\n\x00preserve every byte\n"
            trace.write_bytes(sentinel)

            result, returned_trace = self.run_frontend(directory, 1)

            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(returned_trace, trace)
            self.assertEqual(trace.read_bytes(), sentinel)
            self.assertIn(
                f"refusing to overwrite existing trace log {trace}",
                result.stdout + result.stderr,
            )

    def test_early_shutdown_is_marked_incomplete(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            result, trace = self.run_frontend(
                Path(temp), 1, trace_frames=10
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(
                trace.read_text().splitlines()[-1],
                "# INCOMPLETE frames=1 events=0 errors=0 reason=core_deinit",
            )


if __name__ == "__main__":
    unittest.main()
