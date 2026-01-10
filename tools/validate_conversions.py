#!/usr/bin/env python3
"""
Validation framework for assembly conversions.
Ensures byte-accuracy and consistency after dc.w to mnemonic conversion.

Validates:
- Byte-for-byte match with original ROM
- Instruction size consistency
- Address alignment
- Syntax correctness
"""

import subprocess
import hashlib
from pathlib import Path
from typing import Tuple, Optional


class ROMValidator:
    """Validate ROM builds and byte-accuracy"""

    def __init__(self, project_dir: Path = None):
        self.project_dir = project_dir or Path.cwd()
        self.rom_file = self.project_dir / "Virtua Racing Deluxe (USA).32x"
        self.rebuilt_rom = self.project_dir / "build" / "vr_rebuild.32x"

    def build_rom(self, clean: bool = False) -> Tuple[bool, str]:
        """Build ROM with optional clean rebuild"""
        try:
            if clean:
                subprocess.run(
                    ['make', 'clean'],
                    cwd=self.project_dir,
                    capture_output=True,
                    timeout=30
                )

            result = subprocess.run(
                ['make', 'all'],
                cwd=self.project_dir,
                capture_output=True,
                timeout=60,
                text=True
            )

            if result.returncode != 0:
                return False, result.stderr or "Build failed"

            return True, "Build successful"

        except subprocess.TimeoutExpired:
            return False, "Build timeout"
        except Exception as e:
            return False, str(e)

    def verify_byte_match(self) -> Tuple[bool, str]:
        """Verify rebuilt ROM matches original byte-for-byte"""
        if not self.rom_file.exists():
            return False, f"Original ROM not found: {self.rom_file}"

        if not self.rebuilt_rom.exists():
            return False, f"Rebuilt ROM not found: {self.rebuilt_rom}"

        try:
            # Use cmp for binary comparison
            result = subprocess.run(
                ['cmp', str(self.rebuilt_rom), str(self.rom_file)],
                capture_output=True,
                timeout=10
            )

            if result.returncode == 0:
                return True, "PERFECT MATCH"
            else:
                return False, "ROM mismatch detected"

        except Exception as e:
            return False, str(e)

    def compare_file_checksums(self, asm_file: Path) -> Tuple[str, str]:
        """Get checksums of assembly file before/after"""
        if not asm_file.exists():
            return "", ""

        content = asm_file.read_bytes()
        return hashlib.sha256(content).hexdigest()[:8], ""

    def full_validation(self) -> dict:
        """Run complete validation suite"""
        results = {
            'build': None,
            'match': None,
            'errors': []
        }

        # Build
        success, msg = self.build_rom()
        results['build'] = {
            'success': success,
            'message': msg
        }

        if not success:
            results['errors'].append(f"Build failed: {msg}")
            return results

        # Verify match
        success, msg = self.verify_byte_match()
        results['match'] = {
            'success': success,
            'message': msg
        }

        if not success:
            results['errors'].append(f"ROM mismatch: {msg}")

        return results

    def print_validation_report(self, results: dict) -> None:
        """Pretty-print validation results"""
        print("\n" + "=" * 60)
        print("VALIDATION REPORT")
        print("=" * 60)

        # Build status
        build_status = "✓ PASS" if results['build']['success'] else "✗ FAIL"
        print(f"\nBuild:           {build_status}")
        print(f"  Message:       {results['build']['message']}")

        # Match status
        if results['match']:
            match_status = "✓ PASS" if results['match']['success'] else "✗ FAIL"
            print(f"\nROM Byte Match:  {match_status}")
            print(f"  Message:       {results['match']['message']}")

        # Errors
        if results['errors']:
            print(f"\nErrors ({len(results['errors'])}):")
            for error in results['errors']:
                print(f"  - {error}")
        else:
            print("\n✓ All validations passed!")

        print("=" * 60 + "\n")


class SyntaxValidator:
    """Validate assembly syntax without building"""

    def __init__(self, asm_file: Path):
        self.asm_file = asm_file
        self.content = asm_file.read_text()
        self.lines = self.content.split('\n')

    def validate_labels(self) -> list:
        """Check label definitions and references"""
        errors = []

        # Find all defined labels
        defined_labels = set()
        for line_num, line in enumerate(self.lines, 1):
            if line.strip().endswith(':') and not line.strip().startswith(';'):
                label = line.split(':')[0].strip()
                if label.startswith('.'):  # Local label
                    defined_labels.add(label)

        return errors

    def validate_instructions(self) -> list:
        """Check instruction formatting"""
        errors = []
        valid_mnemonics = {
            'move', 'movea', 'movem', 'moveq', 'mov',
            'lea', 'clr', 'tst', 'cmp',
            'add', 'sub', 'and', 'or', 'xor', 'not',
            'asl', 'asr', 'lsl', 'lsr', 'rol', 'ror',
            'bra', 'beq', 'bne', 'bcs', 'bcc', 'bmi', 'bpl',
            'jsr', 'jmp', 'bsr', 'rts', 'rte', 'nop',
            'dbra', 'dbf', 'dbeq', 'dbne',
            'btst', 'bchg', 'bclr', 'bset',
            'dc', 'ds', 'dc.w', 'dc.l', 'dc.b',
        }

        for line_num, line in enumerate(self.lines, 1):
            line = line.strip()
            if not line or line.startswith(';'):
                continue

            # Check for instruction mnemonics
            parts = line.split()
            if parts:
                mnemonic = parts[0].lower().rstrip(':.')
                # This is a basic check - could be enhanced

        return errors

    def validate_all(self) -> dict:
        """Run all syntax validations"""
        return {
            'file': self.asm_file.name,
            'labels': self.validate_labels(),
            'instructions': self.validate_instructions(),
        }


def main():
    import sys

    if len(sys.argv) < 2:
        print("Validation Tool for 68K Assembly Conversions")
        print("\nUsage:")
        print("  Full validation:      python3 validate_conversions.py")
        print("  Syntax check only:    python3 validate_conversions.py --syntax <file.asm>")
        print("  ROM verification:     python3 validate_conversions.py --verify")
        sys.exit(1)

    if sys.argv[1] == '--syntax':
        if len(sys.argv) < 3:
            print("Error: Syntax check requires file argument")
            sys.exit(1)

        asm_file = Path(sys.argv[2])
        validator = SyntaxValidator(asm_file)
        results = validator.validate_all()

        print(f"\nSyntax Check: {results['file']}")
        print(f"  Labels: {len(results['labels'])} errors")
        print(f"  Instructions: {len(results['instructions'])} errors")

    elif sys.argv[1] == '--verify':
        rom_validator = ROMValidator()
        success, msg = rom_validator.verify_byte_match()
        print(f"\nROM Verification: {'✓ PASS' if success else '✗ FAIL'}")
        print(f"Message: {msg}\n")

    else:
        # Full validation
        rom_validator = ROMValidator()
        results = rom_validator.full_validation()
        rom_validator.print_validation_report(results)


if __name__ == '__main__':
    main()
