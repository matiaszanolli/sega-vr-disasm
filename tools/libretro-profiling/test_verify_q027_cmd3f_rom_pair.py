#!/usr/bin/env python3
"""Adversarial tests for the fail-closed Q-027 static verifier."""

from __future__ import annotations

import shutil
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from verify_q027_cmd3f_rom_pair import (  # noqa: E402
    CMD3F_JUMP,
    HANDLER_CALL_TABLE,
    HELPER_END,
    HELPER_START,
    INIT_END,
    INIT_START,
    PAIR_BRANCH,
    PARK_END,
    PARK_START,
    STARTUP_LITERAL,
    VECTOR_START,
    verify_pair,
)


ROOT = Path(__file__).resolve().parents[2]
PATHS = {
    "active": ROOT / "build/vr60_q027_cmd3f_active.32x",
    "control": ROOT / "build/vr60_q027_cmd3f_stage_control.32x",
    "default": ROOT / "build/vr_rebuild.32x",
    "mode1_active": ROOT / "build/vr60_mode1_active.32x",
    "mode1_control": ROOT / "build/vr60_mode1_stage_control.32x",
    "mode2_active": ROOT / "build/vr60_mode2_active.32x",
    "mode2_control": ROOT / "build/vr60_mode2_stage_control.32x",
    "q023_active": ROOT / "build/vr60_q023_mailbox_active.32x",
    "q023_control": ROOT / "build/vr60_q023_mailbox_stage_control.32x",
    "q026_active": ROOT / "build/vr60_q026_player_active.32x",
    "q026_control": ROOT / "build/vr60_q026_player_stage_control.32x",
    "handler_bin": ROOT / "build/sh2/q027_player_stock_dispatch.bin",
    "handler_elf": ROOT / "build/sh2/q027_player_stock_dispatch.elf",
    "active_isr": ROOT / "build/sh2/q027_external_isr_active_core.bin",
    "control_isr": ROOT / "build/sh2/q027_external_isr_control_core.bin",
    "active_isr_elf": ROOT / "build/sh2/q027_external_isr_active.elf",
    "control_isr_elf": ROOT / "build/sh2/q027_external_isr_control.elf",
    "park_bin": ROOT / "build/sh2/q027_master_park.bin",
    "init_bin": ROOT / "build/sh2/q027_external_isr_init.bin",
}
SOURCE_PATHS = (
    "Makefile", "disasm/vrd.asm",
    "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm",
    "disasm/modules/68k/sh2/q027_cmd3f_transport.asm",
    "disasm/sh2/expansion/q027_player_stock_dispatch.s",
    "disasm/sh2/expansion/q027_external_isr.s",
    "disasm/sections/expansion_300000.asm",
)


def verify(*, repo_root: Path = ROOT, **overrides: Path) -> dict[str, object]:
    paths = dict(PATHS)
    paths.update(overrides)
    return verify_pair(paths, repo_root)


