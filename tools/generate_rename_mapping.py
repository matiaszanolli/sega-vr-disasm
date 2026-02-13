#!/usr/bin/env python3
"""Generate rename mapping for 68K game function files.

Reads all .asm files in disasm/modules/68k/game/, extracts headers,
proposes mnemonic names + subcategories, and outputs a TSV mapping file.
"""

import os
import re
import sys
from pathlib import Path
from collections import defaultdict

GAME_DIR = Path("disasm/modules/68k/game")
OUTPUT_TSV = Path("tools/rename_mapping.tsv")

# Keyword-to-subcategory mapping (order matters — first match wins)
# More specific rules MUST come before generic ones
SUBCATEGORY_RULES = [
    # AI (specific)
    (["ai ", "ai_", "opponent", "steering"], "ai"),
    # Name entry / menu (specific — must precede generic "score", "bcd")
    (["name entry", "cursor render", "menu item", "menu state",
     "menu tile", "mode select", "mode dispatch",
     "camera selection counter", "camera demo", "camera menu",
     "camera dma transfer", "camera render", "camera tile render",
     "camera sh2", "camera state disp",
     "i/o port config", "palette fade", "scroll x:", "scroll y:",
     "read combined start", "advance game state",
     "set control flag", "set mode flag",
     "add track segment", "subtract track segment",
     "adjust $903c", "initialize scroll", "initialize track segment",
     "fade level", "vdp slot activ",
     "conditional state set", "conditional scene transition"], "menu"),
    # Camera (general)
    (["camera", "viewport", "view toggle", "view select", "camera_"], "camera"),
    # Collision / proximity
    (["collision", "proximity", "separation", "distance check"], "collision"),
    # HUD / display UI
    (["hud", "digit", "score display", "sprite layout", "display entry",
     "display list build", "ascii", "tile index", "tile mapper",
     "digit lookup", "panel config", "score/stat",
     "bcd time", "bcd score", "bcd scoring"], "hud"),
    # Data / decompression
    (["decompress", "unpack", "descriptor table", "huffman", "lzss",
     "bit unpack", "lookup table"], "data"),
    # Physics / speed
    (["speed", "acceleration", "braking", "tilt", "physics", "velocity",
     "heading", "drift", "tire", "wind resistance", "boost",
     "weighted average", "interpolat", "relative position",
     "position clamp"], "physics"),
    # Race / sound (game-level sound is race-related)
    (["race ", "race_", "lap ", "lap_", "race state", "race init", "race mode",
     "lap check", "lap value", "countdown timer",
     "sound", "sfx", "tire squeal", "tire screech", "audio",
     "fm ", "frequency"], "race"),
    # Render / visibility / VDP / sprites / 3D
    (["visib", "depth sort", "vdp", "dma transfer", "dma setup",
     "framebuffer", "palette", "render", "geometry",
     "display list pointer", "display size", "cram",
     "sprite param", "sprite config", "sprite init",
     "3d transform", "anim", "display param"], "render"),
    # Scene / orchestrator / SH2 communication
    (["scene", "orchestrat", "frame orch", "game frame",
     "sh2 comm", "sh2 command", "sh2 send", "sh2 cmd", "comm reset",
     "sh2 scene reset", "comm transfer", "comm setup", "mars comm",
     "sh2 transfer", "sh2 mode", "sprite buffer clear + sh2",
     "comm signal", "v-int comm", "sh2 call", "sh2 handshake",
     "game mode", "communication and state"], "scene"),
    # State / dispatch / counter / timer / flags
    (["state dispatch", "jump table", "dispatch", "counter",
     "flag", "timer", "state reset", "state check",
     "abort", "reset step", "advance state",
     "clear state", "advance dispatch", "conditional advance",
     "set state", "input state", "object state", "input guard",
     "conditional return", "conditional scroll", "conditional guard",
     "double conditional", "system init",
     "controller", "input check", "input init",
     "state handler"], "state"),
    # Track
    (["track data", "track segment", "segment offset", "road"], "track"),
    # Entity / object
    (["entity", "object", "spawn", "table load", "table setup",
     "table fill", "field store", "field clear", "field check",
     "link copy", "entries reset", "bitmask table",
     "button flag", "obj_"], "entity"),
]

# Prefixes on mnemonic-named files → subcategory
MNEMONIC_PREFIX_MAP = {
    "ai_": "ai",
    "camera_": "camera",
    "close_position": "collision",
    "proximity_": "collision",
    "position_separation": "collision",
    "entity_": "entity",
    "obj_": "entity",
    "hud_": "hud",
    "speed_": "physics",
    "physics_": "physics",
    "tilt_": "physics",
    "heading_": "physics",
    "race_": "race",
    "lap_": "race",
    "timer_": "state",
    "counter_": "state",
    "flag": "state",
    "state_": "state",
    "abort_": "state",
    "set_state": "state",
    "set_timer": "state",
    "reset_timer": "state",
    "advance_": "state",
    "full_state": "state",
    "clear_heading": "physics",
    "clear_camera": "camera",
    "check_timeout": "state",
    "calc_state": "state",
    "sound_": "race",  # game-level sound triggers are race-related
    "sprite_": "render",
    "effect_": "state",
    "bulk_table": "data",
    "zone_": "collision",
}


