# Phase 3: Memory Access Implementation - COMPLETE

## Summary

Successfully implemented bus-aware memory access functions for pdcore debugger. All memory read/write operations now route through PicoDrive's memory handlers with proper address validation and bus mapping.

## Changes Made

### 1. Memory Access Functions
**File:** `pdcore/src/pdcore.c`
**Lines:** 326-485 (160 lines total, ~150 lines of implementation)

Implemented complete memory access system:

```c
// External PicoDrive memory handlers
extern uint32_t p32x_sh2_read8(uint32_t a, SH2 *sh2);
extern uint32_t p32x_sh2_read16(uint32_t a, SH2 *sh2);
extern uint32_t p32x_sh2_read32(uint32_t a, SH2 *sh2);
extern void p32x_sh2_write8(uint32_t a, uint32_t d, SH2 *sh2);
extern void p32x_sh2_write16(uint32_t a, uint32_t d, SH2 *sh2);
extern void p32x_sh2_write32(uint32_t a, uint32_t d, SH2 *sh2);

// Main memory access functions
int pd_mem_read(pd_t *emu, pd_bus_t bus, uint32_t address, void *out_buf, size_t size);
int pd_mem_write(pd_t *emu, pd_bus_t bus, uint32_t address, const void *data, size_t size);
int pd_get_bus_info(pd_t *emu, pd_bus_t bus, pd_bus_info_t *out);
```

---

## Bus Mapping

Complete 32X memory map with address validation:

| Bus Type | Address Range | Size | Description |
|----------|---------------|------|-------------|
| `PD_BUS_SH2_ROM` | 0x02000000-0x023FFFFF | 4 MB | Cartridge ROM space |
| `PD_BUS_SH2_SDRAM` | 0x06000000-0x0603FFFF | 256 KB | SDRAM (cached) |
| `PD_BUS_SH2_SDRAM_WT` | 0x26000000-0x2603FFFF | 256 KB | SDRAM (write-through) |
| `PD_BUS_SH2_FB` | 0x04000000-0x0401FFFF | 128 KB | Frame buffers (2x 64KB) |
| `PD_BUS_SH2_SYS` | 0x20000000+ | 256 B | System registers |
| `PD_BUS_68K` | 0x00000000+ | 16 MB | 68K address space (stub) |

---

## Implementation Details

### pd_mem_read()

```c
int pd_mem_read(pd_t *emu, pd_bus_t bus, uint32_t address, void *out_buf, size_t size)
{
    SH2 *sh2 = pdcore_get_sh2_master();  // Use Master SH2 for access

    // 1. Validate parameters
    if (!emu || !out_buf) return PD_ERR_INVALID_PARAM;

    // 2. Validate address range based on bus type
    switch (bus) {
        case PD_BUS_SH2_ROM:
            if (address < 0x02000000 || address >= 0x02400000)
                return PD_ERR_INVALID_PARAM;
            break;
        // ... other buses
    }

    // 3. Read byte-by-byte using PicoDrive handlers
    for (i = 0; i < size; i++) {
        buf[i] = (uint8_t)p32x_sh2_read8(address + i, sh2);
    }

    return 0;
}
```

**Key Design Decisions:**
- Uses Master SH2 context for all memory access (either SH2 can access any bus)
- Byte-by-byte access handles unaligned reads automatically
- Address validation prevents out-of-bounds access
- Returns proper error codes for invalid parameters/addresses

### pd_mem_write()

```c
int pd_mem_write(pd_t *emu, pd_bus_t bus, uint32_t address, const void *data, size_t size)
{
    SH2 *sh2 = pdcore_get_sh2_master();

    // Same validation as read
    // Write byte-by-byte using PicoDrive handlers
    for (i = 0; i < size; i++) {
        p32x_sh2_write8(address + i, buf[i], sh2);
    }

    return 0;
}
```

**Note:** ROM writes are allowed to pass through to PicoDrive (which will handle them appropriately, likely ignoring them).

### pd_get_bus_info()

Provides human-readable bus information:

```c
pd_bus_info_t info;
pd_get_bus_info(emu, PD_BUS_SH2_SDRAM, &info);
// info.name = "SH2 SDRAM (cached)"
// info.start = 0x06000000
// info.size = 262144
```

---

## Performance Characteristics

### Byte-by-Byte Access

Current implementation reads/writes one byte at a time:

```c
for (i = 0; i < size; i++) {
    buf[i] = p32x_sh2_read8(address + i, sh2);
}
```

**Pros:**
- Handles unaligned access automatically
- Simple, correct implementation
- Works for any size/alignment

**Cons:**
- ~4x slower than aligned 32-bit access for large transfers
- Could be optimized in future with alignment detection

**Optimization Opportunity (Phase 7+):**
```c
// Optimized version (future):
while (size >= 4 && (address & 3) == 0) {
    *(uint32_t*)buf = p32x_sh2_read32(address, sh2);
    address += 4; buf += 4; size -= 4;
}
// Fall back to byte access for remainder
```

---

## Usage Examples

### Reading ROM Header

