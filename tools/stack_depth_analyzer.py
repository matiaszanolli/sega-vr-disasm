#!/usr/bin/env python3
"""
stack_depth_analyzer.py — 68K Call-Graph Stack Depth Analyzer
==============================================================
Scans all 68K assembly sources in the Virtua Racing Deluxe 32X disassembly
project, builds a call graph, and computes maximum stack depth (in bytes)
reachable from given entry points via DFS.

Stack accounting:
  - JSR / BSR / BSR.S / BSR.W: each call pushes 4 bytes (return address)
    BUT for JMP to a known label (tail call): no return address pushed, but
    we still follow the callee for its own stack usage (stack not deeper than
    the parent at the call site, so we use max(current, callee) approach).
  - MOVEM.L reglist,-(SP) or -(A7): count registers * 4 bytes
  - LINK An,#N: 4 bytes (old FP pushed) + |N| bytes (frame allocation)
  - PEA <ea>: 4 bytes
  - MOVE.x <ea>,-(SP): size bytes (b=1, w=2, l=4)

Usage:
  python3 tools/stack_depth_analyzer.py [--entry LABEL] [--top N]

Defaults: reports top 10 chains by bytes, V-INT chain, main-loop chain.
"""

import os
import re
import argparse

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
ASM_ROOTS = [
    "disasm/sections",
    "disasm/modules/68k",
]

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(SCRIPT_DIR)

# ---------------------------------------------------------------------------
# Regex patterns
# ---------------------------------------------------------------------------

# A label definition: starts at column 0, identifier followed by ':'
# Matches both global (func_name:) and local (.local:) labels
RE_LABEL = re.compile(r'^([A-Za-z_.][A-Za-z0-9_.]*)\s*:')

# Call instructions: jsr / bsr / bsr.s / bsr.w / jmp (tail call)
# Captures the mnemonic and the target expression
RE_CALL = re.compile(
    r'^\s+(jsr|bsr(?:\.s|\.w)?|jmp)\s+(.+?)(?:\s*;.*)?$',
    re.IGNORECASE
)

# MOVEM.L reglist,-(SP) or -(A7)
RE_MOVEM = re.compile(
    r'^\s+movem\.l\s+([^,]+),\s*-\s*\(\s*(?:sp|a7)\s*\)',
    re.IGNORECASE
)

# LINK An,#disp
RE_LINK = re.compile(
    r'^\s+link\s+a\d\s*,\s*#?\s*(-?\d+|\$[0-9A-Fa-f]+)',
    re.IGNORECASE
)

# PEA <ea>
RE_PEA = re.compile(r'^\s+pea\s+', re.IGNORECASE)

# MOVE.x <ea>,-(SP) or -(A7)
RE_MOVE_SP = re.compile(
    r'^\s+move\.(b|w|l)\s+.+,\s*-\s*\(\s*(?:sp|a7)\s*\)',
    re.IGNORECASE
)

# ---------------------------------------------------------------------------
# Register list parser
# ---------------------------------------------------------------------------

ALL_DREGS = ['d0','d1','d2','d3','d4','d5','d6','d7']
ALL_AREGS = ['a0','a1','a2','a3','a4','a5','a6','a7']
ALL_REGS  = ALL_DREGS + ALL_AREGS

def _expand_reg_range(start: str, end: str) -> list[str]:
    """Expand a register range like d0-d7 or a0-a6 into a list."""
    start = start.lower()
    end = end.lower()
    result = []
    in_range = False
    for r in ALL_REGS:
        if r == start:
            in_range = True
        if in_range:
            result.append(r)
        if in_range and r == end:
            break
    return result

def count_registers(reglist: str) -> int:
    """
    Parse a MOVEM register list like 'd0-d7/a0-a6' or 'd0/d2/a1'
    and return the number of registers.
    """
    count = 0
    reglist = reglist.strip()
    # Split on /
    groups = [g.strip() for g in reglist.split('/') if g.strip()]
    for grp in groups:
        m = re.match(r'([da]\d)-([da]\d)', grp, re.IGNORECASE)
        if m:
            count += len(_expand_reg_range(m.group(1), m.group(2)))
        elif re.match(r'[da]\d', grp, re.IGNORECASE):
            count += 1
        # ignore unrecognised tokens (e.g. fp, pc in rare cases)
    return count

