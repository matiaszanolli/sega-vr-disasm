#!/usr/bin/env python3
"""
extract_function_docs.py — Extract function documentation from 68K/SH2 module headers.

Reads all .asm files in disasm/modules/68k/ and disasm/modules/sh2/,
parses the header comment blocks, and generates:
  - analysis/MASTER_FUNCTION_REFERENCE.md  (full detail, by category)
  - analysis/FUNCTION_QUICK_LOOKUP.md      (flat sorted-by-address, LLM-optimized)
"""

import os
import re
import sys
from pathlib import Path
from collections import defaultdict

REPO_ROOT = Path(__file__).parent.parent
MODULES_68K = REPO_ROOT / "disasm/modules/68k"
MODULES_SH2 = REPO_ROOT / "disasm/modules/sh2"
OUTPUT_MASTER = REPO_ROOT / "analysis/MASTER_FUNCTION_REFERENCE.md"
OUTPUT_QUICK  = REPO_ROOT / "analysis/FUNCTION_QUICK_LOOKUP.md"

# --- Header parser -----------------------------------------------------------

SEP_RE = re.compile(r'^;\s*={10,}')

def parse_header(lines):
    """
    Parse the leading comment block of a module .asm file.
    Returns a dict with extracted fields.

    Handles three header patterns:
      A) "Field: value" style (most modules)
      B) "SECTION_HEADER\n-----\ncontent" style (large boot/display modules)
      C) Description lines directly after ROM Range (simple modules)
    """
    entry = {
        "name": "",
        "rom_range": "",
        "rom_start": None,
        "rom_end": None,
        "size_bytes": None,
        "description": [],
        "entry": "",
        "exit_": "",
        "uses": "",
        "calls": "",
        "ram": "",
        "object_fields": "",
        "confidence": "",
        "category_hint": "",
        "raw_lines": [],
    }

    # Collect ALL leading comment lines until the first non-comment, non-blank line
    # (i.e. until actual code starts). Strip === separator lines.
    # This handles both:
    #   (A) Single-box format: name + desc all between two === separators
    #   (B) Two-box format: name in first box, desc after box until closing ===
    header_lines = []
    found_first_sep = False
    for line in lines:
        stripped = line.rstrip('\n')
        raw_stripped = stripped.strip()
        # Stop at blank line that follows a non-comment line (code territory)
        if raw_stripped == '':
            # If we've already seen some content, stop collecting
            if any(not SEP_RE.match(h) and h.lstrip('; ').strip() for h in header_lines):
                # Allow one blank comment line (";") but stop at true blank
                if stripped == '':
                    break
            header_lines.append(stripped)
            continue
        if SEP_RE.match(stripped):
            found_first_sep = True
            # Skip === separator lines (visual decoration only)
            continue
        if stripped.startswith(';'):
            if not found_first_sep:
                continue  # skip preamble before first ===
            header_lines.append(stripped)
        else:
            # Non-comment line = code starts, stop
            break

    if not header_lines:
        return None

    entry["raw_lines"] = header_lines

    # Strip leading "; " from all header lines
    def strip_comment(ln):
        return re.sub(r'^;\s?', '', ln)

    slines = [strip_comment(ln) for ln in header_lines]

    # --- Title line (first non-empty)
    title_idx = 0
    title_line = ""
    for i, s in enumerate(slines):
        if s.strip():
            title_line = s.strip()
            title_idx = i
            break

    em_dash = '—'
    if em_dash in title_line:
        parts = title_line.split(em_dash, 1)
        entry["name"] = parts[0].strip()
        rest = parts[1].strip()
        if rest:
            entry["description"].append(rest)
    else:
        entry["name"] = title_line

    # Map of field labels (lowercase) → internal key or special handler
    FIELD_LABELS = {
        "rom range": "rom_range_field",
        "purpose": "description",
        "entry": "entry",
        "entry point": "entry",
        "exit": "exit",
        "returns": "exit",
        "uses": "uses",
        "modifies": "uses",
        "calls": "calls",
        "call": "calls",
        "ram": "ram",
        "memory": "ram",
        "object fields": "object_fields",
        "object field": "object_fields",
        "confidence": "confidence",
        "category": "category_hint_field",
        "data prefix": "description",
    }

    # All-caps section headers (Pattern B) — appear without colon, before ----
    SECTION_CAPS = {
        "PURPOSE": "description",
        "ENTRY POINT": "entry",
        "ENTRY": "entry",
        "EXIT": "exit",
        "RETURNS": "exit",
        "USES": "uses",
        "CALLS": "calls",
        "RAM": "ram",
        "MEMORY MAPPING": "description",
        "HARDWARE REGISTERS USED": "description",
        "HARDWARE REGISTERS": "description",
        "FLOW": "description",
        "OVERVIEW": "description",
        "DESCRIPTION": "description",
        "DEPENDENCIES": "description",
        "RELATED": "description",
        "DETAILS": "description",
        "BEHAVIOR": "description",
        "NOTES": "description",
    }

    def flush(field, value_lines):
        if not field or not value_lines:
            return
        val = " ".join(v.strip() for v in value_lines if v.strip())
        if not val:
            return
        if field == "description":
            entry["description"].append(val)
        elif field == "entry":
            entry["entry"] = (entry["entry"] + "; " + val).lstrip("; ")
        elif field == "exit":
            entry["exit_"] = val
        elif field == "uses":
            entry["uses"] = (entry["uses"] + ", " + val).lstrip(", ")
        elif field == "calls":
            entry["calls"] = (entry["calls"] + "; " + val).lstrip("; ")
        elif field == "ram":
            entry["ram"] = (entry["ram"] + "; " + val).lstrip("; ")
        elif field == "object_fields":
            entry["object_fields"] = val
        elif field == "confidence":
            entry["confidence"] = val

    current_field = None
    current_value = []

    i = title_idx + 1
    while i < len(slines):
        s = slines[i]
        raw = s.strip()

        # Pure dash separator (visual underline for section headers) — skip
        if re.match(r'^-{3,}$', raw):
            i += 1
            continue

        # Empty line — paragraph break; flush + reset to description
        if not raw:
            flush(current_field, current_value)
            current_field = None
            current_value = []
            i += 1
            continue

        # --- "Field: value" pattern (Pattern A / C) ---
        colon_m = re.match(r'^([\w][^\n:]{1,40}?):\s*(.*)', s)
        if colon_m:
            label_raw = colon_m.group(1).strip()
            label_lo  = label_raw.lower()
            value_rest = colon_m.group(2).strip()
            mapped = FIELD_LABELS.get(label_lo)
            if mapped:
                flush(current_field, current_value)
                current_field = None
                current_value = []

                if mapped == "rom_range_field":
                    rm = re.search(
                        r'\$([0-9A-Fa-f]+)\s*[-–]\s*\$([0-9A-Fa-f]+)'
                        r'(?:\s*\((\d+)\s*bytes?\))?',
                        value_rest)
                    if rm:
                        entry["rom_start"] = int(rm.group(1), 16)
                        entry["rom_end"]   = int(rm.group(2), 16)
                        entry["size_bytes"] = (
                            int(rm.group(3)) if rm.group(3)
                            else entry["rom_end"] - entry["rom_start"]
                        )
                    entry["rom_range"] = value_rest
                elif mapped == "category_hint_field":
                    entry["category_hint"] = value_rest
                else:
                    current_field = mapped
                    if value_rest:
                        current_value = [value_rest]
                i += 1
                continue

        # --- All-caps section header (Pattern B) ---
        if re.match(r'^[A-Z][A-Z\s/()]+$', raw) and len(raw) >= 3:
            cap_mapped = SECTION_CAPS.get(raw)
            if cap_mapped:
                flush(current_field, current_value)
                current_field = cap_mapped
                current_value = []
                i += 1
                continue

        # --- Accumulate into current field or default to description ---
        if current_field:
            current_value.append(raw)
        else:
            entry["description"].append(raw)

        i += 1

    flush(current_field, current_value)

    entry["description_text"] = " ".join(entry["description"]).strip()
    return entry


