# PDB Debugger Usage Guide

## Custom PicoDrive Debugger (PDB)

Date: 2026-01-20

---

## Overview

Our PicoDrive build includes PDB, a custom debugger for 32X development. This was enabled by adding `-DPDB` to the build and is NOT available in standard PicoDrive builds.

## Build Configuration

**Location**: `/mnt/data/src/32x-playground/third_party/picodrive/`

**Build flags added**:
```make
PDB ?= 1
CFLAGS += -DPDB
OBJS += cpu/debug.o
```

**Modifications made**:
1. Fixed field names in `cpu/debug.c` (cycles_done → icount, cycles_aim → cycles_timeslice)
2. Added `break` command for setting breakpoints

---

## Available Commands

| Command | Arguments | Description |
|---------|-----------|-------------|
| help | | Show all commands |
| break | [addr] | Set breakpoint at address, or list breakpoints if no addr |
| continue | [insns] | Continue execution for N instructions (optional) |
| step | [insns] | Step N instructions (default 1) |
| step_all | <insns> | Step all CPUs for N instructions |
| waitcpu | <cpuname> | Wait until specific CPU is active (msh2 or ssh2) |
| print | | Print current CPU state and registers |

---

## CPU Names

- **msh2**: Master SH2 (primary rendering CPU)
- **ssh2**: Slave SH2 (worker CPU)

---

## Register Display Format (print command)

For SH2 CPUs:
```
PC,SR <pc_value>,     <sr_value>
R0, 8 <r0_value>,<r8_value>
R1, 9 <r1_value>,<r9_value>
...
R7,15 <r7_value>,<r15_value>
gb,vb <gbr_value>,<vbr_value>
IRQs/mask:        <irq>/<mask>
cycles <icount>/<timeslice> (<sr_shift>)
```

---

## Command-Line Usage

**Basic syntax**:
```bash
./picodrive -pdb "<commands>" <rom_file>
```

**Multiple commands** (semicolon-separated):
```bash
./picodrive -pdb "waitcpu ssh2; break 0x06020688; continue; print" build/vr_rebuild.32x
```

**Command sequence**:
1. `waitcpu ssh2` - Wait until Slave SH2 becomes active
2. `break 0x06020688` - Set breakpoint at Slave work loop
3. `continue` - Run until breakpoint hit
4. `print` - Show all registers including R2

---

## R2 Register Investigation

**Target address**: 0x06020688 (Slave work loop before JSR @R2)

**Script**: `pdb_r2_check.sh`

```bash
cd /mnt/data/src/32x-playground/third_party/picodrive
./pdb_r2_check.sh
```

**What we're checking**:
- R2 value at the moment before `JSR @R2` executes
- Expected hypotheses:
  - R2 = 0x0602050C (VDP wait function - uncached ROM)
  - R2 = 0x2002050C (VDP wait function - cached ROM)
  - R2 = other address (needs investigation)

---

## Interactive Mode

To use interactively, run with initial break command:
```bash
./picodrive -pdb "step 1" build/vr_rebuild.32x
```

When debugger stops (shows prompt `(pdb)`), you can type commands:
```
(pdb) waitcpu ssh2
(pdb) break 0x06020688
(pdb) continue
(pdb) print
```

**Note**: SDL may still open fullscreen - debugger output goes to terminal.

---

## Implementation Notes

**Custom additions to PDB**:
1. **break command** (added by us):
   - Sets hardware breakpoint at specified address
   - Supports up to 16 breakpoints
   - Shows list when called without arguments

2. **Field name fixes**:
   - Original PDB used obsolete SH2 structure field names
   - Updated to match current PicoDrive SH2 structure

**Files modified**:
- `Makefile`: Added PDB ?= 1 and conditional CFLAGS
- `cpu/debug.c`: Fixed field names, added break command

---

## Debugger Limitations

1. **No disassembly command**: Can't disassemble at arbitrary addresses
2. **No memory inspection**: Can't read/write memory directly
3. **No symbol support**: Must use absolute addresses
4. **SDL interference**: Graphics mode may obscure debugger output

**Workaround**: Use command-line scripting (-pdb flag) instead of interactive mode.

---

## Next Steps After R2 Verification

Once R2 value is confirmed:

**If R2 = 0x0602050C (VDP wait)**:
- Implement COMM register check at $020688
- Add work distribution protocol
- Expected FPS gain: +25-50%

**If R2 = other**:
- Disassemble target function
- Analyze actual Slave behavior
- Adapt optimization strategy accordingly

---

**Status**: Debugger ready for R2 verification ✅
**Script**: pdb_r2_check.sh prepared
**Next action**: Run script to determine R2 value