# ---------------------------------------------------------------------------
# Target extraction from call operand
# ---------------------------------------------------------------------------

def extract_call_target(operand: str) -> str | None:
    """
    Given the operand string of a jsr/bsr/jmp instruction, extract the
    symbolic label target (if any).

    Returns the label string, or None for indirect/unknown calls.

    Examples:
      'label(pc)'            -> 'label'
      'label+$880000(pc)'    -> 'label'
      'label'                -> 'label'
      'label+6(pc)'          -> 'label'
      '(a1)'                 -> None  (indirect)
      '($00123456).l'        -> None  (absolute numeric)
      '#$1234'               -> None  (immediate — shouldn't happen but guard)
    """
    op = operand.strip()

    # Indirect register-based calls: (An), (An,Dn), etc.
    if re.match(r'^\s*\(', op):
        return None

    # Absolute numeric addresses: $XXXXXXXX or ($XXXXXXXX)
    if re.match(r'^\$[0-9A-Fa-f]+', op):
        return None
    if re.match(r'^\d+', op):
        return None

    # Extract label from patterns like:
    #   label(pc)
    #   label+$880000(pc)
    #   label+6(pc)
    #   label-2(pc)
    #   label          (bare label)
    m = re.match(r'^([A-Za-z_.][A-Za-z0-9_.]*)(\s*[+\-].*)?(\(pc\))?', op, re.IGNORECASE)
    if m:
        label = m.group(1)
        # Filter out register names that sneak through
        if label.lower() in ('sp', 'a0','a1','a2','a3','a4','a5','a6','a7',
                              'd0','d1','d2','d3','d4','d5','d6','d7',
                              'pc', 'sr', 'ccr', 'usp'):
            return None
        return label

    return None

# ---------------------------------------------------------------------------
# Stack bytes counter per instruction line
# ---------------------------------------------------------------------------

SIZE_BYTES = {'b': 1, 'w': 2, 'l': 4}

# Sanity limit: if a LINK frame or MOVEM register count seems impossibly large
# it is almost certainly mis-parsed ASCII data or dc.w bytes, not real code.
# 68K stack is typically a few KB; reject anything over 4096 bytes from a single
# instruction.
MAX_SANE_PUSH = 4096

def stack_bytes_for_line(line: str) -> int:
    """Return how many bytes this single instruction pushes onto the stack.

    Returns 0 if the value exceeds MAX_SANE_PUSH (treats it as data noise).
    """
    # Skip lines that look like dc.w / dc.b / dc.l data pseudo-ops or pure comments
    stripped = line.strip()
    if stripped.startswith(';'):
        return 0
    if re.match(r'\s*dc\.[bwl]\s', line, re.IGNORECASE):
        return 0

    # MOVEM.L reglist,-(SP)
    m = RE_MOVEM.match(line)
    if m:
        n = count_registers(m.group(1))
        result = n * 4
        return result if result <= MAX_SANE_PUSH else 0

    # LINK An,#disp
    m = RE_LINK.match(line)
    if m:
        raw = m.group(1).strip()
        try:
            if raw.startswith('-$'):
                val = -int(raw[2:], 16)
            elif raw.startswith('$'):
                val = int(raw[1:], 16)
            else:
                val = int(raw)
        except ValueError:
            return 0
        frame = abs(val)
        result = 4 + frame  # 4 for saved FP + frame allocation
        return result if result <= MAX_SANE_PUSH else 0

    # PEA
    if RE_PEA.match(line):
        return 4

    # MOVE.x <ea>,-(SP)
    m = RE_MOVE_SP.match(line)
    if m:
        size = m.group(1).lower()
        return SIZE_BYTES.get(size, 2)

    return 0

