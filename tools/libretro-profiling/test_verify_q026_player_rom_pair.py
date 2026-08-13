#!/usr/bin/env python3
"""Adversarial tests for the fail-closed Q-026 static verifier."""

from __future__ import annotations

import shutil
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from verify_q026_player_rom_pair import (  # noqa: E402
    CMD3F_JUMP,
    HANDLER_POOL,
    HANDLER_START,
    ISR_INIT_END,
    ISR_INIT_START,
    STARTUP_LITERAL,
    TRIGGER_START,
    VECTOR_START,
    verify_pair,
)


ROOT = Path(__file__).resolve().parents[2]
PATHS = {
    "active": ROOT / "build/vr60_q026_player_active.32x",
    "control": ROOT / "build/vr60_q026_player_stage_control.32x",
    "default": ROOT / "build/vr_rebuild.32x",
    "mode1_active": ROOT / "build/vr60_mode1_active.32x",
    "mode1_control": ROOT / "build/vr60_mode1_stage_control.32x",
    "mode2_active": ROOT / "build/vr60_mode2_active.32x",
    "mode2_control": ROOT / "build/vr60_mode2_stage_control.32x",
    "q023_active": ROOT / "build/vr60_q023_mailbox_active.32x",
    "q023_control": ROOT / "build/vr60_q023_mailbox_stage_control.32x",
    "handler_bin": ROOT / "build/sh2/q026_player_shadow.bin",
    "handler_elf": ROOT / "build/sh2/q026_player_shadow.elf",
    "isr_bin": ROOT / "build/sh2/q026_external_isr.bin",
    "isr_elf": ROOT / "build/sh2/q026_external_isr.elf",
}

SOURCE_PATHS = (
    "Makefile", "disasm/vrd.asm",
    "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm",
    "disasm/sh2/expansion/q026_player_shadow.s",
    "disasm/sh2/expansion/q026_external_isr.s",
    "disasm/sections/expansion_300000.asm",
    "disasm/sections/code_20200.asm",
)


def verify(*, repo_root: Path = ROOT, **overrides: Path) -> dict[str, object]:
    paths = dict(PATHS)
    paths.update(overrides)
    return verify_pair(paths, repo_root)


class Q026VerifierTests(unittest.TestCase):
    def tamper(self, source: Path, directory: str, offset: int) -> Path:
        destination = Path(directory) / source.name
        image = bytearray(source.read_bytes())
        image[offset] ^= 1
        destination.write_bytes(image)
        return destination

    def source_root(self, directory: str) -> Path:
        root = Path(directory)
        for relative in SOURCE_PATHS:
            destination = root / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(ROOT / relative, destination)
        return root

    def assert_fails_with(self, fragment: str, **overrides: Path) -> None:
        result = verify(**overrides)
        self.assertFalse(result["static_eligible"])
        self.assertTrue(
            any(fragment in finding for finding in result["findings"]),
            result["findings"],
        )

    def test_repository_pair_passes_static_only(self) -> None:
        result = verify()
        self.assertTrue(result["static_eligible"], result["findings"])
        self.assertFalse(result["eligible"])
        self.assertFalse(result["promotable"])
        self.assertFalse(result["cmd3f_enabled"])
        self.assertTrue(result["accepted_identities_unchanged"])
        self.assertEqual(len(result["active_control_differences"]), 8)

    def test_each_accepted_identity_is_pinned(self) -> None:
        for name in ("default", "mode1_active", "mode1_control", "mode2_active",
                     "mode2_control", "q023_active", "q023_control"):
            with self.subTest(name=name), tempfile.TemporaryDirectory() as directory:
                path = self.tamper(PATHS[name], directory, 0)
                result = verify(**{name: path})
                self.assertFalse(result["static_eligible"])
                self.assertFalse(result["accepted_identities_unchanged"])

    def test_extra_pair_delta_fails(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            self.assert_fails_with(
                "active_control_delta",
                active=self.tamper(PATHS["active"], directory, 0x100),
            )

    def test_active_and_control_trigger_slots_are_pinned(self) -> None:
        for name in ("active", "control"):
            with self.subTest(name=name), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    f"{name}_trigger",
                    **{name: self.tamper(PATHS[name], directory, TRIGGER_START)},
                )

    def test_vectors_startup_and_cmd3f_registration_are_pinned(self) -> None:
        for offset, fragment in (
            (VECTOR_START, "active_vectors"),
            (STARTUP_LITERAL, "active_startup"),
            (CMD3F_JUMP, "active_cmd3f_registered"),
        ):
            with self.subTest(fragment=fragment), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    fragment, active=self.tamper(PATHS["active"], directory, offset)
                )

    def test_handler_pool_and_literal_ownership_are_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            offset = min(HANDLER_POOL)
            self.assert_fails_with(
                "handler_pool", active=self.tamper(PATHS["active"], directory, offset)
            )
        with tempfile.TemporaryDirectory() as directory:
            self.assert_fails_with(
                "handler_literal_ownership",
                active=self.tamper(PATHS["active"], directory, HANDLER_START + 3),
            )

    def test_handler_binary_and_reserved_padding_are_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            self.assert_fails_with(
                "active_handler",
                handler_bin=self.tamper(PATHS["handler_bin"], directory, 0),
            )
        with tempfile.TemporaryDirectory() as directory:
            self.assert_fails_with(
                "active_handler_padding",
                active=self.tamper(PATHS["active"], directory, 0x3015C8),
            )

    def test_isr_core_init_and_padding_are_pinned(self) -> None:
        for offset, fragment in (
            (0x304000, "active_isr_core"),
            (0x304290, "active_isr_middle_padding"),
            (ISR_INIT_START, "active_isr_init"),
            (ISR_INIT_END, "active_isr_tail_padding"),
        ):
            with self.subTest(fragment=fragment), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    fragment, active=self.tamper(PATHS["active"], directory, offset)
                )

    def test_isr_literal_ownership_is_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            self.assert_fails_with(
                "isr_literal_ownership",
                active=self.tamper(PATHS["active"], directory, 0x304027),
            )

    def test_elf_symbol_addresses_are_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            self.assert_fails_with(
                "symbols:", isr_elf=self.tamper(PATHS["isr_elf"], directory, 0)
            )

    def test_source_mutual_exclusion_is_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            source = root / "disasm/vrd.asm"
            source.write_text(source.read_text().replace(
                "Q-026 and mode-2 validation are mutually exclusive",
                "removed Q-026 guard",
            ))
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(any("source_mutual_exclusion" in item for item in result["findings"]))

    def test_source_handler_exclusion_is_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            source = root / "disasm/sh2/expansion/q026_player_shadow.s"
            source.write_text(source.read_text() + "\n    mov.l @(.COMM,pc),r0\n")
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(any("source_handler_forbidden:COMM" in item for item in result["findings"]))

    def test_admission_local_canary_refresh_is_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            source = root / "disasm/sh2/expansion/q026_external_isr.s"
            source.write_text(source.read_text().replace(
                "    mov.l   r2,@r1\n    mov.l   @r1,r0\n",
                "    nop\n    mov.l   @r1,r0\n",
                1,
            ))
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(any("source_isr:" in item for item in result["findings"]))


if __name__ == "__main__":
    unittest.main()
