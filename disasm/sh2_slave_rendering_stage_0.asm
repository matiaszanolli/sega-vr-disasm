# SH2 Slave Rendering - Stage 3.0: Polygon Bounds Parser
# Virtua Racing Deluxe parallelization
#
# Purpose: Initialize polygon bounds array for fast spatial queries
# In Phase 3.0: Simple initialization with safe defaults
# In Phase 3.5+: Full display list parsing (future optimization)
#
# This allows Slave to render all polygons initially without bounds culling.
# Later stages can optimize with actual polygon boundary extraction.

.set SYNC_BASE, 0x22000400
.set BOUNDS_ARRAY_BASE, 0x22001000
.set FRAME_WIDTH, 448
.set FRAME_HEIGHT, 224
.set MAX_POLYGONS, 800

.align 2

# ============================================================================
# init_polygon_bounds - Initialize bounds array with safe defaults
# ============================================================================
# Called once per frame before Slave rendering begins
# Fills bounds array at 0x22001000 with default full-screen bounds
#
# Input:  R14 = RenderingContext (optional, for actual bounds extraction)
# Output: SDRAM at 0x22001000 contains initialized bounds
# Uses:   R0-R3, R14
#
# Size: ~40 bytes
# Complexity: Low
# ============================================================================

.globl init_polygon_bounds
init_polygon_bounds:
    mov.l   bounds_base, r1
    mov.l   default_bounds, r0
    mov.l   poly_count, r2

.bounds_loop:
    mov.l   r0, @r1
    add     #4, r1

    dt      r2
    bf      .bounds_loop

    rts
    nop

.align 4

# ============================================================================
# parse_polygon_bounds_full - Full display list parser (Phase 3.5+)
# ============================================================================
# More advanced version that actually extracts polygon bounds from
# the display list. Implemented in Phase 3.5 after basic rendering works.
# For now, stub that returns immediately.
#
# Input:  R13 = Display list pointer
#         R14 = RenderingContext
# Output: SDRAM at 0x22001000 contains actual polygon bounds
# ============================================================================

.globl parse_polygon_bounds_full
parse_polygon_bounds_full:
    # STUB: Actual implementation deferred to Phase 3.5
    # For now, just return - init_polygon_bounds already set safe defaults
    rts
    nop

.align 4

# ============================================================================
# update_slave_bounds - Optional: Update bounds for specific polygon
# ============================================================================
# Allows selective bounds updates if needed during rendering
# Phase 3.0: Not used (all polygons rendered)
# Phase 3.5+: Used for optimized rendering
#
# Input:  R0 = polygon index
#         R1 = X_min
#         R2 = X_max
# Output: bounds_array[index] updated
# ============================================================================

.globl update_slave_bounds
update_slave_bounds:
    # STUB: Deferred to Phase 3.5
    rts
    nop

.align 4

# Literals

bounds_base:
    .long   BOUNDS_ARRAY_BASE

default_bounds:
    .long   0x01C00000

poly_count:
    .long   MAX_POLYGONS