# ---------------------------------------------------------------------------
# Data structures
# ---------------------------------------------------------------------------

class FuncInfo:
    """Information about a single function/label."""
    __slots__ = ('name', 'file', 'line_no', 'stack_self',
                 'calls', 'tail_calls', 'has_indirect')

    def __init__(self, name: str, file: str, line_no: int):
        self.name        = name
        self.file        = file
        self.line_no     = line_no
        self.stack_self  = 0    # bytes pushed by this function's own instructions
        self.calls       = []   # list of (target_label, is_tail_call)
        self.tail_calls  = []   # convenience alias for tail calls only
        self.has_indirect = False  # true if this function has indirect calls

    def __repr__(self):
        return (f'FuncInfo({self.name!r}, stack_self={self.stack_self}, '
                f'calls={len(self.calls)})')

# ---------------------------------------------------------------------------
# Scanner
# ---------------------------------------------------------------------------

def scan_asm_files(roots: list[str], project_root: str) -> dict[str, FuncInfo]:
    """
    Walk all .asm files under the given roots and build a dict of
    label -> FuncInfo.

    Duplicate label policy: if a label is defined in more than one file
    (e.g. a section file that re-declares what a module file also declares),
    we prefer the **module file** over the section file, because modules are
    the primary edited source.  If both are from the same category (both
    sections or both modules), the first occurrence wins and subsequent
    redefinitions are ignored.

    In practice this prevents double-counting of MOVEM/LINK instructions when
    both disasm/sections/code_NNN.asm and disasm/modules/68k/.../foo.asm define
    the same label.
    """
    funcs: dict[str, FuncInfo] = {}
    # Current function context for local label scoping
    current_global: str | None = None

    # Track which file "owns" each global label.
    # Section files (disasm/sections/) take priority over module files because
    # section files are the actual assembled source and may contain optimised
    # rewrites of functions also present as standalone docs in modules/.
    # Only one label in the entire codebase is duplicated this way:
    # vint_handler (code_200.asm overrides main-loop/vint_handler.asm).
    label_file_priority: dict[str, int] = {}
    # priority: 0 = module file, 1 = section file

    def file_priority(rel: str) -> int:
        if rel.startswith('disasm/sections/'):
            return 1
        return 0

    def collect_file(path: str):
        nonlocal current_global
        rel = os.path.relpath(path, project_root)
        this_priority = file_priority(rel)

        try:
            with open(path, 'r', encoding='utf-8', errors='replace') as f:
                lines = f.readlines()
        except OSError:
            return

        # Track which labels we define (or redefine) in this file
        # so we only attribute lines to those labels
        active_label: str | None = None  # global label currently active in this file

        for lineno, raw_line in enumerate(lines, start=1):
            line = raw_line.rstrip('\n')

            # ---- Label detection ----
            lm = RE_LABEL.match(line)
            if lm:
                label = lm.group(1)
                if label.startswith('.'):
                    # Local label: scope under current global
                    if active_label is not None:
                        full = f'{active_label}{label}'
                        existing_prio = label_file_priority.get(full, -1)
                        if full not in funcs or this_priority >= existing_prio:
                            funcs[full] = FuncInfo(full, rel, lineno)
                            label_file_priority[full] = this_priority
                    current_global = f'{active_label}{label}' if active_label else None
                else:
                    existing_prio = label_file_priority.get(label, -1)
                    if label not in funcs:
                        funcs[label] = FuncInfo(label, rel, lineno)
                        label_file_priority[label] = this_priority
                        active_label = label
                        current_global = label
                    elif this_priority > existing_prio:
                        # Module file overrides section file: reset the entry
                        funcs[label] = FuncInfo(label, rel, lineno)
                        label_file_priority[label] = this_priority
                        active_label = label
                        current_global = label
                    else:
                        # Lower or equal priority duplicate: do NOT attribute
                        # subsequent lines to this label from this file.
                        # Set active_label to None to suppress accumulation.
                        active_label = None
                        current_global = None
                continue

            if active_label is None:
                continue

            # Determine which label the current line belongs to
            owner = current_global if current_global else active_label
            fi = funcs.get(owner)
            if fi is None:
                continue

            # ---- Stack push accounting ----
            fi.stack_self += stack_bytes_for_line(line)

            # ---- Call detection ----
            cm = RE_CALL.match(line)
            if cm:
                mnemonic = cm.group(1).lower()
                operand  = cm.group(2).strip()
                target   = extract_call_target(operand)
                is_tail  = (mnemonic == 'jmp')
                is_indirect = (target is None)

                if is_indirect:
                    fi.has_indirect = True
                else:
                    fi.calls.append((target, is_tail))
                    if is_tail:
                        fi.tail_calls.append(target)

    for root in roots:
        abs_root = os.path.join(project_root, root)
        if not os.path.isdir(abs_root):
            continue
        for dirpath, _dirs, files in os.walk(abs_root):
            for fname in sorted(files):
                if fname.endswith('.asm'):
                    collect_file(os.path.join(dirpath, fname))

    return funcs

