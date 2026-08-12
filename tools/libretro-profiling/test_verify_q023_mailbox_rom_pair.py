#!/usr/bin/env python3
"""Focused adversarial tests for the Q-023 mailbox-pair verifier."""

from __future__ import annotations

import tempfile
import unittest
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from verify_q023_mailbox_rom_pair import (
    CMD3F_JUMP_OFFSET,
    CORRECTED_LITERAL,
    HANDLER_OFFSET,
    LITERAL_OFFSET,
    LITERAL_RELATIVE_OFFSET,
    LOAD_RELATIVE_OFFSET,
    verify_pair,
)


ROOT = Path(__file__).resolve().parents[2]
ACTIVE = ROOT / "build/vr60_q023_mailbox_active.32x"
CONTROL = ROOT / "build/vr60_q023_mailbox_stage_control.32x"
DEFAULT = ROOT / "build/vr_rebuild.32x"
MODE1_ACTIVE = ROOT / "build/vr60_mode1_active.32x"
MODE1_CONTROL = ROOT / "build/vr60_mode1_stage_control.32x"
MODE1_ISR = ROOT / "build/sh2/cmd3e_mode1_validation.bin"
MODE2_ACTIVE = ROOT / "build/vr60_mode2_active.32x"
MODE2_CONTROL = ROOT / "build/vr60_mode2_stage_control.32x"
MODE2_ISR = ROOT / "build/sh2/cmd3e_mode2_validation.bin"
LEGACY_HANDLER = ROOT / "build/sh2/cmd3f_vr60_gameframe.bin"
CORRECTED_HANDLER = ROOT / "build/sh2/cmd3f_vr60_gameframe_q023_corrected.bin"


def verify(**overrides: Path):
    paths = {
        "active_path": ACTIVE,
        "control_path": CONTROL,
        "default_path": DEFAULT,
        "mode1_active_path": MODE1_ACTIVE,
        "mode1_control_path": MODE1_CONTROL,
        "mode1_isr_path": MODE1_ISR,
        "mode2_active_path": MODE2_ACTIVE,
        "mode2_control_path": MODE2_CONTROL,
        "mode2_isr_path": MODE2_ISR,
        "legacy_handler_path": LEGACY_HANDLER,
        "corrected_handler_path": CORRECTED_HANDLER,
        "repo_root": ROOT,
    }
    paths.update(overrides)
    return verify_pair(**paths)


