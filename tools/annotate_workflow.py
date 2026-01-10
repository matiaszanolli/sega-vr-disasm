#!/usr/bin/env python3
"""
Annotation Workflow Orchestrator - Coordinates all annotation tools.

This is the main entry point for batch annotation sessions.
Manages: annotation → documentation → validation → commit

Usage:
    python3 annotate_workflow.py --help
    python3 annotate_workflow.py --phase 1 --count 10
    python3 annotate_workflow.py --batch <function_list.txt>
"""

import sys
import subprocess
from pathlib import Path
from typing import List, Optional
from datetime import datetime


class AnnotationWorkflow:
    """Orchestrate annotation, validation, and commit workflow"""

    def __init__(self, project_dir: Path = None):
        self.project_dir = project_dir or Path.cwd()
        self.sections_dir = self.project_dir / "disasm" / "sections"
        self.tools_dir = self.project_dir / "tools"
        self.log_file = self.project_dir / "annotation_log.txt"

        self.stats = {
            'files_processed': 0,
            'functions_annotated': 0,
            'build_failures': 0,
            'conversion_failures': 0,
        }

    def log(self, message: str, level: str = "INFO") -> None:
        """Log message to file and stdout"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_entry = f"[{timestamp}] {level:8s} {message}"
        print(log_entry)

        with open(self.log_file, 'a') as f:
            f.write(log_entry + '\n')

    def run_command(self, cmd: List[str], description: str = "") -> bool:
        """Run command and return success status"""
        try:
            if description:
                self.log(f"Running: {description}")

            result = subprocess.run(
                cmd,
                cwd=self.project_dir,
                capture_output=True,
                timeout=120,
                text=True
            )

            if result.returncode != 0:
                self.log(f"Error: {description} failed", "ERROR")
                if result.stderr:
                    self.log(f"  {result.stderr[:200]}", "ERROR")
                return False

            return True

        except subprocess.TimeoutExpired:
            self.log(f"Timeout: {description}", "ERROR")
            return False
        except Exception as e:
            self.log(f"Exception: {str(e)}", "ERROR")
            return False

    def annotate_file(self, asm_file: Path) -> bool:
        """Annotate single file"""
        self.log(f"Annotating {asm_file.name}...")

        # Run enhanced annotation
        result = self.run_command(
            ['python3', str(self.tools_dir / 'enhanced_annotate.py'), str(asm_file)],
            f"Annotate {asm_file.name}"
        )

        if result:
            self.stats['files_processed'] += 1
        else:
            self.stats['conversion_failures'] += 1

        return result

    def verify_build(self) -> bool:
        """Verify ROM builds and matches original"""
        self.log("Verifying ROM build...", "INFO")

        # Build
        if not self.run_command(['make', 'all'], "Build ROM"):
            self.stats['build_failures'] += 1
            return False

        # Verify match
        result = subprocess.run(
            ['cmp', 'build/vr_rebuild.32x', 'Virtua Racing Deluxe (USA).32x'],
            cwd=self.project_dir,
            capture_output=True
        )

        if result.returncode == 0:
            self.log("✓ PERFECT MATCH verified", "SUCCESS")
            return True
        else:
            self.log("✗ ROM mismatch detected", "ERROR")
            self.stats['build_failures'] += 1
            return False

    def commit_changes(self, message: str, files: List[Path]) -> bool:
        """Commit changes to git"""
        self.log(f"Committing {len(files)} files...", "INFO")

        try:
            # Stage files
            for f in files:
                subprocess.run(
                    ['git', 'add', str(f)],
                    cwd=self.project_dir,
                    check=True
                )

            # Commit with message
            subprocess.run(
                ['git', 'commit', '-m', message],
                cwd=self.project_dir,
                check=True
            )

            self.log("✓ Changes committed", "SUCCESS")
            return True

        except subprocess.CalledProcessError as e:
            self.log(f"Git commit failed: {str(e)}", "ERROR")
            return False

    def process_phase(self, phase: int, file_count: int = 5) -> None:
        """Process annotation phase"""
        phase_info = {
            1: ("High-frequency hotspot functions", ['code_e000.asm', 'code_1000.asm']),
            2: ("Entry point initialization", ['entry_point.asm']),
            3: ("Game logic and utilities", ['code_2000.asm', 'code_4000.asm']),
        }

        if phase not in phase_info:
            self.log(f"Unknown phase: {phase}", "ERROR")
            return

        phase_name, files = phase_info[phase]
        self.log(f"Starting Phase {phase}: {phase_name}", "INFO")

        annotated_files = []

        for filename in files:
            asm_file = self.sections_dir / filename
            if not asm_file.exists():
                self.log(f"File not found: {filename}", "WARN")
                continue

            if self.annotate_file(asm_file):
                annotated_files.append(asm_file)

        if annotated_files:
            # Verify all changes together
            if self.verify_build():
                commit_msg = f"feat: Phase {phase} - {phase_name}\n\n" \
                           f"Annotated {len(annotated_files)} files"
                self.commit_changes(commit_msg, annotated_files)
            else:
                self.log("Build verification failed - not committing", "ERROR")
        else:
            self.log("No files to process", "WARN")

        self.print_summary()

    def process_batch_list(self, function_list: List[str]) -> None:
        """Process specific functions from list"""
        self.log(f"Processing {len(function_list)} functions from batch list", "INFO")

        annotated = 0
        failed = 0

        for func_name in function_list:
            self.log(f"Processing {func_name}...", "INFO")
            # Would need to find which file contains this function
            annotated += 1

        self.log(f"Batch complete: {annotated} succeeded, {failed} failed", "INFO")
        self.print_summary()

    def print_summary(self) -> None:
        """Print workflow summary"""
        print("\n" + "=" * 70)
        print("WORKFLOW SUMMARY")
        print("=" * 70)
        print(f"Files processed:           {self.stats['files_processed']}")
        print(f"Functions annotated:       {self.stats['functions_annotated']}")
        print(f"Build failures:            {self.stats['build_failures']}")
        print(f"Conversion failures:       {self.stats['conversion_failures']}")
        print("=" * 70 + "\n")


def print_help():
    """Print usage information"""
    print("""
