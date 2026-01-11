# Debugging func_065 FIFO ROM with GDB

## Problem
Patched ROM "Virtua Racing - FIFO.32x" not booting.

## Patch Details
- **Trampoline at**: ROM 0x23F2E → SH2 address 0x02223F2E
- **Relocated function at**: ROM 0x16300 → SH2 address 0x02016300
- **Trampoline code**:
  ```
  02223F2E: D001       MOV.L @(PC+4),R0    ; Load target address
  02223F30: 402B       JMP @R0              ; Jump to relocated function
  02223F32: 0009       NOP                  ; Delay slot
  02223F34: 02016300   .long 0x02016300     ; Target address
  ```

## GDB Debugging Session

### 1. Launch Gens with GDB
```bash
./Gens_KMod_v0.7.3/gens.exe "Virtua Racing - FIFO.32x"
# Enable GDB stub in Gens menu
```

### 2. Connect GDB
```bash
gdb
(gdb) target remote localhost:6868
(gdb) set architecture sh2
```

### 3. Set Breakpoint at Trampoline
```gdb
# Break when func_065 is first called
(gdb) break *0x02223F2E
(gdb) continue
```

**Expected**: Breakpoint should hit when rendering starts

**If breakpoint never hits**: Original game code isn't reaching func_065
- Check if game initializes properly
- May be crashing earlier

### 4. Step Through Trampoline
```gdb
(gdb) info registers r0
(gdb) stepi              # Execute MOV.L @(PC+4),R0
(gdb) info registers r0  # Should show 0x02016300
(gdb) stepi              # Execute JMP @R0
(gdb) info registers pc  # Should show 0x02016300
```

**Expected**: R0 = 0x02016300, PC jumps to relocated function

**If R0 is wrong**: PC-relative load calculated incorrectly
**If JMP fails**: Address alignment or cache issue

### 5. Verify Relocated Function Entry
```gdb
(gdb) x/10i $pc
# Should show:
# 0x02016300: NOP
# 0x02016302: SHLL8 R0
# 0x02016304: SHLR R0
# ... etc
```

**Expected**: Disassembly matches relocated function

**If different**: ROM not written correctly, or cache issue

### 6. Check Register State
```gdb
(gdb) info registers
# Key registers:
# R0 = index parameter (from caller)
# R9 = destination pointer (frame buffer)
# R10 = table base address
# R13 = stride (CRITICAL - should be 8 for FIFO batching to work)
```

**Expected**: R13 = 8 (or 0x00000008)

**If R13 != 8**: FIFO batching assumption WRONG - patch corrupts memory

### 7. Single-Step Through Function
```gdb
# Step through first FIFO pair
(gdb) stepi   # NOP
(gdb) stepi   # SHLL8 R0
(gdb) stepi   # SHLR R0
(gdb) stepi   # ADD R10,R0
(gdb) info registers r0  # Should be source data address

(gdb) stepi   # MOV R9,R1
(gdb) info registers r1 r9  # R1 = R9 (destination)

# First FIFO batch - 4 consecutive writes
(gdb) stepi   # MOV.L @R0+,R2
(gdb) info registers r2  # First data value
(gdb) stepi   # MOV.L R2,@($0,R1)
(gdb) stepi   # MOV.L @R0+,R2
(gdb) info registers r2  # Second data value
(gdb) stepi   # MOV.L R2,@($4,R1)
(gdb) stepi   # MOV.L @R0+,R2
(gdb) info registers r2  # Third data value
(gdb) stepi   # MOV.L R2,@($8,R1)
(gdb) stepi   # MOV.L @R0+,R2
(gdb) info registers r2  # Fourth data value
(gdb) stepi   # MOV.L R2,@($C,R1)  ← FIFO triggers here!

# Advance destination by 2× stride
(gdb) info registers r1 r13  # Before ADD
(gdb) stepi   # ADD R13,R1
(gdb) stepi   # ADD R13,R1
(gdb) info registers r1  # Should be +16 bytes from original R1
```

**Expected**: R1 advances by 2×R13 = 16 bytes after each FIFO pair

**If R1 wrong**: Stride calculation broken, frame buffer corruption

### 8. Memory Inspection
```gdb
# Check if frame buffer writes succeed
(gdb) print/x $r1
(gdb) x/4wx $r1-16  # Look at last 4 writes
# Should show 4 consecutive longwords written
```

**Expected**: Frame buffer at R1 contains expected data

**If zeros or garbage**: VDP timing issue, or write to wrong address

### 9. Complete Function and Return
```gdb
(gdb) break *0x02016396  # RTS at end of relocated function
(gdb) continue
(gdb) info registers pr  # Return address (should be caller)
(gdb) stepi             # Execute RTS
(gdb) info registers pc # Should be back at caller (0x022xxxxx)
```

**Expected**: Returns to caller, continues execution

**If hangs**: Infinite loop or crash in relocated function
**If returns to wrong address**: PR corrupted

## Common Failure Modes

### Failure 1: Breakpoint Never Hits
**Symptom**: Game crashes before func_065 is called
**Cause**: Earlier initialization code broken by our patch
**Fix**: Verify no other code overlaps with 0x16300 or trampoline

### Failure 2: R0 Load Incorrect
**Symptom**: R0 != 0x02016300 after MOV.L
**Cause**: PC-relative calculation wrong
**Fix**: Check ROM address mapping (0x02xxxxxx vs 0x00xxxxxx vs 0x22xxxxxx)

### Failure 3: R13 != 8
**Symptom**: R13 is different value (e.g., 4, 12, 16)
**Cause**: Stride assumption wrong
**Fix**: Adjust FIFO batching to use actual R13 value, or abandon FIFO optimization

### Failure 4: Frame Buffer Corruption
**Symptom**: Graphics glitches, wrong colors
**Cause**: Writing to wrong addresses due to stride mismatch
**Fix**: Verify R1 calculation matches original function

### Failure 5: Cache Issue
**Symptom**: Random behavior, sometimes works
**Cause**: Relocated code in non-executable region or cache conflict
**Fix**: Try cache-through address (0x22016300) or different relocation target

## Quick Diagnostic Commands

```gdb
# Dump trampoline bytes
(gdb) x/4xh 0x02223F2E

# Dump relocated function start
(gdb) x/20xh 0x02016300

# Watch R13 value
(gdb) watch $r13

# Continuous step until crash
(gdb) while 1
> stepi
> end
```

## Success Criteria

✅ Breakpoint at 0x02223F2E hits
✅ R0 loads 0x02016300 correctly
✅ PC jumps to 0x02016300
✅ R13 = 8 (confirms stride assumption)
✅ Frame buffer writes complete
✅ RTS returns to caller
✅ Game continues rendering

## Next Steps Based on Findings

- **If trampoline works but function crashes**: Bug in FIFO batching logic
- **If R13 != 8**: Need to regenerate patch with correct stride
- **If cache/addressing issue**: Try different ROM base address
- **If all checks pass but still crashes**: Issue elsewhere in game (unrelated to our patch)