def parse_file_header(filepath):
    """Extract header info from an assembly file."""
    with open(filepath, 'r') as f:
        lines = f.readlines()

    title = ""
    rom_start = ""
    is_auto = False
    label = ""
    category_tag = ""

    for i, line in enumerate(lines):
        line = line.rstrip()

        # Title line: second line after ===, typically line index 1 or 2
        if i < 5 and line.startswith("; ") and not line.startswith("; ==") and not line.startswith("; ROM"):
            if "ROM Range:" in line:
                # Extract ROM start address
                m = re.search(r'ROM Range: \$([0-9A-Fa-f]+)', line)
                if m:
                    rom_start = m.group(1).lower()
            elif not title:
                title = line[2:].strip()

        if "ROM Range:" in line and not rom_start:
            m = re.search(r'ROM Range: \$([0-9A-Fa-f]+)', line)
            if m:
                rom_start = m.group(1).lower()

        if "(auto-analyzed)" in line:
            is_auto = True

        if "; Category:" in line:
            m = re.search(r'Category:\s*(\w+)', line)
            if m:
                category_tag = m.group(1)

        # Find the primary label (first non-comment, non-empty line with a colon)
        if not label and not line.startswith(";") and not line.startswith(" ") and ":" in line and line.strip():
            label = line.split(":")[0].strip()

    # Also scan for label if we didn't find it in header area
    if not label:
        for line in lines:
            line = line.rstrip()
            if not line.startswith(";") and not line.startswith(" ") and ":" in line and line.strip():
                label = line.split(":")[0].strip()
                break

    return {
        "title": title,
        "rom_start": rom_start,
        "is_auto": is_auto,
        "label": label,
        "category_tag": category_tag,
    }


def title_to_filename(title):
    """Convert a descriptive title to a snake_case filename."""
    # Remove "fn_XXXX_NNN — " prefix (em-dash variant)
    title = re.sub(r'^fn_[a-fA-F0-9]+_\d+\s*[—–-]\s*', '', title)
    # Remove "(auto-analyzed)" tag
    title = re.sub(r'\s*\([^)]*auto-analyzed[^)]*\)', '', title)
    # Strip parenthetical content (variant info, implementation details)
    title = re.sub(r'\s*\([^)]*\)', '', title)

    name = title.lower()
    # Replace non-alphanumeric with underscore
    name = re.sub(r'[^a-z0-9]+', '_', name)
    name = name.strip('_')

    # Remove verbose suffixes that don't add meaning
    verbose = [
        '_data_prefix', '_word_data_prefix', '_byte_data_prefix',
        '_jump_table', '_entry_jump_table',
        '_entry_point', '_dual_entry_point',
        '_subroutines', '_subroutine',
        '_with_data_prefix', '_with_timer',
    ]
    for v in verbose:
        if name.endswith(v):
            name = name[:-len(v)]

    # Remove numeric entry counts like "_5_entry_" or "_4_entry_"
    name = re.sub(r'_\d+_entry_', '_', name)
    name = re.sub(r'_\d+_word_', '_', name)
    name = re.sub(r'_\d+_byte_', '_', name)

    # Shorten common verbose patterns
    name = name.replace('_and_', '_')
    name = name.replace('_with_', '_')
    name = name.replace('_from_', '_')
    name = name.replace('_orchestrator', '_orch')
    name = name.replace('_dispatcher', '_disp')
    name = name.replace('_conditional', '_cond')
    name = name.replace('_initialization', '_init')
    name = name.replace('_calculation', '_calc')
    name = name.replace('_configuration', '_config')
    name = name.replace('_computation', '_calc')
    name = name.replace('_parameter', '_param')
    name = name.replace('_animation', '_anim')
    name = name.replace('_sequence', '_seq')
    name = name.replace('_register', '_reg')
    name = name.replace('_transfer', '_xfer')
    name = name.replace('_accumulate', '_accum')
    name = name.replace('_decrement', '_dec')
    name = name.replace('_increment', '_inc')
    name = name.replace('_controller', '_ctrl')
    name = name.replace('_position', '_pos')
    name = name.replace('_display', '_disp')
    name = name.replace('_comparison', '_cmp')

    # Collapse multiple underscores
    name = re.sub(r'_+', '_', name)
    name = name.strip('_')

    # Labels can't start with a digit in vasm — prefix with underscore-free word
    if name and name[0].isdigit():
        name = "gfx_" + name  # e.g., "3d_transform" → "gfx_3d_transform"

    # Truncate to 45 chars
    if len(name) > 45:
        # Try to truncate at word boundary
        truncated = name[:45]
        last_underscore = truncated.rfind('_')
        if last_underscore > 30:
            name = truncated[:last_underscore]
        else:
            name = truncated.rstrip('_')

    return name