class Q027VerifierTests(unittest.TestCase):
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
        self.assertTrue(any(fragment in finding for finding in result["findings"]),
                        result["findings"])

    def test_repository_pair_passes_static_only(self) -> None:
        result = verify()
        self.assertTrue(result["static_eligible"], result["findings"])
        self.assertFalse(result["eligible"])
        self.assertFalse(result["promotable"])
        self.assertTrue(result["cmd3f_stock_dispatch_exercised"])
        self.assertFalse(result["authority_transferred"])
        self.assertFalse(result["fps_claimed"])
        self.assertEqual(result["active_control_differences"], ["0x3041A2", "0x3041A3"])
        self.assertTrue(result["accepted_identities_unchanged"])

    def test_every_identity_is_pinned(self) -> None:
        for name in PATHS:
            if name.endswith("_elf"):
                continue
            with self.subTest(name=name), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    f"{name}_sha256", **{name: self.tamper(PATHS[name], directory, 0)}
                )

    def test_only_one_pair_instruction_is_allowed(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            self.assert_fails_with(
                "active_control_delta",
                active=self.tamper(PATHS["active"], directory, 0x100),
            )
        for name in ("active", "control"):
            with self.subTest(name=name), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    f"{name}_branch",
                    **{name: self.tamper(PATHS[name], directory, PAIR_BRANCH)},
                )

    def test_vectors_startup_and_real_table_target_are_pinned(self) -> None:
        for offset, finding in ((VECTOR_START, "active_vectors"),
                                (STARTUP_LITERAL, "active_startup"),
                                (CMD3F_JUMP, "active_cmd3f_target")):
            with self.subTest(finding=finding), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    finding, active=self.tamper(PATHS["active"], directory, offset)
                )

    def test_exact_helper_sequence_and_padding_are_pinned(self) -> None:
        for offset, finding in ((HELPER_START + 0x22, "active_helper_sequence"),
                                (HELPER_END, "active_helper_padding")):
            with self.subTest(finding=finding), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    finding, active=self.tamper(PATHS["active"], directory, offset)
                )

    def test_handler_mailbox_call_table_and_literal_owners_are_pinned(self) -> None:
        for offset, finding in ((0x301644, "mailbox_image"),
                                (HANDLER_CALL_TABLE, "player_call_table"),
                                (0x301503, "handler_literal_ownership")):
            with self.subTest(finding=finding), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    finding, active=self.tamper(PATHS["active"], directory, offset)
                )

    def test_isr_core_park_init_padding_and_literal_owners_are_pinned(self) -> None:
        for offset, finding in ((0x304000, "active_isr_core"),
                                (0x304314, "active_core_padding"),
                                (PARK_START, "active_park"),
                                (PARK_END, "active_park_padding"),
                                (INIT_START, "active_init"),
                                (INIT_END, "active_init_padding"),
                                (0x304027, "isr_literal_ownership")):
            with self.subTest(finding=finding), tempfile.TemporaryDirectory() as directory:
                self.assert_fails_with(
                    finding, active=self.tamper(PATHS["active"], directory, offset)
                )

    def test_elf_symbols_are_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            self.assert_fails_with(
                "symbols:",
                active_isr_elf=self.tamper(PATHS["active_isr_elf"], directory, 0),
            )

    def test_source_rejects_finalization_pc_and_shared_comm(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            isr = root / "disasm/sh2/expansion/q027_external_isr.s"
            isr.write_text(isr.read_text() + "\n.long 0x06004438\n")
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(any("source_finalization_forbidden" in item
                                for item in result["findings"]))
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            helper = root / "disasm/modules/68k/sh2/q027_cmd3f_transport.asm"
            helper.write_text(helper.read_text() + "\nmove.w #1,COMM7\n")
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(any("source_helper_shared_comm" in item
                                for item in result["findings"]))

    def test_source_pins_ipl_and_comm_publish_order(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            helper = root / "disasm/modules/68k/sh2/q027_cmd3f_transport.asm"
            helper.write_text(helper.read_text().replace("move.w  sr,-(a7)", "nop", 1))
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertIn("source_helper_order", result["findings"])

    def test_source_rejects_prepark_word_test_and_missing_normalization(self) -> None:
        mutations = (
            ("tst.b   COMM0_HI", "tst.w   COMM0_HI", "source_helper_order"),
            ("clr.w   COMM0_HI", "nop", "source_helper_order"),
            ("clr.w   COMM0_HI\n        tst.w   COMM0_HI",
             "clr.w   COMM0_HI\n        nop", "source_helper_order"),
        )
        for old, new, finding in mutations:
            with self.subTest(old=old), tempfile.TemporaryDirectory() as directory:
                root = self.source_root(directory)
                helper = root / "disasm/modules/68k/sh2/q027_cmd3f_transport.asm"
                self.assertEqual(helper.read_text().count(old), 1)
                helper.write_text(helper.read_text().replace(old, new, 1))
                result = verify(repo_root=root)
                self.assertFalse(result["static_eligible"])
                self.assertIn(finding, result["findings"])

    def test_source_rejects_postpublish_comm_and_edge1_word_access(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            helper = root / "disasm/modules/68k/sh2/q027_cmd3f_transport.asm"
            helper.write_text(helper.read_text().replace(
                "move.w  #$013F,COMM0_HI",
                "move.w  #$013F,COMM0_HI\n        tst.b   COMM0_HI", 1))
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertIn("source_helper_comm0_widths", result["findings"])
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            isr = root / "disasm/sh2/expansion/q027_external_isr.s"
            isr.write_text(isr.read_text().replace("mov.b   @r1,r0", "mov.w   @r1,r0", 1))
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(any(item.startswith("source_edge1_comm0_hi:")
                                for item in result["findings"]))

    def test_source_pins_preserved_handler_context(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = self.source_root(directory)
            handler = root / "disasm/sh2/expansion/q027_player_stock_dispatch.s"
            handler.write_text(handler.read_text().replace("stc.l   gbr,@-r15", "nop", 1))
            result = verify(repo_root=root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(any("source_handler:" in item for item in result["findings"]))


if __name__ == "__main__":
    unittest.main()