# ---------------------------------------------------------------------------
# Local label resolution
# ---------------------------------------------------------------------------

def resolve_local_labels(funcs: dict[str, FuncInfo]) -> None:
    """
    BSR.S .local_label within a function is stored as a raw '.local_label'
    target. Resolve these against the enclosing global label.
    """
    for name, fi in funcs.items():
        if name.startswith('.'):
            continue
        resolved = []
        for (target, is_tail) in fi.calls:
            if target.startswith('.'):
                full = f'{name}{target}'
                resolved.append((full, is_tail))
            else:
                resolved.append((target, is_tail))
        fi.calls = resolved

# ---------------------------------------------------------------------------
# DFS stack depth computation
# ---------------------------------------------------------------------------

VISIT_IN_PROGRESS = 1
VISIT_DONE        = 2

def compute_max_depth(
    entry: str,
    funcs: dict[str, FuncInfo],
    max_depth: int = 200,
) -> tuple[int, int, list[str]]:
    """
    DFS from `entry` to find the call chain with maximum total stack bytes.

    Returns (max_levels, max_bytes, chain) where chain is the list of labels
    from entry to the deepest point.

    Handles cycles by cutting them (treating recursive calls as depth=0).

    For tail calls (JMP to label): the callee runs in the same stack frame —
    it does NOT add a 4-byte return address. But we still account for any
    pushes the callee itself does beyond the call site. The effective depth
    contribution of a tail call is:
        callee_self_stack + max_recursive_callee_calls
    with NO additional +4 for the JSR return address.

    For normal calls (JSR/BSR): +4 bytes return address.
    """
    # Memoize: label -> (max_levels, max_bytes_below, best_chain_below)
    # "below" means the chain starting at this function (inclusive of self)
    memo: dict[str, tuple[int, int, list[str]]] = {}
    visiting: set[str] = set()  # cycle detection

    def dfs(label: str, depth: int) -> tuple[int, int, list[str]]:
        if depth > max_depth:
            # Safety: avoid runaway recursion in pathological graphs
            return 0, 0, [label]

        if label in memo:
            levels, byte_cost, chain = memo[label]
            return levels, byte_cost, chain

        fi = funcs.get(label)
        if fi is None:
            # Unknown function (external or not yet disassembled)
            result = (1, 0, [label])
            memo[label] = result
            return result

        if label in visiting:
            # Cycle: stop recursion here
            result = (1, fi.stack_self, [label])
            return result

        visiting.add(label)

        best_levels = 0
        best_bytes  = 0
        best_chain  = []

        for (target, is_tail) in fi.calls:
            sub_levels, sub_bytes, sub_chain = dfs(target, depth + 1)

            if is_tail:
                # Tail call: no additional return-address push
                call_bytes = sub_bytes
            else:
                # Normal call: +4 bytes for return address on stack
                call_bytes = 4 + sub_bytes

            call_levels = 1 + sub_levels

            if call_bytes > best_bytes or (call_bytes == best_bytes and call_levels > best_levels):
                best_bytes  = call_bytes
                best_levels = call_levels
                best_chain  = sub_chain

        visiting.discard(label)

        total_bytes  = fi.stack_self + best_bytes
        total_levels = 1 + best_levels if best_chain else 1
        chain        = [label] + best_chain

        result = (total_levels, total_bytes, chain)
        memo[label] = result
        return result

    return dfs(entry, 0)

