#!/usr/bin/env python3
"""Generate rename mapping for 68K game function files in auto/.

Reads all .asm files in disasm/modules/68k/game/auto/, extracts headers,
proposes mnemonic names + subcategories, and outputs a TSV mapping file.

Auto-analyzed files (stub headers) stay in auto/ with original names.
Documented files get snake_case names and move to subcategory directories.

Usage:
    cd /path/to/project
    python3 tools/generate_rename_mapping.py
    # Review tools/rename_mapping.tsv
"""

import os
import re
import sys
from pathlib import Path
from collections import defaultdict

PROJECT_ROOT = Path(__file__).parent.parent
GAME_DIR = PROJECT_ROOT / "disasm" / "modules" / "68k" / "game"
AUTO_DIR = GAME_DIR / "auto"
OUTPUT_TSV = PROJECT_ROOT / "tools" / "rename_mapping.tsv"

# Keyword-to-subcategory mapping (order matters — first match wins)
SUBCATEGORY_RULES = [
    # Sound / FM / PSG (must be early — many fn_30200 files)
    (["fm ", "fm_", "psg ", "psg_", "z80 ", "dac ",
     "sound driver", "sound program", "sound priority", "sound command",
     "system command dispatcher",
     "key-on", "key-off", "key off",
     "instrument setup", "instrument register", "instrument loader",
     "instrument index", "instrument number",
     "envelope tick", "envelope number", "envelope command",
     "total level", "tl reset", "tl scaling",
     "panning envelope", "panning init", "set panning", "write panning",
     "channel pause", "channel resume", "channel cleanup",
     "channel tempo", "channel timer", "channel multiplier",
     "channel register", "channel pointer", "channel stop",
     "fade in", "fade out", "fade clear", "full silence", "all silence",
     "vibrato setup", "vibrato check",
     "pitch bend", "base frequency", "frequency table",
     "ssg-eg", "operator register",
     "sequence process", "sequence data", "sequence command",
     "sequence tick", "sequence loop", "sequence call",
     "stack pop return", "set envelope", "set instrument",
     "note-off", "note off",
     "volume adjust", "volume writer", "volume envelope",
     "set volume", "set position + silence",
     "conditional write", "write wrapper", "write port",
     "init channel"], "sound"),

    # AI
    (["ai ", "ai_", "opponent", "steering calc"], "ai"),

    # Camera
    (["camera "], "camera"),

    # Collision / proximity
    (["collision", "proximity", "close position", "sine billboard"], "collision"),

    # HUD / digit / BCD
    (["hud", "digit renderer", "digit tile", "bcd ",
     "nibble splitter", "ascii character",
     "tile blit", "tile dma", "display entry",
     "display element"], "hud"),

    # Menu / name entry / records / selection
    (["name entry", "cursor position", "car/driver selection",
     "race config", "records ", "standings",
     "camera selection", "camera/replay", "camera angle",
     "tile block send", "tile fill", "byte iterator",
     "table entry swap", "sh2 multi-parameter",
     "scroll position", "sprite strip renderer",
     "game mode transition"], "menu"),

    # Data / decompression
    (["decompress", "unpack", "huffman", "lzss", "lz ",
     "descriptor table", "bulk table", "bit unpack",
     "tile data stream", "bit-stream refill"], "data"),

    # Physics
    (["speed", "acceleration", "braking", "tilt", "physics",
     "velocity", "heading", "drift", "momentum",
     "friction", "wind resistance"], "physics"),

    # Race
    (["race ", "race_", "lap ", "countdown",
     "audio frequency", "audio trigger"], "race"),

    # Render / display / VDP / sprites
    (["render", "visib", "depth sort", "dma ",
     "vdp ", "vdp_", "vram clear", "vram ",
     "framebuffer", "palette", "cram fill",
     "sprite param", "sprite config",
     "display state", "display list", "display init",
     "nametable", "row copy",
     "animation", "billboard",
     "object table 3 proximity"], "render"),

    # Scene / SH2
    (["scene", "orchestrat", "frame orch",
     "sh2 comm", "sh2 command", "sh2 send", "sh2 cmd",
     "sh2 frame", "frame sync",
     "clear communication",
     "game mode"], "scene"),

    # Entity / object
    (["entity", "object table", "obj table", "spawn"], "entity"),

    # State / dispatch / timer / flags
    (["state dispatch", "dispatch", "counter",
     "flag", "timer", "abort",
     "conditional return", "conditional guard",
     "system boot", "system init",
     "register restore", "hardware init",
     "warm boot"], "state"),

    # Track
    (["track", "segment"], "track"),
]


def parse_file_header(filepath):
    """Extract header info from an assembly file."""
    with open(filepath, 'r') as f:
        lines = f.readlines()

    title = ""
    rom_start = ""
    is_auto = False
    label = ""

    for i, line in enumerate(lines):
        line = line.rstrip()

        # Title: second line (index 1), after "==="
        if i == 1 and line.startswith("; "):
            raw = line[2:].strip()
            # Remove "fn_XXXX_NNN — " prefix
            m = re.match(r'^fn_\w+\s*[—–-]\s*(.*)', raw)
            if m:
                title = m.group(1).strip()
            else:
                title = raw

        # ROM range
        if "ROM Range:" in line:
            m = re.search(r'ROM Range:\s*\$([0-9A-Fa-f]+)', line)
            if m:
                rom_start = m.group(1).lower()

        # Auto-analyzed check
        if "(auto-analyzed)" in line.lower():
            is_auto = True

        # Primary label (first non-comment, non-whitespace line with colon)
        if not label and not line.startswith(";") and line.strip() and ":" in line:
            candidate = line.split(":")[0].strip()
            if candidate and not candidate.startswith(".") and not candidate.startswith(" "):
                label = candidate

    return {
        "title": title,
        "rom_start": rom_start,
        "is_auto": is_auto,
        "label": label,
    }