def classify_subcategory(title, filename, is_mnemonic):
    """Determine subcategory from title keywords or filename prefix."""
    title_lower = title.lower()

    # For mnemonic-named files, use prefix mapping
    if is_mnemonic:
        for prefix, subcat in MNEMONIC_PREFIX_MAP.items():
            if filename.startswith(prefix):
                return subcat
        # Fall through to keyword matching

    # Keyword matching on title
    for keywords, subcat in SUBCATEGORY_RULES:
        for kw in keywords:
            if kw in title_lower:
                return subcat

    return ""  # uncategorized — stays in game/ root


def main():
    if not GAME_DIR.exists():
        print(f"ERROR: {GAME_DIR} not found. Run from project root.", file=sys.stderr)
        sys.exit(1)

    # Collect all .asm files
    files = sorted(GAME_DIR.glob("*.asm"))
    print(f"Found {len(files)} .asm files in {GAME_DIR}")

    entries = []
    for filepath in files:
        filename = filepath.name
        if not filename.endswith(".asm"):
            continue

        info = parse_file_header(filepath)
        is_mnemonic = not filename.startswith("fn_")
        is_fn = filename.startswith("fn_")

        if info["is_auto"]:
            # Auto-analyzed: move to auto/, keep label
            new_label = info["label"]
            new_filename = filename
            subcategory = "auto"
        elif is_mnemonic:
            # Already has mnemonic name: just assign subcategory
            new_label = info["label"]
            new_filename = filename
            subcategory = classify_subcategory(info["title"], filename, True)
        else:
            # Documented fn_ file: derive new name
            if info["title"]:
                new_filename_base = title_to_filename(info["title"])
            else:
                # Fallback: keep original name
                new_filename_base = filename[:-4]  # strip .asm

            if not new_filename_base or new_filename_base == filename[:-4]:
                new_filename_base = filename[:-4]

            new_label = new_filename_base
            new_filename = new_filename_base + ".asm"
            subcategory = classify_subcategory(info["title"], new_filename_base, False)

        # Build paths
        old_path = f"modules/68k/game/{filename}"
        if subcategory:
            new_path = f"modules/68k/game/{subcategory}/{new_filename}"
        else:
            new_path = f"modules/68k/game/{new_filename}"

        entries.append({
            "old_path": old_path,
            "new_path": new_path,
            "old_label": info["label"],
            "new_label": new_label,
            "subcategory": subcategory or "(root)",
            "title": info["title"],
            "is_auto": info["is_auto"],
            "rom_start": info["rom_start"],
        })

    # Detect and resolve duplicate new_paths
    path_counts = defaultdict(list)
    for e in entries:
        path_counts[e["new_path"]].append(e)

    for path, dupes in path_counts.items():
        if len(dupes) > 1:
            for e in dupes:
                # Append ROM address to disambiguate
                base = e["new_path"][:-4]  # strip .asm
                suffix = f"_{e['rom_start']}" if e['rom_start'] else f"_{id(e)}"
                e["new_path"] = base + suffix + ".asm"
                if not e["is_auto"]:
                    e["new_label"] = e["new_label"] + suffix

    # Verify no remaining duplicates
    final_paths = [e["new_path"] for e in entries]
    if len(final_paths) != len(set(final_paths)):
        dupes = [p for p in final_paths if final_paths.count(p) > 1]
        print(f"ERROR: Still have duplicate paths: {set(dupes)}", file=sys.stderr)
        sys.exit(1)

    # Write TSV
    OUTPUT_TSV.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_TSV, 'w') as f:
        f.write("old_path\tnew_path\told_label\tnew_label\tsubcategory\ttitle\n")
        for e in entries:
            f.write(f"{e['old_path']}\t{e['new_path']}\t{e['old_label']}\t{e['new_label']}\t{e['subcategory']}\t{e['title']}\n")

    # Print summary
    subcats = defaultdict(int)
    for e in entries:
        subcats[e["subcategory"]] += 1

    print(f"\nMapping written to {OUTPUT_TSV}")
    print(f"\nSubcategory distribution:")
    for subcat, count in sorted(subcats.items(), key=lambda x: -x[1]):
        print(f"  {subcat:15s} {count:4d}")

    # Count changes
    renames = sum(1 for e in entries if e["old_path"] != e["new_path"])
    label_changes = sum(1 for e in entries if e["old_label"] != e["new_label"])
    print(f"\nTotal files: {len(entries)}")
    print(f"Files to move/rename: {renames}")
    print(f"Labels to change: {label_changes}")


if __name__ == "__main__":
    main()