# --- ROM Range from name line (alternative format) ---------------------------

def extract_rom_range_from_name(entry):
    """If ROM range wasn't found in dedicated field, try to parse from name."""
    if entry["rom_start"] is not None:
        return
    m = re.search(r'\(\s*\$([0-9A-Fa-f]+)\s*[-–]\s*\$([0-9A-Fa-f]+)', entry.get("name", ""))
    if m:
        entry["rom_start"] = int(m.group(1), 16)
        entry["rom_end"]   = int(m.group(2), 16)
        entry["size_bytes"] = entry["rom_end"] - entry["rom_start"]
        entry["rom_range"] = f"${m.group(1).upper()}-${m.group(2).upper()}"


# --- Category from path -------------------------------------------------------

def category_from_path(path: Path) -> str:
    """Determine display category from module file path."""
    parts = path.parts
    # Find 'modules' in path
    try:
        idx = parts.index('modules')
    except ValueError:
        return "unknown"
    # parts after 'modules': ['68k', 'game', 'state'] or ['68k', 'boot'] etc.
    after = parts[idx+1:]
    if len(after) >= 3:
        # e.g. 68k / game / state
        return f"{after[0]}/{after[1]}/{after[2]}"
    elif len(after) >= 2:
        return f"{after[0]}/{after[1]}"
    elif len(after) >= 1:
        return after[0]
    return "unknown"