def title_to_filename(title):
    """Convert a descriptive title to a snake_case filename."""
    t = title

    # Remove everything after em-dash description
    t = re.sub(r'\s*[—–]\s*.*$', '', t)
    # Remove parenthetical content
    t = re.sub(r'\s*\([^)]*\)', '', t)
    # Remove brackets
    t = re.sub(r'\[.*?\]', '', t)

    name = t.lower().strip()
    # Replace non-alphanumeric with underscore
    name = re.sub(r'[^a-z0-9]+', '_', name)
    name = name.strip('_')

    # Shorten verbose patterns
    replacements = [
        ('_orchestrator', '_orch'),
        ('_dispatcher', '_disp'),
        ('_conditional', '_cond'),
        ('_initialization', '_init'),
        ('_calculation', '_calc'),
        ('_configuration', '_config'),
        ('_parameter', '_param'),
        ('_register', '_reg'),
        ('_position', '_pos'),
        ('_frequency', '_freq'),
        ('_processor', '_proc'),
        ('_handler', '_handler'),  # keep this one readable
    ]
    for old, new in replacements:
        name = name.replace(old, new)

    # Collapse underscores
    name = re.sub(r'_+', '_', name).strip('_')

    # Labels can't start with digit in vasm
    if name and name[0].isdigit():
        name = "gfx_" + name

    # Truncate to 50 chars at word boundary
    if len(name) > 50:
        truncated = name[:50]
        last_us = truncated.rfind('_')
        if last_us > 30:
            name = truncated[:last_us]
        else:
            name = truncated.rstrip('_')

    return name


def classify_subcategory(title):
    """Determine subcategory from title keywords."""
    title_lower = title.lower()
    for keywords, subcat in SUBCATEGORY_RULES:
        for kw in keywords:
            if kw in title_lower:
                return subcat
    return "auto"  # fallback


def main():
    if not AUTO_DIR.exists():
        print(f"ERROR: {AUTO_DIR} not found.", file=sys.stderr)
        sys.exit(1)

    # Collect all auto/ .asm files
    asm_files = sorted(AUTO_DIR.glob("fn_*.asm"))
    print(f"Found {len(asm_files)} files in {AUTO_DIR.relative_to(PROJECT_ROOT)}", file=sys.stderr)

    entries = []
    for filepath in asm_files:
        info = parse_file_header(filepath)
        filename = filepath.name
        old_path = str(filepath.relative_to(PROJECT_ROOT / "disasm"))

        if info["is_auto"]:
            # Auto-analyzed: stay in auto/ with current name
            new_path = old_path  # no change
            new_label = info["label"]
            subcategory = "auto"
        else:
            # Documented: derive new name and subcategory
            if info["title"]:
                new_name = title_to_filename(info["title"])
            else:
                new_name = filename[:-4]  # fallback

            subcategory = classify_subcategory(info["title"] or "")
            new_label = new_name
            new_path = f"modules/68k/game/{subcategory}/{new_name}.asm"

        entries.append({
            "old_path": old_path,
            "new_path": new_path,
            "old_label": info["label"],
            "new_label": new_label,
            "subcategory": subcategory,
            "title": info["title"] or "(no title)",
            "is_auto": info["is_auto"],
            "rom_start": info["rom_start"],
        })

    # Detect and resolve duplicate new_paths
    path_groups = defaultdict(list)
    for e in entries:
        path_groups[e["new_path"]].append(e)

    for path, dupes in path_groups.items():
        if len(dupes) > 1:
            for e in dupes:
                # Append ROM start address to disambiguate
                suffix = f"_{e['rom_start']}" if e['rom_start'] else ""
                base = e["new_path"][:-4]  # strip .asm
                e["new_path"] = f"{base}{suffix}.asm"
                if not e["is_auto"]:
                    e["new_label"] = f"{e['new_label']}{suffix}"

    # Verify no remaining duplicates
    all_paths = [e["new_path"] for e in entries]
    dups = [p for p in all_paths if all_paths.count(p) > 1]
    if dups:
        print(f"ERROR: Duplicate paths remain: {set(dups)}", file=sys.stderr)
        sys.exit(1)

    # Write TSV
    with open(OUTPUT_TSV, 'w') as f:
        f.write("old_path\tnew_path\told_label\tnew_label\tsubcategory\ttitle\n")
        for e in entries:
            f.write('\t'.join([
                e["old_path"], e["new_path"],
                e["old_label"], e["new_label"],
                e["subcategory"], e["title"],
            ]) + '\n')

    # Summary
    subcats = defaultdict(int)
    for e in entries:
        subcats[e["subcategory"]] += 1

    renames = sum(1 for e in entries if e["old_path"] != e["new_path"])
    label_changes = sum(1 for e in entries if e["old_label"] != e["new_label"])

    print(f"\nMapping: {OUTPUT_TSV.relative_to(PROJECT_ROOT)}", file=sys.stderr)
    print(f"\nSubcategory distribution:", file=sys.stderr)
    for subcat, count in sorted(subcats.items(), key=lambda x: -x[1]):
        print(f"  {subcat:15s} {count:4d}", file=sys.stderr)
    print(f"\nTotal: {len(entries)}", file=sys.stderr)
    print(f"To rename/move: {renames}", file=sys.stderr)
    print(f"Labels to change: {label_changes}", file=sys.stderr)


if __name__ == "__main__":
    main()