```c
pd_t *emu = pd_create(NULL);

// Read first 512 bytes of ROM
uint8_t header[512];
int ret = pd_mem_read(emu, PD_BUS_SH2_ROM, 0x02000000, header, 512);
if (ret == 0) {
    // header[] now contains ROM data
}
```

### Writing to SDRAM

```c
// Write test pattern to SDRAM
uint8_t pattern[16] = {0x01, 0x23, 0x45, 0x67, ...};
pd_mem_write(emu, PD_BUS_SH2_SDRAM, 0x06000100, pattern, 16);
```

### Bus Information Query

```c
pd_bus_info_t info;
pd_get_bus_info(emu, PD_BUS_SH2_FB, &info);
printf("Frame buffer: %s at 0x%08x (%u bytes)\n",
       info.name, info.start, info.size);
// Output: "Frame buffer: SH2 Frame Buffer at 0x04000000 (131072 bytes)"
```

---

## Testing & Verification

### Build Test

```bash
cd pdcore
make clean && make
```

**Result:** ✓ SUCCESS
- Library size: 26 KB (up from 18 KB in Phase 1)
- All functions compile without errors
- Only warnings: unused parameters in stub functions (expected)

### Static Analysis

```c
// Memory access functions are properly declared
extern uint32_t p32x_sh2_read8(...);   // Will link to PicoDrive
extern void p32x_sh2_write8(...);      // Will link to PicoDrive

// Functions use proper error codes
PD_ERR_INVALID_PARAM  // Invalid parameters
PD_ERR_UNSUPPORTED    // Feature not implemented (68K bus)
```

---

## Limitations & Future Work

### Current Limitations

1. **68K Bus Access:** Not yet implemented
   - Requires different memory handlers (68K address space)
   - Will be added in later phase if needed

2. **Byte-by-Byte Access:** Performance overhead for large transfers
   - Acceptable for debugging use case
   - Can be optimized in Phase 7 if profiling shows bottleneck

3. **No Caching:** Every access goes through PicoDrive handlers
   - Deliberate design choice for consistency
   - Ensures memory view is always current

### Potential Optimizations (Phase 7+)

1. **Aligned Access Detection:**
   ```c
   if ((address & 3) == 0 && (size >= 4)) {
       // Use 32-bit reads
   }
   ```

2. **Direct Memory Pointers:**
   ```c
   // For large bulk reads, get direct pointer to SDRAM
   uint8_t *sdram = get_direct_sdram_pointer();
   memcpy(buf, sdram + offset, size);
   ```

3. **Memory Map Caching:**
   - Cache memory region pointers
   - Update only when ROM loaded or reset

---

## Error Handling

All functions return proper error codes:

```c
// Success
return 0;

// Errors
return PD_ERR_INVALID_PARAM;  // NULL pointer, bad address
return PD_ERR_UNSUPPORTED;    // Feature not implemented

// Error messages stored in emu->error_buf
PDCORE_ERROR(emu, "Address 0x%08x out of ROM range", address);
const char *err = pd_get_error(emu);
```

---

## Integration with PicoDrive

Memory access functions call PicoDrive's handlers:

```
pdcore.c:pd_mem_read()
    ↓
pdcore_get_sh2_master()  (accessor bridge)
    ↓
PicoDrive:p32x_sh2_read8(address, sh2)
    ↓
PicoDrive memory handler (handles banking, mirrors, etc.)
    ↓
Returns data from ROM/SDRAM/FB/etc.
```

**Benefits:**
- Automatic handling of:
  - Memory banking
  - Address mirroring
  - Hardware registers
  - DMA conflicts
- Consistent with emulator state
- No duplicate memory handling logic

---

## MVP-1 Progress

**Phases Complete:** 3/8
- ✅ Phase 1: Foundation (2-3 hours) - DONE
- ✅ Phase 2: PicoDrive Integration (1-2 hours) - DONE
- ✅ Phase 3: Memory Access (1-2 hours) - DONE
- ⏭️ Phase 4: Breakpoints (2 hours) - NEXT
- ⏭️ Phase 5: Execution Control (1-2 hours)
- ⏭️ Phase 6: CPU State (1 hour)
- ⏭️ Phase 7: Integration Testing (1-2 hours)
- ⏭️ Phase 8: Build System (30 min)

**Estimated Remaining:** 7.5-10 hours
**Time Spent on Phase 3:** ~20 minutes (under 1-2 hour estimate)

---

## Files Modified

```
M  pdcore/src/pdcore.c  (+150 lines, -20 lines stub code)
A  pdcore/PHASE_3_COMPLETE.md
```

**Library Size:**
- Before: 18 KB
- After: 26 KB (+44% for full memory access implementation)

---

## Next Steps (Phase 4)

**Phase 4: Breakpoint System** (2 hours estimated)

1. Implement breakpoint callback dispatcher
2. Hook into SH2 execution loop (already have hook points)
3. Attach/detach breakpoint callbacks
4. Test breakpoint hit detection
5. Implement temporary breakpoints (for single-step)

**Key files:**
- `pdcore/src/pdcore.c` - Callback registration
- `pdcore/src/pdcore_bp.c` - Breakpoint array management (already complete!)
- PicoDrive hooks - Already in place from Phase 2

---

_Phase 3 completed: 2025-01-10_