# ---------------------------------------------------------------------------
# Formatting
# ---------------------------------------------------------------------------

def format_chain(chain: list[str], funcs: dict[str, FuncInfo], total_bytes: int) -> str:
    lines = []
    running = 0
    for i, label in enumerate(chain):
        fi = funcs.get(label)
        self_bytes = fi.stack_self if fi else 0
        # Add JSR cost for non-first entries
        call_cost = 4 if i > 0 else 0
        running += call_cost + self_bytes
        fi_file = fi.file if fi else '(unknown)'
        lines.append(
            f"  {'  ' * i}{label}  [self={self_bytes}B, +call={call_cost}B, cumul={running}B]"
            f"  ({fi_file})"
        )
    lines.append(f"  --> TOTAL: {total_bytes} bytes")
    return '\n'.join(lines)

# ---------------------------------------------------------------------------
# Entry points search helpers
# ---------------------------------------------------------------------------

VINT_CANDIDATES = ['vint_handler', 'v_int_handler', 'vint_entry', 'VINT_handler']
MAIN_CANDIDATES = ['main_loop', 'polling_loop', 'game_main_loop', 'main_game_loop',
                   'game_loop', 'frame_loop']

def find_entry(candidates: list[str], funcs: dict[str, FuncInfo]) -> str | None:
    for c in candidates:
        if c in funcs:
            return c
    # Try case-insensitive
    lower_map = {k.lower(): k for k in funcs}
    for c in candidates:
        if c.lower() in lower_map:
            return lower_map[c.lower()]
    return None

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--entry', metavar='LABEL', action='append',
                        help='Additional entry point label(s) to analyze')
    parser.add_argument('--top', metavar='N', type=int, default=10,
                        help='Show top N chains by stack bytes (default: 10)')
    parser.add_argument('--project-root', metavar='DIR', default=PROJECT_ROOT,
                        help='Project root directory')
    args = parser.parse_args()

    project_root = os.path.abspath(args.project_root)

    print(f"[*] Project root: {project_root}")
    print("[*] Scanning .asm files ...")
    funcs = scan_asm_files(ASM_ROOTS, project_root)
    print(f"[*] Found {len(funcs)} labels total")

    resolve_local_labels(funcs)

    # Count functions with calls
    n_with_calls = sum(1 for fi in funcs.values() if fi.calls)
    n_with_indirect = sum(1 for fi in funcs.values() if fi.has_indirect)
    print(f"[*] {n_with_calls} labels have direct calls, "
          f"{n_with_indirect} have indirect/unknown calls")

    # ----------------------------------------------------------------
    # Top-N analysis: pick the top N entry points by worst-case stack
    # We use only "global" (non-local) labels as potential entry points.
    # ----------------------------------------------------------------
    print(f"\n{'='*70}")
    print(f"TOP {args.top} DEEPEST CALL CHAINS (by total stack bytes)")
    print(f"{'='*70}")

    global_labels = [name for name in funcs if not name.startswith('.')]

    results = []
    for label in global_labels:
        levels, byte_cost, chain = compute_max_depth(label, funcs)
        results.append((byte_cost, levels, label, chain))

    results.sort(reverse=True)

    for rank, (byte_cost, levels, label, chain) in enumerate(results[:args.top], 1):
        fi = funcs.get(label)
        fi_file = fi.file if fi else '(unknown)'
        print(f"\n#{rank}  {label}  ({fi_file})")
        print(f"     Max stack depth: {byte_cost} bytes  |  {levels} call levels")
        print(format_chain(chain, funcs, byte_cost))

    # ----------------------------------------------------------------
    # V-INT handler chain
    # ----------------------------------------------------------------
    print(f"\n{'='*70}")
    print("V-INT HANDLER STACK DEPTH ANALYSIS")
    print(f"{'='*70}")

    vint_label = find_entry(VINT_CANDIDATES, funcs)
    if args.entry:
        for e in args.entry:
            if e in VINT_CANDIDATES:
                vint_label = e

    if vint_label:
        print(f"\n[*] Entry point: {vint_label}")
        # V-INT adds 6-byte exception frame + the 60-byte MOVEM in the handler itself
        # The MOVEM is already counted via stack_self; the 6-byte exception frame is
        # pushed by hardware (SR + PC = 2+4 = 6 bytes).
        VINT_HW_FRAME = 6
        levels, byte_cost, chain = compute_max_depth(vint_label, funcs)
        total_with_hw = byte_cost + VINT_HW_FRAME
        print(f"    Handler own stack accounting: {byte_cost} bytes")
        print(f"    + Hardware exception frame:   {VINT_HW_FRAME} bytes (SR=2, PC=4)")
        print(f"    TOTAL worst-case stack:       {total_with_hw} bytes\n")
        print(format_chain(chain, funcs, byte_cost))

        # Also note indirect calls in vint path
        fi = funcs.get(vint_label)
        if fi and fi.has_indirect:
            print(f"\n  NOTE: {vint_label} has indirect call(s) (e.g. jsr (a1)) — "
                  "actual depth may be higher.")
    else:
        print(f"  [!] No V-INT entry point found. Tried: {VINT_CANDIDATES}")
        vint_like = [k for k in funcs if 'vint' in k.lower()]
        print("      Available labels containing 'vint': " + str(vint_like))

    # ----------------------------------------------------------------
    # Main loop chain
    # ----------------------------------------------------------------
    print(f"\n{'='*70}")
    print("MAIN LOOP / POLLING LOOP STACK DEPTH ANALYSIS")
    print(f"{'='*70}")

    main_label = find_entry(MAIN_CANDIDATES, funcs)
    if args.entry:
        for e in args.entry:
            if e not in VINT_CANDIDATES:
                main_label = e

    if main_label:
        print(f"\n[*] Entry point: {main_label}")
        levels, byte_cost, chain = compute_max_depth(main_label, funcs)
        print(f"    Max stack depth: {byte_cost} bytes  |  {levels} call levels\n")
        print(format_chain(chain, funcs, byte_cost))
    else:
        print(f"  [!] No main-loop entry point found. Tried: {MAIN_CANDIDATES}")
        available = [k for k in funcs if any(c in k.lower() for c in ['main','loop','poll'])]
        print(f"      Available labels with 'main/loop/poll': {available[:20]}")

    # ----------------------------------------------------------------
    # Additional user-specified entry points
    # ----------------------------------------------------------------
    if args.entry:
        for e in args.entry:
            if e in (vint_label, main_label):
                continue
            print(f"\n{'='*70}")
            print(f"ENTRY POINT: {e}")
            print(f"{'='*70}")
            if e not in funcs:
                print(f"  [!] Label '{e}' not found in any .asm file.")
                continue
            levels, byte_cost, chain = compute_max_depth(e, funcs)
            print(f"    Max stack depth: {byte_cost} bytes  |  {levels} call levels\n")
            print(format_chain(chain, funcs, byte_cost))

    # ----------------------------------------------------------------
    # Summary of indirect-call hotspots (functions we can't fully trace)
    # ----------------------------------------------------------------
    print(f"\n{'='*70}")
    print("INDIRECT CALL SITES (not traced — depth may be underestimated)")
    print(f"{'='*70}")
    indirect_funcs = [(fi.name, fi.file) for fi in funcs.values() if fi.has_indirect]
    print(f"  {len(indirect_funcs)} functions have indirect calls:")
    for name, path in sorted(indirect_funcs)[:30]:
        print(f"    {name}  ({path})")
    if len(indirect_funcs) > 30:
        print(f"    ... and {len(indirect_funcs)-30} more")

if __name__ == '__main__':
    main()