def display_category(path: Path) -> str:
    """Human-readable category for grouping in master reference."""
    parts = path.parts
    try:
        idx = parts.index('modules')
    except ValueError:
        return "Other"
    after = parts[idx+1:]
    cpu = after[0].upper() if after else ""  # '68K' or 'SH2'
    if len(after) >= 3 and after[1] == "game":
        return f"Game / {after[2].title()}"
    elif len(after) >= 2:
        return f"{after[1].replace('-', ' ').title()}"
    return cpu


# --- Process a single module file --------------------------------------------

def process_file(path: Path) -> dict | None:
    try:
        lines = path.read_text(encoding='utf-8', errors='replace').splitlines()
    except Exception:
        return None

    if not lines or len(lines) < 3:
        return None  # empty stub

    entry = parse_header(lines)
    if not entry:
        return None

    extract_rom_range_from_name(entry)

    # If still no name, use filename stem
    if not entry["name"]:
        entry["name"] = path.stem.replace('_', ' ').title()

    entry["filename"] = path.name
    entry["filepath"] = str(path.relative_to(REPO_ROOT))
    entry["category"] = display_category(path)
    entry["sort_category"] = category_from_path(path)

    return entry


# --- Main gathering pass ------------------------------------------------------

def gather_all_entries():
    entries = []

    for base in [MODULES_68K, MODULES_SH2]:
        if not base.exists():
            continue
        for path in sorted(base.rglob("*.asm")):
            entry = process_file(path)
            if entry:
                entries.append(entry)

    return entries


# --- Formatting helpers -------------------------------------------------------

def fmt_addr(n: int | None) -> str:
    if n is None:
        return "?"
    return f"${n:06X}"


def field_line(label: str, value: str) -> str:
    if value.strip():
        return f"- **{label}**: {value.strip()}\n"
    return ""


def short_desc(entry: dict) -> str:
    d = entry.get("description_text", "").strip()
    if not d:
        d = "(no description)"
    # Truncate at ~200 chars for quick lookup
    if len(d) > 200:
        d = d[:197] + "..."
    return d


def one_liner(entry: dict) -> str:
    """Single-line summary for quick lookup."""
    d = entry.get("description_text", "").strip()
    if not d:
        d = "(no description)"
    # First sentence only
    m = re.match(r'^[^.!?]+[.!?]', d)
    if m:
        d = m.group(0).strip()
    if len(d) > 150:
        d = d[:147] + "..."
    return d


# --- Generate MASTER_FUNCTION_REFERENCE.md -----------------------------------

def generate_master(entries: list) -> str:
    lines = []
    lines.append("# Master Function Reference\n")
    lines.append("**Virtua Racing Deluxe — Complete 68K + SH2 Function Catalog**\n")
    lines.append(f"**Generated from**: `tools/extract_function_docs.py`\n")
    lines.append(f"**Total entries**: {len(entries)}\n")
    lines.append("\n")
    lines.append("> This document is auto-generated from module header comments.\n")
    lines.append("> For SH2 3D engine deep analysis see `analysis/sh2-analysis/SH2_3D_FUNCTION_REFERENCE.md`.\n")
    lines.append("> For frame-level execution flow see `analysis/SYSTEM_EXECUTION_FLOW.md`.\n")
    lines.append("\n---\n\n")
    lines.append("## Table of Contents\n\n")

    # Group by category
    by_cat = defaultdict(list)
    for e in entries:
        by_cat[e["category"]].append(e)

    # Sort entries within each category by ROM address
    for cat in by_cat:
        by_cat[cat].sort(key=lambda e: (e["rom_start"] if e["rom_start"] is not None else 0xFFFFFF))

    sorted_cats = sorted(by_cat.keys())

    # TOC
    for cat in sorted_cats:
        anchor = cat.lower().replace(' ', '-').replace('/', '').replace('(', '').replace(')', '')
        count = len(by_cat[cat])
        lines.append(f"- [{cat}](#{anchor}) ({count} functions)\n")
    lines.append("\n---\n\n")

    # Body
    for cat in sorted_cats:
        anchor = cat.lower().replace(' ', '-').replace('/', '').replace('(', '').replace(')', '')
        lines.append(f"## {cat}\n\n")

        for e in by_cat[cat]:
            addr = fmt_addr(e["rom_start"])
            end  = fmt_addr(e["rom_end"])
            size = f"{e['size_bytes']} bytes" if e["size_bytes"] else ""
            name = e["name"]

            # Heading: ### name (addr–end, N bytes)
            if e["rom_start"] is not None:
                range_str = f"{addr}–{end}"
                if size:
                    range_str += f", {size}"
                lines.append(f"### {name} ({range_str})\n\n")
            else:
                lines.append(f"### {name}\n\n")

            desc = e.get("description_text", "").strip()
            if desc:
                lines.append(f"{desc}\n\n")

            if e["entry"]:
                lines.append(field_line("Entry", e["entry"]))
            if e["exit_"]:
                lines.append(field_line("Returns", e["exit_"]))
            if e["uses"]:
                lines.append(field_line("Modifies", e["uses"]))
            if e["calls"]:
                lines.append(field_line("Calls", e["calls"]))
            if e["ram"]:
                lines.append(field_line("RAM", e["ram"]))
            if e["object_fields"]:
                lines.append(field_line("Object fields", e["object_fields"]))
            if e["confidence"]:
                lines.append(field_line("Confidence", e["confidence"]))

            lines.append(f"*Source: [{e['filename']}]({e['filepath']})*\n\n")
            lines.append("---\n\n")

    return "".join(lines)