Annotation Workflow - Orchestrate 68K assembly annotation

USAGE:
    python3 annotate_workflow.py [OPTIONS]

OPTIONS:
    --help                  Show this help message
    --phase <N>             Run phase N (1=hotspots, 2=entry, 3=game logic)
    --count <N>             Number of files to process (default: 5)
    --file <path>           Annotate single file
    --batch <list.txt>      Process functions from list file
    --verify                Just verify current build
    --commit <msg>          Commit with message (after verification)

EXAMPLES:
    # Annotate Phase 1 with 10 files
    python3 annotate_workflow.py --phase 1 --count 10

    # Process single file
    python3 annotate_workflow.py --file disasm/sections/code_1000.asm

    # Verify current build
    python3 annotate_workflow.py --verify

    # Process batch list
    python3 annotate_workflow.py --batch functions_to_do.txt

WORKFLOW:
    1. Annotation     - Convert dc.w to mnemonics
    2. Documentation  - Generate function headers
    3. Validation     - Build and verify ROM
    4. Commit         - Git commit with message
    """)


def main():
    if len(sys.argv) < 2 or sys.argv[1] == '--help':
        print_help()
        sys.exit(0)

    workflow = AnnotationWorkflow()

    if sys.argv[1] == '--phase':
        phase = int(sys.argv[2]) if len(sys.argv) > 2 else 1
        count = int(sys.argv[4]) if '--count' in sys.argv and len(sys.argv) > sys.argv.index('--count') + 1 else 5
        workflow.process_phase(phase, count)

    elif sys.argv[1] == '--file':
        if len(sys.argv) < 3:
            print("Error: --file requires path argument")
            sys.exit(1)
        asm_file = Path(sys.argv[2])
        workflow.annotate_file(asm_file)
        workflow.verify_build()

    elif sys.argv[1] == '--verify':
        workflow.verify_build()

    elif sys.argv[1] == '--batch':
        if len(sys.argv) < 3:
            print("Error: --batch requires file argument")
            sys.exit(1)
        # Would load function list from file
        workflow.log("Batch processing not yet implemented", "WARN")

    else:
        print(f"Unknown option: {sys.argv[1]}")
        print_help()
        sys.exit(1)


if __name__ == '__main__':
    main()
