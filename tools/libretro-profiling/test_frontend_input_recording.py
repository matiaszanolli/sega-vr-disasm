#!/usr/bin/env python3
"""Deterministic real-core acceptance test for VR60-003 input capture/replay."""

from __future__ import annotations

import csv
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


TOOL_DIR = Path(__file__).resolve().parent
REPO_ROOT = TOOL_DIR.parents[1]
DEFAULT_FRONTEND = TOOL_DIR / "profiling_frontend"
DEFAULT_ROM = REPO_ROOT / "build" / "vr_rebuild.32x"
RECORD_TEMPLATE = TOOL_DIR / "fixtures" / "input_record_600.commands.in"
REPLAY_TEMPLATE = TOOL_DIR / "fixtures" / "input_replay_600.commands.in"
SEGMENTS = (
    (73, 0x0008),
    (127, 0x0100),
    (89, 0x0140),
    (111, 0x0180),
    (95, 0x0001),
    (105, 0x0101),
)


class FrontendInputRecordingIntegrationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.frontend = Path(
            os.environ.get("VRD_TEST_FRONTEND", DEFAULT_FRONTEND)
        ).resolve()
        cls.rom = Path(os.environ.get("VRD_TEST_ROM", DEFAULT_ROM)).resolve()
        if not cls.frontend.is_file():
            raise RuntimeError(f"frontend is missing: {cls.frontend}")
        if not cls.rom.is_file():
            raise RuntimeError(f"test ROM is missing: {cls.rom}")
        if not (TOOL_DIR / "picodrive_libretro.so").is_file():
            raise RuntimeError("picodrive_libretro.so is missing")

    def run_debugger(
        self,
        directory: Path,
        commands: str,
        *,
        frames: int = 600,
        input_script: Path | None = None,
    ) -> subprocess.CompletedProcess[str]:
        script = directory / "commands.txt"
        script.write_text(commands)
        env = os.environ.copy()
        for name in tuple(env):
            if name.startswith("VRD_"):
                env.pop(name)
        if input_script is not None:
            env["VRD_INPUT_SCRIPT"] = str(input_script)
        return subprocess.run(
            [
                str(self.frontend),
                str(self.rom),
                str(frames),
                "--debug-script",
                str(script),
            ],
            cwd=TOOL_DIR,
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            timeout=120,
            check=False,
        )

    def test_varying_600_frame_recording_replays_byte_identically(self) -> None:
        expected_masks = [
            mask for count, mask in SEGMENTS for _ in range(count)
        ]
        self.assertEqual(len(expected_masks), 600)
        expected_bytes = (
            "frame,mask\n"
            + "".join(
                f"{frame},0x{mask:04X}\n"
                for frame, mask in enumerate(expected_masks)
            )
        ).encode()

        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            captured = directory / "captured.csv"
            record_commands = RECORD_TEMPLATE.read_text().replace(
                "@OUTPUT@", str(captured)
            )
            recorded = self.run_debugger(directory, record_commands)
            self.assertEqual(recorded.returncode, 0, recorded.stdout + recorded.stderr)
            self.assertEqual(captured.read_bytes(), expected_bytes)

            with captured.open(newline="") as stream:
                reader = csv.DictReader(stream)
                self.assertEqual(reader.fieldnames, ["frame", "mask"])
                rows = list(reader)
            self.assertEqual(len(rows), 600)
            self.assertEqual([int(row["frame"], 0) for row in rows], list(range(600)))
            self.assertEqual([int(row["mask"], 0) for row in rows], expected_masks)
            self.assertNotIn(0, expected_masks, "default zero masks are not part of this fixture")

            replayed = directory / "replayed.csv"
            replay_commands = REPLAY_TEMPLATE.read_text().replace(
                "@OUTPUT@", str(replayed)
            )
            replay = self.run_debugger(
                directory, replay_commands, input_script=captured
            )
            self.assertEqual(replay.returncode, 1, replay.stdout + replay.stderr)
            self.assertIn("Input replay exhausted at frame 600", replay.stderr)
            self.assertEqual(replayed.read_bytes(), captured.read_bytes())

    def test_script_error_discards_an_active_recording(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            one_frame_script = directory / "one-frame.csv"
            one_frame_script.write_text("frame,mask\n0,0x0100\n")
            partial = directory / "partial.csv"
            commands = f"record start {partial}\nrun 1\nrun 1\n"
            result = self.run_debugger(
                directory, commands, frames=1, input_script=one_frame_script
            )
            self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
            self.assertIn("Input replay exhausted at frame 1", result.stderr)
            self.assertIn("discarding partial file", result.stderr)
            self.assertFalse(partial.exists())

    def test_quit_and_eof_discard_active_recordings(self) -> None:
        for suffix, ending in (("quit", "quit\n"), ("eof", "")):
            with self.subTest(suffix=suffix), tempfile.TemporaryDirectory() as temp:
                directory = Path(temp)
                partial = directory / f"partial-{suffix}.csv"
                commands = f"record start {partial}\n{ending}"
                result = self.run_debugger(directory, commands, frames=1)
                self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
                self.assertIn("discarding partial file", result.stderr)
                self.assertFalse(partial.exists())

    def test_record_start_refuses_to_overwrite(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            existing = directory / "existing.csv"
            existing.write_text("do not overwrite\n")
            result = self.run_debugger(
                directory, f"record start {existing}\n", frames=1
            )
            self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
            self.assertIn("Cannot create new input recording", result.stderr)
            self.assertEqual(existing.read_text(), "do not overwrite\n")

    def test_replay_requires_the_header_and_ordered_rows(self) -> None:
        scripts = {
            "missing-header": "0,0x0008\n1,0x0100\n",
            "out-of-order": "frame,mask\n1,0x0100\n0,0x0008\n",
        }
        for name, contents in scripts.items():
            with self.subTest(name=name), tempfile.TemporaryDirectory() as temp:
                directory = Path(temp)
                replay = directory / f"{name}.csv"
                replay.write_text(contents)
                result = self.run_debugger(
                    directory, "quit\n", frames=2, input_script=replay
                )
                self.assertEqual(result.returncode, 1, result.stdout + result.stderr)
                self.assertIn("Invalid input script row", result.stderr)


if __name__ == "__main__":
    unittest.main()