# --- Generate FUNCTION_QUICK_LOOKUP.md ---------------------------------------

def generate_quick(entries: list) -> str:
    lines = []
    lines.append("# Function Quick Lookup\n")
    lines.append("**Virtua Racing Deluxe — LLM-Optimized Flat Reference**\n")
    lines.append(f"**Total entries**: {len(entries)} | Sorted by ROM address\n\n")
    lines.append("Format: `$ADDRESS  name  [category]  — description`\n\n")
    lines.append("---\n\n")

    # Sort all by ROM address (unknowns at end)
    sorted_entries = sorted(entries, key=lambda e: (e["rom_start"] if e["rom_start"] is not None else 0xFFFFFFFF))

    lines.append("```\n")
    for e in sorted_entries:
        addr = fmt_addr(e["rom_start"]) if e["rom_start"] is not None else "??????"
        name = e["name"]
        cat  = e["category"]
        desc = one_liner(e)

        # Extra compact info
        extras = []
        if e["entry"]:
            extras.append(f"in:{e['entry'][:60]}")
        if e["uses"]:
            extras.append(f"mod:{e['uses'][:40]}")
        if e["calls"]:
            extras.append(f"calls:{e['calls'][:60]}")

        line = f"{addr}  {name:<48s}  [{cat}]\n"
        lines.append(line)
        lines.append(f"         {desc}\n")
        if extras:
            lines.append(f"         {' | '.join(extras)}\n")
        lines.append("\n")

    lines.append("```\n")
    return "".join(lines)


# --- Main --------------------------------------------------------------------

def main():
    print("Scanning module files...", file=sys.stderr)
    entries = gather_all_entries()
    print(f"  Found {len(entries)} entries", file=sys.stderr)

    # Count entries with/without ROM addresses
    with_addr = sum(1 for e in entries if e["rom_start"] is not None)
    without_addr = len(entries) - with_addr
    print(f"  With ROM address: {with_addr}", file=sys.stderr)
    print(f"  Without ROM address: {without_addr}", file=sys.stderr)

    print("Generating MASTER_FUNCTION_REFERENCE.md...", file=sys.stderr)
    master_text = generate_master(entries)
    OUTPUT_MASTER.write_text(master_text, encoding='utf-8')
    print(f"  Written: {OUTPUT_MASTER}", file=sys.stderr)

    print("Generating FUNCTION_QUICK_LOOKUP.md...", file=sys.stderr)
    quick_text = generate_quick(entries)
    OUTPUT_QUICK.write_text(quick_text, encoding='utf-8')
    print(f"  Written: {OUTPUT_QUICK}", file=sys.stderr)

    print("Done.", file=sys.stderr)

    # Print sample entries for verification
    sample = [e for e in entries if e["rom_start"] is not None][:5]
    for e in sample:
        print(f"\n  Sample: {e['name']} @ {fmt_addr(e['rom_start'])} [{e['category']}]")
        print(f"    Desc: {e.get('description_text','')[:80]}")


if __name__ == "__main__":
    main()
