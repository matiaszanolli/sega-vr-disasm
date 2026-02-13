#!/usr/bin/env python3
"""Apply rename mapping to 68K game function files.

Reads tools/rename_mapping.tsv and:
  1. Creates subdirectories under disasm/modules/68k/game/
  2. Updates label definitions inside own files
  3. Updates ALL cross-file label references (code + comments)
  4. Updates include directives in section files
  5. Moves files (git mv)

Usage:
  python3 tools/apply_rename_mapping.py --dry-run   # Preview changes
  python3 tools/apply_rename_mapping.py --apply      # Execute changes
"""

import os
import re
import subprocess
import sys
from pathlib import Path
from collections import defaultdict

MAPPING_TSV = Path("tools/rename_mapping.tsv")
DISASM_DIR = Path("disasm")
GAME_DIR = DISASM_DIR / "modules" / "68k" / "game"
SECTIONS_DIR = DISASM_DIR / "sections"


def load_mapping():
    """Load TSV mapping file."""
    entries = []
    with open(MAPPING_TSV, 'r') as f:
        header = f.readline().strip().split('\t')
        for line in f:
            fields = line.strip().split('\t')
            if len(fields) < 6:
                continue
            entry = dict(zip(header, fields))
            entries.append(entry)
    return entries


def build_label_map(entries):
    """Build old_label → new_label for all labels that change.

    Includes both primary labels AND secondary labels (sub-labels)
    defined in files that get renamed.
    """
    label_map = {}
    for e in entries:
        if e['old_label'] != e['new_label']:
            label_map[e['old_label']] = e['new_label']
    return label_map


def collect_all_secondary_labels(entries):
    """Scan files for secondary labels that should NOT be renamed.

    Secondary labels like 'copy_16b_blocks', 'phase_duration_table' etc.
    are defined inside files but are NOT the primary label. These are
    referenced cross-file and must NOT be renamed (they don't change).
    We just need to make sure we don't accidentally match them.
    """
    # This is handled by the regex approach — we only rename labels
    # that are in the label_map, so secondary labels won't be affected.
    pass


def update_all_labels_in_file(filepath, label_map, dry_run=True):
    """Update all label references (definitions + operands + comments) in a file.

    Uses word-boundary matching to replace old labels with new ones.
    """
    with open(filepath, 'r') as f:
        content = f.read()

    original = content

    # Replace each old_label → new_label
    # Sort by length descending to avoid partial matches
    # e.g., "fn_c200_012" must be replaced before "fn_c200_01"
    for old_label, new_label in sorted(label_map.items(), key=lambda x: -len(x[0])):
        if old_label not in content:
            continue
        # Word-boundary replacement: label followed by non-identifier char
        # This handles: label:, label(, label+, label\n, label space, ; label, etc.
        content = re.sub(
            r'\b' + re.escape(old_label) + r'\b',
            new_label,
            content
        )

    if content == original:
        return 0

    if not dry_run:
        with open(filepath, 'w') as f:
            f.write(content)

    return 1


def update_section_includes(entries, dry_run=True):
    """Update include directives in section files."""
    path_map = {}
    for e in entries:
        if e['old_path'] != e['new_path']:
            path_map[e['old_path']] = e['new_path']

    if not path_map:
        return 0

    section_files = sorted(SECTIONS_DIR.glob("code_*.asm"))
    changes = 0

    for sf in section_files:
        with open(sf, 'r') as f:
            content = f.read()

        original = content
        for old_path, new_path in path_map.items():
            old_include = f'include "{old_path}"'
            new_include = f'include "{new_path}"'
            content = content.replace(old_include, new_include)

        if content != original:
            changes += 1
            if not dry_run:
                with open(sf, 'w') as f:
                    f.write(content)
            else:
                n_changes = sum(1 for o, n in zip(original.split('\n'), content.split('\n')) if o != n)
                print(f"  {sf.name}: {n_changes} include(s) updated")

    return changes


def create_subdirectories(entries, dry_run=True):
    """Create subcategory subdirectories."""
    subdirs = set()
    for e in entries:
        new_path = Path(DISASM_DIR) / e['new_path']
        parent = new_path.parent
        if not parent.exists():
            subdirs.add(parent)

    for d in sorted(subdirs):
        if dry_run:
            print(f"  mkdir -p {d}")
        else:
            d.mkdir(parents=True, exist_ok=True)

    return len(subdirs)


def move_files(entries, dry_run=True):
    """Move files using git mv."""
    moves = 0
    errors = []

    for e in entries:
        old_path = DISASM_DIR / e['old_path']
        new_path = DISASM_DIR / e['new_path']

        if old_path == new_path:
            continue

        if not old_path.exists():
            errors.append(f"  MISSING: {old_path}")
            continue

        moves += 1
        if not dry_run:
            result = subprocess.run(
                ['git', 'mv', str(old_path), str(new_path)],
                capture_output=True, text=True
            )
            if result.returncode != 0:
                errors.append(f"  git mv FAILED: {old_path} -> {new_path}: {result.stderr.strip()}")

    return moves, errors


def main():
    if len(sys.argv) != 2 or sys.argv[1] not in ('--dry-run', '--apply'):
        print("Usage: python3 tools/apply_rename_mapping.py [--dry-run|--apply]")
        sys.exit(1)

    dry_run = sys.argv[1] == '--dry-run'
    mode = "DRY RUN" if dry_run else "APPLYING"
    print(f"=== {mode} ===\n")

    if not MAPPING_TSV.exists():
        print(f"ERROR: {MAPPING_TSV} not found. Run generate_rename_mapping.py first.")
        sys.exit(1)

    entries = load_mapping()
    label_map = build_label_map(entries)
    print(f"Loaded {len(entries)} entries from {MAPPING_TSV}")
    print(f"Labels to rename: {len(label_map)}")
    print(f"Files to move: {sum(1 for e in entries if e['old_path'] != e['new_path'])}")

    # Step 1: Create subdirectories
    print(f"\n--- Step 1: Create subdirectories ---")
    n_dirs = create_subdirectories(entries, dry_run)
    print(f"Directories to create: {n_dirs}")

    # Step 2: Update ALL label references across ALL game files
    # This handles: label definitions, self-references, cross-file references, comments
    # Must happen BEFORE moving files
    print(f"\n--- Step 2: Update label references across all game files ---")
    updated = 0
    all_game_files = sorted(GAME_DIR.glob("*.asm"))
    for filepath in all_game_files:
        n = update_all_labels_in_file(filepath, label_map, dry_run)
        updated += n
    print(f"Game files updated: {updated}")

    # Step 3: Update section file includes
    # Must happen BEFORE moving files
    print(f"\n--- Step 3: Update section includes ---")
    n_sections = update_section_includes(entries, dry_run)
    print(f"Section files updated: {n_sections}")

    # Step 4: Move files
    print(f"\n--- Step 4: Move files (git mv) ---")
    n_moves, errors = move_files(entries, dry_run)
    print(f"Files moved: {n_moves}")
    if errors:
        print("ERRORS:")
        for err in errors:
            print(err)

    # Summary
    print(f"\n=== Summary ===")
    print(f"Subdirectories: {n_dirs}")
    print(f"Game files with label updates: {updated}")
    print(f"Section files updated: {n_sections}")
    print(f"Files moved: {n_moves}")
    if errors:
        print(f"Errors: {len(errors)}")
        sys.exit(1)

    if dry_run:
        print(f"\nThis was a dry run. Use --apply to execute.")
    else:
        print(f"\nDone! Run 'make clean && make all' to verify build.")


if __name__ == "__main__":
    main()
