#!/usr/bin/env python3
"""
vrd_budget.py — authoritative per-CPU useful-work budget + effective display FPS
for the VRD profiler (libretro/PicoDrive Tier 1+2 instrumentation).

Consumes:
  - frame CSV (VRD_PROFILE_LOG): frame,m68k_cycles,msh2_cycles,ssh2_cycles,
        m68k_useful,msh2_useful,ssh2_useful,active,fb_crc,scene,state,is_32x
  - pc    CSV (VRD_PROFILE_PC_LOG): cpu,pc,total_cycles,count,avg,share  + BUDGET lines

Usage:
  python3 vrd_budget.py <frame.csv> [pc.csv]

Why a companion script: idle/useful classification for the SH2s lives HERE (easy
to tune, no emulator rebuild). The in-core BUDGET line is a quick approximation;
this recomputes the authoritative split from the PC histogram.
"""
import sys, csv

TV_FRAME_CYC = 127833          # one NTSC TV-frame of 68K cycles
SH2_FRAME_CYC = 383333         # one TV-frame of SH2 cycles

# Idle/poll/delay-loop PC ranges, derived EMPIRICALLY from profiling (not docs).
# Re-derive if SDRAM code layout changes: idle loops are the dominant low-avg
# self-looping PCs in each CPU's histogram.
IDLE = {
    '68K':    [(0xFF0000, 0x1000000)],                       # BIOS main-loop V-blank poll
    'Master': [(0x06004230, 0x06004260), (0x06000440, 0x06000492)],  # dispatch/idle poll
    'Slave':  [(0x06000580, 0x06000660), (0x020003C0, 0x020003E0)],  # cmd poll + delay + boot
}

def is_idle(cpu, pc):
    for lo, hi in IDLE.get(cpu, []):
        if lo <= pc < hi:
            return True
    return False

def load_frames(path):
    rows = []
    with open(path) as f:
        for r in csv.DictReader(f):
            if not r.get('frame', '').strip().lstrip('-').isdigit():
                continue
            rows.append({k: (v.strip() if isinstance(v, str) else v) for k, v in r.items()})
    return rows

def effective_fps(rows):
    """Distinct displayed frames / elapsed, via consecutive fb_crc change."""
    crcs = [r['fb_crc'] for r in rows if r.get('fb_crc')]
    crcs = [c for c in crcs if c not in ('0x00000000', '0', '')]
    if len(crcs) < 2:
        return None, 0, 0
    changes = sum(1 for i in range(1, len(crcs)) if crcs[i] != crcs[i-1])
    n = len(crcs)
    return 60.0 * changes / n, changes, n

def report_frames(rows):
    g = [r for r in rows if r.get('active', '1') == '1']
    print(f"=== Frame-level ({len(rows)} frames, {len(g)} 3D-active) ===")
    fps, changes, n = effective_fps(rows)
    if fps is not None:
        print(f"  Effective display FPS (fb hash changes): {fps:5.1f}  "
              f"({changes} unique / {n} frames)")
        print(f"     [~60 => new image every TV frame; ~20 => every 3rd]")
    else:
        print("  Effective display FPS: n/a (enable VRD_FB_CRC=1)")
    # scene/state breakdown
    scenes = {}
    for r in g:
        key = (r.get('scene', '?'), r.get('state', '?'))
        scenes[key] = scenes.get(key, 0) + 1
    top = sorted(scenes.items(), key=lambda x: -x[1])[:6]
    print("  scene/state dwell (top): " +
          ", ".join(f"{s}/{st}:{c}" for (s, st), c in top))
    # 68K useful from per-frame column (correct: idle = WRAM poll)
    uf = [int(r['m68k_useful']) for r in g if r.get('m68k_useful', '0').isdigit()]
    uf = [x for x in uf if x > 0]
    if uf:
        avg = sum(uf) / len(uf)
        print(f"  68K useful/frame (per-frame col): {avg:8.0f}  "
              f"({100*avg/TV_FRAME_CYC:.1f}% of TV-frame)")
    print()

def report_pc_budget(path):
    cpus = {'68K': {}, 'Master': {}, 'Slave': {}}
    budget_lines = []
    with open(path) as f:
        for line in f:
            line = line.strip()
            if line.startswith('BUDGET,') or line.startswith('# BUDGET'):
                budget_lines.append(line)
                continue
            p = line.split(',')
            if len(p) < 6 or p[0] not in cpus:
                continue
            try:
                pc = int(p[1], 16); tot = int(p[2])
            except ValueError:
                continue
            cpus[p[0]][pc] = cpus[p[0]].get(pc, 0) + tot

    print("=== PC-level useful/idle budget (authoritative, from histogram) ===")
    if budget_lines:
        print("  in-core BUDGET (full-sample, authoritative — counts every sample):")
        for b in budget_lines:
            print("    " + b)
    for cpu, hist in cpus.items():
        if not hist:
            continue
        tot = sum(hist.values())
        idle = sum(c for pc, c in hist.items() if is_idle(cpu, pc))
        useful = tot - idle
        print(f"  {cpu:7s} useful={100*useful/tot:5.1f}%  idle={100*idle/tot:5.1f}%"
              f"   (idle PCs reclassified in-analyzer)")
    print()

def main():
    if len(sys.argv) < 2:
        print(__doc__); sys.exit(1)
    rows = load_frames(sys.argv[1])
    report_frames(rows)
    if len(sys.argv) > 2:
        report_pc_budget(sys.argv[2])

if __name__ == '__main__':
    main()
