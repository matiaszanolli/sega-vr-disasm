# SH2 Code Section Boundaries

## Purpose
Document the clear boundaries between different code sections in the ROM to avoid making incorrect assumptions about what code does.

## ROM Structure Overview

### 68K Code Sections
| Offset Range | File | Description | Translation Status |
|--------------|------|-------------|-------------------|
| $000000-$0001FF | Header | ROM header, vectors | ✅ Documented |
| $000200-$0021FF | code_200.asm | 68K main code, V-INT handler | ✅ Complete |
| ... | ... | ... | 🔄 To be mapped |

### SH2 Code Sections
| Offset Range | CPU | Description | Translation Status |
|--------------|-----|-------------|-------------------|
| $020500-$02050B | Master | Entry point signature "M_OK" "CMDI" | ✅ Identified |
| $02050C-$02051C | Slave | VDP wait function (CRITICAL) | ✅ Verified |
| $02050D-??? | Master | Master initialization/main loop | ❌ NOT TRANSLATED |
| ???-??? | Slave | Slave entry point/main loop | ❌ NOT IDENTIFIED |

### Audio/Graphics Code (OUT OF SCOPE FOR NOW)
| Offset Range | Description | Status |
|--------------|-------------|--------|
| TBD | Audio driver | 🚫 Not translating yet |
| TBD | Graphics rendering | 🚫 Not translating yet |
| TBD | VDP routines | 🚫 Not translating yet |

## Critical Functions for Work Distribution

### Must Understand Before Modification
1. **Master SH2 Entry** ($020500) - Where Master starts, initialization
2. **Master Main Loop** (TBD) - Where Master coordinates work
3. **Slave SH2 Entry** (TBD) - Where Slave starts
4. **Slave Main Loop** (TBD) - Where Slave waits for/processes work
5. **VDP Wait Function** ($02050C) - DO NOT MODIFY - Rendering depends on this
6. **COMM Register Usage** (TBD) - Current protocol between CPUs

### Can Defer Understanding
1. Audio synthesis routines
2. Graphics rasterization details
3. VDP hardware control sequences
4. Input handling details

## Next Steps

1. **Map SH2 code extent** - Find where SH2 code ends
2. **Identify Slave entry point** - Find where Slave SH2 starts executing
3. **Document current COMM usage** - What registers are used for what
4. **Trace Master main loop** - Understand coordination flow
5. **Trace Slave main loop** - Understand work processing flow

Only AFTER understanding items 1-5 should we attempt any modifications.

## Known Critical Locations (DO NOT MODIFY)

| Location | Description | Reason |
|----------|-------------|--------|
| $000512 | "MARS Initial & Security Program" | Boot security check |
| $0016A6 | V-INT epilogue (MOVEM.L) | Register restoration |
| $020500 | Master SH2 "M_OK" signature | Entry point verification |
| $02050C | VDP wait function | Rendering synchronization |

---

**Status**: Boundaries being mapped
**Next**: Systematically identify SH2 code sections
**Date**: 2026-01-20