class Q023MailboxVerifierTests(unittest.TestCase):
    def tamper(self, source: Path, temp: str, offset: int) -> Path:
        path = Path(temp) / source.name
        image = bytearray(source.read_bytes())
        image[offset] ^= 1
        path.write_bytes(image)
        return path

    def source_root(self, temp: str) -> Path:
        root = Path(temp)
        relative_paths = (
            "Makefile",
            "disasm/vrd.asm",
            "disasm/sh2/expansion/cmd3f_vr60_gameframe.asm",
            "disasm/sections/expansion_300000.asm",
            "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm",
            "disasm/modules/68k/game/scene/game_frame_orch_013.asm",
        )
        for relative in relative_paths:
            destination = root / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            destination.write_bytes((ROOT / relative).read_bytes())
        return root

    def test_repository_pair_passes_only_the_static_gate(self) -> None:
        result = verify()
        self.assertTrue(result["static_eligible"], result["findings"])
        self.assertFalse(result["eligible"])
        self.assertFalse(result["promotable"])
        self.assertFalse(result["cmd3f_enabled"])
        self.assertEqual(
            result["runtime_evidence"], "NOT_APPLICABLE_CMD3F_UNREACHABLE"
        )
        self.assertTrue(result["accepted_identities_unchanged"])
        self.assertEqual(result["active_control_differences"], ["0x301638"])
        self.assertEqual(result["handler_differences"], ["0x138"])

    def test_wrong_active_literal_fails_closed(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            path = self.tamper(ACTIVE, temp, LITERAL_OFFSET)
            result = verify(active_path=path)
            self.assertFalse(result["static_eligible"])
            self.assertIn("active_mailbox_literal", result["findings"])

    def test_any_extra_rom_delta_fails_closed(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            path = self.tamper(ACTIVE, temp, 0x100)
            result = verify(active_path=path)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(
                any(item.startswith("active_control_differences:") for item in result["findings"])
            )

    def test_control_and_default_identity_fail_closed(self) -> None:
        for argument, source in (
            ("control_path", CONTROL),
            ("default_path", DEFAULT),
        ):
            with self.subTest(argument=argument), tempfile.TemporaryDirectory() as temp:
                result = verify(**{argument: self.tamper(source, temp, 0x100)})
                self.assertFalse(result["static_eligible"])

    def test_every_accepted_mode_identity_is_pinned(self) -> None:
        for argument, source in (
            ("mode1_active_path", MODE1_ACTIVE),
            ("mode1_control_path", MODE1_CONTROL),
            ("mode1_isr_path", MODE1_ISR),
            ("mode2_active_path", MODE2_ACTIVE),
            ("mode2_control_path", MODE2_CONTROL),
            ("mode2_isr_path", MODE2_ISR),
        ):
            with self.subTest(argument=argument), tempfile.TemporaryDirectory() as temp:
                result = verify(**{argument: self.tamper(source, temp, 0)})
                self.assertFalse(result["static_eligible"])
                self.assertFalse(result["accepted_identities_unchanged"])

    def test_cmd3f_jump_is_pinned_and_not_retargeted(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            path = self.tamper(ACTIVE, temp, CMD3F_JUMP_OFFSET)
            result = verify(active_path=path)
            self.assertFalse(result["static_eligible"])
            self.assertIn("active_cmd3f_jump", result["findings"])

    def test_load_opcode_and_literal_ownership_are_pinned(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            path = self.tamper(
                CORRECTED_HANDLER, temp, LOAD_RELATIVE_OFFSET
            )
            result = verify(corrected_handler_path=path)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(
                any(item.startswith("corrected_literal_users:") for item in result["findings"])
            )

    def test_handler_literal_position_cannot_move(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / CORRECTED_HANDLER.name
            image = bytearray(CORRECTED_HANDLER.read_bytes())
            image[LITERAL_RELATIVE_OFFSET : LITERAL_RELATIVE_OFFSET + 4] = b"\0" * 4
            image[LITERAL_RELATIVE_OFFSET + 4 : LITERAL_RELATIVE_OFFSET + 8] = CORRECTED_LITERAL
            path.write_bytes(image)
            result = verify(corrected_handler_path=path)
            self.assertFalse(result["static_eligible"])

    def test_q023_flag_leak_into_68k_hook_fails_source_policy(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            source_root = self.source_root(temp)
            hook = source_root / "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm"
            hook.write_text(
                hook.read_text(encoding="utf-8") + "\n; VR60_Q023 injected\n",
                encoding="utf-8",
            )
            result = verify(repo_root=source_root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(
                any(item.startswith("q023_flag_leaked_to_hook:") for item in result["findings"])
            )

    def test_uncommented_cmd3f_trigger_fails_source_policy(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            source_root = self.source_root(temp)
            hook = source_root / "disasm/modules/68k/sh2/vr60_1p_staging_hook.asm"
            hook.write_text(
                hook.read_text(encoding="utf-8")
                + "\n        jsr     vr60_1p_comm_trigger\n",
                encoding="utf-8",
            )
            result = verify(repo_root=source_root)
            self.assertFalse(result["static_eligible"])
            self.assertIn("cmd3f_trigger_enabled", result["findings"])

    def test_source_build_guards_fail_closed(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            source_root = self.source_root(temp)
            vrd = source_root / "disasm/vrd.asm"
            vrd.write_text(
                vrd.read_text(encoding="utf-8").replace(
                    "Q-023 and mode-2 validation are mutually exclusive",
                    "removed Q-023 guard",
                ),
                encoding="utf-8",
            )
            result = verify(repo_root=source_root)
            self.assertFalse(result["static_eligible"])
            self.assertTrue(
                any(item.startswith("vrd_guard:") for item in result["findings"])
            )


if __name__ == "__main__":
    unittest.main()
